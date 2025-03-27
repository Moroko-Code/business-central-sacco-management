// Report 51516473 "All Earnings Summary"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/PaymentsSummary.rdlc';

//     dataset
//     {
//         dataitem("Payroll Monthly Transactions"; "Payroll Monthly Transactions")
//         {
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(COMPANYNAME; COMPANYNAME)
//             {
//             }
//             column(COMPANYNAME_Control1102755015; COMPANYNAME)
//             {
//             }
//             column(COMPANYNAME_Control1102756027; COMPANYNAME)
//             {
//             }
//             column(COMPANYNAME_Control1102756028; COMPANYNAME)
//             {
//             }
//             column(CompanyInfo_Picture1; CompanyInfo.Picture)
//             {
//             }
//             column(CompanyInfo_Picture_Control1102756014; CompanyInfo.Picture)
//             {
//             }
//             column(CompName; CompName)
//             {
//             }
//             column(Addr1; Addr1)
//             {
//             }
//             column(Addr2; Addr2)
//             {
//             }
//             column(Email; Email)
//             {
//             }
//             column(PayrollSummary; 'COMPANY PAYROLL SUMMARY')
//             {
//             }
//             column(PeriodNamez; 'PERIOD:  ' + PeriodName)
//             {
//             }
//             column(TransDesc; 'TRANSACTION DESC.')
//             {
//             }
//             column(payments; 'PAYMENTS')
//             {
//             }
//             column(deductions; 'DEDUCTIONS')
//             {
//             }
//             column(kirinyagatitle; COMPANYNAME)
//             {
//             }
//             column(abreviation; 'MUST')
//             {
//             }
//             column(DetDate; DetDate)
//             {
//             }
//             column(EmpNo; "Payroll Monthly Transactions"."No.")
//             {
//             }
//             column(empName; empName)
//             {
//             }
//             column(EmpAmount; "Payroll Monthly Transactions".Amount)
//             {
//             }
//             column("code"; "Payroll Monthly Transactions"."Transaction Code")
//             {
//             }
//             column(name; "Payroll Monthly Transactions"."Transaction Name")
//             {
//             }
//             column(Transaction; "Payroll Monthly Transactions"."Transaction Code" + ': ' + "Payroll Monthly Transactions"."Transaction Name")
//             {
//             }
//             column(TotLabel; "Payroll Monthly Transactions"."Transaction Code" + ': ' + "Payroll Monthly Transactions"."Transaction Name")
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 Clear(empName);
//                 if emps.Get("Payroll Monthly Transactions"."No.") then
//                     empName := emps."Full Name";

//                 if not (((("Payroll Monthly Transactions".Grouping = 1) and
//                 ("Payroll Monthly Transactions".SubGrouping <> 1)) or
//                ("Payroll Monthly Transactions".Grouping = 3) or
//                 (("Payroll Monthly Transactions".Grouping = 4) and
//                  ("Payroll Monthly Transactions".SubGrouping <> 0)))) then begin
//                     CurrReport.Skip;
//                 end;

//                 "prPayroll Periods".Reset;
//                 "prPayroll Periods".SetRange("prPayroll Periods"."Date Opened", SelectedPeriod);
//                 if "prPayroll Periods".Find('-') then begin
//                     Clear(DetDate);
//                     DetDate := Format("prPayroll Periods"."Period Name");
//                 end;

//                 /*IF NOT ( ((("Payroll Monthly Transactions"."Grouping"=7) AND
//                      (("Payroll Monthly Transactions"."SubGrouping"<>6)
//                     AND ("Payroll Monthly Transactions"."SubGrouping"<>5))) OR
//                     (("Payroll Monthly Transactions"."Grouping"=8) AND
//                      ("Payroll Monthly Transactions"."SubGrouping"<>9)))) THEN BEGIN
//                       CurrReport.SKIP;
//                       END; */

