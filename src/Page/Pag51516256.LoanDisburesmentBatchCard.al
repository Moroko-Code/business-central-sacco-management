Page 51516256 "Loan Disburesment Batch Card"
{
    DeleteAllowed = false;
    ObsoleteState = Pending;
    ObsoleteReason = 'The sacco does utilize the faeture at the moment';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Disburesment-Batching";
    SourceTableView = where(Posted = const(false), Source = const(BOSA));

    layout
    {
        area(content)
        {
            field("Batch No."; "Batch No.")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field(Source; Source)
            {
                ApplicationArea = Basic;
                Editable = SourceEditable;
            }
            field("Batch Type"; "Batch Type")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Description/Remarks"; "Description/Remarks")
            {
                ApplicationArea = Basic;
                //Editable = DescriptionEditable;
                Editable = true;
            }
            field(Status; Status)
            {
                ApplicationArea = Basic;
                Editable = true;
            }
            field("Total Loan Amount"; "Total Loan Amount")
            {
                ApplicationArea = Basic;
            }
            field("No of Loans"; "No of Loans")
            {
                ApplicationArea = Basic;
            }
            field("Mode Of Disbursement"; "Mode Of Disbursement")
            {
                ApplicationArea = Basic;
                Editable = ModeofDisburementEditable;
                Visible = false;
                trigger OnValidate()
                begin
                    if "Mode Of Disbursement" <> "mode of disbursement"::Cheque then
                        "Cheque No." := "Batch No.";
                    Modify;
                end;
            }
            field("Document No."; "Document No.")
            {
                ApplicationArea = Basic;
                Editable = DocumentNoEditable;
                trigger OnValidate()
                begin
                end;
            }
            field(o; "Posting Date")
            {
                ApplicationArea = Basic;
                Caption = 'Posting Date';
                Editable = PostingDateEditable;
            }
            // field("BOSA Bank Account"; "BOSA Bank Account")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Paying Bank';
            //     Editable = PayingAccountEditable;
            // }
            // field("Cheque No."; LoansBatch."Cheque No.")
            // {
            //     ApplicationArea = Basic;
            //     Editable = ChequeNoEditable;
            // }
            part("`"; "Loans Sub-Page List Disburse")
            {
                Editable = false;
                SubPageLink = "Batch No." = field("Batch No.");
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(LoansB)
            {
                Caption = 'Batch';

                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    Enabled = SendApprovalEditable;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
                    begin
                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
                        if LoanApps.Find('-') = false then Error('You cannot send an empty batch for approval');
                        TestField("Description/Remarks");
                        if Status <> Status::Open then Error(Text001);
                        if Confirm('Send Approval Request?', false) = true then
                            // Status := Status::Approved;
                            // rec.Modify(true);
                            // Message('Approved');
                            SrestepApprovalsCodeUnit.SendLoanBatchRequestForApproval(rec."Batch No.", Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = CancelApprovalEditable;

                    trigger OnAction()
                    var
                        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
                    begin
                        if Confirm('Cancel Approval?', false) = true then
                            SrestepApprovalsCodeUnit.CancelLoanBatchRequestForApproval(rec."Batch No.", Rec);
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Batch';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = PostEnabled;

                    trigger OnAction()
                    var
                        Text001: label 'The Batch need to be approved.';
                    begin
                        if Posted = true then Error('Batch already posted.');
                        if Status <> Status::Approved then Error(Format(Text001));
                        if Confirm('Are you sure you want to post this batch?', false) = false then
                            exit
                        else begin
                            TestField("Description/Remarks");
                            TestField("Posting Date");
                            TestField("Document No.");
                            //PRORATED DAYS
                            EndMonth := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy("Posting Date", 2), Date2dmy("Posting Date", 3))));
                            RemainingDays := (EndMonth - "Posting Date") + 1;
                            TMonthDays := Date2dmy(EndMonth, 1);
                            //PRORATED DAYS
                            //Delete Journal Lines
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                            GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                            GenJournalLine.DeleteAll;
                            GenSetUp.Get;
                            DActivity := '';
                            DBranch := '';
                            LoanApps.Reset;
                            LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
                            //LoanApps.SetFilter(LoanApps."Loan Status", '<>Rejected');
                            if LoanApps.Find('-') then
                                repeat
                                    FnInsertBOSALines(LoanApps, LoanApps."Loan  No.");
                                    FnSendDisburesmentSMS(LoanApps."Loan  No.", LoanApps."Client Code");
                                    LoanApps."Loan Status" := LoanApps."Loan Status"::Issued;
                                    LoanApps.Posted := true;
                                    LoanApps."Posted By" := UserId;
                                    LoanApps."Posting Date" := Today;
                                    LoanApps."Issued Date" := LoanApps."Loan Disbursement Date";
                                    LoanApps."Approval Status" := LoanApps."Approval Status"::Approved;
                                    LoanApps."Loans Category-SASRA" := LoanApps."Loans Category-SASRA"::Perfoming;
                                    LoanApps.Modify;

                                    //.................................................
                                    CurrPage.close();
                                until LoanApps.Next = 0;
                        end;
                        //CU posting
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        if GenJournalLine.Find('-') then
                            page.Run(Page::"Job Journal", GenJournalLine);
                        //Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                        Message('Loan has successfully been posted and member notified');
                        Posted := true;
                        "Posting Date" := Today;
                        "Posted By" := UserId;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    var
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        Cust: Record Customer;
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Product Charges";
        GenJournalLine: Record "Gen. Journal Line";
        //GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        DActivity: Code[20];
        DBranch: Code[20];
        LoanApps: Record "Loans Register";
        EndMonth: Date;
        RemainingDays: Integer;
        TMonthDays: Integer;
        iEntryNo: Integer;
        DescriptionEditable: Boolean;
        ModeofDisburementEditable: Boolean;
        DocumentNoEditable: Boolean;
        PostingDateEditable: Boolean;
        SourceEditable: Boolean;
        PayingAccountEditable: Boolean;
        ChequeNoEditable: Boolean;
        ChequeNameEditable: Boolean;
        SFactory: Codeunit "SURESTEP Factory";
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        SMSMessages: Record "SMS Messages";
        SendApprovalEditable: Boolean;
        CancelApprovalEditable: Boolean;
        PostEnabled: Boolean;
        VarAmounttoDisburse: Decimal;
        DirbursementDate: Date;
        VarLoanNo: Code[20];

    local procedure FnInsertBOSALines(var LoanApps: Record "Loans Register"; LoanNo: Code[30])
    var
        EndMonth: Date;
        RemainingDays: Integer;
        TMonthDays: Integer;
        Sfactorycode: Codeunit "SURESTEP Factory";
        AmountTop: Decimal;
        NetAmount: Decimal;
    begin
        AmountTop := 0;
        NetAmount := 0;
        VarLoanNo := LoanNo;
        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'LOANS';
        DOCUMENT_NO := VarLoanNo;
        IF LoanApps.GET(VarLoanNo) THEN
            repeat
                //--------------------Generate Schedule
                Sfactorycode.FnGenerateRepaymentSchedule(LoanApps."Loan  No.");
                DirbursementDate := "Posting Date";
                VarAmounttoDisburse := LoanApps."Approved Amount";
                //....................PRORATED DAYS
                EndMonth := CALCDATE('-1D', CALCDATE('1M', DMY2DATE(1, DATE2DMY(Today, 2), DATE2DMY(Today, 3))));
                RemainingDays := (EndMonth - Today) + 1;
                TMonthDays := DATE2DMY(EndMonth, 1);
                //....................Ensure that If Batch doesnt exist then create
                IF NOT GenBatch.GET(BATCH_TEMPLATE, BATCH_NAME) THEN BEGIN
                    GenBatch.INIT;
                    GenBatch."Journal Template Name" := BATCH_TEMPLATE;
                    GenBatch.Name := BATCH_NAME;
                    GenBatch.INSERT;
                END;
                //....................Reset General Journal Lines
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SETRANGE("Journal Batch Name", BATCH_NAME);
                GenJournalLine.DELETEALL;
                //....................Loan Posting Lines
                GenSetUp.GET;
                DActivity := '';
                DBranch := '';
                IF Cust.GET(LoanApps."Client Code") THEN BEGIN
                    DActivity := Cust."Global Dimension 1 Code";
                    DBranch := Cust."Global Dimension 2 Code";
                END;
                //**************Loan Principal Posting**********************************
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::Loan, GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, VarAmounttoDisburse, 'BOSA', "Batch No.", 'Loan Disbursement - ' + LoanApps."Loan Product Type", LoanApps."Loan  No.");
                //--------------------------------RECOVER OVERDRAFT()-------------------------------------------------------

                //...................Cater for Loan Offset Now !
                LoanApps.CalcFields(LoanApps."Top Up Amount");
                if LoanApps."Top Up Amount" > 0 then begin
                    LoanTopUp.RESET;
                    LoanTopUp.SETRANGE(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                    IF LoanTopUp.FIND('-') THEN
                        repeat
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::Repayment, GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, Round(LoanTopUp."Principle Top Up", 0.01, '=') * -1, 'BOSA', "Batch No.", 'Loan OffSet By - ' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                            //..................Recover Interest On Top Up
                            // LineNo := LineNo + 10000;
                            // SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::"Interest Paid", GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, Round(LoanTopUp."Interest Top Up", 0.01, '=') * -1, 'BOSA', "Batch No.", 'Interest Due Paid on top up - ', LoanTopUp."Loan Top Up");
                            //If there is top up commission charged write it here start
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Top up Account", DirbursementDate, Round(LoanTopUp.Commision, 1, '=') * -1, 'BOSA', "Batch No.", 'Commision on top up - ', LoanTopUp."Loan Top Up");
                            //If there is top up commission charged write it here end
                            AmountTop := (Round(LoanTopUp."Principle Top Up", 0.01, '=') + Round(LoanTopUp.Commision, 1, '='));
                            VarAmounttoDisburse := VarAmounttoDisburse - (Round(LoanTopUp."Principle Top Up", 0.01, '=') + Round(LoanTopUp.Commision, 1, '='));
                        // VarAmounttoDisburse := VarAmounttoDisburse - ;
                        UNTIL LoanTopUp.NEXT = 0;
                end;
                //If there is top up commission charged write it here start
                //If there is top up commission charged write it here end
                //.....Valuation
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Asset Valuation Cost", DirbursementDate, Round(LoanApps."Valuation Cost", 0.01, '=') * -1, 'BOSA', "Batch No.", 'Loan Principle Amount ' + Format(LoanApps."Loan  No."), '');
                // VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Valuation Cost";
                //...Debosting amount
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Boosting Fees Account", DirbursementDate, Round(LoanApps."Deboost Commision", 0.01, '=') * -1, 'BOSA', "Batch No.", 'Debosting commision ' + Format(LoanApps."Loan  No."), '');
                VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Deboost Commision";
                //Debosting commsion

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Legal Fees", DirbursementDate, Round(LoanApps."Legal Cost", 0.01, '=') * -1, 'BOSA', "Batch No.", 'Loan Principle Amount ' + Format(LoanApps."Loan  No."), '');
                // VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Legal Cost";

                NetAmount := VarAmounttoDisburse - LoanApps."Loan Insurance";
                //***************************Loan Product Charges code
                PCharges.Reset();
                PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                IF PCharges.FIND('-') THEN
                    REPEAT
                        PCharges.TESTFIELD(PCharges."G/L Account");
                        LineNo := LineNo + 10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name" := BATCH_TEMPLATE;
                        GenJournalLine."Journal Batch Name" := BATCH_NAME;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                        GenJournalLine."Account No." := PCharges."G/L Account";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := LoanApps."Loan  No.";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Posting Date" := DirbursementDate;
                        GenJournalLine.Description := PCharges.Description + '-' + Format(LoanApps."Loan  No.");
                        IF PCharges."Use Perc" = TRUE THEN
                            GenJournalLine.Amount := Round((LoanApps."Approved Amount" * (PCharges.Percentage / 100)), 1) * -1
                        ELSE
                            IF PCharges."Use Perc" = false then
                                if (NetAmount >= 1000000) then
                                    GenJournalLine.Amount := Round(PCharges.Amount2, 0.01, '=') * -1
                                else
                                    GenJournalLine.Amount := Round(PCharges.Amount, 0.01, '=') * -1;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        IF GenJournalLine.Amount <> 0 THEN GenJournalLine.INSERT;
                    UNTIL PCharges.NEXT = 0;
                VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Loan Insurance";
                //end of code
                //------------------------------------2. CREDIT MEMBER BANK A/C---------------------------------------------------------------------------------------------

                //------------------------------------2. CREDIT MEMBER BANK A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"Bank Account", LoanApps."Paying Bank Account No", DirbursementDate, VarAmounttoDisburse * -1, 'BOSA', "Batch No.", 'Loan Principle Amount ' + Format(LoanApps."Loan  No.") + ' ' + Format(LoanApps."Client Name"), '');
            until LoanApps.Next = 0;
    end;

    procedure UpdateControl()
    begin
        if Status = Status::Open then begin
            DescriptionEditable := true;
            ModeofDisburementEditable := false;
            DocumentNoEditable := false;
            PostingDateEditable := false;
            SourceEditable := true;
            PayingAccountEditable := true;
            ChequeNoEditable := false;
            ChequeNameEditable := false;
            SendApprovalEditable := true;
            CancelApprovalEditable := false;
            PostEnabled := false;
        end;
        if Status = Status::"Pending Approval" then begin
            DescriptionEditable := false;
            ModeofDisburementEditable := false;
            DocumentNoEditable := false;
            PostingDateEditable := false;
            SourceEditable := false;
            PayingAccountEditable := false;
            ChequeNoEditable := false;
            ChequeNameEditable := false;
            SendApprovalEditable := false;
            CancelApprovalEditable := true;
            PostEnabled := false;
        end;
        if Status = Status::Rejected then begin
            DescriptionEditable := false;
            ModeofDisburementEditable := false;
            DocumentNoEditable := false;
            PostingDateEditable := false;
            SourceEditable := false;
            PayingAccountEditable := false;
            ChequeNoEditable := false;
            ChequeNameEditable := false;
            SendApprovalEditable := true;
            CancelApprovalEditable := false;
            PostEnabled := false;
        end;
        if Status = Status::Approved then begin
            DescriptionEditable := false;
            ModeofDisburementEditable := true;
            DocumentNoEditable := true;
            SourceEditable := false;
            PostingDateEditable := true;
            PayingAccountEditable := true; //FALSE;
            ChequeNoEditable := true;
            ChequeNameEditable := true;
            SendApprovalEditable := false;
            CancelApprovalEditable := false;
            PostEnabled := true;
        end;
    end;

    procedure FnSendDisburesmentSMS(LoanNo: Code[20]; AccountNo: Code[20])
    var
        msg: Text[250];
        PhoneNo: Text[250];
    begin
        LoanApps.Reset();
        LoanApps.SetRange(LoanApps."Loan  No.", LoanNo);
        if LoanApps.Find('-') then begin
            msg := '';
            msg := 'Dear Member, Your ' + Format(LoanApps."Loan Product Type") + ' loan application of KSHs.' + Format(LoanApps."Requested Amount") + ' has been processed and it will be deposited to your Bank Account.';
            PhoneNo := FnGetPhoneNo(LoanApps."Client Code");
            SendSMSMessage(LoanApps."Client Code", msg, PhoneNo);
        end;
    end;

    local procedure SendSMSMessage(BOSANo: Code[20]; msg: Text[250]; PhoneNo: Text[250])
    begin
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else
            iEntryNo := 1;
        //--------------------------------------------------
        SMSMessages.Reset;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Account No" := BOSANo;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'LOANDISB';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := msg;
        SMSMessages."Telephone No" := PhoneNo;
        SMSMessages.Insert;
    end;

    local procedure FnGetPhoneNo(ClientCode: Code[50]): Text[250]
    var
        Member: Record Customer;
        Vendor: Record Vendor;
    begin
        Member.Reset();
        Member.SetRange(Member."No.", ClientCode);
        if Member.Find('-') = true then begin
            if (Member."Mobile Phone No." <> '') and (Member."Mobile Phone No." <> '0') then
                exit(Member."Mobile Phone No.");
            if (Member."Mobile Phone No" <> '') and (Member."Mobile Phone No" <> '0') then
                exit(Member."Mobile Phone No");
            if (Member."Phone No." <> '') and (Member."Phone No." <> '0') then
                exit(Member."Phone No.");
            Vendor.Reset();
            Vendor.SetRange(Vendor."BOSA Account No", ClientCode);
            if Vendor.Find('-') then begin
                if (Vendor."Mobile Phone No." <> '') or (Vendor."Mobile Phone No." <> '0') then
                    exit(Vendor."Mobile Phone No.");
                if (Vendor."Mobile Phone No" <> '') or (Vendor."Mobile Phone No" <> '0') then
                    exit(Vendor."Mobile Phone No");
                if (Vendor."MPESA Mobile No" <> '') or (Vendor."MPESA Mobile No" <> '0') then
                    exit(Vendor."MPESA Mobile No");
            end;
        end
        else
            if Member.find('-') = false then begin
                Vendor.Reset();
                Vendor.SetRange(Vendor."BOSA Account No", ClientCode);
                if Vendor.Find('-') then begin
                    if (Vendor."Mobile Phone No." <> '') or (Vendor."Mobile Phone No." <> '0') then
                        exit(Vendor."Mobile Phone No.");
                    if (Vendor."Mobile Phone No" <> '') or (Vendor."Mobile Phone No" <> '0') then
                        exit(Vendor."Mobile Phone No");
                    if (Vendor."MPESA Mobile No" <> '') or (Vendor."MPESA Mobile No" <> '0') then
                        exit(Vendor."MPESA Mobile No");
                end;
            end;
    end;

    local procedure FnGetMemberBranch(MemberNo: Code[50]): Code[100]
    var
        MemberBranch: Code[100];
    begin
        Cust.Reset;
        Cust.SetRange(Cust."No.", MemberNo);
        if Cust.Find('-') then
            MemberBranch := Cust."Global Dimension 2 Code";
        exit(MemberBranch);
    end;

    trigger OnAfterGetRecord()
    begin
        CurrPage.Editable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "Batch No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField(SalesSetup."Loans Batch Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Loans Batch Nos", xRec."No. Series", 0D, "Batch No.", "No. Series");
            "Document No." := "Batch No.";
            "Prepared By" := UserId;
            Source := Source::BOSA;
            xRec."Date Created" := Today;
        end;
    end;
}
