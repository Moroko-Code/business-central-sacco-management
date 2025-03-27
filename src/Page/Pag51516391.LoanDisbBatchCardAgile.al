// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Page 51516391 "Loan Disb. Batch Card-Agile"
// {
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     editable = false;
//     PageType = Card;
//     PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
//     SourceTable = "Loan Disburesment-Batching";
//     SourceTableView = where (Posted = const(false));

//     layout
//     {
//         area(content)
//         {
//             field("Batch No."; "Batch No.")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field(Source; Source)
//             {
//                 ApplicationArea = Basic;
//                 Editable = SourceEditable;
//             }
//             field("Batch Type"; "Batch Type")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field("Description/Remarks"; "Description/Remarks")
//             {
//                 ApplicationArea = Basic;
//                 Editable = DescriptionEditable;
//             }
//             field(Status; Status)
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field("Total Loan Amount"; "Total Loan Amount")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("No of Loans"; "No of Loans")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Mode Of Disbursement"; "Mode Of Disbursement")
//             {
//                 ApplicationArea = Basic;
//                 Editable = ModeofDisburementEditable;

//                 trigger OnValidate()
//                 begin
//                     /*IF "Mode Of Disbursement"="Mode Of Disbursement"::EFT THEN
//                     "Cheque No.":="Batch No.";
//                     MODIFY;  */
//                     if "Mode Of Disbursement" <> "mode of disbursement"::Cheque then
//                         "Cheque No." := "Batch No.";
//                     Modify;

//                 end;
//             }
//             field("Document No."; "Document No.")
//             {
//                 ApplicationArea = Basic;
//                 Editable = DocumentNoEditable;

//                 trigger OnValidate()
//                 begin
//                     /*IF STRLEN("Document No.") > 6 THEN
//                       ERROR('Document No. cannot contain More than 6 Characters.');
//                       */

//                 end;
//             }
//             field("Posting Date"; "Posting Date")
//             {
//                 ApplicationArea = Basic;
//                 Editable = PostingDateEditable;
//             }
//             field("BOSA Bank Account"; "BOSA Bank Account")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Paying Bank';
//                 Editable = PayingAccountEditable;
//                 Visible = false;
//             }
//             field("Cheque No."; LoansBatch."Cheque No.")
//             {
//                 ApplicationArea = Basic;
//                 Editable = ChequeNoEditable;
//                 Visible = false;
//             }
//             part("`"; "Loans Sub-Page List")
//             {
//                 Editable = false;
//                 SubPageLink = "Batch No." = field("Batch No."), "System Created" = const(false), "Batch No." = filter(<> '');
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(LoansB)
//             {
//                 Caption = 'Batch';

//                 //   action(Post)
//                 // {
//                 //     ApplicationArea = Basic;
//                 //     Caption = 'Post';
//                 //     Image = Post;
//                 //     Promoted = true;
//                 //     PromotedCategory = Process;
//                 //     Enabled = PostLoan;

//                 //     trigger OnAction()
//                 //     var
//                 //         Text001: label 'The Batch need to be approved.';
//                 //     begin
//                 //         // Status := Status::approved;
//                 //         // Modify();

//                 //         if Status <> Status::Approved then
//                 //             Error('Loan Batch is not Fully Approved');

//                 //         GenJournalLine.Reset;
//                 //         GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
//                 //         GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
//                 //         if GenJournalLine.Find('-') then begin
//                 //             GenJournalLine.DeleteAll
//                 //         end;

//                 //         LoanApps.Reset;
//                 //         LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
//                 //         LoanApps.SetRange(LoanApps."System Created", false);
//                 //         if LoanApps.Find('-') then begin
//                 //             repeat
//                 //                 FnDisburseToBankAccount(LoanApps, LoanApps."Loan  No.");
//                 //                 GenSetUp.Get();
//                 //                 //Send Loan Disburesment SMS*********************************************
//                 //                 if GenSetUp."Send Loan Disbursement SMS" = true then begin
//                 //                     FnSendDisburesmentSMS(LoanApps."Loan  No.", LoanApps."Client Code");
//                 //                 end;
//                 //             until LoanApps.Next = 0;
//                 //         end;

//                 //         //CU posting
//                 //         GenJournalLine.Reset;
//                 //         GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
//                 //         GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
//                 //         if GenJournalLine.Find('-') then begin
//                 //             Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
//                 //         end;