//                 /*
//               CLEAR(rows);
//               CLEAR(rows2);
//               "Payroll Monthly Transactions".RESET;
//               "Payroll Monthly Transactions".SETRANGE("Payroll Period",SelectedPeriod);
//               "Payroll Monthly Transactions".SETFILTER("Group Order",'=1|3|4|7|8|9');
//               //"Payroll Monthly Transactions".SETFILTER("Payroll Monthly Transactions"."SubGrouping",'=2');
//               "Payroll Monthly Transactions".SETCURRENTKEY("Payroll Period","Group Order","Sub Group Order");
//               IF "Payroll Monthly Transactions".FIND('-') THEN BEGIN
//               CLEAR(DetDate);
//               DetDate:=FORMAT("prPayroll Periods"."Period Name");
//               REPEAT
//               BEGIN
//               IF "Payroll Monthly Transactions".Amount>0 THEN BEGIN
//               IF (("Payroll Monthly Transactions"."Grouping"=4) AND ("Payroll Monthly Transactions"."SubGrouping"=0)) THEN
//                 GPY:=GPY+"Payroll Monthly Transactions".Amount;

//               IF (("Payroll Monthly Transactions"."Grouping"=7) AND
//               (("Payroll Monthly Transactions"."SubGrouping"=3) OR ("Payroll Monthly Transactions"."SubGrouping"=1) OR
//                ("Payroll Monthly Transactions"."SubGrouping"=2)))  THEN
//                 STAT:=STAT+"Payroll Monthly Transactions".Amount;

//               IF (("Payroll Monthly Transactions"."Grouping"=8) AND
//               (("Payroll Monthly Transactions"."SubGrouping"=1) OR ("Payroll Monthly Transactions"."SubGrouping"=0))) THEN
//                  DED:=DED+"Payroll Monthly Transactions".Amount;

//               IF (("Payroll Monthly Transactions"."Grouping"=9) AND ("Payroll Monthly Transactions"."SubGrouping"=0)) THEN
//                 NETS:=NETS+"Payroll Monthly Transactions".Amount;

//               //TotalsAllowances:=TotalsAllowances+"Payroll Monthly Transactions".Amount;
//                   IF ((("Payroll Monthly Transactions"."Grouping"=1) AND
//                    ("Payroll Monthly Transactions"."SubGrouping"<>1)) OR
//                   ("Payroll Monthly Transactions"."Grouping"=3) OR
//                    (("Payroll Monthly Transactions"."Grouping"=4) AND
//                     ("Payroll Monthly Transactions"."SubGrouping"<>0))) THEN BEGIN // A Payment
//                     CLEAR(countz);
//                    // countz:=1;
//                     CLEAR(found);
//                     REPEAT
//                    BEGIN
//                      countz:=countz+1;
//                      IF (PayTrans[countz])="Payroll Monthly Transactions"."Transaction Name" THEN found:=TRUE;
//                      END;
//                     UNTIL ((countz=(ARRAYLEN(PayTransAmt))) OR ((PayTrans[countz])="Payroll Monthly Transactions"."Transaction Name")
//                     OR ((PayTrans[countz])=''));
//                    rows:= countz;
//                   PayTrans[rows]:="Payroll Monthly Transactions"."Transaction Name";
//                   PayTransAmt[rows]:=PayTransAmt[rows]+"Payroll Monthly Transactions".Amount;
//                   END ELSE IF ((("Payroll Monthly Transactions"."Grouping"=7) AND
//                    (("Payroll Monthly Transactions"."SubGrouping"<>6)
//                   AND ("Payroll Monthly Transactions"."SubGrouping"<>5))) OR
//                   (("Payroll Monthly Transactions"."Grouping"=8) AND
//                    ("Payroll Monthly Transactions"."SubGrouping"<>9))) THEN BEGIN
//                     CLEAR(countz);
//                    // countz:=1;
//                     CLEAR(found);
//                     REPEAT
//                    BEGIN
//                      countz:=countz+1;
//                      IF (DedTrans[countz])="Payroll Monthly Transactions"."Transaction Name" THEN found:=TRUE;
//                      END;
//                     UNTIL ((countz=(ARRAYLEN(DedTransAmt))) OR ((DedTrans[countz])="Payroll Monthly Transactions"."Transaction Name")
//                     OR ((DedTrans[countz])=''));
//                    rows:= countz;
//                   DedTrans[rows]:="Payroll Monthly Transactions"."Transaction Name";
//                   DedTransAmt[rows]:=DedTransAmt[rows]+"Payroll Monthly Transactions".Amount;
//                   END;
//                   END; // If Amount >0;
//               END;
//               UNTIL "Payroll Monthly Transactions".NEXT=0;
//               END;// End prPeriod Transactions Repeat
//               // MESSAGE('Heh'+FORMAT(rows)+', '+FORMAT(rows2));
//                                     */

