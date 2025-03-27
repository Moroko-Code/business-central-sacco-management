// report 51516311 "Payroll Employees Report."
// {
//     ApplicationArea = all;
//     UsageCategory = ReportsAndAnalysis;
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/Payroll Employees Report..rdlc';
//     dataset
//     {
//         dataitem("prPeriod Transactions."; "prPeriod Transactions.")
//         {
//             DataItemTableView = SORTING("Employee Code", "Department Code") ORDER(Ascending) WHERE("Transaction Code" = FILTER('NPAY'));
//             RequestFilterFields = "Payroll Period";
//             column(CompName; info.Name)
//             {
//             }
//             column(pic; info.Picture)
//             {
//             }
//             column(Addr1; info.Address)
//             {
//             }
//             column(Addr2; info."Address 2")
//             {
//             }
//             column(Email; info."E-Mail")
//             {
//             }
//             column(Year; Year)
//             {
//             }
//             column(PeriodName; PeriodName)
//             {
//             }
//             column(EmployeeCode_prPeriodTransactions; "prPeriod Transactions."."Employee Code")
//             {
//             }
//             column(TransactionCode_prPeriodTransactions; "prPeriod Transactions."."Transaction Code")
//             {
//             }
//             column(GroupText_prPeriodTransactions; "prPeriod Transactions."."Group Text")
//             {
//             }
//             column(TransactionName_prPeriodTransactions; "prPeriod Transactions."."Transaction Name")
//             {
//             }
//             column(Amount_prPeriodTransactions; "prPeriod Transactions.".Amount)
//             {
//             }
//             column(Balance_prPeriodTransactions; "prPeriod Transactions.".Balance)
//             {
//             }
//             column(OriginalAmount_prPeriodTransactions; "prPeriod Transactions."."Original Amount")
//             {
//             }
//             column(GroupOrder_prPeriodTransactions; "prPeriod Transactions."."Group Order")
//             {
//             }
//             column(SubGroupOrder_prPeriodTransactions; "prPeriod Transactions."."Sub Group Order")
//             {
//             }
//             column(PeriodMonth_prPeriodTransactions; "prPeriod Transactions."."Period Month")
//             {
//             }
//             column(PeriodYear_prPeriodTransactions; "prPeriod Transactions."."Period Year")
//             {
//             }
//             column(PeriodFilter_prPeriodTransactions; "prPeriod Transactions."."Period Filter")
//             {
//             }
//             column(PayrollPeriod_prPeriodTransactions; "prPeriod Transactions."."Payroll Period")
//             {
//             }
//             column(Membership_prPeriodTransactions; "prPeriod Transactions.".Membership)
//             {
//             }
//             column(ReferenceNo_prPeriodTransactions; "prPeriod Transactions."."Reference No")
//             {
//             }
//             column(DepartmentCode_prPeriodTransactions; "prPeriod Transactions."."Department Code")
//             {
//             }
//             column(Lumpsumitems_prPeriodTransactions; "prPeriod Transactions.".Lumpsumitems)
//             {
//             }
//             column(TravelAllowance_prPeriodTransactions; "prPeriod Transactions.".TravelAllowance)
//             {
//             }
//             column(GLAccount_prPeriodTransactions; "prPeriod Transactions."."GL Account")
//             {
//             }
//             column(CompanyDeduction_prPeriodTransactions; "prPeriod Transactions."."Company Deduction")
//             {
//             }
//             column(EmpAmount_prPeriodTransactions; "prPeriod Transactions."."Emp Amount")
//             {
//             }
//             column(EmpBalance_prPeriodTransactions; "prPeriod Transactions."."Emp Balance")
//             {
//             }
//             column(JournalAccountCode_prPeriodTransactions; "prPeriod Transactions."."Journal Account Code")
//             {
//             }
//             column(JournalAccountType_prPeriodTransactions; "prPeriod Transactions."."Journal Account Type")
//             {
//             }
//             column(PostAs_prPeriodTransactions; "prPeriod Transactions."."Post As")
//             {
//             }
//             column(LoanNumber_prPeriodTransactions; "prPeriod Transactions."."Loan Number")
//             {
//             }
//             column(coopparameters_prPeriodTransactions; "prPeriod Transactions."."coop parameters")
//             {
//             }
//             column(PayrollCode_prPeriodTransactions; "prPeriod Transactions."."Payroll Code")
//             {
//             }
//             column(PaymentMode_prPeriodTransactions; "prPeriod Transactions."."Payment Mode")
//             {
//             }
//             column(FosaAccountNo_prPeriodTransactions; "prPeriod Transactions."."Fosa Account No.")
//             {
//             }
//             column(employeeName; employeeName)
//             {
//             }
//             column(Organization_prPeriodTransactions; "prPeriod Transactions.".Organization)
//             {
//             }
//             column(Basicpay; Basicpay)
//             {
//             }
//             column(Totalallowances; Totalallowances)
//             {
//             }
//             column(grosspay; grosspay)
//             {
//             }
//             column(nssf; nssf)
//             {
//             }
//             column(nhif; nhif)
//             {
//             }
//             column(paye; paye)
//             {
//             }
//             column(pension; pension)
//             {
//             }
//             column(totaldeductions; totaldeductions)
//             {
//             }
//             column(net; net)
//             {
//             }
//             column(Transfer; Transfer)
//             {
//             }
//             column(SN; SN)
//             {
//             }
//             column(acting; acting)
//             {
//             }
//             column(NPracticing; NPracticing)
//             {
//             }
//             column(Remunarative; Remunarative)
//             {
//             }
//             column(Faxallowance; Faxallowance)
//             {
//             }
//             column(Responsibility; Responsibility)
//             {
//             }
//             column(Airtime; Airtime)
//             {
//             }
//             column(Transferall; Transferall)
//             {
//             }
//             column(Entertainment; Entertainment)
//             {
//             }
//             column(Variance; Variance) { }
//             column(Athird; Athird) { }
//             column(NHIFPLUSNSSF; NHIFPLUSNSSF) { }
//             column(TypeOfHousing; TypeOfHousing)
//             {
//                 Caption = 'Type of Housing';
//             }
//             column(OvertimeAllowances; OvertimeAllowances) { }
//             column(Relief; Relief) { }
//             column(HousingAlloance; HousingAlloance) { }