//                 //         LoanApps.Reset;
//                 //         LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
//                 //         LoanApps.SetRange(LoanApps."System Created", false);
//                 //         if LoanApps.Find('-') then begin
//                 //             repeat
//                 //                 //============================================================Send Repayment Schedule Via Mail
//                 //                 ObjLoans.Reset;
//                 //                 ObjLoans.SetRange(ObjLoans."Loan  No.", LoanApps."Loan  No.");
//                 //                 if ObjLoans.FindSet then begin
//                 //                     if ObjMember.Get(LoanApps."Client Code") then begin
//                 //                         if (ObjMember."E-Mail" <> '') then begin
//                 //                             VarMemberEmail := Lowercase(ObjMember."E-Mail");

//                 //                             SMTPSetup.GET();
//                 //                             Filename := '';
//                 //                             Filename := SMTPSetup."Path to Save Report" + 'Loan Repayment Schedule.pdf';
//                 //                             REPORT.SAVEASPDF(REPORT::"Loans Repayment Schedule", Filename, ObjLoans);

//                 //                             VarMailSubject := 'Loan Repayment Schedule - ' + LoanApps."Loan  No.";
//                 //                             VarMailBody := 'Your ' + LoanApps."Loan Product Type Name" + ' Application of Ksh. ' + FORMAT(LoanApps."Approved Amount") + ' has been disbursed to your Account No. ' + ObjMember."Bank Name" + ' Acc no. ' + ObjMember."Bank Account No." +
//                 //                             '. Please find attached the loan repayment schedule for your New Loan Account No. ' + LoanApps."Loan  No." + '.';

//                 //                             EmailSend := SFactory.FnSendStatementViaMail(LoanApps."Client Name", VarMailSubject, VarMailBody, VarMemberEmail, 'Loan Repayment Schedule.pdf', '');

//                 //                         end;
//                 //                     end;
//                 //                 end;
//                 //                 //============================================================End Send Repayment Schedule Via Mail
//                 //                 LoanApps.Posted := true;
//                 //                 LoanApps."Loan Status" := LoanApps."loan status"::Disbursed;
//                 //                 LoanApps."Issued Date" := WorkDate;
//                 //                 LoanApps."Offset Eligibility Amount" := LoanApps."Approved Amount" * (1 / 3);
//                 //                 LoanApps."Posting Date" := WorkDate;
//                 //                 LoanApps."Disbursed By" := UserId;
//                 //                 LoanApps."Loan Disbursement Date" := Today;
//                 //                 LoanApps.Modify;
//                 //             until LoanApps.Next = 0;

//                 //             Posted := true;
//                 //             "Posted By" := UserId;
//                 //             "Posting Date" := WorkDate;
//                 //             Message('Loans Disbursed Successfully. The Members has been notified via SMS and Email.');
//                 //             Commit;

//                 //             // Loans.Reset;
//                 //             // Loans.SetRange(Loans."Batch No.", "Batch No.");
//                 //             // if Loans.Find('-') then begin
//                 //             //     Report.run(50953, false, true, Loans)
//                 //             // end;

//                 //         end;

//                 //         CurrPage.Close;

//                 //     end;
//                 // }
//                 // action("Loans Schedule")
//                 // {
//                 //     ApplicationArea = Basic;
//                 //     Caption = 'Loans Schedule';
//                 //     Image = SuggestPayment;
//                 //     Promoted = true;
//                 //     PromotedCategory = Process;

//                 //     trigger OnAction()
//                 //     begin

//                 //         if Posted = true then
//                 //             Error('Batch already posted.');

//                 //         LoansBatch.Reset;
//                 //         LoansBatch.SetRange(LoansBatch."Batch No.", "Batch No.");
//                 //         if LoansBatch.Find('-') then begin
//                 //             if LoansBatch."Batch Type" = LoansBatch."batch type"::"Personal Loans" then
//                 //                 Report.Run(51516232, true, false, LoansBatch)
//                 //             else
//                 //                 if LoansBatch."Batch Type" = LoansBatch."batch type"::"Branch Loans" then
//                 //                     Report.Run(51516232, true, false, LoansBatch)
//                 //                 else
//                 //                     if LoansBatch."Batch Type" = LoansBatch."batch type"::"Appeal Loans" then
//                 //                         Report.Run(51516232, true, false, LoansBatch)
//                 //                     else
//                 //                         Report.Run(51516232, true, false, LoansBatch);
//                 //         end;
//                 //     end;
//                 // }
//                 separator(Action1102760034)
//                 {
//                 }
//                 // action("Export EFT")
//                 // {
//                 //     ApplicationArea = Basic;
//                 //     Caption = 'Export EFT';
//                 //     Image = SuggestPayment;
//                 //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //     //PromotedCategory = Process;

