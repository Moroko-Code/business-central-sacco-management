// Report 51516484 "Provident Schedule"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/ProvidentSchedule.rdlc';

//     dataset
//     {
//         dataitem("Payroll Monthly Transactions"; "Payroll Monthly Transactions")
//         {
//             RequestFilterFields = "Payroll Period";
//             column(No; "Payroll Monthly Transactions"."No.")
//             {
//             }
//             column(EmpName; EmpName)
//             {
//             }
//             column(TName; "Payroll Monthly Transactions"."Transaction Name")
//             {
//             }
//             column(Period; "Payroll Monthly Transactions"."Payroll Period")
//             {
//             }
//             column(Amount; "Payroll Monthly Transactions".Amount)
//             {
//             }
//             column(ProvAmount; ProvAmount)
//             {
//             }
//             column(PeriodFilter; PeriodFilter)
//             {
//             }
//             column(Name; CompanyInfo.Name)
//             {
//             }
//             column(pic; CompanyInfo.Picture)
//             {
//             }
//             column(Address; CompanyInfo.Address)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 if HrEmp.Get("Payroll Monthly Transactions"."No.") then
//                     EmpName := HrEmp."Full Name";

//                 "Payroll Monthly Transactions".SetRange("Payroll Monthly Transactions"."Payroll Period", PeriodFilter);

//                 ProvAmount := 0;
//                 //ERROR('%1',"Payroll Monthly Transactions"."Period Filter");
//                 EmpDed.Reset;
//                 EmpDed.SetRange(EmpDed."Employee Code", "Payroll Monthly Transactions"."No.");
//                 EmpDed.SetRange(EmpDed."Payroll Period", "Payroll Monthly Transactions"."Payroll Period");
//                 //EmpDed.SETFILTER(EmpDed."Payroll Period","Payroll Monthly Transactions"."Payroll Period");
//                 EmpDed.SetRange(EmpDed."Transaction Code", 'D002');
//                 if EmpDed.Find('-') then begin

//                     if HrEmp.Casual = true then
//                         ProvAmount := 0
//                     else
//                         ProvAmount := EmpDed.Amount;
//                 end;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 "Payroll Monthly Transactions".SetRange("Payroll Monthly Transactions"."Transaction Code", 'D002');
//             end;
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 field(periodfilter; PeriodFilter)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Period Filter';
//                     TableRelation = "Payroll Calender"."Date Opened";
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
//         CompanyInfo.Get();
//         CompanyInfo.CalcFields(CompanyInfo.Picture);
//     end;

//     var
//         EmpName: Text[100];
//         HrEmp: Record "Payroll Employee";
//         EmpDed: Record "Payroll Employer Deductions";
//         ProvAmount: Decimal;
//         PeriodFilter: Date;
//         CompanyInfo: Record "Company Information";
// }