//             column(TransportAllowance; TransportAllowance) { }
//             column(LoanAmount; LoanAmount) { }
//             dataitem("Payroll Employee."; "Payroll Employee.")
//             {
//                 DataItemLink = "No." = FIELD("Employee Code");
//                 DataItemTableView = WHERE(Status = CONST(Active));

//                 column(No; "Payroll Employee."."No.")
//                 {
//                 }
//                 column(Surname; "Payroll Employee.".Surname)
//                 {
//                 }
//                 column(FirstName; "Payroll Employee."."First Name")
//                 {
//                 }
//                 column(LastName; "Payroll Employee."."Middle Name")
//                 {
//                 }
//                 column(DateofJoin; "Payroll Employee."."Joining Date")
//                 {
//                 }
//                 column(Activity; "Payroll Employee."."Global Dimension 1")
//                 {
//                 }
//                 column(Branch; "Payroll Employee."."Global Dimension 2")
//                 {
//                 }
//                 column(IDNo; "Payroll Employee."."National ID No")
//                 {
//                 }
//                 column(PINNo; "Payroll Employee."."PIN No")
//                 {
//                 }
//                 column(NSSFNo; "Payroll Employee."."NSSF No")
//                 {
//                 }
//                 column(NHIFNo; "Payroll Employee."."NHIF No")
//                 {
//                 }
//                 column(Department_PayrollEmployee; "Payroll Employee.".Department)
//                 {
//                 }
//                 column(PIN_No; "PIN No") { }
//                 column(Category; Category) { }
//                 column(Basic_Pay; "Basic Pay") { }

//                 trigger OnAfterGetRecord()
//                 begin