//                 //     trigger OnAction()
//                 //     begin

//                 //         LoanApp.Reset;
//                 //         LoanApp.SetRange(LoanApp."Batch No.", "Batch No.");
//                 //         if LoanApp.Find('-') then begin

//                 //             Xmlport.Run(51516012, true, false, LoanApp);
//                 //         end;
//                 //     end;
//                 // }
//                 // action("Member Card")
//                 // {
//                 //     ApplicationArea = Basic;
//                 //     Caption = 'Member Card';
//                 //     Image = Customer;
//                 //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //     //PromotedCategory = Process;

//                 //     trigger OnAction()
//                 //     begin

//                 //         /*LoanApp.RESET;
//                 //         LoanApp.SETRANGE(LoanApp."Loan  No.",CurrPage.LoansSubForm);
//                 //         IF LoanApp.FIND('-') THEN BEGIN*/

//                 //         /*Cust.RESET;
//                 //         Cust.SETRANGE(Cust."No.",LoanApp."Client Code");
//                 //         IF Cust.FIND('-') THEN
//                 //         PAGE.RUNMODAL(,Cust);*/
//                 //         //END;

//                 //     end;
//                 // }
//                 // action("Loan Application")
//                 // {
//                 //     ApplicationArea = Basic;
//                 //     Caption = 'Loan Application Card';
//                 //     Image = Loaners;
//                 //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //     //PromotedCategory = Process;

//                 //     trigger OnAction()
//                 //     begin
//                 //         /*
//                 //         LoanApp.RESET;
//                 //         //LoanApp.SETRANGE(LoanApp."Loan  No.",CurrPage.LoansSubForm.PAGE.GetLoanNo);
//                 //         IF LoanApp.FIND('-') THEN
//                 //         PAGE.RUNMODAL(,LoanApp);
//                 //         */

//                 //     end;
//                 // }

//                 separator(Action1102760045)
//                 {
//                 }
//                 action(Approvals)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Approvals';
//                     Image = Approval;
//                     Promoted = true;
//                     PromotedCategory = Category4;

//                     trigger OnAction()
//                     var
//                         ApprovalEntries: Page "Approval Entries";
//                     begin
//                         DocumentType := Documenttype::Batches;
//                         ApprovalEntries.SetRecordFilters(Database::"Approvals Users Set Up", DocumentType, "Batch No.");
//                         ApprovalEntries.Run;
//                     end;
//                 }
//                 action("Send A&pproval Request")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Send A&pproval Request';
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category4;

//                     trigger OnAction()
//                     var
//                         Text001: label 'This Batch is already pending approval';
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         LoanApps.Reset;
//                         LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
//                         if LoanApps.Find('-') = false then
//                             Error('You cannot send an empty batch for approval');
//                         TestField("Description/Remarks");
//                         if Status <> Status::Open then
//                             Error(Text001);

//                         //End allocate batch number
//                         //Doc_Type:=Doc_Type::"Loan Batch";
//                         //Table_id:=DATABASE::"Loan Disburesment-Batching";
//                         //IF ApprovalMgt.SendApproval(Table_id,"Batch No.",Doc_Type,Status)THEN;

//                         /*IF ApprovalsMgmt.CheckLBatchApprovalsWorkflowEnabled(Rec) THEN
//                           ApprovalsMgmt.OnSendLBatchDocForApproval(Rec);
//                           Status:=Status::"Pending Approval";*/

//                         //TESTFIELD("Document No.");
//                         //TESTFIELD("Posting Date");

//                         Status := Status::Approved;
//                         Modify;

//                         Message(Text002);

//                         //ApprovalMgt.SendBatchApprRequest(LBatches);

//                     end;
//                 }
//                 action("Canel Approval Request")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Cancel Approval Request';
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Category4;

//                     trigger OnAction()
//                     var
//                         ApprovalMgt: Codeunit "Export F/O Consolidation";
//                     begin

//                         if Confirm('Are you sure you want to cancel the approval request', false) = true then begin
//                             Status := Status::Open;
//                             Modify;
//                         end;
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     begin
//         UpdateControl();
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         Source := Source::FOSA;
//         "Batch Type" := "batch type"::Loans;
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         Source := Source::FOSA;
//         "Batch Type" := "batch type"::Loans;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         Source := Source::FOSA;
//         "Batch Type" := "batch type"::Loans;
//     end;

