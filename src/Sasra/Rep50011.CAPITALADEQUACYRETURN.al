#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50011 "CAPITAL ADEQUACY RETURN"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CAPITAL ADEQUACY RETURN.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
#pragma warning disable AL0275
        dataitem(Company; "Company Information")
#pragma warning restore AL0275
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(Name; Company.Name)
            {
            }
            column(FinancialYear; FinancialYear)
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(Date; Date)
            {
            }
            column(ShareCapital; ShareCapital)
            {
            }
            column(StatutoryReserve; StatutoryReserve)
            {
            }
            column(Otherreserves; Otherreserves)
            {
            }
            column(retainedEarnins; retainedEarnins)
            {
            }
            column(NetSurplusaftertax; NetSurplusaftertax)
            {
            }
            column(LoansandAdvances; LoansandAdvances)
            {
            }
            column(totalassetsPBSheet; totalassetsPBSheet)
            {
            }
            column(Cash; Cash)
            {
            }
            column(PropertyandEquipment; PropertyandEquipment)
            {
            }
            column(GovernmentSecurities; GovernmentSecurities)
            {
            }
            column(DepositsandBalancesatOtherInstitutions; DepositsandBalancesatOtherInstitutions)
            {
            }
            column(Otherassets; Otherassets)
            {
            }
            column(CapitalGrants; CapitalGrants)
            {
            }
            column(InvestmentsinSubsidiary; InvestmentsinSubsidiary)
            {
            }
            column(OFFBALANCESHEETASSETS; OFFBALANCESHEETASSETS)
            {
            }
            column(TOTALOnBalanceSheet; TOTALOnBalanceSheet)
            {
            }
            column(Kuscoshares; Kuscoshares)
            {
            }
            column(OtherDeductions; OtherDeductions)
            {
            }
            column(Sub_Total; Sub_Total)
            {
            }
            column(TotalDeductions; TotalDeductions)
            {
            }
            column(CORECAPITAL; CORECAPITAL)
            {
            }
            column(RetainedearningsandDisclosedreserves; RetainedearningsandDisclosedreserves)
            {
            }
            column(TotalAssets; TotalAssets)
            {
            }
            column(TotalDepositsLiabilities; TotalDepositsLiabilities)
            {
            }
            column(CorecapitaltoAssetsRatio; CorecapitaltoAssetsRatio)
            {
            }
            column(MinimumCoreCapitaltoAssetsRatioRequirement; MinimumCoreCapitaltoAssetsRatioRequirement)
            {
            }
            column(Excess1; Excess1)
            {
            }
            column(RetainedearningsanddisclosedreservestoCorecapital; RetainedearningsanddisclosedreservestoCorecapital)
            {
            }
            column(MinimumRetainedearningsanddisclosed; MinimumRetainedearningsanddisclosed)
            {
            }
            column(Excess2; Excess2)
            {
            }
            column(CorecapitatoDepositsRatio; CorecapitatoDepositsRatio)
            {
            }
            column(MinimumCoreCapitaltoDeposits; MinimumCoreCapitaltoDeposits)
            {
            }
            column(Excess; Excess)
            {
            }
            column(investment; investment)
            {
            }
            column(DifferenceNew; DifferenceNew)
            {
            }

            trigger OnAfterGetRecord()
            begin

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::ShareCapital);
                if GLAccount.FindSet then
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ShareCapitalValue := GLEntry.Amount * -1;
                        end;
                        ShareCapital := ShareCapital + ShareCapitalValue;
                    until GLAccount.Next = 0;

                // statutory reserve
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::StatutoryReserve);
                if GLAccount.FindSet then
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            StatutoryReserve += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;
                //retained earnings
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::RetainedEarnings);
                if GLAccount.FindSet then
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            retainedEarnins += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;

                //current year surplus
                NetSurplusaftertax := 0;
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '20800');
                GLAccount.SetFilter(GLAccount."Date Filter", '<=%1', AsAt);
                if GLAccount.FindSet then begin
                    GLAccount.CalcFields(GLAccount."Net Change");
                    NetSurplusaftertax := (NetSurplusaftertax + GLAccount."Net Change") * 0.5;
                end;

                //MESSAGE('net year supp%1',NetSurplusaftertax);
                // GLAccount.RESET;
                // GLAccount.SETRANGE(GLAccount."No.",'202450');
                // GLAccount.SETFILTER(GLAccount."Date Filter",Datefilter);
                // GLAccount.SETAUTOCALCFIELDS(Balance);
                // IF GLAccount.FINDSET THEN BEGIN
                //
                //  REPEAT
                //    NetSurplusaftertax+=(GLAccount.Balance*50/100)*-1;
                //    UNTIL GLAccount.NEXT = 0;
                //
                //  END;

                //Loans and Advances
                /* LoansRegister.RESET;
                 LoansRegister.SETFILTER(LoansRegister."Date filter",Datefilter);
                 LoansRegister.SETAUTOCALCFIELDS("Outstanding Balance");
                 IF LoansRegister.FINDSET THEN BEGIN
                   REPEAT
                     LoansandAdvances+=LoansRegister."Outstanding Balance";
                     UNTIL LoansRegister.NEXT = 0;
                END;*/

                //allowance for loan loss
                AllowanceforLoanLoss := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.StatementOfFP, '%1', GLAccount.Statementoffp::AllowanceforLoanLoss);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            AllowanceforLoanLoss += -GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::LoansandAdvances);
                if GLAccount.FindSet then
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LoansandAdvances += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                LoansandAdvances := LoansandAdvances - AllowanceforLoanLoss;
                //total assets as per the balance sheet
                totalassetsPBSheet := 0;
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '14300');
                GLAccount.SetFilter(GLAccount."Date Filter", '<=%1', AsAt);
                if GLAccount.FindSet then begin
                    GLAccount.CalcFields(GLAccount."Net Change");
                    totalassetsPBSheet := totalassetsPBSheet + GLAccount."Net Change";
                end;

                //Cash (Local + Foreign Currency)
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Cash);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Cash += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //INVESTMENT IN SUBSIDIARY
                InvestmentsinSubsidiary := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::InvestmentsinSubsidiary);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            InvestmentsinSubsidiary += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //MESSAGE('%1',InvestmentsinSubsidiary);

                //KUSCO SHARES
                Kuscoshares := 0;
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '12301');
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Kuscoshares += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //Other reserves
                Otherreserves := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Otherreserves);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Otherreserves += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;

                //gov securities
                GovernmentSecurities := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::GovernmentSecurities);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            GovernmentSecurities += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //balances at other institutions
                DepositsandBalancesatOtherInstitutions := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::DepositsandBalancesatOtherInstitutions);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            DepositsandBalancesatOtherInstitutions += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //other assets
                Otherassets := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Otherassets);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Otherassets += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //property and equipment
                PropertyandEquipment := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::"PropertyandEquipment ");
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            PropertyandEquipment += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //deposit liabilities
                TotalDepositsLiabilities := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::TotalDepositsLiabilities);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TotalDepositsLiabilities += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;

                //investment
                //TotalDepositsLiabilities:=0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Investments);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            investment += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                TOTALOnBalanceSheet := Cash + GovernmentSecurities + DepositsandBalancesatOtherInstitutions + LoansandAdvances +/*InvestmentsinSubsidiary+*/Otherassets + PropertyandEquipment + investment + Kuscoshares;
                Sub_Total := ShareCapital + CapitalGrants + retainedEarnins + NetSurplusaftertax + StatutoryReserve + Otherreserves;
                TotalDeductions := InvestmentsinSubsidiary + OtherDeductions;
                //MESSAGE('%1',InvestmentsinSubsidiary);
                CORECAPITAL := Sub_Total - InvestmentsinSubsidiary;
                RetainedearningsandDisclosedreserves := CapitalGrants + retainedEarnins + NetSurplusaftertax + StatutoryReserve + Otherreserves;//retainedEarnins;
                totalassetsPBSheet := totalassetsPBSheet - AllowanceforLoanLoss;
                TotalAssets := totalassetsPBSheet + OFFBALANCESHEETASSETS;
                CorecapitaltoAssetsRatio := CORECAPITAL / TotalAssets;
                MinimumCoreCapitaltoAssetsRatioRequirement := 0.08;
                Excess1 := CorecapitaltoAssetsRatio - MinimumCoreCapitaltoAssetsRatioRequirement;
                //RetainedearningsanddisclosedreservestoCorecapital :=(RetainedearningsandDisclosedreserves+StatutoryReserve+Otherreserves)/CORECAPITAL;
                RetainedearningsanddisclosedreservestoCorecapital := RetainedearningsandDisclosedreserves / CORECAPITAL;
                //MESSAGE('%1',RetainedearningsanddisclosedreservestoCorecapital);
                MinimumRetainedearningsanddisclosed := 0.5;
                Excess2 := RetainedearningsanddisclosedreservestoCorecapital - MinimumRetainedearningsanddisclosed;
                CorecapitatoDepositsRatio := CORECAPITAL / TotalDepositsLiabilities;
                MinimumCoreCapitaltoDeposits := 0.05;
                Excess := CorecapitatoDepositsRatio - MinimumCoreCapitaltoDeposits;
                DifferenceNew := TOTALOnBalanceSheet - totalassetsPBSheet;
            end;
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
                    Caption = 'As At';
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

    trigger OnPreReport()
    begin
        /*FinancialYear:=DATE2DMY(AsAt,3);
        StartDate:=CALCDATE('-CY',AsAt);
        Datefilter:='..'+FORMAT(AsAt);
        CurrentYearFilter:=FORMAT(StartDate)+'..'+FORMAT(AsAt);
        */
        Date := CalcDate('-CY', AsAt);
        Datefilter := Format(Date) + '..' + Format(AsAt);
        DateFilter11 := Format(Date) + '..' + Format(AsAt);
        FinancialYear := Date2dmy(AsAt, 3);
    end;

    var
        FinancialYear: Integer;
        AsAt: Date;
        Datefilter: Text;
        DateFilter11: Text;
        StartDate: Date;
        ShareCapital: Decimal;
        Date: Date;
