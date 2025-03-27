// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 51516479 "NSSF Schedule"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/NSSFSchedule.rdlc';

//     dataset
//     {
//         dataitem("Payroll Employee";"Payroll Employee")
//         {
//             RequestFilterFields = "Period Filter","No.";

//             column(USERID;UserId)
//             {
//             }
//             column(TODAY;Today)
//             {
//             }
//             column(PeriodName;PeriodName)
//             {
//             }
//             column(CurrReport_PAGENO;CurrReport.PageNo)
//             {
//             }
//             column(CompanyInfo_Picture;CompanyInfo.Picture)
//             {
//             }
//             column(COMPANYNAME;COMPANYNAME)
//             {
//             }
//             column(PeriodName_Control1102756011;PeriodName)
//             {
//             }
//             column(CompName;CompName)
//             {
//             }
//             column(TotalAmount;TotalAmount)
//             {
//             }
//             column(Volume_Amount_;"Volume Amount")
//             {
//             }
//             column(IDNumber;IDNumber)
//             {
//             }
//             column(EmployeeName;EmployeeName)
//             {
//             }
//             column(prSalary_Card__prSalary_Card___Employee_Code_;"Payroll Employee"."No.")
//             {
//             }
//             column(NssfAmount_2;NssfAmount/2)
//             {
//             }
//             column(NssfNo;NssfNo)
//             {
//             }
//             column(NssfAmount_2_Control1102756008;NssfAmount/2)
//             {
//             }
//             column(TotNssfAmount_2;TotNssfAmount/2)
//             {
//             }
//             column(totTotalAmount;totTotalAmount)
//             {
//             }
//             column(TotVolume_Amount_;"TotVolume Amount")
//             {
//             }
//             column(TotNssfAmount_2_Control1102756015;TotNssfAmount/2)
//             {
//             }
//             column(NATIONAL_SOCIAL_SECURITY_FUNDCaption;NATIONAL_SOCIAL_SECURITY_FUNDCaptionLbl)
//             {
//             }
//             column(User_Name_Caption;User_Name_CaptionLbl)
//             {
//             }
//             column(Print_Date_Caption;Print_Date_CaptionLbl)
//             {
//             }
//             column(Period_Caption;Period_CaptionLbl)
//             {
//             }
//             column(Page_No_Caption;Page_No_CaptionLbl)
//             {
//             }
//             column(PERIOD_Caption_Control1102755031;PERIOD_Caption_Control1102755031Lbl)
//             {
//             }
//             column(EMPLOYER_NO_Caption;EMPLOYER_NO_CaptionLbl)
//             {
//             }
//             column(EMPLOYER_NAME_Caption;EMPLOYER_NAME_CaptionLbl)
//             {
//             }
//             column(Payroll_No_Caption;Payroll_No_CaptionLbl)
//             {
//             }
//             column(Employee_NameCaption;Employee_NameCaptionLbl)
//             {
//             }
//             column(NSSF_No_Caption;NSSF_No_CaptionLbl)
//             {
//             }
//             column(ID_Number_Caption;ID_Number_CaptionLbl)
//             {
//             }
//             column(Vol_AmountCaption;Vol_AmountCaptionLbl)
//             {
//             }
//             column(Total_AmountCaption;Total_AmountCaptionLbl)
//             {
//             }
//             column(Employee_AmountCaption;Employee_AmountCaptionLbl)
//             {
//             }
//             column(Employer_AmountCaption;Employer_AmountCaptionLbl)
//             {
//             }
//             column(Total_Amounts_Caption;Total_Amounts_CaptionLbl)
//             {
//             }
//             column(Prepared_by_______________________________________Date_________________Caption;Prepared_by_______________________________________Date_________________CaptionLbl)
//             {
//             }
//             column(Checked_by________________________________________Date_________________Caption;Checked_by________________________________________Date_________________CaptionLbl)
//             {
//             }
//             column(Authorized_by____________________________________Date_________________Caption;Authorized_by____________________________________Date_________________CaptionLbl)
//             {
//             }
//             column(Approved_by______________________________________Date_________________Caption;Approved_by______________________________________Date_________________CaptionLbl)
//             {
//             }
//             column(Company_Name;CompName)
//             {
//             }
//             column(NSSFEmployerAmount;NSSFEmployerAmount)
//             {
//             }
//             column(NSSFEmployee_Amount;NSSFEmployeeAmount)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin

//                 objEmp.Reset;
//                 objEmp.SetRange(objEmp."No.","No.");
//                 if objEmp.Find('-') then;
//                   EmployeeName:=  objEmp."Full Name";
//                   NssfNo:=objEmp."NSSF No";
//                   IDNumber:=objEmp."National ID No";

//                 //Volume Amount****************************************************************************
//                 PeriodTrans.Reset;
//                 PeriodTrans.SetRange(PeriodTrans."No.","No.");
//                 PeriodTrans.SetRange(PeriodTrans."Payroll Period",SelectedPeriod);
//                 PeriodTrans.SetFilter(PeriodTrans."Transaction Code",Format(427)); // Nssf Code
//                 PeriodTrans.SetCurrentkey(PeriodTrans."No.",PeriodTrans."Period Month",PeriodTrans."Period Year",PeriodTrans.Grouping,PeriodTrans.SubGrouping);

//                 "Volume Amount":=0;
//                 if PeriodTrans.Find('-') then
//                    begin
//                       "Volume Amount":=PeriodTrans.Amount;
//                    end;