//     var
//         Text001: label 'Status must be open';
//         MovementTracker: Record "File Movement Tracker";
//         FileMovementTracker: Record "File Movement Tracker";
//         NextStage: Integer;
//         EntryNo: Integer;
//         NextLocation: Text[100];
//         LoansBatch: Record "Loan Disburesment-Batching";
//         i: Integer;
//         LoanType: Record "Loan Products Setup";
//         PeriodDueDate: Date;
//         ScheduleRep: Record "Loan Repayment Schedule";
//         RunningDate: Date;
//         G: Integer;
//         IssuedDate: Date;
//         GracePeiodEndDate: Date;
//         InstalmentEnddate: Date;
//         GracePerodDays: Integer;
//         InstalmentDays: Integer;
//         NoOfGracePeriod: Integer;
//         NewSchedule: Record "Loan Repayment Schedule";
//         RSchedule: Record "Loan Repayment Schedule";
//         GP: Text[30];
//         ScheduleCode: Code[20];
//         PreviewShedule: Record "Loan Repayment Schedule";
//         PeriodInterval: Code[10];
//         CustomerRecord: Record Customer;
//         Gnljnline: Record "Gen. Journal Line";
//         Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
//         CumInterest: Decimal;
//         NewPrincipal: Decimal;
//         PeriodPrRepayment: Decimal;
//         GenBatch: Record "Gen. Journal Batch";
//         LineNo: Integer;
//         GnljnlineCopy: Record "Gen. Journal Line";
//         NewLNApplicNo: Code[10];
//         Cust: Record Customer;
//         LoanApp: Record "Loans Register";
//         TestAmt: Decimal;
//         CustRec: Record Customer;
//         CustPostingGroup: Record "Customer Posting Group";
//         GenSetUp: Record "Sacco General Set-Up";
//         PCharges: Record "Loan Product Charges";
//         TCharges: Decimal;
//         LAppCharges: Record "Loan Applicaton Charges";
//         Loans: Record "Loans Register";
//         LoanAmount: Decimal;
//         InterestRate: Decimal;
//         RepayPeriod: Integer;
//         LBalance: Decimal;
//         RunDate: Date;
//         InstalNo: Decimal;
//         RepayInterval: DateFormula;
//         TotalMRepay: Decimal;
//         LInterest: Decimal;
//         LPrincipal: Decimal;
//         RepayCode: Code[40];
//         GrPrinciple: Integer;
//         GrInterest: Integer;
//         QPrinciple: Decimal;
//         QCounter: Integer;
//         InPeriod: DateFormula;
//         InitialInstal: Integer;
//         InitialGraceInt: Integer;
//         GenJournalLine: Record "Gen. Journal Line";
//         FOSAComm: Decimal;
//         BOSAComm: Decimal;
//         GLPosting: Codeunit "Gen. Jnl.-Post Line";
//         LoanTopUp: Record "Loan Offset Details";
//         Vend: Record Vendor;
//         BOSAInt: Decimal;
//         TopUpComm: Decimal;
//         DActivity: Code[20];
//         DBranch: Code[20];
//         UsersID: Record User;
//         TotalTopupComm: Decimal;
//         Notification: Codeunit Mail;
//         CustE: Record Customer;
//         DocN: Text[50];
//         DocM: Text[100];
//         DNar: Text[250];
//         DocF: Text[50];
//         MailBody: Text[250];
//         ccEmail: Text[250];
//         LoanG: Record "Loans Guarantee Details";
//         SpecialComm: Decimal;
//         LoanApps: Record "Loans Register";
//         Banks: Record "Bank Account";
//         BatchTopUpAmount: Decimal;
//         BatchTopUpComm: Decimal;
//         TotalSpecialLoan: Decimal;
//         SpecialLoanCl: Record "Loan Special Clearance";
//         Loans2: Record "Loans Register";
//         DActivityBOSA: Code[20];
//         DBranchBOSA: Code[20];
//         Refunds: Record "Loan Products Setup";
//         TotalRefunds: Decimal;
//         WithdrawalFee: Decimal;
//         NetPayable: Decimal;
//         NetRefund: Decimal;
//         FWithdrawal: Decimal;
//         OutstandingInt: Decimal;
//         TSC: Decimal;
//         LoanDisbAmount: Decimal;
//         NegFee: Decimal;
//         DValue: Record "Dimension Value";
//         ChBank: Code[20];
//         Trans: Record Transactions;
//         TransactionCharges: Record "Transaction Charges";
//         BChequeRegister: Record "Banker Cheque Register";
//         OtherCommitments: Record "Other Commitements Clearance";
//         BoostingComm: Decimal;
//         BoostingCommTotal: Decimal;
//         BridgedLoans: Record "Loan Special Clearance";
//         InterestDue: Decimal;
//         ContractualShares: Decimal;
//         BridgingChanged: Boolean;
//         BankersChqNo: Code[20];
//         LastPayee: Text[100];
//         RunningAmount: Decimal;
//         BankersChqNo2: Code[20];
//         BankersChqNo3: Code[20];
//         EndMonth: Date;
//         RemainingDays: Integer;
//         PrincipalRepay: Decimal;
//         InterestRepay: Decimal;
//         TMonthDays: Integer;
//         SMSMessage: Record "Loan Appraisal Salary Details";
//         iEntryNo: Integer;
//         Temp: Record Customer;
//         Jtemplate: Code[30];
//         JBatch: Code[30];
//         LBatches: Record "Loan Disburesment-Batching";
//         ApprovalMgt: Codeunit "Export F/O Consolidation";
//         DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
//         DescriptionEditable: Boolean;
//         ModeofDisburementEditable: Boolean;
//         DocumentNoEditable: Boolean;
//         PostingDateEditable: Boolean;
//         SourceEditable: Boolean;
//         PayingAccountEditable: Boolean;
//         ChequeNoEditable: Boolean;
//         ChequeNameEditable: Boolean;
//         upfronts: Decimal;
//         EmergencyInt: Decimal;
//         Table_id: Integer;
//         Doc_No: Code[20];
//         Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan,"Loan Batch";
//         Deductions: Decimal;
//         BatchBoostingCom: Decimal;
//         HisaRepayment: Decimal;
//         HisaLoan: Record "Loans Register";
//         BatchHisaRepayment: Decimal;
//         BatchFosaHisaComm: Decimal;
//         BatchHisaShareBoostComm: Decimal;
//         BatchShareCap: Decimal;
//         BatchIntinArr: Decimal;
//         Loaninsurance: Decimal;
//         TLoaninsurance: Decimal;
//         ProductCharges: Record "Loan Product Charges";
//         InsuranceAcc: Code[20];
//         PTEN: Code[20];
//         LoanTypes: Record "Loan Products Setup";
//         Customer: Record Customer;
//         DataSheet: Record "Data Sheet Main";
//         TotBoost: Decimal;
//         ShareAmount: Decimal;
//         Commitm: Decimal;
//         Scharge: Decimal;
//         EftAmount: Decimal;
//         EFTDeduc: Decimal;
//         linecharges: Decimal;
//         Text002: label 'Loan Batch Approved Successfully';
//         SFactory: Codeunit "SURESTEP Factory";
//         BATCH_TEMPLATE: Code[100];
//         BATCH_NAME: Code[100];
//         DOCUMENT_NO: Code[100];
//         BalanceCutOffDate: Date;

