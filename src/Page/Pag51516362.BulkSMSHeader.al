#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516362 "Bulk SMS Header"
{
    SourceTable = "Bulk SMS Header";

    layout
    {
        area(content)
        {
            field(No; No)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Date Entered"; "Date Entered")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Time Entered"; "Time Entered")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Entered By"; "Entered By")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("SMS Type"; "SMS Type")
            {
                ApplicationArea = Basic;
            }
            field("SMS Status"; "SMS Status")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Status Date"; "Status Date")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Status Time"; "Status Time")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Status By"; "Status By")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field(Message; Message)
            {
                ApplicationArea = Basic;
                Editable = Mssage;
            }
            part(Control1000000012; "Bulk SMS Lines Part")
            {
                Caption = '<Bulk SMS Lines>';
                Editable = BulkSMSLines;
                SubPageLink = No = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Send)
            {
                ApplicationArea = Basic;
                Image = PutawayLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if "SMS Status" <> "sms status"::Pending then
                        Error('This sms has already been sent');
                    if Confirm('Are you sure you would like to send the SMS(ES)?', false) = true then begin
                        if "SMS Type" <> "sms type"::Telephone then
                            TestField(Message);

                        if "SMS Type" = "sms type"::Telephone then
                            if "Use Line Message" = true then
                                TestField(Message);

                        BulkHeader.Reset;
                        BulkHeader.SetRange(BulkHeader.No, No);
                        if BulkHeader.Find('-') then begin

                            //ALL
                            if BulkHeader."SMS Type" = BulkHeader."sms type"::Everyone then begin
                                Vend.Reset;
                                Vend.SetRange(Vend."Creditor Type", Vend."creditor type"::Account);
                                Vend.SetRange(Vend."Vendor Posting Group", 'ORDINARY');
                                if Vend.Find('-') then
                                    repeat
                                        //SMS MESSAGE
                                        SMSMessage.Reset;
                                        if SMSMessage.Find('+') then begin
                                            iEntryNo := SMSMessage."Entry No";
                                            iEntryNo := iEntryNo + 1;
                                        end
                                        else
                                            iEntryNo := 1;

                                        SMSMessage.Init;
                                        SMSMessage."Entry No" := iEntryNo;
                                        SMSMessage."Batch No" := No;
                                        SMSMessage."Document No" := '';
                                        SMSMessage."Account No" := Vend."No.";
                                        SMSMessage."Date Entered" := Today;
                                        SMSMessage."Time Entered" := Time;
                                        SMSMessage.Source := 'BULK';
                                        SMSMessage."Entered By" := UserId;
                                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                                        SMSMessage."SMS Message" := Message;

                                        if Vend."Phone No." <> '' then
                                            SMSMessage."Telephone No" := Vend."Phone No."
                                        else if Vend."Mobile Phone No" <> '' then
                                            SMSMessage."Telephone No" := Vend."Mobile Phone No"
                                        else
                                            SMSMessage."Telephone No" := Vend."MPESA Mobile No";

                                        if SMSMessage."Telephone No" <> '' then
                                            SMSMessage.Insert;

                                    //IF Vend."MPESA Mobile No"<>'' THEN
                                    //SMSMessage.INSERT;
                                    until Vend.Next = 0;
                            end;

                            /*
                            //DIMENSION
                            IF BulkHeader."SMS Type"=BulkHeader."SMS Type"::Dimension THEN BEGIN
                            BulkLines.RESET;
                            BulkLines.SETRANGE(BulkLines.No,No);
                            IF BulkLines.FIND('-') THEN BEGIN
                            REPEAT

                            Vend.RESET;
                            Vend.SETRANGE(Vend."Creditor Type",Vend."Creditor Type"::Account);
                            Vend.SETRANGE(Vend."Vendor Posting Group",'SAVINGS');
                            Vend.SETRANGE(Vend."Global Dimension 1 Code",BulkLines.Code);
                            IF Vend.FIND('-') THEN BEGIN
                            REPEAT
                            //SMS MESSAGE
                            SMSMessage.RESET;
                            IF SMSMessage.FIND('+') THEN BEGIN
                            iEntryNo:=SMSMessage."Entry No";
                            iEntryNo:=iEntryNo+1;
                            END
                            ELSE BEGIN
                            iEntryNo:=1;
                            END;

                            SMSMessage.INIT;
                            SMSMessage."Entry No":=iEntryNo;
                            SMSMessage."Batch No":=No;
                            SMSMessage."Document No":='';
                            SMSMessage."Account No":=Vend."No.";
                            SMSMessage."Date Entered":=TODAY;
                            SMSMessage."Time Entered":=TIME;
                            SMSMessage.Source:='BULK';
                            SMSMessage."Entered By":=USERID;
                            SMSMessage."Sent To Server":=SMSMessage."Sent To Server"::No;
                            SMSMessage."SMS Message":=Message;
                            SMSMessage."Telephone No":=Vend."MPESA Mobile No";
                            IF Vend."MPESA Mobile No"<>'' THEN
                            SMSMessage.INSERT;
                            UNTIL Vend.NEXT=0
                            END;
                            UNTIL BulkLines.NEXT=0
                            END;
                            END;
                            */

                            //Telephone
                            if BulkHeader."SMS Type" = BulkHeader."sms type"::Telephone then begin
                                BulkLines.Reset;
                                BulkLines.SetRange(BulkLines.No, No);
                                if BulkLines.Find('-') then
                                    repeat

                                        //SMS MESSAGE
                                        SMSMessage.Reset;
                                        if SMSMessage.Find('+') then begin
                                            iEntryNo := SMSMessage."Entry No";
                                            iEntryNo := iEntryNo + 1;
                                        end
                                        else
                                            iEntryNo := 1;

                                        SMSMessage.Init;
                                        SMSMessage."Entry No" := iEntryNo;
                                        SMSMessage."Batch No" := No;
                                        SMSMessage."Document No" := '';
                                        SMSMessage."Account No" := BulkLines."Phone No";
                                        SMSMessage."Date Entered" := Today;
                                        SMSMessage."Time Entered" := Time;
                                        SMSMessage.Source := 'BULK';
                                        SMSMessage."Entered By" := UserId;
                                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                                        if "Use Line Message" = true then
                                            SMSMessage."SMS Message" := Message
                                        else
                                            //SMSMessage."SMS Message":=BulkLines.Description;

                                            SMSMessage."SMS Message" := Message;

                                        SMSMessage."Telephone No" := BulkLines."Phone No";
                                        if BulkLines."Phone No" <> '' then
                                            SMSMessage.Insert;
                                    until BulkLines.Next = 0;
                            end;
                        end;

                        "SMS Status" := "sms status"::Sent;
                        "Status Date" := Today;
                        "Status Time" := Time;
                        "Status By" := UserId;
                        Modify;
                    end;
                end;
            }
            action("Import Telephone Nos")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    if "SMS Type" <> "sms type"::Telephone then
                        Error('SMS Type must be Telephone.');

                    BulkHeader.Reset;
                    BulkHeader.SetRange(BulkHeader.No, No);
                    if BulkHeader.Find('-') then begin
                        BulkLines.Reset;
                        BulkLines.SetRange(BulkLines.No, BulkHeader.No);
                        Xmlport.Run(51516015);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    var
        BulkHeader: Record "Bulk SMS Header";
        BulkLines: Record "Bulk SMS Lines";
        Vend: Record Vendor;
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        StatusPermissions: Record "Status Change Permision";
        ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,ImprestSurrender,"MSacco Applications","MSacco PinChange","MSacco PhoneChange","MSacco TransChange",BulkSMS;
        text001: label 'Status must be Open';
        text002: label 'Status must be Pending';
        Mssage: Boolean;
        UseHeader: Boolean;
        BulkSMSLines: Boolean;

    procedure UpdateControl()
    begin
        if Status = Status::Open then begin
            Mssage := true;
            UseHeader := true;
            BulkSMSLines := true;
        end;

        if Status = Status::Pending then begin
            Mssage := false;
            UseHeader := false;
            BulkSMSLines := false;
        end;

        if Status = Status::Rejected then begin
            Mssage := false;
            UseHeader := false;
            BulkSMSLines := false;
        end;

        if Status = Status::Approved then begin
            Mssage := false;
            UseHeader := false;
            BulkSMSLines := false;
        end;
    end;
}
