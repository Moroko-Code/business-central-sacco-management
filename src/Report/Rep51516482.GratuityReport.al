// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 51516482 "Gratuity Report"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/Gratuity Report.rdlc';

//     dataset
//     {
//         dataitem("prPeriod Transactions."; "Payroll Employee Transactions")
//         {
//             DataItemTableView = where("Transaction Code" = filter('GRATUITY'));
//             RequestFilterFields = "Payroll Period";
//             column(ReportForNavId_1; 1)
//             {
//             }
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
//             column(EmployeeCode_prPeriodTransactions; "prPeriod Transactions."."No.")
//             {
//             }
//             column(TransactionCode_prPeriodTransactions; "prPeriod Transactions."."Transaction Code")
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
//             column(PeriodMonth_prPeriodTransactions; "prPeriod Transactions."."Period Month")
//             {
//             }
//             column(PeriodYear_prPeriodTransactions; "prPeriod Transactions."."Period Year")
//             {
//             }
//             column(PeriodFilter_prPeriodTransactions; "prPeriod Transactions."."Payroll Period")
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
//             column(EmpAmount_prPeriodTransactions; "prPeriod Transactions.".Amount)
//             {
//             }
//             column(EmpBalance_prPeriodTransactions; "prPeriod Transactions.".Balance)
//             {
//             }
//             column(LoanNumber_prPeriodTransactions; "prPeriod Transactions."."Loan Number")
//             {
//             }
//             column(PayrollCode_prPeriodTransactions; "prPeriod Transactions."."Payroll Code")
//             {
//             }
//             column(employeeName; employeeName)
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
//             column(gratuity; gratuity)
//             {
//             }
//             column(nita; nita)
//             {
//             }
//             column(SN; SN)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin

//                 objPeriod.Reset;
//                 objPeriod.SetRange(objPeriod."Date Opened", "prPeriod Transactions."."Payroll Period");
//                 if objPeriod.Find('-') then begin
//                     PeriodName := objPeriod."Period Name";
//                 end;

//                 HREmployees.Get("prPeriod Transactions."."No.");
//                 employeeName := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees.Surname;

//                 Organization := HREmployees."Posting Group";
//                 //gratuity
//                 PayrollEmployeeTransactions.Reset;
//                 PayrollEmployeeTransactions.SetRange("Transaction Code", 'GRATUITY');
//                 PayrollEmployeeTransactions.SetRange("No.", "prPeriod Transactions."."No.");
//                 PayrollEmployeeTransactions.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
//                 if PayrollEmployeeTransactions.FindFirst then begin
//                     repeat
//                         gratuity := PayrollEmployeeTransactions.Amount;
//                         if gratuity = 0 then CurrReport.Skip;
//                         SN := SN + 1;
//                     until PayrollEmployeeTransactions.Next = 0;
//                 end;

//             end;

//             trigger OnPreDataItem()
//             begin
//                 info.Get;
//                 info.CalcFields(Picture);

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

//     var
//         HREmployees: Record "HR Employee";
//         employeeName: Text;
//         info: Record "Company Information";
//         CompName: Text[50];
//         Addr1: Text[50];
//         Addr2: Text[50];
//         Email: Text[50];
//         UserSetup: Record "User Setup";
//         SelectedPeriod: Date;
//         objPeriod: Record "Payroll Calender";
//         PeriodFilter: Date;
//         PeriodName: Text;
//         PeriodTrans: Record "Payroll Monthly Transactions";
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
//         PeriodTrans2: Record "Payroll Monthly Transactions";
//         gratuity: Decimal;
//         nita: Decimal;
//         PayrollEmployee: Record "HR Employee";
//         PayrollEmployeeTransactions: Record "Payroll Employee Transactions";
//         SN: Integer;
// }