//     procedure UpdateControl()
//     begin
//         if Status = Status::Open then begin
//             DescriptionEditable := true;
//             ModeofDisburementEditable := false;
//             DocumentNoEditable := false;
//             PostingDateEditable := false;
//             SourceEditable := true;
//             PayingAccountEditable := true;
//             ChequeNoEditable := false;
//             ChequeNameEditable := false;
//         end;

//         if Status = Status::"Pending Approval" then begin
//             DescriptionEditable := false;
//             ModeofDisburementEditable := false;
//             DocumentNoEditable := false;
//             PostingDateEditable := false;
//             SourceEditable := false;
//             PayingAccountEditable := false;
//             ChequeNoEditable := false;
//             ChequeNameEditable := false;

//         end;

//         if Status = Status::Rejected then begin
//             DescriptionEditable := false;
//             ModeofDisburementEditable := false;
//             DocumentNoEditable := false;
//             PostingDateEditable := false;
//             SourceEditable := false;
//             PayingAccountEditable := false;
//             ChequeNoEditable := false;
//             ChequeNameEditable := false;
//         end;

//         if Status = Status::Approved then begin
//             DescriptionEditable := false;
//             ModeofDisburementEditable := true;
//             DocumentNoEditable := true;
//             SourceEditable := false;
//             PostingDateEditable := true;
//             PayingAccountEditable := true;//FALSE;
//             ChequeNoEditable := true;
//             ChequeNameEditable := true;

//         end;
//     end;
// // procedure FnDisburseToBankAccount(var LoanApps: Record "Loans Register"; LoanNo: Code[30])
// //     begin

// //         VarLoanNo := LoanNo;
// //         BATCH_TEMPLATE := 'PAYMENTS';
// //         BATCH_NAME := 'LOANS';
// //         DOCUMENT_NO := VarLoanNo;

