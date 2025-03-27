#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516026 "Manage Loan SMSs"
{
    trigger OnRun()
    begin
        //DueTodayLoansSMS();
        DueInSevenDaysLoansSMS();
    end;

    var
        LoansReg: Record "Loans Register";
        LoanRepay: Record "Loan Repayment Schedule";
        msg: Text[250];
        MembersReg: Record Customer;
        iEntryNo: Integer;
        SMSMessages: Record "SMS Messages";
        SevenDaysPriorDate: Date;
        LoanSMSNotice: Record "Loan SMS Notice";
        SMSLogTable: Record "Sent SMS Messages Log";
        mobileno: Text;

    procedure DueTodayLoansSMS()
    begin
        LoansReg.Reset;
        LoansReg.SetRange(LoansReg."Client Code", MembersReg."No.");
        LoansReg.SetRange(LoansReg.Posted, true);
        LoansReg.CalcFields(LoansReg."Outstanding Balance");
        LoansReg.SetFilter(LoansReg."Outstanding Balance", '>%1', 0);
        if LoansReg.Find('-') then
            repeat
                MembersReg.Reset;
                MembersReg.SetRange(MembersReg."No.", LoansReg."Client Code");
                if MembersReg.Find('-') then
                    mobileno := (MembersReg."Phone No.");
                //...............................Check Loans that are due today
                LoanRepay.Reset;
                LoanRepay.SetRange(LoanRepay."Loan No.", LoansReg."Loan  No.");
                LoanRepay.SetRange(LoanRepay."Repayment Date", Today);//Check that its today
                if LoanRepay.Find('-') then begin
                    //check the last sent date for the message
                    SMSLogTable.Reset;
                    SMSLogTable.SetRange(SMSLogTable."Loan Number", LoanRepay."Loan No.");
                    if SMSLogTable.Find('-') then begin
                        if (SMSLogTable."SMS Log Date" <> Today) then begin
                            SMSLogTable."SMS Log Date" := Today;
                            SMSLogTable.Modify;
                            msg := 'Dear ' + Format(LoansReg."Client Name") + ', Your monthly loan repayment for ' + LoansReg."Loan Product Type Name" + ' of amount Ksh. '
                             + Format(LoansReg.Repayment, 0, '<Precision,2><sign><Integer Thousand><Decimals,3>')
                             + ' is due today.' + ' Please pay via Bank A/C or  Via LIPA na MPESA Paybill 587649. Ignore this message if you have already paid';
                            //SMSMessage(LoansReg."Doc No Used",LoansReg."Client Code",MembersReg."Phone No.",msg);
                            SMSMessage(LoansReg."Doc No Used", LoansReg."Client Code", mobileno, msg);
                        end
                        else if (SMSLogTable."SMS Log Date" = Today) then;

                        //DO NOTHING
                    end
                    else begin//NO RECORD FOUND IN LOG SO INSERT NEW

                        SMSLogTable."Loan Number" := LoanRepay."Loan No.";
                        SMSLogTable."SMS Log Date" := Today;
                        SMSLogTable.Insert(true);

                        msg := 'Dear ' + Format(LoansReg."Client Name") + ', Your monthly loan repayment for ' + LoansReg."Loan Product Type Name" + ' of amount Ksh. '
                        + Format(LoansReg."Loan Principle Repayment", 0, '<Precision,2><sign><Integer Thousand><Decimals,3>')
                        + ' is due today.' + ' Please pay via Bank A/C or  Via LIPA na MPESA Paybill 587649. Ignore this message if you have already paid';
                        SMSMessage(LoansReg."Doc No Used", LoansReg."Client Code", mobileno, msg);
                    end;
                end;
            //.............................................................
            until LoansReg.Next = 0;
    end;

    procedure DueInSevenDaysLoansSMS()
    begin
        //..........................................Automate sending of sms for loans that are due 7 days prior;
        SevenDaysPriorDate := CalcDate('-7D', Today);

        LoansReg.Reset;
        LoansReg.SetRange(LoansReg."Client Code", MembersReg."No.");//L12001000550 client code
        LoansReg.SetRange(LoansReg.Posted, true);
        LoansReg.SetFilter(LoansReg."Recovery Mode", '<>%1', LoansReg."recovery mode"::Dividend);
        LoansReg.CalcFields( LoansReg."Outstanding Balance");
        LoansReg.SetFilter(LoansReg."Outstanding Balance", '>%1', 0);
        if LoansReg.Find('-') then
            repeat
                MembersReg.Reset;
                MembersReg.SetRange(MembersReg."No.", LoansReg."Client Code");
                if MembersReg.Find('-') then
                    mobileno := (MembersReg."Phone No.");
                //..............................................................
                LoanRepay.Reset;
                LoanRepay.SetRange(LoanRepay."Loan No.", LoansReg."Loan  No.");
                LoanRepay.SetRange(LoanRepay."Repayment Date", SevenDaysPriorDate);
                if LoanRepay.Find('-') then begin
                    //..............................................................
                    //check the last sent date for the message
                    SMSLogTable.Reset;
                    SMSLogTable.SetRange(SMSLogTable."Loan Number", LoanRepay."Loan No.");
                    if SMSLogTable.Find('-') then begin
                        if (SMSLogTable."SMS Log Date" <> Today) then begin
                            SMSLogTable."SMS Log Date" := Today;
                            SMSLogTable.Modify;

                            msg := 'Dear ' + Format(LoansReg."Client Name") + ', Your monthly loan repayment for ' + LoansReg."Loan Product Type Name" + ' of  Kshs. '
                            + Format(LoansReg."Loan Principle Repayment" , 0, '<Precision,2><sign><Integer Thousand><Decimals,3>')
                            + ' will fall due in the next 7 days.' + ' Kindly make arrangements to pay via Bank A/C or  Via LIPA na MPESA Paybill 587649';
                            SMSMessage(LoansReg."Doc No Used", LoansReg."Client Code", mobileno, msg);
                        end
                        else if (SMSLogTable."SMS Log Date" = Today) then;
                        //DO NOTHING
                    end
                    else//NO RECORD FOUND IN LOG SO INSERT NEW
                        begin
                        SMSLogTable."Loan Number" := LoanRepay."Loan No.";
                        SMSLogTable."SMS Log Date" := Today;
                        SMSLogTable.Insert(true);

                        msg := 'Dear ' + Format(LoansReg."Client Name") + ', Your monthly loan repayment for ' + LoansReg."Loan Product Type Name" + ' of  Kshs. '
                       + Format(LoansReg."Loan Principle Repayment", 0, '<Precision,2><sign><Integer Thousand><Decimals,3>')
                       + ' will fall due in the next 7 days.' + ' Kindly make arrangements to pay via Bank A/C or  Via LIPA na MPESA Paybill 587649';
                        SMSMessage(LoansReg."Doc No Used", LoansReg."Client Code", mobileno, msg);
                    end;
                end;
            until LoansReg.Next = 0;
        //.............................................................
        //....................................................................................................
    end;

    procedure SMSMessage(documentNo: Text[30]; accfrom: Text[30]; phone: Text[20]; message: Text[250])
    begin
        iEntryNo := 0;
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else
            iEntryNo := 1;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Batch No" := documentNo;
        SMSMessages."Document No" := documentNo;
        SMSMessages."Account No" := accfrom;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'MOBILETRAN';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := message;
        SMSMessages."Telephone No" := phone;
        if SMSMessages."Telephone No" <> '' then
            SMSMessages.Insert;
    end;
}