//             end;

//             trigger OnPreDataItem()
//             begin
//                 if CompanyInfo.Get() then
//                     CompanyInfo.CalcFields(CompanyInfo.Picture);

//                 CompName := CompanyInfo.Name;
//                 Addr1 := CompanyInfo.Address;

//                 Addr2 := CompanyInfo.City;
//                 Email := CompanyInfo."E-Mail";

//                 //LastFieldNo := FIELDNO("Period Year");
//                 "Payroll Monthly Transactions".SetFilter("Payroll Monthly Transactions"."Payroll Period", '=%1', SelectedPeriod);
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

//     trigger OnInitReport()
//     begin
//         objPeriod.Reset;
//         objPeriod.SetRange(objPeriod.Closed, false);
//         if objPeriod.Find('-') then;
//         PeriodFilter := objPeriod."Date Opened";
//     end;

//     trigger OnPreReport()
//     begin
//         if UserSetup.Get(UserId) then begin
//             if UserSetup."Payroll User" = false then Error('You dont have permissions for payroll, Contact your system administrator! ')
//         end else begin
//             Error('You have been setup in the user setup!');
//         end;

//         SelectedPeriod := PeriodFilter;
//         objPeriod.Reset;
//         objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
//         if objPeriod.Find('-') then begin
//             PeriodName := objPeriod."Period Name";
//         end;

//         if CompanyInfo.Get() then
//             CompanyInfo.CalcFields(CompanyInfo.Picture);
//         Clear(rows);
//         Clear(GPY);
//         Clear(STAT);
//         Clear(DED);
//         Clear(NETS);
//     end;

//     var
//         UserSetup: Record "User Setup";
//         empName: Text[250];
//         DetDate: Text[100];
//         found: Boolean;
//         countz: Integer;
//         PeriodFilter: Date;
//         LastFieldNo: Integer;
//         FooterPrinted: Boolean;
//         PeriodTrans: Record "Payroll Monthly Transactions";
//         objPeriod: Record "Payroll Calender";
//         SelectedPeriod: Date;
//         PeriodName: Text[30];
//         CompanyInfo: Record "Company Information";
//         TotalsAllowances: Decimal;
//         Dept: Boolean;
//         PaymentDesc: Text[200];
//         DeductionDesc: Text[200];
//         GroupText1: Text[200];
//         GroupText2: Text[200];
//         PaymentAmount: Decimal;
//         DeductAmount: Decimal;
//         PayTrans: array[70] of Text[250];
//         CompName: Text[50];
//         Addr1: Text[50];
//         Addr2: Text[50];
//         Email: Text[50];
//         PayTransAmt: array[70] of Decimal;
//         DedTrans: array[70] of Text[250];
//         DedTransAmt: array[70] of Decimal;
//         rows: Integer;
//         rows2: Integer;
//         GPY: Decimal;
//         NETS: Decimal;
//         STAT: Decimal;
//         DED: Decimal;
//         TotalFor: label 'Total for ';
//         GroupOrder: label '3';
//         TransBal: array[2, 60] of Text[250];
//         Addr: array[2, 10] of Text[250];
//         RecordNo: Integer;
//         NoOfColumns: Integer;
//         ColumnNo: Integer;
//         emps: Record "Payroll Employee";
//         "prPayroll Periods": Record "Payroll Calender";
// }
