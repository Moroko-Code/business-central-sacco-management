// report 51516008 "Devco Sacco Trial Balance"
// {
//     Caption = 'Devco Sacco Trial Balance';
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = Basic, Suite;
//     // PreviewMode = PrintLayout;
//     // DataAccessIntent = ReadOnly;
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/DevcoTrialBalance.rdlc';
//     dataset
//     {
//         dataitem("G/L Account"; "G/L Account")
//         {
//             RequestFilterFields = "Income/Balance", "No.", "Account Type", "GL Account Balance", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
//             DataItemTableView = sorting("No.");
//             column(STRSUBSTNO_Text000_PeriodText_; STRSUBSTNO(Text000, PeriodText))
//             {
//             }
//             column(CurrReport_PAGENO; CurrReport.PAGENO)
//             {
//             }
//             column(COMPANYNAME; COMPANYNAME)
//             {
//             }
//             column(G_L_Account__TABLECAPTION__________GLFilter; TABLECAPTION + ': ' + GLFilter)
//             {
//             }
//             column(GLFilter; GLFilter)
//             {
//             }
//             column(G_L_Account_No_; "No.")
//             {
//             }
//             column(PeriodText; PeriodText)
//             {
//             }
//             column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
//             {
//             }
//             column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
//             {
//             }
//             column(Net_ChangeCaption; Net_ChangeCaptionLbl)
//             {
//             }
//             column(BalanceCaption; BalanceCaptionLbl)
//             {
//             }
//             column(G_L_Account___No__Caption; FIELDCAPTION("No."))
//             {
//             }
//             column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
//             {
//             }
//             column(G_L_Account___Net_Change_Caption; G_L_Account___Net_Change_CaptionLbl)
//             {
//             }
//             column(G_L_Account___Net_Change__Control22Caption; G_L_Account___Net_Change__Control22CaptionLbl)
//             {
//             }
//             column(G_L_Account___Balance_at_Date_Caption; G_L_Account___Balance_at_Date_CaptionLbl)
//             {
//             }
//             column(G_L_Account___Balance_at_Date__Control24Caption; G_L_Account___Balance_at_Date__Control24CaptionLbl)
//             {
//             }
//             column(AccountType; "G/L Account"."Account Type")
//             {
//             }
//             column(PageGroupNo; PageGroupNo)
//             {
//             }

//             column(Totaldebit; Totaldebit)
//             {
//             }
//             column(Totalcredit; -Totalcredit)
//             {
//             }
//             column(Totaldebitbal; Totaldebitbal)
//             {
//             }
//             column(Totalcreditbal; -Totalcreditbal)
//             {
//             }

//             dataitem(Integer; Integer)
//             {
//                 DataItemTableView = sorting(Number) where(Number = const(1));

//                 column(G_L_Account___No__; "G/L Account"."No.")
//                 {
//                 }
//                 column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PADSTR('', "G/L Account".Indentation * 2) + "G/L Account".Name)
//                 {
//                 }
//                 column(G_L_Account___Net_Change_; "G/L Account"."Net Change")
//                 {
//                 }
//                 column(G_L_Account___Net_Change__Control22; -"G/L Account"."Net Change")
//                 {
//                 }
//                 column(G_L_Account___Balance_at_Date_; "G/L Account"."Balance at Date")
//                 {
//                 }
//                 column(G_L_Account___Balance_at_Date__Control24; -"G/L Account"."Balance at Date")
//                 {
//                 }
//                 column(G_L_Account___Account_Type_; FORMAT("G/L Account"."Account Type", 0, 2))
//                 {
//                 }
//                 column(No__of_Blank_Lines; "G/L Account"."No. of Blank Lines")
//                 {
//                 }

//                 dataitem(BlankLineRepeater; Integer)
//                 {
//                     column(BlankLineNo;
//                     BlankLineNo)
//                     {
//                     }
//                     trigger OnAfterGetRecord()
//                     begin
//                         IF BlankLineNo = 0 THEN
//                             CurrReport.BREAK;

//                         BlankLineNo -= 1;
//                     end;
//                 }
//                 trigger OnAfterGetRecord()
//                 begin
//                     BlankLineNo := "G/L Account"."No. of Blank Lines" + 1;
//                 end;
//             }

//             trigger OnPreDataItem()
//             begin
//                 PageGroupNo := 0;
//                 ChangeGroupNo := false;
//             end;

