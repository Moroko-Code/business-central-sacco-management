// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// report 51516005 "CEEP Officer Collection Report"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/CEEP Officer Collection Report.rdlc';
//     Caption = 'CEEP Officer Collection & Variance Report';
//     dataset
//     {
//         dataitem(Loans; "Loans Register")
//         {
//             DataItemTableView = where(Posted = const(true));
//             RequestFilterFields = Source, "Loan  No.", "Client Code", "Branch Code", "Loan Product Type", "Date filter";
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(ExpectedMonthlyPrinciple; ExpectedMonthlyPrinciple)
//             {
//             }
//             column(ExpectedMonthlyInterest; ExpectedMonthlyInterest)
//             {
//             }
//             column(TotalExpectedRepayment; TotalExpectedRepayment)
//             {
//             }
//             column(OutstandingBalance_Loans; ActualLoanBal)
//             {
//             }
//             column(ClientCode_Loans; Loans."Client Code")
//             {
//             }
//             column(ClientName_Loans; Loans."Client Name")
//             {
//             }
//             column(LoanProductType_Loans; Loans."Loan Product Type")
//             {
//             }
//             column(IssuedDate_Loans; Loans."Issued Date")
//             {
//             }
//             column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
//             {
//             }
//             column(LoanNo_Loans; Loans."Loan  No.")
//             {
//             }
//             column(Entry; Entry)
//             {
//             }
//             column(PaidPrincipal; PaidPrincipal)
//             {
//             }
//             column(PaidInterest; PaidInterest)
//             {
//             }
//             column(ExpectedLoanBalance; ExpectedLoanBalance)
//             {
//             }
//             column(ArrearAmounts; ArrearAmounts)
//             {
//             }
//             column(PrepaidAmounts; PrepaidAmounts)
//             {
//             }
//             column(OutstandingInterest; OutstandingInterest)
//             {
//             }
//             column(CollectedAmount; CollectedAmount)
//             {
//             }
//             column(Deficit; Deficit)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin

//                 LoansRegister.Reset;
//                 LoansRegister.SetFilter(LoansRegister."Issued Date", DateFilter);
//                 LoansRegister.SetFilter(LoansRegister."Date filter", DateFilter);
//                 LoansRegister.SetRange(LoansRegister."Loan  No.", Loans."Loan  No.");
//                 LoansRegister.SetAutoCalcFields(LoansRegister."Outstanding Balance", "Oustanding Interest");
//                 if LoansRegister.Find('-') then begin
//                     repeat
//                         ActualLoanBal := 0;
//                         OutstandingInterest := 0;
//                         ActualLoanBal := LoansRegister."Outstanding Balance";
//                         if (LoansRegister."Loan Product Type" <> 'OKOA') and (LoansRegister."Loan Product Type" <> 'OVERDRAFT') then begin
//                             OutstandingInterest := LoansRegister."Oustanding Interest";
//                         end else
//                             if (LoansRegister."Loan Product Type" = 'OKOA') or (LoansRegister."Loan Product Type" = 'OVERDRAFT') then begin
//                                 OutstandingInterest := FnGetOutstandingInterest(LoansRegister."Loan  No.", LoansRegister."Oustanding Interest");
//                                 if OutstandingInterest <= 0 then begin
//                                     OutstandingInterest := 0;
//                                 end else
//                                     if OutstandingInterest > 0 then begin
//                                         OutstandingInterest := OutstandingInterest;
//                                     end;
//                             end;
//                         //.............................
//                         LoanRepaymentSchedule.Reset;
//                         LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.", LoansRegister."Loan  No.");
//                         LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", DateFilter);
//                         if LoanRepaymentSchedule.Find('-') then begin
//                             ExpectedMonthlyPrinciple := 0;
//                             ExpectedMonthlyInterest := 0;
//                             TotalExpectedRepayment := 0;
//                             repeat
//                                 ExpectedMonthlyPrinciple += LoanRepaymentSchedule."Principal Repayment";
//                                 ExpectedMonthlyInterest += LoanRepaymentSchedule."Monthly Interest";
//                                 TotalExpectedRepayment += LoanRepaymentSchedule."Monthly Repayment";
//                             until LoanRepaymentSchedule.Next = 0;
//                         end;
//                         ExpectedLoanBalance := 0;
//                         ExpectedLoanBalance := LoanClassificationSasra.FnGetLoanExpectedBalance(LoansRegister."Loan  No.", DateFilter);
//                         //LoansRegister."Approved Amount" - ExpectedMonthlyPrinciple;
//                         PrepaidAmounts := 0;
//                         ArrearAmounts := 0;
//                         if ActualLoanBal - ExpectedLoanBalance > 0 then begin
//                             PrepaidAmounts := 0;
//                             ArrearAmounts := ActualLoanBal - ExpectedLoanBalance;
//                         end else
//                             if ActualLoanBal - ExpectedLoanBalance > 0 then begin
//                                 ArrearAmounts := 0;
//                                 PrepaidAmounts := (ActualLoanBal - ExpectedLoanBalance) * -1;
//                             end;
//                         TotalExpectedRepayment := 0;
//                         TotalExpectedRepayment := (ArrearAmounts + OutstandingInterest) - PrepaidAmounts;
//                         if TotalExpectedRepayment > 0 then begin
//                             TotalExpectedRepayment := TotalExpectedRepayment;
//                         end else
//                             if TotalExpectedRepayment <= 0 then begin
//                                 TotalExpectedRepayment := 0;
//                             end;
//                         //........................Get Expected Loan Blance As Per Schedule
//                         CutoffExpectedLoanBal := 0;
//                         CollectedAmount := 0;
//                         Deficit := 0;
//                         CutoffExpectedLoanBal := ExpectedLoanBalance;
//                         if CutoffExpectedLoanBal - ActualLoanBal < 0 then begin
//                             CollectedAmount := 0;
//                             Deficit := (ActualLoanBal + OutstandingInterest) - (CutoffExpectedLoanBal);
//                         end else
//                             if CutoffExpectedLoanBal - ActualLoanBal > 0 then begin
//                                 CollectedAmount := CutoffExpectedLoanBal - ActualLoanBal;
//                                 Deficit := 0;
//                             end;
//                         Entry := Entry + 1;
//                     until LoansRegister.Next = 0;
//                 end;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 ExpectedMonthlyPrinciple := 0;
//                 ExpectedLoanBalance := 0;
//                 ExpectedMonthlyInterest := 0;
//                 TotalExpectedRepayment := 0;
//                 Entry := 0;
//                 ActualLoanBal := 0;
//                 ArrearAmounts := 0;
//                 PrepaidAmounts := 0;
//                 OutstandingInterest := 0;
//             end;
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
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
//         DateFilter := Loans.GetFilter(loans."Date filter");
//         if DateFilter = '' then begin
//             DateFilter := '..' + Format(Today);
//         end;
//     end;

