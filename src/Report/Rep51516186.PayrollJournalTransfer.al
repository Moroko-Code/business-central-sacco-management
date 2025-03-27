// Report 51516186 "Payroll Journal Transfer"
// {
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem("Payroll Employee"; "Payroll Employee")
//         {
//             RequestFilterFields = "Period Filter";
//             trigger OnAfterGetRecord()
//             begin
//                 //For use when posting Pension and NSSF
//                 PostingGroup.Get('PAYROLL');
//                 PostingGroup.TestField(PostingGroup."SSF Employer Account");
//                 PostingGroup.TestField(PostingGroup."SSF Employee Account");
//                 PostingGroup.TestField(PostingGroup."Pension Employer Acc");
//                 PostingGroup.TestField(PostingGroup."Pension Employee Acc");
//                 PostingGroup.TestField(PostingGroup."Gratuity Employee Acc");
//                 PostingGroup.TestField(PostingGroup."Gratuity Employer Acc");
//                 PostingGroup.TestField(PostingGroup."Housing Levy Employee Acc");
//                 PostingGroup.TestField(PostingGroup."Housing Levy Employer Acc");

//                 //Get the staff details (header)
//                 objEmp.SetRange(objEmp."No.", "Payroll Employee"."No.");
//                 if objEmp.Find('-') then begin
//                     strEmpName := '[' + "Payroll Employee"."No." + '] ' + objEmp.Surname + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";
//                     GlobalDim1 := objEmp."Department Code";
//                     GlobalDim2 := objEmp."Global Dim 2";
//                 end;

//                 LineNumber := LineNumber + 10;
//                 PeriodTrans.Reset;
//                 PeriodTrans.SetRange(PeriodTrans."No.", "Payroll Employee"."No.");
//                 PeriodTrans.SetFilter(PeriodTrans."Payroll Period", SelectedPeriod);
//                 if PeriodTrans.Find('-') then begin
//                     repeat
//                         if PeriodTrans."Account No" <> '' then begin
//                             AmountToDebit := 0;
//                             AmountToCredit := 0;
//                             if PeriodTrans."Posting Type" = PeriodTrans."posting type"::Debit then
//                                 AmountToDebit := PeriodTrans.Amount;

//                             if PeriodTrans."Posting Type" = PeriodTrans."posting type"::Credit then
//                                 AmountToCredit := PeriodTrans.Amount;

//                             if PeriodTrans."Account Type" = 1 then
//                                 IntegerPostAs := 0;
//                             if PeriodTrans."Account Type" = 2 then
//                                 IntegerPostAs := 1;

//                             SaccoTransactionType := Saccotransactiontype::" ";

//                             if PeriodTrans."Co-Op parameters" = PeriodTrans."co-op parameters"::loan then
//                                 SaccoTransactionType := Saccotransactiontype::Repayment;

//                             if PeriodTrans."Co-Op parameters" = PeriodTrans."co-op parameters"::"loan Interest" then
//                                 SaccoTransactionType := Saccotransactiontype::"Interest Paid";

//                             if PeriodTrans."Co-Op parameters" = PeriodTrans."co-op parameters"::shares then
//                                 SaccoTransactionType := Saccotransactiontype::"Deposit Contribution";

//                             if PeriodTrans."Co-Op parameters" = PeriodTrans."co-op parameters"::DevShare then
//                                 SaccoTransactionType := Saccotransactiontype::"Dev Shares";

//                             CreateJnlEntry(IntegerPostAs, PeriodTrans."Account No",
//                             GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No.", AmountToDebit, AmountToCredit,
//                             PeriodTrans."Posting Type", PeriodTrans."Loan Number", SaccoTransactionType, PostingGroup."Net Salary Payable");
//                             //PostingGroup."Net Salary Payable"
//                             //Pension
//                             if PeriodTrans."Co-Op parameters" = PeriodTrans."co-op parameters"::Pension then begin
//                                 //Get from Employer Deduction
//                                 EmployerDed.Reset;
//                                 EmployerDed.SetRange(EmployerDed."Employee Code", PeriodTrans."No.");
//                                 EmployerDed.SetRange(EmployerDed."Transaction Code", PeriodTrans."Transaction Code");
//                                 EmployerDed.SetRange(EmployerDed."Payroll Period", PeriodTrans."Payroll Period");
//                                 if EmployerDed.Find('-') then begin
//                                     //Credit Payables
//                                     CreateJnlEntry(0, PostingGroup."Pension Employee Acc",
//                                     GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No.", 0,
//                                     EmployerDed.Amount, PeriodTrans."Posting Type", '', SaccoTransactionType, PostingGroup."Pension Employee Acc");

//                                     //Debit Staff Expense
//                                     CreateJnlEntry(0, PostingGroup."Pension Employer Acc",
//                                     GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No.", EmployerDed.Amount, 0, 1, '',
//                                     SaccoTransactionType, PostingGroup."Pension Employer Acc");