//             trigger OnAfterGetRecord()
//             var
//                 GLEntry: Record "G/L Entry";
//                 Date: Record Date;
//             begin
//                 CalcFields("Net Change", "Balance at Date");
//                 if PrintToExcel then
//                     MakeExcelDataBody;

//                 IF ChangeGroupNo THEN BEGIN
//                     PageGroupNo += 1;
//                     ChangeGroupNo := FALSE;
//                 END;

//                 ChangeGroupNo := "New Page";
//                 CALCFIELDS("Net Change", "Balance at Date");
//                 IF "G/L Account"."Account Type" = "G/L Account"."Account Type"::Posting THEN BEGIN
//                     IF "Net Change" > 0 THEN
//                         Totaldebit := Totaldebit + "Net Change";
//                     IF "Net Change" < 0 THEN
//                         Totalcredit := Totalcredit + "Net Change";
//                 END;

//                 IF "G/L Account"."Account Type" = "G/L Account"."Account Type"::Posting THEN BEGIN
//                     IF "Balance at Date" > 0 THEN
//                         Totaldebitbal := Totaldebitbal + "Balance at Date";
//                     IF "Balance at Date" < 0 THEN
//                         Totalcreditbal := Totalcreditbal + "Balance at Date";
//                 END;
//             end;

//         }

//     }
//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 field(PrintToExcel; PrintToExcel)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Print To Excel';
//                 }
//             }
//         }
//         actions
//         {
//             area(processing)
//             {
//             }
//         }

//     }

//     labels
//     {
//     }
//     trigger OnPreReport()
//     begin
//         PeriodText := "G/L Account".GETFILTER("Date Filter");
//         IF PrintToExcel THEN
//             MakeExcelInfo;
//     end;

//     trigger OnPostReport()
//     begin
//         IF PrintToExcel THEN
//             CreateExcelbook;
//     end;

//     var
//         BlankLineNo: Integer;
//         ExcelBuf: Record "Excel Buffer";
//         GLFilter: Text;
//         PeriodText: Text;
//         PrintToExcel: Boolean;
//         PageGroupNo: Integer;
//         ChangeGroupNo: Boolean;
//         Totaldebit: Decimal;
//         Totalcredit: Decimal;
//         Totaldebitbal: Decimal;
//         Totalcreditbal: Decimal;
//         Trial_BalanceCaptionLbl: Label 'Trial Balance';
//         Text000: label 'Period:%1';
//         Text001: label 'Trial Balance';
//         Text002: label 'Data';
//         Text003: Label 'Debit';
//         Text004: Label 'Credit';
//         Text005: Label 'Company Name';
//         Text006: Label 'Report No.';
//         Text007: Label 'Report Name';
//         Text008: label 'User ID';
//         Text009: Label 'Date';
//         Text010: Label 'G/L Filter';
//         Text011: Label 'Period Filter';
//         CurrReport_PAGENOCaptionLbl: Label 'Page';
//         Net_ChangeCaptionLbl: Label 'Net Change';
//         BalanceCaptionLbl: Label 'Balance';
//         PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: Label 'Name';
//         G_L_Account___Net_Change_CaptionLbl: Label 'Debit';
//         G_L_Account___Net_Change__Control22CaptionLbl: Label 'Credit';
//         G_L_Account___Balance_at_Date_CaptionLbl: Label 'Debit';
//         G_L_Account___Balance_at_Date__Control24CaptionLbl: Label 'Credit';

//     procedure MakeExcelDataBody()
//     var
//         BlankFiller: Text[1000];
//     begin
//         BlankFiller := PADSTR(' ', MAXSTRLEN(BlankFiller), ' ');
//         ExcelBuf.NewRow;
//         ExcelBuf.AddColumn(
//           "G/L Account"."No.", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
//           ExcelBuf."Cell Type"::Text);
//         IF "G/L Account".Indentation = 0 THEN
//             ExcelBuf.AddColumn(
//               "G/L Account".Name, FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
//               ExcelBuf."Cell Type"::Text)
//         ELSE
//             ExcelBuf.AddColumn(
//               COPYSTR(BlankFiller, 1, 2 * "G/L Account".Indentation) + "G/L Account".Name,
//               FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