// //         GenSetUp.GET();
// //         IF LoanApps.GET(VarLoanNo) THEN BEGIN

// //             if LoanApps."Loan  No." = 'LN0001' then
// //                 LoanApps.posted := false;
// //             LoanApps.CALCFIELDS(LoanApps."Loan Offset Amount", LoanApps."Offset iNTEREST");
// //             TCharges := 0;
// //             TopUpComm := 0;
// //             TotalTopupComm := LoanApps."Loan Offset Amount";

// //             IF (LoanApps."Disburesment Type" = LoanApps."Disburesment Type"::"Full/Single disbursement") OR (LoanApps."Disburesment Type" = LoanApps."Disburesment Type"::" ") THEN BEGIN
// //                 VarAmounttoDisburse := LoanApps."Approved Amount"
// //             END ELSE BEGIN
// //                 VarAmounttoDisburse := LoanApps."Amount to Disburse on Tranch 1";
// //                 IF VarAmounttoDisburse <= 0 THEN
// //                     ERROR('You have specified Disbursement Mode as Tranche/Multiple Disbursement, Amount to Disburse on Tranche 1 must be greater than zero.')
// //             END;

// //             //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
// //             LineNo := LineNo + 10000;
// //             SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Loan,
// //             GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", VarAmounttoDisburse, FORMAT(LoanApps.Source),
// //             LoanApps."Loan  No.", 'Loan Disbursement - ' + LoanApps."Loan Product Type", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
// //             //--------------------------------(Debit Member Loan Account)---------------------------------------------

// //             //----------------------------------------4. PAY/RECOVER TOP UPS------------------------------------------------------------------------------------------
// //             // IF LoanApps."Loan Offset Amount" > 0 THEN BEGIN

// //             LoanTopUp.RESET;
// //             LoanTopUp.SETRANGE(LoanTopUp."Loan No.", LoanApps."Loan  No.");
// //             IF LoanTopUp.FINDSET THEN BEGIN
// //                 IF LoanTopUp."Loan Top Up" <> '' then begin
// //                     REPEAT
// //                         IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN

// //                             //------------------------------------PAY-----------------------------------------------------------------------------------------------------------
// //                             //------------------------------------Principal---------------------
// //                             LineNo := LineNo + 10000;
// //                             SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Loan Repayment",
// //                             GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanTopUp."Outstanding Balance" * -1, 'BOSA', LoanTopUp."Loan Top Up",
// //                             'Off Set By - ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."Application Source"::" ");
// //                             //.................Charge Penalty...............
// //                             LineNo := LineNo + 10000;
// //                             SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Loan Application Fee charged",
// //                             GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", 'Application fee Charged' + '_' + LoanApps."Loan  No.", GenJournalLine."Bal. Account Type"::"G/L Account",
// //                             LoanType."Loan ApplFee Accounts", PChargeAmount, 'BOSA', LoanApps."Loan  No.");

// //                             LineNo := LineNo + 10000;
// //                             SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Due",
// //                             GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", 'Interest Penalty Charged- ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", GenJournalLine."Bal. Account Type"::"G/L Account",
// //                             LoanType."Receivable Interest Account", LoanTopUp.Commision, 'BOSA', LoanTopUp."Loan Top Up");

// //                             VarAmounttoDisburse := VarAmounttoDisburse - LoanTopUp."Outstanding Balance";
// //                         END;
// //                     UNTIL LoanTopUp.NEXT = 0;
// //                 end;

// //             END;

// //             //-----------------------------------------Accrue Interest Disburesment--------------------------------------------------------------------------------------------
// //             IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN

// //                 IF (LoanType."Charge Interest Upfront" = TRUE) AND (LoanApps."Interest Upfront" > 0) THEN BEGIN

// //                     //----------------------Debit interest Receivable Account a/c-----------------------------------------------------
// //                     LineNo := LineNo + 10000;
// //                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Due",
// //                     GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Interest Upfront", 'BOSA', BLoan,
// //                     'Interest Due ' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

// //                     LineNo := LineNo + 10000;
// //                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
// //                     GenJournalLine."Account Type"::"G/L Account", LoanType."Receivable Interest Account", LoanApps."Loan Disbursement Date", -LoanApps."Interest Upfront", 'BOSA', BLoan,
// //                     'Interest Upfront ' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

// //                     //----------------------Credit interest Income Account a/c-----------------------------------------------------
// //                     LineNo := LineNo + 10000;
// //                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
// //                    GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Interest Upfront" * -1, 'BOSA', BLoan,
// //                     'Interest Paid ' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
// //                 END;
// //             END;