//                                 end;
//                             end;

//                             //NSSF
//                             if PeriodTrans."Co-Op parameters" = PeriodTrans."co-op parameters"::NSSF then begin
//                                 //Credit Payables
//                                 //Credit Payables

//                                 CreateJnlEntry(0, PostingGroup."SSF Employee Account",
//                                 GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No.", 0, PeriodTrans.Amount,
//                                 PeriodTrans."Posting Type", '', SaccoTransactionType, PostingGroup."SSF Employee Account");

//                                 //Debit Staff Expense

//                                 CreateJnlEntry(0, PostingGroup."SSF Employer Account",
//                                 GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No.", PeriodTrans.Amount, 0, 1, '',
//                                 SaccoTransactionType, PostingGroup."SSF Employee Account");

//                             end;
//                             if PeriodTrans."Co-Op parameters" = PeriodTrans."co-op parameters"::"Housing Levy" then begin
//                                 //Credit Payables
//                                 CreateJnlEntry(0, PostingGroup."Housing Levy Employee Acc",
//                                 GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No.", 0, PeriodTrans.Amount,
//                                 PeriodTrans."Posting Type", '', SaccoTransactionType, PostingGroup."Housing Levy Employee Acc");

//                                 //Debit Staff Expense
//                                 CreateJnlEntry(0, PostingGroup."Housing Levy Employer Acc",
//                                 GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No.", PeriodTrans.Amount, 0, 1, '',
//                                 SaccoTransactionType, PostingGroup."Housing Levy Employer Acc");
//                             end;
//                         end;
//                         IF PeriodTrans."Transaction Code" = 'BPAY' THEN BEGIN
//                             //gratuity
//                             PayrollEmployeeTransactions.RESET;
//                             PayrollEmployeeTransactions.SETRANGE(PayrollEmployeeTransactions."Transaction Code", 'GRATUITY');
//                             PayrollEmployeeTransactions.SETRANGE(PayrollEmployeeTransactions."No.", PeriodTrans."No.");
//                             PayrollEmployeeTransactions.SetRange(PayrollEmployeeTransactions."Payroll Period", PeriodTrans."Payroll Period");
//                             IF PayrollEmployeeTransactions.FINDFIRST THEN BEGIN
//                                 CreateJnlEntry2(0, PostingGroup."Gratuity Employer Acc",
//                                                                   GlobalDim1, GlobalDim2, 'Employer Gratuity Contributions' + '-' + PeriodTrans."No.", ((PeriodTrans.Amount) * 0.25),
//                                                                   PostingGroup."Gratuity Employer Acc");

//                                 //................
//                                 CreateJnlEntry2(0, PostingGroup."Gratuity Employee Acc",
//                                                                    GlobalDim1, GlobalDim2, 'Employer Gratuity Contribution' + '-' + PeriodTrans."No.", ((PeriodTrans.Amount) * 0.25) * -1,
//                                                                    PostingGroup."Gratuity Employee Acc");
//                                 //.......................................................
//                             END;
//                         end;
//                     until PeriodTrans.Next = 0;
//                 end;

//             end;

//             trigger OnPostDataItem()
//             begin
//                 Message('Journals Created Successfully');
//             end;

//             trigger OnPreDataItem()
//             begin
//                 LineNumber := 10000;
//                 SelectedPeriod := "Payroll Employee".GetFilter("Payroll Employee"."Period Filter");
//                 //Create batch*****************************************************************************
//                 GenJnlBatch.Reset;
//                 GenJnlBatch.SetRange(GenJnlBatch."Journal Template Name", 'GENERAL');
//                 GenJnlBatch.SetRange(GenJnlBatch.Name, 'SALARIES');
//                 if GenJnlBatch.Find('-') = false then begin
//                     GenJnlBatch.Init;
//                     GenJnlBatch."Journal Template Name" := 'GENERAL';
//                     GenJnlBatch.Name := 'SALARIES';
//                     GenJnlBatch.Insert;
//                 end;
//                 // End Create Batch

//                 // Clear the journal Lines
//                 GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'SALARIES');
//                 if GeneraljnlLine.Find('-') then
//                     GeneraljnlLine.DeleteAll;

//                 "Slip/Receipt No" := UpperCase(objPeriod."Period Name");
//             end;
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 field(pdate; pdate)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Posting Date';
//                 }
//                 field("DocNo."; "DocNo.")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Document No.';
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnPreReport()
//     begin

//     end;

