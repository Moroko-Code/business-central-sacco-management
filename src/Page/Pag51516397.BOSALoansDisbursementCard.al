Page 51516397 "BOSA Loans Disbursement Card"
{
    DeleteAllowed = false;
    // Editable = false;
    // ModifyAllowed = false;
    PageType = Card;
    InsertAllowed = false;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(Source = const(BOSA), Posted = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Loan  No."; "Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Client Code"; "Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';
                    Editable = MNoEditable;
                    ShowMandatory = true;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                    Style = StrongAccent;
                }
                field("Client Name"; "Client Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Member Deposits"; "Member Deposits")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        //TestField(Posted, false);
                    end;
                }
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    Editable = LProdTypeEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                    end;
                }
                field(Installments; Installments)
                {
                    ApplicationArea = Basic;
                    Editable = InstallmentEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field(Interest; Interest)
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                    Caption = 'Interest Rate';
                }
                field("Requested Amount"; "Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = AppliedAmountEditable;
                    ShowMandatory = true;
                    Style = Strong;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = false;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Main Sector"; "Main Sector")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Style = Ambiguous;
                    Editable = MNoEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Sub-Sector"; "Sub-Sector")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Style = Ambiguous;
                    Editable = MNoEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Specific Sector"; "Specific Sector")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Style = Ambiguous;
                    Editable = MNoEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = MNoEditable;
                    Visible = true;
                }
                field("Repayment Method"; "Repayment Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Principle Repayment"; "Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Interest Repayment"; "Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Repayment; Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Status"; "Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        UpdateControl();
                    end;
                }
                field("Approval Status"; "Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Repayment Frequency"; "Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    Editable = RepayFrequencyEditable;
                    Style = StrongAccent;
                    ShowMandatory = true;
                }
                field("Recovery Mode"; "Recovery Mode")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    ShowMandatory = true;
                    Editable = MNoEditable;
                }
                field("Mode of Disbursement"; "Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = MNoEditable;
                    ShowMandatory = true;
                }
                field("Paying Bank Account No"; "Paying Bank Account No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Batch No."; "Batch No.")
                {
                    Editable = true;
                    Visible = false;
                    ApplicationArea = Basic;
                }
                field("Loan Disbursement Date"; "Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    // Editable = MNoEditable;
                    Editable = true;
                    Style = StrongAccent;
                    ShowMandatory = true;
                }
                field("Repayment Start Date"; "Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Date of Completion"; "Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1000000004; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
                Editable = MNoEditable;
            }
            // part(Control1000000005; "Loan Collateral Security")
            // {
            //     Caption = 'Other Securities';
            //     SubPageLink = "Loan No" = field("Loan  No.");
            //     Editable = MNoEditable;
            // }
            part(Control1000000002; "Loan Appraisal Salary Details")
            {
                Caption = 'Salary Details';
                Editable = MNoEditable;
                SubPageLink = "Loan No" = field("Loan  No."), "Client Code" = field("Client Code");
            }
        }
        area(factboxes)
        {
            part("Member Statistics FactBox"; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                action("POST")
                {
                    ApplicationArea = all;
                    Caption = 'POST LOAN';
                    Enabled = true;
                    Image = PrepaymentPostPrint;
                    PromotedIsBig = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    // Visible = false;
                    trigger OnAction()
                    begin
                        If FnCanPostLoans(UserId) = false then
                            Error('Prohibited ! You are not allowed to POST this Loan');
                        if Posted = true then
                            Error('Prohibited ! The loan is already Posted');
                        if "Loan Status" <> "Loan Status"::Approved then
                            Error('Prohibited ! The loan is Status MUST be Approved');
                        if Confirm('Are you sure you want to POST Loan Approved amount of Ksh. ' + Format("Approved Amount") + ' to member -' + Format("Client Name") + ' ?', false) = false then
                            exit
                        else begin
                            TemplateName := 'GENERAL';
                            BatchName := 'LOANS';
                            LoanApps.Reset;
                            LoanApps.SetRange(LoanApps."Loan  No.", "Loan  No.");
                            if LoanApps.FindSet then begin
                                repeat
                                    FnInsertBOSALines(LoanApps, LoanApps."Loan  No.");
                                    GenJournalLine.RESET;
                                    GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
                                    GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
                                    if GenJournalLine.Find('-') then begin
                                        Page.Run(Page::"General Journal", GenJournalLine);

                                        // CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
                                        // FnSendNotifications(); //Send Notifications
                                        // "Loan Status" := "Loan Status"::Issued;
                                        // Posted := true;
                                        // "Posted By" := UserId;
                                        // "Posting Date" := Today;
                                        // "Issued Date" := "Loan Disbursement Date";
                                        // "Approval Status" := "Approval Status"::Approved;
                                        // "Loans Category-SASRA" := "Loans Category-SASRA"::Perfoming;
                                        // Modify();

                                    end;
                                until LoanApps.Next = 0;
                                //.................................................
                                Message('Loan has successfully been posted and member notified');
                                CurrPage.close();
                            end;
                        end;
                    end;
                }

                action("Cancel Approvals")
                {
                    ApplicationArea = all;
                    Caption = 'Cancel For Approval';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    //  visible = false;

                    trigger OnAction()
                    begin
                        if Confirm('Cancel Approval?', false) = false then
                            exit
                        else begin
                            SrestepApprovalsCodeUnit.CancelLoanApplicationsRequestForApproval(rec."Loan  No.", Rec);
                            CurrPage.Close();
                        end;
                    end;
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if ("Repayment Start Date" = 0D) then Error('Please enter Disbursement Date to continue');
                        SFactory.FnGenerateRepaymentSchedule("Loan  No.");
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then
                            Report.Run(51516477, true, false, LoanApp);
                    end;
                }
                action("Loans to Offset")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans to Offset';
                    //Enabled = (not OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist AND (not RecordApproved);
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Offset Detail List";
                    RunPageLink = "Loan No." = field("Loan  No."), "Client Code" = field("Client Code");
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(REC.RecordId); //Return No and allow sending of approval request.
        EnabledApprovalWorkflowsExist := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        LoansR.Reset;
        LoansR.SetRange(LoansR.Posted, false);
        LoansR.SetRange(LoansR."Captured By", UserId);
        if LoansR."Client Name" = '' then
            if LoansR.Count > 1 then
                if Confirm('There are still some Unused Loan Nos. Continue?', false) = false then
                    Error('There are still some Unused Loan Nos. Please utilise them first');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Source := Source::BOSA;
        "Mode of Disbursement" := "mode of disbursement"::Cheque;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
    end;

    trigger OnOpenPage()
    begin
        SetRange(Posted, false);
    end;

    var
        DirbursementDate: Date;
        VarAmounttoDisburse: Decimal;
        LoanGuar: Record "Loans Guarantee Details";
        SMSMessages: Record "SMS Messages";
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        Cust: Record Customer;
        LoanApp: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Product Charges";
        LoansR: Record "Loans Register";
        GenJournalLine: Record "Gen. Journal Line";
        LoanTopUp: Record "Loan Offset Details";
        DActivity: Code[20];
        DBranch: Code[20];
        Notification: Codeunit Mail;
        SMSMessage: Record "SMS Messages";
        LoanApps: Record "Loans Register";
        LoanStatusEditable: Boolean;
        MNoEditable: Boolean;
        ApplcDateEditable: Boolean;
        LProdTypeEditable: Boolean;
        InstallmentEditable: Boolean;
        AppliedAmountEditable: Boolean;
        ApprovedAmountEditable: Boolean;
        RepayMethodEditable: Boolean;
        RepaymentEditable: Boolean;
        BatchNoEditable: Boolean;
        RepayFrequencyEditable: Boolean;
        ModeofDisburesmentEdit: Boolean;
        DisbursementDateEditable: Boolean;
        AccountNoEditable: Boolean;
        RejectionRemarkEditable: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        compinfo: Record "Company Information";
        iEntryNo: Integer;
        eMAIL: Text;
        EditableField: Boolean;
        SFactory: Codeunit "SURESTEP Factory";
        OpenApprovalEntriesExist: Boolean;
        TemplateName: Code[50];
        BatchName: Code[50];
        EnabledApprovalWorkflowsExist: Boolean;
        RecordApproved: Boolean;
        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
        CanCancelApprovalForRecord: Boolean;

    procedure UpdateControl()
    begin
        if "Loan Status" = "loan status"::Application then begin
            RecordApproved := false;
            MNoEditable := true;
            ApplcDateEditable := false;
            LoanStatusEditable := true;
            LProdTypeEditable := true;
            InstallmentEditable := true;
            AppliedAmountEditable := true;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := true;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
            CanCancelApprovalForRecord := false;
        end;
        if "Loan Status" = "loan status"::Appraisal then begin
            RecordApproved := true;
            MNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
            CanCancelApprovalForRecord := true;
        end;
        if "Loan Status" = "loan status"::Rejected then begin
            RecordApproved := true;
            MNoEditable := false;
            AccountNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := false;
            DisbursementDateEditable := false;
            RejectionRemarkEditable := false;
            CanCancelApprovalForRecord := false;
        end;
        if "Approval Status" = "approval status"::Approved then begin
            RecordApproved := true;
            MNoEditable := false;
            AccountNoEditable := false;
            LoanStatusEditable := false;
            ApplcDateEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := true;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := true;
            RejectionRemarkEditable := false;
            RecordApproved := true;
            CanCancelApprovalForRecord := true;
        end;
    end;

    procedure LoanAppPermisions()
    begin
    end;

    procedure SendSMS()
    begin
        GenSetUp.Get;
        compinfo.Get;
        if GenSetUp."Send SMS Notifications" = true then begin
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
            SMSMessage."Batch No" := "Batch No.";
            SMSMessage."Document No" := "Loan  No.";
            SMSMessage."Account No" := "Account No";
            SMSMessage."Date Entered" := Today;
            SMSMessage."Time Entered" := Time;
            SMSMessage.Source := 'LOANS';
            SMSMessage."Entered By" := UserId;
            SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
            SMSMessage."SMS Message" := 'Your Loan Application of amount ' + Format("Requested Amount") + ' for ' + "Client Code" + ' ' + "Client Name" + ' has been received and is being Processed ' + compinfo.Name + ' ' + GenSetUp."Customer Care No";
            Cust.Reset;
            Cust.SetRange(Cust."No.", "Client Code");
            if Cust.Find('-') then
                SMSMessage."Telephone No" := Cust."Mobile Phone No";
            SMSMessage.Insert;
        end;
    end;

    procedure SendMail()
    begin
        GenSetUp.Get;
        if Cust.Get(LoanApps."Client Code") then
            eMAIL := Cust."E-Mail (Personal)";
        if GenSetUp."Send Email Notifications" = true then begin
            Notification.CreateMessage('Dynamics NAV', GenSetUp."Sender Address", eMAIL, 'Loan Receipt Notification', 'Loan application ' + LoanApps."Loan  No." + ' , ' + LoanApps."Loan Product Type" + ' has been received and is being processed' + ' (Dynamics NAV ERP)', true, false);
            Notification.Send;
        end;
    end;

    local procedure FnCheckForTestFields()
    var
        LoanType: Record "Loan Products Setup";
        LoanGuarantors: Record "Loans Guarantee Details";
    begin
        //--------------------
        if "Approval Status" = "Approval Status"::Approved then
            Error('The loan has already been approved');
        if "Approval Status" <> "Approval Status"::Open then
            Error('Approval status MUST be Open');
        TestField("Requested Amount");
        TestField("Main Sector");
        TestField("Sub-Sector");
        TestField("Specific Sector");
        TestField("Loan Product Type");
        TestField("Mode of Disbursement");
        //----------------------
        if LoanType.get("Loan Product Type") then
            if LoanType."Appraise Guarantors" = true then begin
                LoanGuarantors.Reset();
                LoanGuarantors.SetRange(LoanGuarantors."Loan No", "Loan  No.");
                if LoanGuarantors.find('-') then
                    Error('Please Insert Loan Applicant Guarantor Details!');
            end;
    end;

    local procedure FnSendLoanApprovalNotifications()
    var
    begin
        //...........................Notify Loaner
        SMSMessages.RESET;
        IF SMSMessages.FIND('+') THEN BEGIN
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        END
        ELSE
            iEntryNo := 1;
        SMSMessages.RESET;
        SMSMessages.INIT;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Account No" := "Client Code";
        SMSMessages."Date Entered" := TODAY;
        SMSMessages."Time Entered" := TIME;
        SMSMessages.Source := 'LOAN APPL';
        SMSMessages."Entered By" := USERID;
        SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
        SMSMessages."SMS Message" := 'Your loan application of KSHs.' + FORMAT("Requested Amount") + ' has been received. Devco Sacco Ltd.';
        Cust.RESET;
        IF Cust.GET("Client Code") THEN
            if Cust."Mobile Phone No" <> '' then
                SMSMessages."Telephone No" := Cust."Mobile Phone No"
            else
                if (Cust."Mobile Phone No" = '') and (Cust."Mobile Phone No." <> '') then
                    SMSMessages."Telephone No" := Cust."Phone No.";
        SMSMessages.INSERT;
        //.......................................Notify Guarantors
        LoanGuar.RESET;
        LoanGuar.SETRANGE(LoanGuar."Loan No", "Loan  No.");
        IF LoanGuar.FIND('-') THEN
            REPEAT
                Cust.RESET;
                Cust.SETRANGE(Cust."No.", LoanGuar."Member No");
                IF Cust.FIND('-') THEN BEGIN
                    SMSMessages.RESET;
                    IF SMSMessages.FIND('+') THEN BEGIN
                        iEntryNo := SMSMessages."Entry No";
                        iEntryNo := iEntryNo + 1;
                    END
                    ELSE
                        iEntryNo := 1;
                    SMSMessages.INIT;
                    SMSMessages."Entry No" := iEntryNo;
                    SMSMessages."Account No" := LoanGuar."Member No";
                    SMSMessages."Date Entered" := TODAY;
                    SMSMessages."Time Entered" := TIME;
                    SMSMessages.Source := 'LOAN GUARANTORS';
                    SMSMessages."Entered By" := USERID;
                    SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
                    IF LoanApp.GET(LoanGuar."Loan No") THEN SMSMessages."SMS Message" := 'You have guaranteed an amount of ' + FORMAT(LoanGuar."Amont Guaranteed") + ' to ' + "Client Name" + '  ' + 'Loan Type ' + "Loan Product Type" + ' ' + 'of ' + FORMAT("Requested Amount") + ' at Devco Sacco Ltd. Call 0726050260 if in dispute';
                    ;
                    SMSMessages."Telephone No" := Cust."Phone No.";
                    SMSMessages.INSERT;
                END;
            UNTIL LoanGuar.NEXT = 0;
    end;

    local procedure FnMemberHasAnExistingLoanSameProduct(): Boolean
    var
        LoansReg: Record "Loans Register";
        Balance: Decimal;
    begin
        Balance := 0;
        LoansReg.Reset();
        LoansReg.SetRange(LoansReg."Client Code", "Client Code");
        LoansReg.SetRange(LoansReg."Loan Product Type", "Loan Product Type");
        LoansReg.SetRange(LoansReg.Posted, true);
        LoansReg.SetAutoCalcFields(LoansReg."Outstanding Balance");
        if LoansReg.Find('-') then
            repeat
                Balance += LoansReg."Outstanding Balance";
            until LoansReg.Next = 0;
        if Balance > 0 then
            exit(true)
        else
            if Balance <= 0 then
                exit(false);
    end;

    local procedure FnGetProductOutstandingBal(): Decimal
    var
        LoansReg: Record "Loans Register";
        Balance: Decimal;
    begin
        Balance := 0;
        LoansReg.Reset();
        LoansReg.SetRange(LoansReg."Client Code", "Client Code");
        LoansReg.SetRange(LoansReg."Loan Product Type", "Loan Product Type");
        LoansReg.SetRange(LoansReg.Posted, true);
        LoansReg.SetAutoCalcFields(LoansReg."Outstanding Balance");
        if LoansReg.Find('-') then
            repeat
                Balance += LoansReg."Outstanding Balance";
            until LoansReg.Next = 0;
        exit(Balance);
    end;

    local procedure FnInsertBOSALines(var LoanApps: Record "Loans Register"; LoanNo: Code[30])
    var
        EndMonth: Date;
        RemainingDays: Integer;
        TMonthDays: Integer;
        Sfactorycode: Codeunit "SURESTEP Factory";
        AmountTop: Decimal;
        NetAmount: Decimal;
        LoanInsurance: Decimal;
        LProdSetup: Record "Loan Products Setup";
        UpfrontInterest: Decimal;
    begin
        AmountTop := 0;
        UpfrontInterest := 0;
        NetAmount := 0;
        LoanInsurance := 0;

        //--------------------Generate Schedule
        Sfactorycode.FnGenerateRepaymentSchedule("Loan  No.");
        DirbursementDate := "Loan Disbursement Date";
        VarAmounttoDisburse := "Approved Amount";
        //....................PRORATED DAYS
        EndMonth := CALCDATE('-1D', CALCDATE('1M', DMY2DATE(1, DATE2DMY(Today, 2), DATE2DMY(Today, 3))));
        RemainingDays := (EndMonth - Today) + 1;
        TMonthDays := DATE2DMY(EndMonth, 1);
        //....................Ensure that If Batch doesnt exist then create
        IF NOT GenBatch.GET(TemplateName, BatchName) THEN BEGIN
            GenBatch.INIT;
            GenBatch."Journal Template Name" := TemplateName;
            GenBatch.Name := BatchName;
            GenBatch.INSERT;
        END;
        //....................Reset General Journal Lines
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
        GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
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
        SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, "Loan  No.", LineNo, GenJournalLine."Transaction Type"::Loan, GenJournalLine."Account Type"::Customer, "Client Code", DirbursementDate, VarAmounttoDisburse, 'BOSA', LoanApps."Loan  No.", 'Loan Disbursement - ' + LoanApps."Loan Product Type", LoanApps."Loan  No.");
        //--------------------------------RECOVER OVERDRAFT()-------------------------------------------------------
        //Code Here
        if LProdSetup.Get("Loan Product Type") then begin
            //Charge SAIDIKA and SHORT-TERM 
            if LProdSetup."Charge Interest Upfront" then begin
                UpfrontInterest := Round(LoanApps."Approved Amount" * ((LProdSetup."Interest rate" / 1200) * LoanApps.Installments), 1, '=');
                //Interest to charge

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, "Loan  No.", LineNo, GenJournalLine."Transaction Type"::Loan,
                GenJournalLine."Account Type"::Customer, "Client Code", DirbursementDate, UpfrontInterest, 'BOSA', LoanApps."Loan  No.",
                'Loan Interest upfront for ' + Format(LoanApps."Loan  No."), LoanApps."Loan  No.");

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, "Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"G/L Account", LProdSetup."Loan Interest Account", DirbursementDate, -UpfrontInterest, 'BOSA', LoanApps."Loan  No.",
                'Loan Interest upfront for ' + Format(LoanApps."Loan  No."), LoanApps."Loan  No.");
            end;
            //End of Charge SAIDIKA and SHORT-TERM 
        end;

        //...................Cater for Loan Offset Now !
        CalcFields("Top Up Amount");
        if "Top Up Amount" > 0 then begin
            LoanTopUp.RESET;
            LoanTopUp.SETRANGE(LoanTopUp."Loan No.", "Loan  No.");
            LoanTopUp.SetRange(LoanTopUp."Client Code", "Client Code");
            IF LoanTopUp.FIND('-') THEN
                repeat
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, "Loan  No.", LineNo, GenJournalLine."Transaction Type"::Repayment, GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, LoanTopUp."Principle Top Up" * -1, 'BOSA', LoanApps."Loan  No.", 'Loan OffSet By - ' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Top up Account", DirbursementDate, LoanTopUp.Commision * -1, 'BOSA', "Batch No.", 'Commision on top up - ', LoanTopUp."Loan Top Up");
                    //If there is top up commission charged write it here end
                    AmountTop := (LoanTopUp."Principle Top Up" + LoanTopUp.Commision);
                    VarAmounttoDisburse := VarAmounttoDisburse - (LoanTopUp."Principle Top Up" + LoanTopUp.Commision);
                UNTIL LoanTopUp.NEXT = 0;
        end;
        //If there is top up commission 

        VarAmounttoDisburse := VarAmounttoDisburse - "Loan Insurance";

        //***************************Loan Product Charges code
        PCharges.Reset();
        PCharges.SETRANGE(PCharges."Product Code", "Loan Product Type");
        IF PCharges.FIND('-') THEN
            REPEAT
                PCharges.TESTFIELD(PCharges."G/L Account");
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := TemplateName;
                GenJournalLine."Journal Batch Name" := BatchName;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                GenJournalLine."Account No." := PCharges."G/L Account";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No." := "Loan  No.";
                GenJournalLine."External Document No." := "Loan  No.";
                GenJournalLine."Posting Date" := DirbursementDate;
                GenJournalLine.Description := PCharges.Description + '-' + Format("Loan  No.");
                IF PCharges."Use Perc" = TRUE THEN
                    GenJournalLine.Amount := Round(("Approved Amount" * (PCharges.Percentage / 100)) * -1, 1)
                ELSE
                    IF PCharges."Use Perc" = false then
                        GenJournalLine.Amount := Round(PCharges.Amount * -1, 1);
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;
            UNTIL PCharges.NEXT = 0;
        //end of code

        //Debosting amount
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ",
        GenJournalLine."Account Type"::"G/L Account", GenSetUp."Boosting Fees Account", DirbursementDate, LoanApps."Deboost Commision" * -1,
         'BOSA', "Batch No.", 'Debosting commision ' + Format(LoanApps."Loan  No."), '');
        VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Deboost Commision";

        //..Legal Fees
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Legal Fees", DirbursementDate, LoanApps."Legal Cost" * -1, 'BOSA', "Batch No.", 'Loan Principle Amount ' + Format(LoanApps."Loan  No."), '');
        // VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Legal Cost";
        //------------------------------------2. CREDIT MEMBER BANK A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, "Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"Bank Account", LoanApps."Paying Bank Account No", DirbursementDate, VarAmounttoDisburse * -1, 'BOSA', LoanApps."Loan  No.", 'Loan Principle Amount ' + Format("Loan  No."), '');
    end;

    local procedure FnSendNotifications()
    var
        msg: Text[250];
        PhoneNo: Text[250];
    begin
        LoansR.Reset();
        LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");
        if LoansR.Find('-') then begin
            msg := '';
            msg := 'Dear Member, Your ' + Format(LoansR."Loan Product Type") + ' loan application of KSHs.' + Format("Requested Amount") + ' has been processed and it will be deposited to your Bank Account.';
            PhoneNo := FnGetPhoneNo("Client Code");
            SendSMSMessage("Client Code", msg, PhoneNo);
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

    local procedure FnCanPostLoans(UserId: Text): Boolean
    var
        UserSetUp: Record "User Setup";
    begin
        if UserSetUp.get(UserId) then
            if UserSetUp."Can POST Loans" = true then
                exit(true);
        exit(false);
    end;
}