// //             //-----------------------------------------Accrue insurance on Disburesment--------------------------------------------------------------------------------------------

// //             IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
// //                 //IF LoanType."Accrue Total Insurance&Interes" = TRUE THEN BEGIN

// //                 //Message('Charging insurance...');
// //                 PCharges.RESET;
// //                 PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
// //                 PCharges.SETRANGE(PCharges."Loan Charge Type", PCharges."Loan Charge Type"::"Loan Insurance");
// //                 IF PCharges.FIND('-') THEN BEGIN
// //                     //PCharges.TESTFIELD(PCharges."G/L Account");
// //                     //GenSetUp.TESTFIELD(GenSetUp."Excise Duty Account");
// //                     LoanType.TestField(LoanType."Loan Insurance Accounts");
// //                     PChargeAmount := PCharges.Amount;
// //                     IF PCharges."Use Perc" = TRUE THEN
// //                         PChargeAmount := (LoanApps."Approved Amount" * PCharges.Percentage / 100);
// //                     //----------------------Debit insurance Receivable Account a/c-----------------------------------------------------
// //                     /// Message('insurance to charge %1...', PChargeAmount);
// //                     LineNo := LineNo + 10000;
// //                     SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Loan Insurance Charged",
// //                     GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", 'Insurance Charged' + '_' + LoanApps."Loan  No.", GenJournalLine."Bal. Account Type"::"G/L Account",
// //                     LoanType."Loan Insurance Accounts", PChargeAmount, 'BOSA', LoanApps."Loan  No.");

// //                 END;
// //                 // END;
// //             END;

// //             //--------------------------------------------------------Loan application fee--------------------------------
// //             IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
// //                 //IF LoanType."Accrue Total Insurance&Interes" = TRUE THEN BEGIN

// //                 PCharges.RESET;
// //                 PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
// //                 PCharges.SETRANGE(PCharges."Loan Charge Type", PCharges."Loan Charge Type"::"Loan Application Fee");
// //                 IF PCharges.FIND('-') THEN BEGIN

// //                     // PCharges.TESTFIELD(PCharges."G/L Account");
// //                     //GenSetUp.TESTFIELD(GenSetUp."Excise Duty Account");
// //                     LoanType.TestField(LoanType."Loan ApplFee Accounts");
// //                     PChargeAmount := PCharges.Amount;
// //                     IF PCharges."Use Perc" = TRUE THEN
// //                         PChargeAmount := (LoanApps."Approved Amount" * PCharges.Percentage / 100);
// //                     //----------------------Debit Application fee Receivable Account a/c-----------------------------------------------------
// //                     LineNo := LineNo + 10000;
// //                     SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Loan Application Fee charged",
// //                     GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", 'Application fee Charged' + '_' + LoanApps."Loan  No.", GenJournalLine."Bal. Account Type"::"G/L Account",
// //                     LoanType."Loan ApplFee Accounts", PChargeAmount, 'BOSA', LoanApps."Loan  No.");

// //                 END;
// //                 // END;
// //             END;
// //             //------------------------------------------------end loan application fee----------------------

// //             //-----------------------------------------5. BOOST DEPOSITS COMMISSION / RECOVER FROM FOSA A/C--------------------------------------------------------------------------------------------
// //             //IF LoanApps."Share Boosting Comission" > 0 THEN BEGIN

// //             GenSetUp.GET();
// //             //------------------------------Credit Income G/L-----------------------------------------------
// //             LineNo := LineNo + 10000;
// //             SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
// //             GenJournalLine."Account Type"::"G/L Account", GenSetUp."Boosting Fees Account", LoanApps."Loan Disbursement Date", LoanApps."Share Boosting Comission" * -1, 'BOSA', BLoan,
// //             'Deposits Boosting Fee', BLoan, GenJournalLine."Application Source"::" ");

// //             GenSetUp.GET();
// //             //------------------------------Credit Excise Duty Account-----------------------------------------------
// //             LineNo := LineNo + 10000;
// //             SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
// //             GenJournalLine."Account Type"::"G/L Account", GenSetUp."Excise Duty Account", LoanApps."Loan Disbursement Date", (LoanApps."Share Boosting Comission" * (GenSetUp."Excise Duty(%)" / 100)) * -1, 'BOSA', BLoan,
// //             'Excise Duty_Boosting Fee', BLoan, GenJournalLine."Application Source"::" ");

// //         END;

