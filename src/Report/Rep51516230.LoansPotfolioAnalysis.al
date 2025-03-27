#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516230 "Loans Potfolio Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loans Potfolio Analysis.rdlc';

    dataset
    {
        dataitem("Loan Products Setup"; "Loan Products Setup")
        {
            RequestFilterFields = "Code";
            column(ReportForNavId_1344; 1344)
            {
            }
            column(USERID; UserId)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(Over3MonthT; Over3MonthT)
            {
            }
            column(V3MonthT_; "3MonthT")
            {
            }
            column(V2MonthT_; "2MonthT")
            {
            }
            column(V1MonthT_; "1MonthT")
            {
            }
            column(V1MonthT___2MonthT___3MonthT__Over3MonthT; "1MonthT" + "2MonthT" + "3MonthT" + Over3MonthT)
            {
            }
            column(Over3MonthT___0MonthT___1MonthT___2MonthT___3MonthT__Over3MonthT___100; (Over3MonthT / ("0MonthT" + "1MonthT" + "2MonthT" + "3MonthT" + Over3MonthT)) * 100)
            {
            }
            column(V3MonthT____0MonthT___1MonthT___2MonthT___3MonthT__Over3MonthT___100; ("3MonthT" / ("0MonthT" + "1MonthT" + "2MonthT" + "3MonthT" + Over3MonthT)) * 100)
            {
            }
            column(V0MonthT___1MonthT___2MonthT___3MonthT__Over3MonthT____0MonthT___1MonthT___2MonthT___3MonthT__Over3MonthT___100; (("0MonthT" + "1MonthT" + "2MonthT" + "3MonthT" + Over3MonthT) / ("0MonthT" + "1MonthT" + "2MonthT" + "3MonthT" + Over3MonthT)) * 100)
            {
            }
            column(V2MonthT____0MonthT___1MonthT___2MonthT___3MonthT__Over3MonthT___100; ("2MonthT" / ("0MonthT" + "1MonthT" + "2MonthT" + "3MonthT" + Over3MonthT)) * 100)
            {
            }
            column(V1MonthT____0MonthT___1MonthT___2MonthT___3MonthT__Over3MonthT___100; ("1MonthT" / ("0MonthT" + "1MonthT" + "2MonthT" + "3MonthT" + Over3MonthT)) * 100)
            {
            }
            column(Over3MonthT_GrandTotal__100; (Over3MonthT / GrandTotal) * 100)
            {
            }
            column(V3MonthT__GrandTotal__100; ("3MonthT" / GrandTotal) * 100)
            {
            }
            column(V0MonthT___1MonthT___2MonthT___3MonthT__Over3MonthT__GrandTotal; ("0MonthT" + "1MonthT" + "2MonthT" + "3MonthT" + Over3MonthT) / GrandTotal)
            {
            }
            column(V2MonthT__GrandTotal__100; ("2MonthT" / GrandTotal) * 100)
            {
            }
            column(V1MonthT__GrandTotal__100; ("1MonthT" / GrandTotal) * 100)
            {
            }
            column(V1MonthT___2MonthT___3MonthT__Over3MonthT__GrandTotal__100; (("1MonthT" + "2MonthT" + "3MonthT" + Over3MonthT) / GrandTotal) * 100)
            {
            }
            column(V0MonthT_; "0MonthT")
            {
            }
            column(V0MonthT__GrandTotal__100; ("0MonthT" / GrandTotal) * 100)
            {
            }
            column(V0MonthT____0MonthT___1MonthT___2MonthT___3MonthT__Over3MonthT___100; ("0MonthT" / ("0MonthT" + "1MonthT" + "2MonthT" + "3MonthT" + Over3MonthT)) * 100)
            {
            }
            column(V0MonthT__0_01; "0MonthT" * 0.01)
            {
            }
            column(V1MonthT__0_05; "1MonthT" * 0.05)
            {
            }
            column(V2MonthT__0_25; "2MonthT" * 0.25)
            {
            }
            column(V3MonthT__0_5; "3MonthT" * 0.5)
            {
            }
            column(Over3MonthT_Control1102760068; Over3MonthT)
            {
            }
            column(V0MonthT__0_01____1MonthT__0_05____2MonthT__0_25____3MonthT__0_5__Over3MonthT; ("0MonthT" * 0.01) + ("1MonthT" * 0.05) + ("2MonthT" * 0.25) + ("3MonthT" * 0.5) + Over3MonthT)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loans_Aging_Analysis__SASRA_Caption; Loans_Aging_Analysis__SASRA_CaptionLbl)
            {
            }
            column(Oustanding_BalanceCaption; Oustanding_BalanceCaptionLbl)
            {
            }
            column(Deliquency____Caption; Deliquency____CaptionLbl)
            {
            }
            column(Total_DeliquentCaption; Total_DeliquentCaptionLbl)
            {
            }
            column(V1___30_Days_Caption; V1___30_Days_CaptionLbl)
            {
            }
            column(Over_360_DaysCaption; Over_360_DaysCaptionLbl)
            {
            }
            column(V181___360_Days_Caption; V181___360_Days_CaptionLbl)
            {
            }
            column(V31___180_Days_Caption; V31___180_Days_CaptionLbl)
            {
            }
            column(As_at_Caption; As_at_CaptionLbl)
            {
            }
            column(V0_Days_Caption; V0_Days_CaptionLbl)
            {
            }
            column(PerformingCaption; PerformingCaptionLbl)
            {
            }
            column(WatchCaption; WatchCaptionLbl)
            {
            }
            column(SubstandardCaption; SubstandardCaptionLbl)
            {
            }
            column(DoubtfulCaption; DoubtfulCaptionLbl)
            {
            }
            column(LossCaption; LossCaptionLbl)
            {
            }
            column(Total_Aged__Amount_Caption; Total_Aged__Amount_CaptionLbl)
            {
            }
            column(Total_Aged____Caption; Total_Aged____CaptionLbl)
            {
            }
            column(Total_Aged__Total_Loans____Caption; Total_Aged__Total_Loans____CaptionLbl)
            {
            }
            column(Prudential_Standard____Caption; Prudential_Standard____CaptionLbl)
            {
            }
            column(Society_Target____Caption; Society_Target____CaptionLbl)
            {
            }
            column(V5_00Caption; V5_00CaptionLbl)
            {
            }
            column(V1_50Caption; V1_50CaptionLbl)
            {
            }
            column(Prepared_By________________________________________________________________________________________Caption; Prepared_By________________________________________________________________________________________CaptionLbl)
            {
            }
            column(Certified_By________________________________________________________________________________________Caption; Certified_By________________________________________________________________________________________CaptionLbl)
            {
            }
            column(Checked_By________________________________________________________________________________________Caption; Checked_By________________________________________________________________________________________CaptionLbl)
            {
            }
            column(Loan_Loss_ProvisionCaption; Loan_Loss_ProvisionCaptionLbl)
            {
            }
            column(Loan_Product_Types_Code; Code)
            {
            }
            dataitem("Loans Register"; "Loans Register")
            {
                DataItemLink = "Loan Product Type" = field(Code);
                DataItemTableView = sorting("Loan Product Type") where("Outstanding Balance" = filter(> 0), Posted = const(true));
                RequestFilterFields = "Date filter", "Issued Date";
                column(ReportForNavId_4645; 4645)
                {
                }
                column(Loans_Loans__Outstanding_Balance_; "Loans Register"."Outstanding Balance")
                {
                }
                column(V2Month_; "2Month")
                {
                }
                column(V3Month_; "3Month")
                {
                }
                column(Over3Month; Over3Month)
                {
                }
                column(V1Month_; "1Month")
                {
                }
                column(V1Month___2Month___3Month__Over3Month; "1Month" + "2Month" + "3Month" + Over3Month)
                {
                }
                column(V0Month_; "0Month")
                {
                }
                column(Loans_Loans__Outstanding_Balance__Control1000000016; "Loans Register"."Outstanding Balance")
                {
                }
                column(Over3Month_Control1102760000; Over3Month)
                {
                }
                column(V3Month__Control1102760001; "3Month")
                {
                }
                column(V2Month__Control1102760002; "2Month")
                {
                }
                column(V1Month__Control1102760003; "1Month")
                {
                }
                column(Loan_Product_Types___Product_Description_; "Loan Products Setup"."Product Description")
                {
                }
                column(DeliquecyP; DeliquecyP)
                {
                }
                column(V1Month___2Month___3Month__Over3Month_Control1102760015; "1Month" + "2Month" + "3Month" + Over3Month)
                {
                }
                column(V0Month__Control1102760047; "0Month")
                {
                }
                column(Loans_Loan__No_; "Loan  No.")
                {
                }
                column(Loans_Loan_Product_Type; "Loan Product Type")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    NoLoans := NoLoans + 1;

                    if AsAt = 0D then
                        AsAt := Today;

                    Evaluate(DFormula, '1Q');

                    Current := 0;
                    "0Month" := 0;
                    "1Month" := 0;
                    "2Month" := 0;
                    "3Month" := 0;
                    Over3Month := 0;

                    "Loans Register".CalcFields("Loans Register"."Last Pay Date", "Loans Register"."Outstanding Balance");
                    if "Loans Register"."Instalment Period" = DFormula then
                        LastDueDate := CalcDate('1Q', "Loans Register"."Last Pay Date")
                    else
                        LastDueDate := "Loans Register"."Last Pay Date";

                    if LastDueDate = 0D then
                        if "Loans Register"."Issued Date" <> 0D then
                            if LoanProduct.Get("Loans Register"."Loan Product Type") then
                                if LoanProduct."Check Off Recovery" = false then begin
                                    FirstMonthDate := Dmy2date(1, Date2dmy("Loans Register"."Issued Date", 2), Date2dmy("Loans Register"."Issued Date", 3));
                                    EndMonthDate := CalcDate('-1D', CalcDate('1M', FirstMonthDate));
                                    //LastDueDate:=CALCDATE('-2D',FirstMonthDate);//Loans."Issued Date"
                                    if Date2dmy("Loans Register"."Issued Date", 1) < 20 then
                                        LastDueDate := CalcDate('-2D', FirstMonthDate)
                                    else
                                        LastDueDate := EndMonthDate;

                                end else begin
                                    FirstMonthDate := Dmy2date(1, Date2dmy("Loans Register"."Issued Date", 2), Date2dmy("Loans Register"."Issued Date", 3));
                                    EndMonthDate := CalcDate('-1D', CalcDate('1M', FirstMonthDate));
                                    LastDueDate := EndMonthDate;//Loans."Issued Date";//CALCDATE('1M',Loans."Issued Date");
                                end;

                    if LastDueDate > CalcDate('-1M', AsAt) then begin
                        "0Month" := "Loans Register"."Outstanding Balance";
                        "0MonthT" := "0MonthT" + "Loans Register"."Outstanding Balance";
                    end else
                        if LastDueDate > CalcDate('-2M', AsAt) then begin
                            "1Month" := "Loans Register"."Outstanding Balance";
                            "1MonthT" := "1MonthT" + "Loans Register"."Outstanding Balance";
                            "1MonthC" := "1MonthC" + 1;
                        end else
                            if LastDueDate > CalcDate('-7M', AsAt) then begin
                                "2Month" := "Loans Register"."Outstanding Balance";
                                "2MonthT" := "2MonthT" + "Loans Register"."Outstanding Balance";
                                "2MonthC" := "2MonthC" + 1;
                            end else
                                if LastDueDate > CalcDate('-13M', AsAt) then begin
                                    "3Month" := "Loans Register"."Outstanding Balance";
                                    "3MonthT" := "3MonthT" + "Loans Register"."Outstanding Balance";
                                    "3MonthC" := "3MonthC" + 1;
                                end else begin
                                    Over3Month := "Loans Register"."Outstanding Balance";
                                    Over3MonthT := Over3MonthT + "Loans Register"."Outstanding Balance";
                                    Over3MonthC := Over3MonthC + 1;
                                end;

                    GrandTotal := GrandTotal + "Loans Register"."Outstanding Balance";

                    /*
                    IF ("0Month" = 0) AND ("1Month" = 0) AND ("2Month" = 0) AND ("3Month" = 0) AND (Over3Month = 0) THEN
                    CurrReport.SKIP;
                    */
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CreateTotals("0Month", "1Month", "2Month", "3Month", Over3Month);
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(AsAt; AsAt)
                {
                    ApplicationArea = Basic;
                    Caption = 'AsAt :';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        AsAt: Date;
        LastDueDate: Date;
        DFormula: DateFormula;
        "1MonthC": Integer;
        "2MonthC": Integer;
        "3MonthC": Integer;
        Over3MonthC: Integer;
        NoLoans: Integer;
        PhoneNo: Text[30];
        Cust: Record Customer;
        "StaffNo.": Text[30];
        Deposits: Decimal;
        GrandTotal: Decimal;
        "0Month": Decimal;
        "0MonthT": Decimal;
        "1MonthT": Decimal;
        "2MonthT": Decimal;
        "3MonthT": Decimal;
        Over3MonthT: Decimal;
        DeliquecyP: Decimal;
        "0MonthD": Decimal;
        "1MonthD": Decimal;
        "2MonthD": Decimal;
        "3MonthD": Decimal;
        Over3MonthD: Decimal;
        "0MonthDL": Decimal;
        "1MonthDL": Decimal;
        "2MonthDL": Decimal;
        "3MonthDL": Decimal;
        Over3MonthDL: Decimal;
        DeliquecyPT: Decimal;
        Current: Decimal;
        CurrentT: Decimal;
        LoanProduct: Record "Loan Products Setup";
        FirstMonthDate: Date;
        EndMonthDate: Date;
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loans_Aging_Analysis__SASRA_CaptionLbl: label 'Loans Aging Analysis (SASRA)';
        Oustanding_BalanceCaptionLbl: label 'Oustanding Balance';
        Deliquency____CaptionLbl: label 'Deliquency (%)';
        Total_DeliquentCaptionLbl: label 'Total Deliquent';
        V1___30_Days_CaptionLbl: label '(1 - 30 Days)';
        Over_360_DaysCaptionLbl: label 'Over 360 Days';
        V181___360_Days_CaptionLbl: label '(181 - 360 Days)';
        V31___180_Days_CaptionLbl: label '(31 - 180 Days)';
        As_at_CaptionLbl: label 'As at:';
        V0_Days_CaptionLbl: label '(0 Days)';
        PerformingCaptionLbl: label 'Performing';
        WatchCaptionLbl: label 'Watch';
        SubstandardCaptionLbl: label 'Substandard';
        DoubtfulCaptionLbl: label 'Doubtful';
        LossCaptionLbl: label 'Loss';
        Total_Aged__Amount_CaptionLbl: label 'Total Aged (Amount)';
        Total_Aged____CaptionLbl: label 'Total Aged (%)';
        Total_Aged__Total_Loans____CaptionLbl: label 'Total Aged /Total Loans (%)';
        Prudential_Standard____CaptionLbl: label 'Prudential Standard (%)';
        Society_Target____CaptionLbl: label 'Society Target (%)';
        V5_00CaptionLbl: label '5.00';
        V1_50CaptionLbl: label '1.50';
        Prepared_By________________________________________________________________________________________CaptionLbl: label 'Prepared By: ......................................................................................';
        Certified_By________________________________________________________________________________________CaptionLbl: label 'Certified By: ......................................................................................';
        Checked_By________________________________________________________________________________________CaptionLbl: label 'Checked By: ......................................................................................';
        Loan_Loss_ProvisionCaptionLbl: label 'Loan Loss Provision';
}