#pragma warning disable AL0275
        GLEntry: Record "G/L Entry";
#pragma warning restore AL0275
#pragma warning disable AL0275
        GLAccount: Record "G/L Account";
#pragma warning restore AL0275
        ShareCapitalValue: Decimal;
        StatutoryReserve: Decimal;
        investment: Decimal;
        Otherreserves: Decimal;
        retainedEarnins: Decimal;
        NetSurplusaftertax: Decimal;
        CurrentYearFilter: Text;
        LoansandAdvances: Decimal;
        LoansRegister: Record "Loans Register";
        totalassetsPBSheet: Decimal;
        Cash: Decimal;
        PropertyandEquipment: Decimal;
        GovernmentSecurities: Decimal;
        DepositsandBalancesatOtherInstitutions: Decimal;
        Otherassets: Decimal;
        CapitalGrants: Decimal;
        InvestmentsinSubsidiary: Decimal;
        OFFBALANCESHEETASSETS: Decimal;
        TOTALOnBalanceSheet: Decimal;
        OtherDeductions: Decimal;
        Sub_Total: Decimal;
        TotalDeductions: Decimal;
        CORECAPITAL: Decimal;
        RetainedearningsandDisclosedreserves: Decimal;
        TotalAssets: Decimal;
        TotalDepositsLiabilities: Decimal;
        CorecapitaltoAssetsRatio: Decimal;
        MinimumCoreCapitaltoAssetsRatioRequirement: Decimal;
        Excess1: Decimal;
        RetainedearningsanddisclosedreservestoCorecapital: Decimal;
        MinimumRetainedearningsanddisclosed: Decimal;
        Excess2: Decimal;
        CorecapitatoDepositsRatio: Decimal;
        MinimumCoreCapitaltoDeposits: Decimal;
        Excess: Decimal;
        DifferenceNew: Decimal;
        Kuscoshares: Decimal;
        AllowanceforLoanLoss: Decimal;
}