//         CASE TRUE OF
//             "G/L Account"."Net Change" = 0:
//                 BEGIN
//                     ExcelBuf.AddColumn(
//                       '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
//                       ExcelBuf."Cell Type"::Text);
//                     ExcelBuf.AddColumn(
//                       '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
//                       ExcelBuf."Cell Type"::Text);
//                 END;
//             "G/L Account"."Net Change" > 0:
//                 BEGIN
//                     ExcelBuf.AddColumn(
//                       "G/L Account"."Net Change", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
//                       FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
//                     ExcelBuf.AddColumn(
//                       '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
//                       ExcelBuf."Cell Type"::Text);
//                 END;
//             "G/L Account"."Net Change" < 0:
//                 BEGIN
//                     ExcelBuf.AddColumn(
//                       '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
//                       ExcelBuf."Cell Type"::Text);
//                     ExcelBuf.AddColumn(
//                       -"G/L Account"."Net Change", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
//                       FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
//                 END;
//         END;

//         CASE TRUE OF
//             "G/L Account"."Balance at Date" = 0:
//                 BEGIN
//                     ExcelBuf.AddColumn(
//                       '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
//                       ExcelBuf."Cell Type"::Text);
//                     ExcelBuf.AddColumn(
//                       '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
//                       ExcelBuf."Cell Type"::Text);
//                 END;
//             "G/L Account"."Balance at Date" > 0:
//                 BEGIN
//                     ExcelBuf.AddColumn(
//                       "G/L Account"."Balance at Date", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
//                       FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
//                     ExcelBuf.AddColumn(
//                       '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
//                       ExcelBuf."Cell Type"::Text);
//                 END;
//             "G/L Account"."Balance at Date" < 0:
//                 BEGIN
//                     ExcelBuf.AddColumn(
//                       '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
//                       ExcelBuf."Cell Type"::Text);
//                     ExcelBuf.AddColumn(
//                       -"G/L Account"."Balance at Date", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
//                       FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
//                 END;
//         END;
//     end;

//     procedure MakeExcelInfo()
//     begin
//         ExcelBuf.SetUseInfoSheet;
//         ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
//         ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
//         ExcelBuf.NewRow;
//         ExcelBuf.AddInfoColumn(FORMAT(Text007), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
//         ExcelBuf.AddInfoColumn(FORMAT(Text001), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
//         ExcelBuf.NewRow;
//         ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
//         ExcelBuf.AddInfoColumn(REPORT::"Trial Balance", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
//         ExcelBuf.NewRow;
//         ExcelBuf.AddInfoColumn(FORMAT(Text008), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
//         ExcelBuf.AddInfoColumn(USERID, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
//         ExcelBuf.NewRow;
//         ExcelBuf.AddInfoColumn(FORMAT(Text009), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
//         ExcelBuf.AddInfoColumn(TODAY, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
//         ExcelBuf.NewRow;
//         ExcelBuf.AddInfoColumn(FORMAT(Text010), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
//         ExcelBuf.AddInfoColumn("G/L Account".GETFILTER("No."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
//         ExcelBuf.NewRow;
//         ExcelBuf.AddInfoColumn(FORMAT(Text011), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
//         ExcelBuf.AddInfoColumn("G/L Account".GETFILTER("Date Filter"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
//         ExcelBuf.ClearNewRow;
//         MakeExcelDataHeader;
//     end;

//     procedure CreateExcelbook()
//     begin
//         ExcelBuf.CreateBookAndOpenExcel(Text001, Text002, Text001, COMPANYNAME, USERID);
//         ERROR('');
//     end;

//     procedure MakeExcelDataHeader()
//     begin
//         ExcelBuf.AddColumn("G/L Account".FIELDCAPTION("No."), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
//         ExcelBuf.AddColumn("G/L Account".FIELDCAPTION(Name), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
//         ExcelBuf.AddColumn(
//           FORMAT("G/L Account".FIELDCAPTION("Net Change") + ' - ' + Text003), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
//         ExcelBuf.AddColumn(
//           FORMAT("G/L Account".FIELDCAPTION("Net Change") + ' - ' + Text004), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
//         ExcelBuf.AddColumn(
//           FORMAT("G/L Account".FIELDCAPTION("Balance at Date") + ' - ' + Text003), FALSE, '', TRUE, FALSE, TRUE, '',
//           ExcelBuf."Cell Type"::Text);
//         ExcelBuf.AddColumn(
//           FORMAT("G/L Account".FIELDCAPTION("Balance at Date") + ' - ' + Text004), FALSE, '', TRUE, FALSE, TRUE, '',
//           ExcelBuf."Cell Type"::Text);
//     end;

// }