//                     objPeriod.Reset;
//                     objPeriod.SetRange(objPeriod."Date Opened", "prPeriod Transactions."."Payroll Period");
//                     if objPeriod.Find('-') then begin
//                         PeriodName := objPeriod."Period Name" + Format(objPeriod."Period Year");
//                         //Message('PeriodName%1',PeriodName);
//                     end;

//                     HREmployees.Get("prPeriod Transactions."."Employee Code");
//                     if "Employee Posting Group" <> '' then
//                         if "Employee Posting Group" <> HREmployees."Posting Group" then CurrReport.Skip;

//                     employeeName := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees.Surname;
//                     //Organization := HREmployees."Posting Group";
//                     if "prPeriod Transactions."."Group Order" = 6 then
//                         CurrReport.Skip;
//                     if PeriodTrans.Find('-') then begin
//                         Year := PeriodTrans."Period Year";
//                         //Organization:=HREmployees.."Posting Group";
//                         if PeriodTrans.Amount = 0 then
//                             CurrReport.Skip;

//                     end;
//                     //IF PeriodTrans."Transaction Code"='E009' THEN
//                     // CurrReport.SKIP;
//                     Basicpay := 0;
//                     Totalallowances := 0;
//                     grosspay := 0;
//                     nssf := 0;
//                     nhif := 0;
//                     paye := 0;
//                     pension := 0;
//                     totaldeductions := 0;
//                     net := 0;
//                     Transfer := 0;
//                     Athird := 0;
//                     NHIFPLUSNSSF := 0;
//                     acting := 0;
//                     NPracticing := 0;
//                     Remunarative := 0;
//                     Faxallowance := 0;
//                     Responsibility := 0;
//                     Airtime := 0;
//                     Transfer := 0;
//                     Entertainment := 0;
//                     Transferall := 0;
//                     OvertimeAllowances := 0;
//                     //Basic pay
//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetRange("Transaction Code", 'BPAY');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     //PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.Find('-') then begin
//                         Basicpay := PeriodTrans2.Amount;

//                     end;
//                     //Transport Allowance
//                     //END;

//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetRange("Group Text", 'ALLOWANCE');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.FindSet then begin
//                         repeat
//                             Totalallowances := Totalallowances + PeriodTrans2.Amount;
//                         until PeriodTrans2.Next = 0;
//                     end;
//                     //END;

//                     //gross
//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetRange("Transaction Code", 'GPAY');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.FindFirst then begin
//                         repeat
//                             grosspay := PeriodTrans2.Amount;
//                         until PeriodTrans2.Next = 0;
//                     end;
//                     //END;

//                     //nssf
//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetRange("Transaction Code", 'NSSF');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.FindFirst then begin
//                         repeat
//                             nssf := PeriodTrans2.Amount;
//                         until PeriodTrans2.Next = 0;
//                     end;
//                     //END;

//                     //nhif
//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetRange("Transaction Code", 'NHIF');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.FindFirst then begin
//                         repeat
//                             nhif := PeriodTrans2.Amount;

//                         until PeriodTrans2.Next = 0;
//                     end;
//                     //END;
//                     //Total Contibution
//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetFilter("Transaction Code", '%1|%2|%3|%3|%4|%5', 'PEN1', 'PEN2', 'PEN3', 'PEN5', 'N.S.S.F');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.FindFirst then begin
//                         repeat
//                             NHIFPLUSNSSF := PeriodTrans2.Amount;

//                         until PeriodTrans2.Next = 0;
//                     end;
//                     //paye
//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetRange("Transaction Code", 'PAYE');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.FindFirst then begin
//                         repeat
//                             paye := PeriodTrans2.Amount;
//                         until PeriodTrans2.Next = 0;
//                     end;
//                     //END;

//                     //pension
//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetRange("Transaction Code", 'PNSRLF');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.FindFirst then begin
//                         repeat
//                             pension := PeriodTrans2.Amount;
//                         until PeriodTrans2.Next = 0;
//                     end;
//                     //END;