// //         //------------------------------------2. CREDIT MEMBER BANK A/C---------------------------------------------------------------------------------------------
// //         LineNo := LineNo + 10000;
// //         SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
// //         GenJournalLine."Account Type"::"Bank Account", LoanApps."Paying Bank Account No", LoanApps."Loan Disbursement Date", VarAmounttoDisburse * -1, 'BOSA', LoanApps."Cheque No.",
// //         'Loan Disbursement - ' + LoanApps."Loan Product Type" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
// //         //----------------------------------(Credit Member Bank Account)------------------------------------------------

// //     END;
//     local procedure FnRecoverOverDraft("Account No": Code[100]; RunningBalance: Decimal): Decimal
//     var
//         ObjVendor: Record Vendor;
//         ObjOverDraft: Record "Over Draft Register";
//         ObjOverDraftSetup: Record "Overdraft Setup";
//         AmountToDeduct: Decimal;
//         ODNumber: Code[100];
//     begin
//         if RunningBalance > 0 then begin
//             ODNumber := FnGetApprovedOverDraftNo("Account No");
//             ObjOverDraftSetup.Get();
//             AmountToDeduct := 0;
//             ObjVendor.Reset;
//             ObjVendor.SetRange(ObjVendor."No.", "Account No");
//             ObjVendor.SetFilter(ObjVendor."Date Filter", '..' + Format("Posting Date"));
//             if ObjVendor.Find('-') then begin
//                 ObjVendor.CalcFields(ObjVendor."Oustanding Overdraft interest", ObjVendor.Balance, ObjVendor."Outstanding Overdraft");
//                 if ObjVendor."Outstanding Overdraft" > 0 then begin
//                     LineNo := LineNo + 10000;
//                     AmountToDeduct := FnGetMonthlyRepayment("Account No");

//                     if ObjVendor."Outstanding Overdraft" <= AmountToDeduct then
//                         AmountToDeduct := ObjVendor."Outstanding Overdraft";

//                     if RunningBalance <= AmountToDeduct then
//                         AmountToDeduct := RunningBalance;

//                     SFactory.FnCreateGnlJournalLineBalancedCashier(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"0", GenJournalLine."account type"::Vendor,
//                     "Account No", "Posting Date", AmountToDeduct, 'FOSA', 'OV' + "Account No", "Account No" + ' Overdraft paid', '',
//                     GenJournalLine."account type"::"G/L Account", ObjOverDraftSetup."Control Account", ODNumber, GenJournalLine."overdraft codes"::"Overdraft Paid");
//                     RunningBalance := RunningBalance - AmountToDeduct;
//                 end;
//             end;
//         end;
//         exit(RunningBalance);
//     end;

//     local procedure FnGetApprovedOverDraftNo(AccNo: Code[100]): Code[100]
//     var
//         ObjOverdraftRegister: Record "Over Draft Register";
//     begin
//         ObjOverdraftRegister.Reset;
//         ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Account No", AccNo);
//         ObjOverdraftRegister.SetRange(ObjOverdraftRegister.Status, ObjOverdraftRegister.Status::Approved);
//         ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Overdraft Status", ObjOverdraftRegister."overdraft status"::Active);
//         ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Running Overdraft", true);
//         ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Recovery Mode", ObjOverdraftRegister."recovery mode"::Loan);
//         if ObjOverdraftRegister.FindFirst then
//             exit(ObjOverdraftRegister."Over Draft No");
//     end;

//     local procedure FnGetMonthlyRepayment(AccNo: Code[100]): Decimal
//     var
//         ObjOverdraftRegister: Record "Over Draft Register";
//     begin
//         ObjOverdraftRegister.Reset;
//         ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Account No", AccNo);
//         ObjOverdraftRegister.SetRange(ObjOverdraftRegister.Status, ObjOverdraftRegister.Status::Approved);
//         ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Overdraft Status", ObjOverdraftRegister."overdraft status"::Active);
//         ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Running Overdraft", true);
//         ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Recovery Mode", ObjOverdraftRegister."recovery mode"::Loan);
//         if ObjOverdraftRegister.FindFirst then
//             exit(ObjOverdraftRegister."Monthly Overdraft Repayment");
//     end;

//     local procedure FnGetMemberBranch(MemberNo: Code[50]): Code[100]
//     var
//         MemberBranch: Code[100];
//     begin
//         Vend.Reset;
//         Vend.SetRange(Vend."No.", LoanApps."Account No");
//         if Vend.Find('-') then begin
//             MemberBranch := Vend."Global Dimension 2 Code";
//         end;
//         exit(MemberBranch);
//     end;
// }
