#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516031 "Funds Transfer Card"
{
    PageType = Card;
    SourceTable = "Funds Transfer Header";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Date; Date)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Paying Bank Account"; "Paying Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Paying Bank Name"; "Paying Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank Balance"; "Bank Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount to Transfer"; "Amount to Transfer")
                {
                    ApplicationArea = Basic;
                }
                field("Total Line Amount"; "Total Line Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque/Doc. No"; "Cheque/Doc. No")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Created"; "Date Created")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Created"; "Time Created")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    OptionCaption = 'Open,Pending Approval,Approved,Cancelled,Posted';
                }
            }
            part(Control24; "Funds Transfer Lines")
            {
                SubPageLink = "Document No" = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup25)
            {
                action(Post)
                {
                    ApplicationArea = Basic;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin

                        TempBatch.Reset;
                        TempBatch.SetRange(TempBatch.UserID, UserId);
                        if TempBatch.Find('-') then begin

                            "Inter Bank Template Name" := TempBatch."FundsTransfer Batch Name";
                            Message("Inter Bank Template Name");
                            "Inter Bank Journal Batch" := TempBatch."FundsTransfer Template Name";
                        end;

                        TestField(Status, Status::Approved);
                        TestField("Posting Date");
                        //TESTFIELD("Sending Responsibility Center");
                        TestField("Paying Bank Account");

                        //Check whether the two LCY amounts are same
                        //IF "Request Amt LCY" <>"Pay Amt LCY" THEN
                        // ERROR('The [Requested Amount in LCY: %1] should be same as the [Paid Amount in LCY: %2]',"Request Amt LCY" ,"Pay Amt LCY");

                        //get the source account balance from the database table
                        BankAcc.Reset;
                        BankAcc.SetRange(BankAcc."No.", "Paying Bank Account");
                        BankAcc.SetRange(BankAcc."Bank Type", BankAcc."bank type"::Cash);
                        if BankAcc.FindFirst then begin
                            BankAcc.CalcFields(BankAcc.Balance);
                            "Bank Balance" := BankAcc.Balance;
                            if ("Bank Balance" - "Amount to Transfer") < 0 then
                                Error('The transaction will result in a negative balance in a CASH ACCOUNT.');
                        end;
                        if "Amount to Transfer" = 0 then
                            Error('Please ensure Amount to Transfer is entered');
                        /*Check if the user's batch has any records within it*/

                        FundsLine.Reset;
                        FundsLine.SetRange(FundsLine."Document No", "No.");
                        if FundsLine.Find('-') then
                            repeat
                                GenJnlLine.Reset;
                                GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Inter Bank Template Name");
                                GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Inter Bank Journal Batch");
                                GenJnlLine.DeleteAll;

                                LineNo := 1000;
                                /*Insert the new lines to be updated*/
                                GenJnlLine.Init;
                                /*Insert the lines*/
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Source Code" := 'PAYMENTJNL';
                                GenJnlLine."Journal Template Name" := "Inter Bank Template Name";
                                GenJnlLine."Journal Batch Name" := "Inter Bank Journal Batch";
                                GenJnlLine."Posting Date" := "Posting Date";
                                GenJnlLine."Document No." := "No.";
                                /* IF "Receiving Transfer Type"="Receiving Transfer Type"::"Intra-Company" THEN
                                   BEGIN
                                     GenJnlLine."Account Type":=GenJnlLine."Account Type"::"Bank Account";
                                   END
                                 ELSE IF "Receiving Transfer Type"="Receiving Transfer Type"::"Inter-Company" THEN
                                   BEGIN
                                     GenJnlLine."Account Type":=GenJnlLine."Account Type"::"IC Partner";
                                   END;*/
                                GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
                                GenJnlLine."Account No." := FundsLine."Receiving Bank Account";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                GenJnlLine.Description := 'Inter-Bank Transfer Ref No:' + Format("No.");
                                //GenJnlLine."Shortcut Dimension 1 Code":="Receiving Depot Code";
                                //GenJnlLine."Shortcut Dimension 2 Code":="Receiving Department Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                //GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code1");
                                //GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code1");
                                //GenJnlLine."External Document No.":=fundline.e;
                                GenJnlLine.Description := Description;
                                if Description = '' then GenJnlLine.Description := 'Inter-Bank Transfer Ref No:' + Format("No.");
                                //GenJnlLine."Currency Code":="Currency Code Destination";
                                GenJnlLine.Validate(GenJnlLine."Currency Code");
                                /*IF "Currency Code Destination"<>'' THEN
                                  BEGIN
                                    GenJnlLine."Currency Factor":="Exch. Rate Destination";//"Reciprical 2";
                                    GenJnlLine.VALIDATE(GenJnlLine."Currency Factor");
                                  END*/
                                GenJnlLine.Amount := "Amount to Transfer";
                                GenJnlLine.Validate(GenJnlLine.Amount);
                                GenJnlLine.Insert;

                                GenJnlLine.Init;
                                /*Insert the lines*/
                                GenJnlLine."Line No." := LineNo + 1;
                                GenJnlLine."Source Code" := 'PAYMENTJNL';
                                GenJnlLine."Journal Template Name" := "Inter Bank Template Name";
                                GenJnlLine."Journal Batch Name" := "Inter Bank Journal Batch";
                                GenJnlLine."Posting Date" := "Posting Date";
                                GenJnlLine."Document No." := "No.";
                                /*IF "Source Transfer Type"="Source Transfer Type"::"Intra-Company" THEN
                                  BEGIN
                                    GenJnlLine."Account Type":=GenJnlLine."Account Type"::"Bank Account";
                                  END
                                ELSE IF "Source Transfer Type"="Source Transfer Type"::"Inter-Company" THEN
                                  BEGIN
                                    GenJnlLine."Account Type":=GenJnlLine."Account Type"::"IC Partner";
                                  END;
                                  */
                                GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
                                GenJnlLine."Account No." := "Paying Bank Account";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                //GenJnlLine."Shortcut Dimension 1 Code":="Source Depot Code";
                                //GenJnlLine."Shortcut Dimension 2 Code":="Source Department Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                // GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                                //GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                                GenJnlLine."External Document No." := FundsLine."External Doc No.";
                                GenJnlLine.Description := Description;
                                if Description = '' then GenJnlLine.Description := 'Inter-Bank Transfer Ref No:' + Format("No.");
                                //GenJnlLine."Currency Code":="Currency Code Source";
                                //GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                                /* IF "Currency Code Source"<>'' THEN
                                   BEGIN
                                     GenJnlLine."Currency Factor":="Exch. Rate Source";//"Reciprical 1";
                                     GenJnlLine.VALIDATE(GenJnlLine."Currency Factor");
                                   END;*/
                                GenJnlLine.Amount := -"Amount to Transfer";
                                GenJnlLine.Validate(GenJnlLine.Amount);
                                GenJnlLine.Insert;
                            until FundsLine.Next = 0;
                        Post := false;
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnlLine);

                        Posted := true;
                        "Date Posted" := Today;
                        "Time Posted" := Time;
                        "Posted By" := UserId;
                        Modify;
                    end;
                }
                separator(Action34)
                {
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
                    begin
                        if Status <> Status::Open then
                            Error('This batch is already %1', Format(Status));
                        if Confirm('Send Approval Request?', false) = false then
                            exit
                        else
                            SrestepApprovalsCodeUnit.SendPettyCashReimbersementRequestForApproval(rec."No.", Rec);
                        //CurrPage.Close();
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
                    begin
                        if Confirm('Cancel Approval Request?', false) = false then
                            exit
                        else
                            SrestepApprovalsCodeUnit.CancelPettyCashReimbersementRequestForApproval(rec."No.", Rec);
                        //CurrPage.Close();
                    end;
                }
                separator(Action30)
                {
                }
                action(Refresh)
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Refresh;
                    trigger OnAction()
                    begin
                        CurrPage.Update();
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        rec.Reset();
                        rec.SetRange(rec."No.", "No.");
                        if Rec.FindFirst()
                        then
                            Report.RunModal(Report::"Funds Transfer Voucher", true, false, Rec);
                    end;
                }
                separator(Action28)
                {
                }
                action("Cancel Document")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*TESTFIELD(Status,Status::Approved);
                        IF CONFIRM(Text000,TRUE) THEN  BEGIN
                        Status:=Status::Cancelled;
                        "Cancelled By":=USERID;
                        "Date Cancelled":=TODAY;
                        "Time Cancelled":=TIME;
                        MODIFY;
                        END ELSE
                          ERROR(Text001);*/
                    end;
                }
            }
            action(PostA)
            {
                ApplicationArea = Basic;
                Caption = 'Post Transfer';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    //Check Required Fields
                    CheckRequiredFields;

                    TestField("Posting Date");
                    TestField(Status, Status::Approved);

                    //Get Setups of the current UserID from Cash Office User Template
                    CashOfficeUserTemplate.Reset;
                    CashOfficeUserTemplate.SetRange(CashOfficeUserTemplate.UserID, UserId);
                    if CashOfficeUserTemplate.Find('-') then begin
                        "Inter Bank Template Name" := CashOfficeUserTemplate."FundsTransfer Template Name";
                        "Inter Bank Journal Batch" := CashOfficeUserTemplate."FundsTransfer Batch Name";
                    end;

                    //Check whether the "Line Amounts" to be Transfered is the same as "Amount to Transfer" in the header
                    CalcFields("Total Line Amount");
                    if "Total Line Amount" <> "Amount to Transfer" then
                        Error(Text001, "Amount to Transfer", "Total Line Amount");

                    //Check if the transaction will lead to a Negative Account Balance in the Paying Account Bank
                    BankAcc.Reset;
                    BankAcc.SetRange(BankAcc."No.", "Paying Bank Account");
                    if BankAcc.FindFirst then begin
                        BankAcc.CalcFields(BankAcc.Balance);

                        currBankBalance := BankAcc.Balance - "Amount to Transfer";
                        /*
                    //For normal banks with no Credit Agreement
                    IF (currBankBalance <= 0) AND NOT BankAcc."Credit Agreement?" THEN
                    BEGIN
                        ERROR(Text002,currBankBalance,"Paying Bank Account","Paying Account Name");
                    END;
                        */
                        //For banks with credit agreeement
                        if (currBankBalance <= 0) and (BankAcc."Credit Agreement?") then begin
                            NewBankBalanceAfterPost := BankAcc.Balance - "Amount to Transfer";
                            if NewBankBalanceAfterPost < BankAcc."Maximum Credit Limit" then
                                Error(Text006, "Paying Bank Account", "Paying Bank Name")
                            else
                                ;
                            //Do Nothing
                        end;
                    end;

                    //Clear Users Batch
                    GenJnlLine.Reset;
                    GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Inter Bank Template Name");
                    GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Inter Bank Journal Batch");
                    GenJnlLine.DeleteAll;

                    //Inserting Amounts of Accounts to be Debited into the Journal (+)
                    IBTLines.Reset;
                    IBTLines.SetRange(IBTLines."Document No", "No.");
                    if IBTLines.Find('-') then
                        repeat
                            Insert_IBTLines_to_Journal;
                        until IBTLines.Next = 0;

                    //Insert Amounts of Accounts to "Credit" (-) into the Journal
                    Insert_IBTHead_to_Journal;

                    Post := false;
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnlLine);
                    //Post:=JournalPostedSuccessfully.PostedSuccessfully();

                    //IF Post THEN BEGIN
                    Posted := true;
                    Status := Status::Posted;
                    "Date Posted" := Today;
                    "Time Posted" := Time;
                    "Posted By" := UserId;
                    //"Posted On Computer Name":='';
                    Modify;
                    Commit;
                    Message('The Journal Has Been Posted Successfully');

                    //END;

                    //MESSAGE('Lines transfered to Payments Journal and Batch Name %1 for posting',"Inter Bank Journal Batch");
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Created By" := UserId;
    end;

    var
        interbank: Record "Funds Transfer Header";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","FOSA Opening","Loan Batching",Leave,"Imprest Requisition","Imprest Surrender","Stores Requisition","Funds Transfer","Change Request","Staff Claims","BOSA Transfer","Loan Tranche","Loan TopUp","Memb Opening","Member Withdrawal";
        TempBatch: Record "Funds User Setup";
        "Inter Bank Template Name": Code[30];
        "Inter Bank Journal Batch": Code[30];
        BankAcc: Record "Bank Account";
        LineNo: Integer;
        FundsLine: Record "Funds Transfer Line";
        GenJnlLine: Record "Gen. Journal Line";
        CashOfficeUserTemplate: Record "Funds User Setup";
        JTemplate: Code[20];
        IBTLines: Record "Funds Transfer Line";
        Post: Boolean;
        currBankBalance: Decimal;
        NewBankBalanceAfterPost: Decimal;
        FHeader: Record "BOSA Transfer Schedule";
        Text001: label 'The [Requested Amount to Transfer in LCY: %1] should be same as the [Total Line Amount in LCY: %2]';
        Text002: label 'The Transaction will result in a negative Balance of [%1] in Bank Account [%2 - %3]';
        Text003: label 'Sorry you are not authorised to Cancel Petty Cash Documents. Please liase with the Approver (%1)';
        Text004: label 'Document % 1 is already POSTED and cannot be reverted to Pending';
        Text006: label 'The Transaction will result in a negative Maximum Credit Limit Balance of in Bank Account [%1 - %2]';

    procedure CheckRequiredFields()
    begin
        TestField("Amount to Transfer");
        //Check Lines if Cheque No has been specified
        IBTLines.Reset;
        IBTLines.SetRange(IBTLines."Document No", "No.");
        if IBTLines.Find('-') then
            repeat
                IBTLines.TestField(IBTLines."Pay Mode");
                if IBTLines."Pay Mode" = IBTLines."pay mode"::Cheque then
                    IBTLines.TestField(IBTLines."External Doc No.");
            until IBTLines.Next = 0;

        //Check whether the "Line Amounts" to be Transfered is the same as "Amount to Transfer" in the header
        CalcFields("Total Line Amount");
        if "Total Line Amount" <> "Amount to Transfer" then
            Error(Text001, "Amount to Transfer", "Total Line Amount");
    end;

    procedure Insert_IBTLines_to_Journal()
    begin
        //Get Last Line No in Journal
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Inter Bank Template Name");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Inter Bank Journal Batch");
        if GenJnlLine.Find('+') then
            LineNo := GenJnlLine."Line No." + 1
        else
            LineNo := 1000;

        //Insert Into Journal
        GenJnlLine.Init;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Journal Template Name" := "Inter Bank Template Name";
        GenJnlLine."Journal Batch Name" := "Inter Bank Journal Batch";
        GenJnlLine."Posting Date" := "Posting Date";
        GenJnlLine."Document No." := "No.";
        GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
        GenJnlLine."Account No." := IBTLines."Receiving Bank Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine.Description := 'Inter-Bank Transfer Ref No: ' + Format("No.");
        //GenJnlLine."Shortcut Dimension 1 Code":="Receiving Depot Code";
        //GenJnlLine."Shortcut Dimension 2 Code":="Receiving Department Code";
        //GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        //GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        //GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code1");
        //GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code1");
        GenJnlLine."External Document No." := IBTLines."External Doc No.";
        if Description = '' then
            GenJnlLine.Description := 'Inter-Bank Transfer Ref No: ' + Format("No.")
        else
            GenJnlLine.Description := Description;
        GenJnlLine."Currency Code" := IBTLines."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");

        if IBTLines."Currency Code" <> '' then begin
            GenJnlLine."Currency Factor" := IBTLines."Currency Factor";
            GenJnlLine.Validate(GenJnlLine."Currency Factor");
        end;

        GenJnlLine.Amount := IBTLines."Amount to Receive";
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine.Insert;
    end;

    procedure Insert_IBTHead_to_Journal()
    begin
        //Get Last Line No in Journal
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Inter Bank Template Name");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Inter Bank Journal Batch");
        if GenJnlLine.Find('+') then
            LineNo := GenJnlLine."Line No." + 1
        else
            LineNo := 1000;

        GenJnlLine.Init;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Journal Template Name" := "Inter Bank Template Name";
        GenJnlLine."Journal Batch Name" := "Inter Bank Journal Batch";
        GenJnlLine."Posting Date" := "Posting Date";
        GenJnlLine."Document No." := "No.";
        GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
        GenJnlLine."Account No." := "Paying Bank Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        //GenJnlLine."Shortcut Dimension 1 Code":="Source Depot Code";
        //GenJnlLine."Shortcut Dimension 2 Code":="Source Department Code";
        //GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        //GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        //GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
        //GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
        GenJnlLine."External Document No." := "Cheque/Doc. No";
        if Description = '' then
            GenJnlLine.Description := 'Inter-Bank Transfer Ref No:' + Format("No.")
        else
            GenJnlLine.Description := Description;
        //GenJnlLine."Currency Code":=;
        //GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
        //IF "Paying Account Currency Code" <> '' THEN
        // BEGIN
        GenJnlLine."Currency Factor" := IBTLines."Currency Factor";  //Exchange Rate of Paying Account
        GenJnlLine.Validate(GenJnlLine."Currency Factor");
        //END;
        GenJnlLine.Amount := -"Amount to Transfer";
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine.Insert;
    end;

    procedure UpdateControl()
    begin
        /*
        IF Status=Status::Open THEN BEGIN
            Currpage."Paying Bank Account".EDITABLE:=TRUE;
            Currpage.Description.EDITABLE:=TRUE;
            Currpage."Amount to Transfer".EDITABLE:=TRUE;
            Currpage.IBTLines.EDITABLE:=TRUE;
            //Currpage."Posting Date".EDITABLE:=FALSE;
            Currpage.UPDATECONTROLS;
        END;
        */
        if Status = Status::"Pending Approval" then
            CurrPage.Editable := false;
        //Currpage.UPDATECONTROLS
        /*
        IF Status=Status::Approved THEN
        BEGIN
            //message('');
            Currpage."Paying Bank Account".EDITABLE:=FALSE;
            Currpage.Description.EDITABLE:=FALSE;
            //Currpage."Amount to Transfer".EDITABLE:=FALSE;
            Currpage.IBTLines.EDITABLE:=FALSE;
            Currpage.UPDATECONTROLS;
        END;
        //Currpage.UPDATE(FALSE);
         */
    end;
}