//     var
//         PeriodTrans: Record "Payroll Monthly Transactions";
//         objEmp: Record "HR Employee";
//         PeriodName: Text[30];
//         PeriodFilter: Text[30];
//         SelectedPeriod: Text;
//         objPeriod: Record "Payroll Calender";
//         ControlInfo: Record "Payroll Calender";
//         strEmpName: Text[150];
//         GeneraljnlLine: Record "Gen. Journal Line";
//         GenJnlBatch: Record "Gen. Journal Batch";
//         "Slip/Receipt No": Code[50];
//         LineNumber: Integer;
//         "Salary Card": Record "Payroll Employee";
//         TaxableAmount: Decimal;
//         PostingGroup: Record "Payroll Posting Groups";
//         GlobalDim1: Code[10];
//         GlobalDim2: Code[10];
//         TransCode: Record "Payroll Transaction Code";
//         PostingDate: Date;
//         AmountToDebit: Decimal;
//         AmountToCredit: Decimal;
//         IntegerPostAs: Integer;
//         SaccoTransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares";
//         EmployerDed: Record "Payroll Employer Deductions";
//         PayrollEmployeeTransactions: Record "Payroll Employee Transactions";
//         pdate: Date;
//         "DocNo.": Code[15];

//     procedure CreateJnlEntry(AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,"None",Staff; AccountNo: Code[20]; GlobalDime1: Code[20]; GlobalDime2: Code[20]; Description: Text[50]; DebitAmount: Decimal; CreditAmount: Decimal; PostAs: Option " ",Debit,Credit; LoanNo: Code[20]; TransType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2"; BalAccountNo: Code[20])
//     begin

//         if AccountType = Accounttype::Customer then begin
//             AccountType := Accounttype::Customer;
//         end;

//         LineNumber := LineNumber + 100;
//         GeneraljnlLine.Init;
//         GeneraljnlLine."Journal Template Name" := 'GENERAL';
//         GeneraljnlLine."Journal Batch Name" := 'SALARIES';
//         GeneraljnlLine."Line No." := LineNumber;
//         GeneraljnlLine."Document No." := "DocNo.";
//         GeneraljnlLine."Loan No" := LoanNo;
//         GeneraljnlLine."Transaction Type" := TransType;
//         GeneraljnlLine."Posting Date" := pdate;
//         GeneraljnlLine."Account Type" := AccountType;
//         GeneraljnlLine."Account No." := AccountNo;
//         GeneraljnlLine.Description := Description;
//         if PostAs = Postas::Debit then begin
//             GeneraljnlLine."Debit Amount" := DebitAmount;
//             GeneraljnlLine.Validate("Debit Amount");
//         end else begin
//             GeneraljnlLine."Credit Amount" := CreditAmount;
//             GeneraljnlLine.Validate("Credit Amount");
//         end;
//         GeneraljnlLine."Shortcut Dimension 1 Code" := GlobalDime1;
//         GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 1 Code");
//         GeneraljnlLine."Shortcut Dimension 2 Code" := GlobalDime2;
//         GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 2 Code");
//         if GeneraljnlLine.Amount <> 0 then
//             GeneraljnlLine.Insert;

//     end;

//     procedure CreateJnlEntry2(AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,"None",Staff; AccountNo: Code[20]; GlobalDime1: Code[20]; GlobalDime2: Code[20]; Description: Text[50]; Amount: Decimal; BalAccountNo: Code[20])
//     begin

//         if AccountType = Accounttype::Customer then begin
//             AccountType := Accounttype::Customer;
//         end;

//         LineNumber := LineNumber + 100;
//         GeneraljnlLine.Init;
//         GeneraljnlLine."Journal Template Name" := 'GENERAL';
//         GeneraljnlLine."Journal Batch Name" := 'SALARIES';
//         GeneraljnlLine."Line No." := LineNumber;
//         GeneraljnlLine."Document No." := "DocNo.";
//         GeneraljnlLine."Posting Date" := pdate;
//         GeneraljnlLine."Account Type" := AccountType;
//         GeneraljnlLine."Account No." := AccountNo;
//         GeneraljnlLine.Description := Description;
//         GeneraljnlLine.Amount := Amount;
//         GeneraljnlLine.Validate(GeneraljnlLine.Amount);
//         GeneraljnlLine."Shortcut Dimension 1 Code" := GlobalDime1;
//         GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 1 Code");
//         GeneraljnlLine."Shortcut Dimension 2 Code" := GlobalDime2;
//         GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 2 Code");
//         if GeneraljnlLine.Amount <> 0 then
//             GeneraljnlLine.Insert;
//     end;

//     local procedure FnMemberIsCasual(No: Code[20]): Boolean
//     var
//         EmployeeTable: Record "Payroll Employee";
//     begin
//         EmployeeTable.Reset();
//         EmployeeTable.SetRange(EmployeeTable."No.", No);
//         if EmployeeTable.Find('-') then begin
//             IF EmployeeTable.Gratuity = true THEN begin
//                 exit(true);
//             end;
//         end;
//         exit(false);
//     end;
// }