//                     //other deductions
//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetFilter("Transaction Code", '<>%1', 'PNSRLF');
//                     PeriodTrans2.SetRange("Group Text", 'DEDUCTIONS');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.FindFirst then begin
//                         repeat
//                             totaldeductions := totaldeductions + PeriodTrans2.Amount;
//                         until PeriodTrans2.Next = 0;
//                     end;
//                     //END;
//                     //transfer Allowance
//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetRange("Transaction Code", '0011');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.FindFirst then begin
//                         repeat
//                             Transfer := PeriodTrans2.Amount;
//                         until PeriodTrans2.Next = 0;
//                     end;

//                     //END Acting Allowance;

//                     //net pay
//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetRange("Transaction Code", 'NPAY');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.FindFirst then begin
//                         repeat
//                             net := PeriodTrans2.Amount;
//                             Variance := net - Athird;
//                         until PeriodTrans2.Next = 0;
//                     end;

//                     //Overtime Allowance
//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetRange("Transaction Code", '0013');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.FindFirst then begin
//                         repeat
//                             OvertimeAllowances := PeriodTrans2.Amount;
//                         until PeriodTrans2.Next = 0;
//                     end;
//                     //Acting Allowance
//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetRange("Transaction Code", '0010');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.FindFirst then begin
//                         repeat
//                             Morgage := PeriodTrans2.Amount;
//                         until PeriodTrans2.Next = 0;
//                     end;
//                     //Housing Allowances
//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetRange("Transaction Code", '001');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.FindFirst then begin
//                         repeat
//                             HousingAlloance := PeriodTrans2.Amount;
//                         until PeriodTrans2.Next = 0;
//                     end;
//                     ///commuter
//                                         //Housing Allowances
//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetRange("Transaction Code", '004');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.FindFirst then begin
//                         repeat
//                             TransportAllowance := PeriodTrans2.Amount;
//                         until PeriodTrans2.Next = 0;
//                     end;

//                     //Acting  Allowances NPracticing
//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetRange("Transaction Code", '001');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.FindFirst then begin
//                         repeat
//                             acting := PeriodTrans2.Amount;
//                         until PeriodTrans2.Next = 0;
//                     end;
//                     //Acting  Allowances NPracticing
//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetRange("Transaction Code", '0012');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.Find('-') then begin
//                         repeat
//                             NPracticing := PeriodTrans2.Amount;
//                         until PeriodTrans2.Next = 0;
//                     end;
//                     // Remunarative
//                     PeriodTrans2.Reset;
//                     PeriodTrans2.SetRange("Transaction Code", '002');
//                     PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                     PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                     if PeriodTrans2.Find('-') then begin
//                         repeat
//                             Remunarative := PeriodTrans2.Amount;
//                         until PeriodTrans2.Next = 0;
//                         //fax Responsibility
//                         PeriodTrans2.Reset;
//                         PeriodTrans2.SetRange("Transaction Code", '003');
//                         PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                         PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                         if PeriodTrans2.Find('-') then begin
//                             repeat
//                                 Faxallowance := PeriodTrans2.Amount;
//                             until PeriodTrans2.Next = 0;
//                         end;
//                         // Responsibility

//                         // PeriodTrans2.Reset;
//                         // PeriodTrans2.SetRange("Transaction Code", '005');
//                         // PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                         // PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                         // if PeriodTrans2.FindFirst then begin
//                         //     repeat
//                         //         Responsibility := PeriodTrans2.Amount;
//                         //     until PeriodTrans2.Next = 0;
//                         // end;
//                         //resp Allowance
//                         PeriodTrans2.Reset;
//                         PeriodTrans2.SetRange("Transaction Code", '005');
//                         PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                         PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                         if PeriodTrans2.Find('-') then begin
//                             repeaT
//                                 Responsibility := PeriodTrans2.Amount;
//                             until PeriodTrans2.Next = 0;
//                         end;
//                         // Airtime

