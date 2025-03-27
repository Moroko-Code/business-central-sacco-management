#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516245 "Loan Application Card"
{
    DeleteAllowed = true;
    Editable = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(Source = const(BOSA),
                            Posted = const(false));
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
                    Caption = 'Member';
                    Editable = MNoEditable;
                    ShowMandatory = true;
                }
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    Editable = LProdTypeEditable;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        if FnMemberHasAnExistingLoanSameProduct() = true then begin
                            if Confirm(('The Member Has An Existing Loan Of Product-' + Format("Loan Product Type") + ' with an outstanding balance of Ksh. ' + Format(FnGetProductOutstandingBal()) + ' Do you want to Top Up?'), false) = true then
                                exit else
                                Error('Cannot Proceed');
                        end;
                    end;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                    Style = StrongAccent;
                    Visible = false;
                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = all;
                    Visible = false;
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
                    Editable = false;
                }
                field(Mulitiplier; Mulitiplier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Deposits Mulitiplier"; "Deposits Mulitiplier")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Existing Loan"; "Existing Loan")
                {
                    ApplicationArea = basic;
                    Editable = false;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Estimated Years to Retire"; "Estimated Years to Retire")
                {
                    ApplicationArea = all;
                    Editable = false;
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
                field("Deboost Commision"; "Deboost Commision")
                {
                    ApplicationArea = all;
                    Caption = 'Deboost Commision';
                    // Editable = false;
                }
                field("Deboost Loan"; "Deboost Loan Applied")
                {
                    ApplicationArea = all;
                    Caption = 'Initiate Bulk Deposit';
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        Loanoffeset: Record "Loan Offset Details";
                        OffesetAmount: Decimal;
                        DebostAmount: Decimal;
                    begin
                        if "Deboost Loan Applied" = true then begin
                            // OffesetAmount := 0;
                            // Loanoffeset.Reset();
                            // Loanoffeset.SetRange("Loan No.", "Loan  No.");
                            // if Loanoffeset.FindSet() then
                            //     repeat
                            //         OffesetAmount := OffesetAmount + Loanoffeset."Principle Top Up"
                            //     Until Loanoffeset.Next = 0;
                            // DebostAmount := 0;
                            // if ("Member Deposits" * Mulitiplier) < ((rec."Requested Amount" + "Existing Loan") - OffesetAmount) then begin
                            //     DebostAmount := ((((rec."Requested Amount" + ("Existing Loan" - OffesetAmount))) - ("Member Deposits" * Mulitiplier)) / Mulitiplier);
                            //     // "Deboost Commision" := DebostAmount * 0.1;
                            //     rec.Modify;
                            page.Run(Page::"BOSA Receipts List");
                        end;
                    end;
                    //end;
                }

                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = false;
                    ShowMandatory = true;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Recommended Amount"; "Recommended Amount")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Main Sector"; "Main Sector")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = false;
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
                    ShowMandatory = false;
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
                    ShowMandatory = false;
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
                field("Valuation Cost"; "Valuation Cost")
                {
                    Visible = false;
                    ApplicationArea = Basic;
                }
                field("Legal Cost"; "Legal Cost")
                {
                    ApplicationArea = all;
                    Visible = false;
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
                    Editable = false;
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
                field("Loan Disbursement Date"; "Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    // Editable = MNoEditable;
                    Editable = true;
                    Style = StrongAccent;
                    ShowMandatory = true;
                }
                field("Paying Bank Account No"; "Paying Bank Account No")
                {
                    ApplicationArea = basic;
                    Editable = false;
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
                field("Total TopUp Commission"; "Total TopUp Commission")
                {
                    ApplicationArea = Basic;
                    Editable = MNoEditable;
                    Visible = false;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1000000003; "Loans CheckRisk List")
            {
                Caption = 'Loan Risk Checking';
                ApplicationArea = Basic;
                SubPageLink = "Client Code" = field("Client Code");
                Editable = false;
            }
            part(Control1000000004; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                ApplicationArea = Basic;
                SubPageLink = "Loan No" = field("Loan  No.");
                Editable = MNoEditable;
            }
            part(Control1000000005; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                ApplicationArea = Basic;
                SubPageLink = "Loan No" = field("Loan  No.");
                Editable = MNoEditable;
            }
            // part(Control1000000002; "Loan Appraisal Salary Details")
            // {
            //     Caption = 'Salary Details';
            //     ApplicationArea = Basic;
            //     Editable = MNoEditable;
            //     SubPageLink = "Loan No" = field("Loan  No."),
            //                   "Client Code" = field("Client Code");
            // }
        }
        area(factboxes)
        {
            part("Member Statistics FactBox"; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                Caption = 'Loan';
                Image = AnalysisView;

                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = Aging;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(Report::"Loan Appraisal", true, false, LoanApp);
                        end;

                    end;
                }
                action("Send Approvals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send For Approval';
                    Enabled = (not OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist AND (not RecordApproved);
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        if "Approved Amount" > 0 then begin
                            FnCheckForTestFields();
                            if Confirm('Send Approval Request For Loan Application of Ksh. ' + Format("Approved Amount") + ' applied by ' + Format("Client Name") + ' ?', false) = false then
                                exit
                            else begin
                                SrestepApprovalsCodeUnit.SendLoanApplicationsRequestForApproval(rec."Loan  No.", Rec);
                                FnSendLoanApprovalNotifications();
                                CurrPage.close();
                            end;
                        end else
                            Message('Appproved Amount cannot be Zero');
                    end;
                }
                action("Cancel Approvals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel For Approval';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
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
                action("Member Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = Report;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "Client Code");
                        Report.Run(51516223, true, false, Cust);
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
                        if ("Repayment Start Date" = 0D) then
                            Error('Please enter Disbursement Date to continue');

                        SFactory.FnGenerateRepaymentSchedule("Loan  No.");

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then
                            Report.Run(51516477, true, false, LoanApp);
                    end;
                }
                separator(Action1102755012)
                {
                }
                action("Loans to Offset")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans to Offset';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Offset Detail List";
                    RunPageLink = "Loan No." = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
                action("Loan Appraisal Salary Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal Salary Details';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Appraisal Salary Details";
                    RunPageLink = "Loan No" = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(REC.RecordId);//Return No and allow sending of approval request.

        EnabledApprovalWorkflowsExist := true;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControl();
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
        "Mode of Disbursement" := "mode of disbursement"::"Cheque";
        "Mode of Disbursement" := "Mode Of Disbursement"::Cash;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
    end;

    trigger OnOpenPage()
    begin
        SetRange(Posted, false);
    end;

    var
        LoanGuar: Record "Loans Guarantee Details";
        SMSMessages: Record "SMS Messages";
        i: Integer;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "Loan Repayment Schedule";
        RSchedule: Record "Loan Repayment Schedule";
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record "Loan Repayment Schedule";
        PeriodInterval: Code[10];
        CustomerRecord: Record Customer;
        Gnljnline: Record "Gen. Journal Line";
        //  Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record Customer;
        EmailCodeunit: Codeunit Emailcodeunit;
        SurestepFactory: Codeunit "SURESTEP Factory";
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record Customer;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        LoansR: Record "Loans Register";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        TotalTopupComm: Decimal;
        //Notification: Codeunit Mail;
        CustE: Record Customer;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Special Clearance";
        SMSMessage: Record "SMS Messages";
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record "Loan Disburesment-Batching";
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loans Register";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        Text001: label 'Status Must Be Open';
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","FOSA Opening","Loan Batching",Leave,"Imprest Requisition","Imprest Surrender","Stores Requisition","Funds Transfer","Change Request","Staff Claims","BOSA Transfer","Loan Tranche","Loan TopUp","Memb Opening","Member Withdrawal";
        CurrpageEditable: Boolean;
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
        LNBalance: Decimal;
        ApprovalEntries: Record "Approval Entry";
        RejectionRemarkEditable: Boolean;
        ApprovalEntry: Record "Approval Entry";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        compinfo: Record "Company Information";
        iEntryNo: Integer;
        eMAIL: Text;
        "Telephone No": Integer;
        Text002: label 'The Loan has already been approved';
        LoanSecurities: Integer;
        EditableField: Boolean;
        SFactory: Codeunit "SURESTEP Factory";
        OpenApprovalEntriesExist: Boolean;

        EnabledApprovalWorkflowsExist: Boolean;
        RecordApproved: Boolean;
        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
        CanCancelApprovalForRecord: Boolean;

    procedure UpdateControl()
    begin
        MNoEditable := true;
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
            CanCancelApprovalForRecord := false;
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
            SMSMessage."SMS Message" := 'Your Loan Application of amount ' + Format("Requested Amount") + ' for ' +
            "Client Code" + ' ' + "Client Name" + ' has been received and is being Processed ' + compinfo.Name + ' ' + GenSetUp."Customer Care No";
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

        // if GenSetUp."Send Email Notifications" = true then begin

        //     Notification.CreateMessage('Dynamics NAV', GenSetUp."Sender Address", eMAIL, 'Loan Receipt Notification',
        //                     'Loan application ' + LoanApps."Loan  No." + ' , ' + LoanApps."Loan Product Type" + ' has been received and is being processed'
        //                    + ' (Dynamics NAV ERP)', true, false);

        //     Notification.Send;

        // end;
    end;

    local procedure FnCheckForTestFields()
    var
        LoanType: Record "Loan Products Setup";
        LoanGuarantors: Record "Loans Guarantee Details";
    begin
        //--------------------
        if "Approved Amount" <= 0 then
            Error('Approved Amount cannot be 0 , please appraise the Loan');

        if "Approval Status" = "Approval Status"::Approved then
            Error('The loan has already been approved');
        if "Approval Status" <> "Approval Status"::Open then
            Error('Approval status MUST be Open');
        if Appraised = false then
            Error('Please Appraise the Loan');
        TestField("Requested Amount");

        TestField("Loan Product Type");
        if "Recovery Mode" = "Recovery Mode"::" " then
            Error('Recovery Mode Cannot be Empty');
        //----------------------
        if (LoanType.get("Loan Product Type")) then begin
            if LoanType."Appraise Guarantors" = true then begin
                LoanGuarantors.Reset();
                LoanGuarantors.SetRange(LoanGuarantors."Loan No", "Loan  No.");
                if LoanGuarantors.find('-') then begin
                    Error('Please Insert Loan Applicant Guarantor Details!');
                end;
            end;
        end;
    end;

    local procedure FnSendEmailAprovalNottifications()
    var
        EmailBody: Text[700];
        EmailSubject: Text[100];
        Emailaddress: Text[100];
    begin
        ///...............Notify Via Email
        Cust.Reset();
        Cust.SetRange(Cust."No.", "Client Code");
        if Cust.FindSet()
        then
            if Cust."E-Mail (Personal)" <> ' ' then begin
                Emailaddress := Cust."E-Mail (Personal)";
                EmailSubject := 'Loan Application Approval';
                EMailBody := 'Dear <b>' + '</b>,</br></br>' + 'Your loan application of KSHs.' + FORMAT("Requested Amount") +
                          ' has been Approved by Credit. Devco Sacco Ltd.' + '<br></br>' +
'Congratulations';
                EmailCodeunit.SendMail(Emailaddress, EmailSubject, EmailBody);
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
        SMSMessages."SMS Message" := 'Your loan application of KSHs.' + FORMAT("Requested Amount") +
                                  ' has been Approved by Credit. Devco Sacco Ltd.';
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
                    IF LoanApp.GET(LoanGuar."Loan No") THEN
                        SMSMessages."SMS Message" := 'You have guaranteed an amount of ' + FORMAT(LoanGuar."Amont Guaranteed")
                        + ' to ' + "Client Name" + '  ' +
                        'Loan Type ' + "Loan Product Type" + ' ' + 'of ' + FORMAT("Requested Amount") + ' at Devco Sacco Ltd. Call 0726050260 if in dispute';
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
}