//                 "TotVolume Amount":="TotVolume Amount"+"Volume Amount";

//                 //Standard Amount**************************************************************************
//                 PeriodTrans.Reset;
//                 PeriodTrans.SetRange(PeriodTrans."No.","No.");
//                 PeriodTrans.SetRange(PeriodTrans."Payroll Period",SelectedPeriod);
//                 PeriodTrans.SetFilter(PeriodTrans.Grouping,'=7');
//                 PeriodTrans.SetFilter(PeriodTrans.SubGrouping,'=1');
//                 PeriodTrans.SetCurrentkey(PeriodTrans."No.",PeriodTrans."Period Month",PeriodTrans."Period Year",
//                 PeriodTrans.Grouping,PeriodTrans.SubGrouping);

//                 NssfAmount:=0;
//                 NSSFEmployerAmount:=0;
//                 NSSFEmployeeAmount:=0;
//                 if PeriodTrans.Find('-') then
//                    begin
//                       NssfAmount:=PeriodTrans.Amount+PeriodTrans.Amount;
//                       NSSFEmployeeAmount:=PeriodTrans.Amount;
//                       NSSFEmployerAmount:=PeriodTrans.Amount;

//                  TotalAmount:=NSSFEmployeeAmount+NSSFEmployerAmount;
//                     if "Payroll Employee".Casual = true then begin
//                        NSSFEmployerAmount:=1080;
//                       TotalAmount:=NSSFEmployerAmount+NSSFEmployeeAmount;
//                       end;

//                    end;

//                 //Total Amount=NssfAmount+Volume Amount**************************************************
//                 //TotalAmount:=NssfAmount+"Volume Amount";
//                 //TotalAmount:=NSSFEmployeeAmount+NSSFEmployerAmount;

//                 //Summation Total Amount=****************************************************************
//                 totTotalAmount:=totTotalAmount+TotalAmount;

//                 if NssfAmount<=0 then
//                   CurrReport.Skip;
//                   TotNssfAmount:=TotNssfAmount+NssfAmount;
//             end;
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 field(periodfilter;PeriodFilter)
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

//     trigger OnInitReport()
//     begin
//         objPeriod.Reset;
//         objPeriod.SetRange(objPeriod.Closed,false);
//         if objPeriod.Find('-') then;
//         PeriodFilter:=objPeriod."Date Opened";
//     end;

//     trigger OnPreReport()
//     begin
//         if UserSetup.Get(UserId) then
//         begin
//         if UserSetup."Payroll User"=false then Error ('You dont have permissions for payroll, Contact your system administrator! ')
//         end else begin
//         Error('You have been setup in the user setup!');
//         end;

//         //PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
//         if PeriodFilter=0D then Error('You must specify the period filter');

//         SelectedPeriod:=PeriodFilter;
//         objPeriod.Reset;
//         if objPeriod.Get(SelectedPeriod) then PeriodName:=objPeriod."Period Name";

//         if CompanyInfo.Get() then
//         CompanyInfo.CalcFields(CompanyInfo.Picture);
//         CompName:=CompanyInfo.Name;
//     end;

//     var
//         UserSetup: Record "User Setup";
//         PeriodTrans: Record "Payroll Monthly Transactions";
//         NssfAmount: Decimal;
//         TotNssfAmount: Decimal;
//         objEmp: Record "Payroll Employee";
//         EmployeeName: Text[150];
//         NssfNo: Text[30];
//         IDNumber: Text[30];
//         objPeriod: Record "Payroll Calender";
//         SelectedPeriod: Date;
//         PeriodName: Text[30];
//         PeriodFilter: Date;
//         "Volume Amount": Decimal;
//         "TotVolume Amount": Decimal;
//         TotalAmount: Decimal;
//         totTotalAmount: Decimal;
//         CompanyInfo: Record "Company Information";
//         NATIONAL_SOCIAL_SECURITY_FUNDCaptionLbl: label 'NATIONAL SOCIAL SECURITY FUND';
//         User_Name_CaptionLbl: label 'User Name:';
//         Print_Date_CaptionLbl: label 'Print Date:';
//         Period_CaptionLbl: label 'Period:';
//         Page_No_CaptionLbl: label 'Page No:';
//         PERIOD_Caption_Control1102755031Lbl: label 'PERIOD:';
//         EMPLOYER_NO_CaptionLbl: label 'EMPLOYER NO:';
//         EMPLOYER_NAME_CaptionLbl: label 'EMPLOYER NAME:';
//         Payroll_No_CaptionLbl: label 'Payroll No:';
//         Employee_NameCaptionLbl: label 'Employee Name';
//         NSSF_No_CaptionLbl: label 'NSSF No:';
//         ID_Number_CaptionLbl: label 'ID Number:';
//         Vol_AmountCaptionLbl: label 'Vol Amount';
//         Total_AmountCaptionLbl: label 'Total Amount';
//         Employee_AmountCaptionLbl: label 'Employee Amount';
//         Employer_AmountCaptionLbl: label 'Employer Amount';
//         Total_Amounts_CaptionLbl: label 'Total Amounts:';
//         Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by……………………………………………………..                 Date……………………………………………';
//         Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by…………………………………………………..                   Date……………………………………………';
//         Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by……………………………………………………..              Date……………………………………………';
//         Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by……………………………………………………..                Date……………………………………………';
//         CompName: Text[100];
//         NSSFEmployerAmount: Decimal;
//         NSSFEmployeeAmount: Decimal;
// }