//     local procedure FnGetOutstandingInterest(LoanNo: Code[30]; OustandingInterest: Decimal): Decimal
//     var
//         ExpectedPaidInterest: Decimal;
//         CustInterestPaid: Decimal;
//         CustLedgerEntry: Record "Cust. Ledger Entry";
//     begin
//         ExpectedPaidInterest := 0;
//         CustInterestPaid := 0;
//         LoanRepaymentSchedule.Reset;
//         LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.", LoanNo);
//         LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", DateFilter);
//         if LoanRepaymentSchedule.Find('-') then begin
//             repeat
//                 ExpectedPaidInterest += LoanRepaymentSchedule."Monthly Interest";
//             until LoanRepaymentSchedule.Next = 0;
//             CustLedgerEntry.Reset();
//             CustLedgerEntry.SetRange(CustLedgerEntry."Loan No", LoanNo);
//             CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", DateFilter);
//             CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Interest Paid");
//             if CustLedgerEntry.Find('-') then begin
//                 repeat
//                     CustInterestPaid += CustLedgerEntry."Amount Posted";
//                 until CustLedgerEntry.Next = 0;
//             end;
//         end;
//         exit(ExpectedPaidInterest - CustInterestPaid);
//     end;

//     var
//         LoanRepaymentSchedule: Record "Loan Repayment Schedule";
//         LoansRegister: Record "Loans Register";
//         ExpectedMonthlyPrinciple: Decimal;
//         OutstandingInterest: Decimal;
//         ExpectedMonthlyInterest: Decimal;
//         ExpectedLoanBalance: Decimal;
//         TotalExpectedRepayment: Decimal;
//         ActualLoanBal: Decimal;
//         CutoffExpectedLoanBal: Decimal;
//         CollectedAmount: Decimal;
//         Entry: Integer;
//         PeriodStop: Date;
//         PeriodStart: Date;
//         PaidPrincipal: Decimal;
//         PaidInterest: Decimal;
//         ArrearAmounts: Decimal;
//         PrepaidAmounts: Decimal;
//         CustLedgerEntry: Record "Cust. Ledger Entry";
//         LoanClassificationSasra: Codeunit "Loan Classification-SASRA";
//         Deficit: Decimal;
//         DateFilter: Text;
// }