//                         PeriodTrans2.Reset;
//                         PeriodTrans2.SetRange("Transaction Code", '006');
//                         PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                         PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                         if PeriodTrans2.Find('-') then begin
//                             repeat
//                                 Airtime := PeriodTrans2.Amount;
//                             until PeriodTrans2.Next = 0;
//                         end;
//                         //Entertainment
//                         PeriodTrans2.Reset;
//                         PeriodTrans2.SetRange("Transaction Code", '006');
//                         PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                         PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                         if PeriodTrans2.Find('-') then begin
//                             repeat
//                                 Entertainment := PeriodTrans2.Amount;
//                             until PeriodTrans2.Next = 0;
//                         end;
//                         //Transfer
//                         PeriodTrans2.Reset;
//                         PeriodTrans2.SetRange("Transaction Code", '008');
//                         PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                         PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                         if PeriodTrans2.Find('-') then begin
//                             repeat
//                                 Transferall := PeriodTrans2.Amount;
//                             until PeriodTrans2.Next = 0;
//                         end;
//                         //Loan amount
//                         PeriodTrans2.Reset;
//                         // PeriodTrans2.SetFilter("Is Loan", '%1', true);
//                         PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                         PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                         if PeriodTrans2.FindFirst then begin
//                             repeat
//                                 // if PayrollTransaction."Is Loan Account" = true then
//                                 LoanAmount := PeriodTrans2.Amount
//                             // else
//                             // LoanAmount := 0;

//                             until PeriodTrans2.Next = 0;
//                         end;

//                         //calculate 1/3 Basic and Variance
//                         PeriodTrans2.Reset;
//                         PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
//                         PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                         if PeriodTrans2.FindFirst then begin
//                             repeat
//                                 Athird := (Basicpay / 3);
//                                 Variance := (net - Athird);
//                             until PeriodTrans2.Next = 0;
//                         end;

//                         Relief := 2400;

//                     end;
//                     SN := SN + 1;
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     /*IF UserSetup.GET(USERID) THEN
//                     BEGIN
//                     IF UserSetup."View Payroll"=FALSE THEN ERROR ('You dont have permissions for payroll, Contact your system administrator! ')
//                     END ELSE BEGIN
//                     ERROR('You have been setup in the user setup!');
//                     END;*/

//                     info.Get;
//                     info.CalcFields(Picture);
//                 end;

//             }

//         }

//     }

//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 field(ORGANIZATION; "Employee Posting Group")
//                 {
//                     TableRelation = "Payroll Posting Groups.";
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

//     var
//         LoanAmount: Decimal;
//         PEN1: Decimal;
//         PEN2: Decimal;
//         PEN3: Decimal;
//         PEN5: Decimal;
//         HousingAlloance: Decimal;
//         Relief: Decimal;
//         Morgage: Decimal;
//         OvertimeAllowances: Decimal;
//         TransportAllowance: Decimal;
//         PayrollTransaction: Record "Payroll Transaction Code.";
//         TypeOfHousing: Text;
//         NHIFPLUSNSSF: Decimal;
//         Athird: Decimal;
//         Variance: Decimal;
//         HREmployees: Record "Payroll Employee.";
//         employeeName: Text;
//         info: Record "Company Information";
//         CompName: Text[50];
//         Addr1: Text[50];
//         Addr2: Text[50];
//         Email: Text[50];
//         UserSetup: Record "User Setup";
//         SelectedPeriod: Date;
//         objPeriod: Record "Payroll Calender.";
//         PeriodFilter: Date;
//         PeriodName: Text;
//         PeriodTrans: Record "prPeriod Transactions.";
//         Year: Integer;
//         Organization: Text;
//         PostingGroup: Text;
//         "Employee Posting Group": Code[10];
//         Basicpay: Decimal;
//         Totalallowances: Decimal;
//         grosspay: Decimal;
//         nssf: Decimal;
//         nhif: Decimal;
//         paye: Decimal;
//         pension: Decimal;
//         totaldeductions: Decimal;
//         net: Decimal;
//         PeriodTrans2: Record "prPeriod Transactions.";
//         Transferall: Decimal;
//         Transfer2: Decimal;
//         SN: Integer;
//         Entertainment: decimal;
//         acting: decimal;
//         NPracticing: decimal;
//         Remunarative: Decimal;
//         Faxallowance: Decimal;
//         Responsibility: Decimal;
//         Airtime: Decimal;
//         Transfer: Decimal;

// }
