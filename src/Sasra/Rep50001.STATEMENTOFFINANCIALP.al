#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50001 "STATEMENT OF FINANCIAL P"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/STATEMENT OF FINANCIAL P.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
#pragma warning disable AL0275
        dataitem("Company Information"; "Company Information")
#pragma warning restore AL0275
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(FinancialYear; FinancialYear)
            {
            }
            column(Date; Date)
            {
            }
            column(Asat; Asat)
            {
            }
            column(Name; "Company Information".Name)
            {
            }
            column(Cashinhand; Cashinhand)
            {
            }
            column(Cashatbank; Cashatbank)
            {
            }
            column(CashCashEquivalent; CashCashEquivalent)
            {
            }
            column(PrepaymentsSundryReceivables; PrepaymentsSundryReceivables)
            {
            }
            column(FinancialInvestments; FinancialInvestments)
            {
            }
            column(GovernmentSecurities; GovernmentSecurities)
            {
            }
            column(Placement; Placement)
            {
            }
            column(CommercialPapers; CommercialPapers)
            {
            }
            column(CollectiveInvestment; CollectiveInvestment)
            {
            }
            column(Derivatives; Derivatives)
            {
            }
            column(EquityInvestments; EquityInvestments)
            {
            }
            column(Investmentincompanies; Investmentincompanies)
            {
            }
            column(GrossLoanPortfolio; GrossLoanPortfolio)
            {
            }
            column(PropertyEquipment; PropertyEquipment)
            {
            }
            column(AllowanceforLoanLoss; AllowanceforLoanLoss)
            {
            }
            column(Nonwithdrawabledeposits; Nonwithdrawabledeposits)
            {
            }
            column(TaxPayable; TaxPayable)
            {
            }
            column(DeferredTaxLiability; DeferredTaxLiability)
            {
            }
            column(RetirementBenefitsLiability; RetirementBenefitsLiability)
            {
            }
            column(OtherLiabilities; OtherLiabilities)
            {
            }
            column(ExternalBorrowings; ExternalBorrowings)
            {
            }
            column(TotalLiabilities; TotalLiabilities)
            {
            }
            column(ShareCapital; ShareCapital)
            {
            }
            column(StatutoryReserve; StatutoryReserve)
            {
            }
            column(OtherReserves; OtherReserves)
            {
            }
            column(RevaluationReserves; RevaluationReserves)
            {
            }
            column(ProposedDividends; ProposedDividends)
            {
            }
            column(AdjustmenttoEquity; AdjustmenttoEquity)
            {
            }
            column(PrioryarRetainedEarnings; PrioryarRetainedEarnings)
            {
            }
            column(CurrentYearSurplus; CurrentYearSurplus)
            {
            }
            column(TaxRecoverable; TaxRecoverable)
            {
            }
            column(DeferredTaxAssets; DeferredTaxAssets)
            {
            }
            column(RetirementBenefitAssets; RetirementBenefitAssets)
            {
            }
            column(OtherAssets; OtherAssets)
            {
            }
            column(IntangibleAssets; IntangibleAssets)
            {
            }
            column(PrepaidLeaseentals; PrepaidLeaseentals)
            {
            }
            column(InvestmentProperties; InvestmentProperties)
            {
            }
            column(DividendPayable; DividendPayable)
            {
            }
            column(NetLoanPortfolio; NetLoanPortfolio)
            {
            }
            column(AccountsReceivables; AccountsReceivables)
            {
            }
            column(PropertyEquipmentOtheassets; PropertyEquipmentOtheassets)
            {
            }
            column(AccountsPayableOtherLiabilities; AccountsPayableOtherLiabilities)
            {
            }
            column(CapitalGrants; CapitalGrants)
            {
            }
            column(EQUITY; EQUITY)
            {
            }
            column(RetainedEarnings; RetainedEarnings)
            {
            }
            column(OtherEquityAccounts; OtherEquityAccounts)
            {
            }
            column(TotalEquity; TotalEquity)
            {
            }
            column(TotalLiabilitiesandEquity; TotalLiabilitiesandEquity)
            {
            }
            column(TotalLiabilitiesNew; TotalLiabilitiesNew)
            {
            }
            column(TotalAssets; TotalAssets)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Cashinhand := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.StatementOfFP, '%1', GLAccount.Statementoffp::Cashinhand);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange("G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter("Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Cashinhand += 1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                Cashatbank := 0;

                GLAccount.Reset;
                GLAccount.SetFilter(StatementOfFP, '%1', GLAccount.Statementoffp::Cashatbank);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange("G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter("Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Cashatbank += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //gross loan portfolio
                GrossLoanPortfolio := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(StatementOfFP, '%1', GLAccount.Statementoffp::GrossLoanPortfolio);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange("G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter("Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            GrossLoanPortfolio += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //property and equipments

                GLAccount.Reset;
                GLAccount.SetFilter(StatementOfFP, '%1', GLAccount.Statementoffp::PropertyEquipment);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange("G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter("Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            PropertyEquipment += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //allowance for loan loss
                GLAccount.Reset;
                GLAccount.SetFilter(StatementOfFP, '%1', GLAccount.Statementoffp::AllowanceforLoanLoss);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange("G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter("Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            AllowanceforLoanLoss += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //prepayments and sandry receivables
                GLAccount.Reset;
                GLAccount.SetFilter(StatementOfFP, '%1', GLAccount.Statementoffp::PrepaymentsSundryReceivables);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            PrepaymentsSundryReceivables += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //non withdrawal
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.StatementOfFP2, '%1', GLAccount.Statementoffp2::Nonwithdrawabledeposits);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Nonwithdrawabledeposits += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //share capital
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.StatementOfFP2, '%1', GLAccount.Statementoffp2::ShareCapital);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ShareCapital += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //prior year
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.StatementOfFP2, '%1', GLAccount.Statementoffp2::PrioryarRetainedEarnings);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            PrioryarRetainedEarnings += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //statutory
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.StatementOfFP2, '%1', GLAccount.Statementoffp2::StatutoryReserve);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            StatutoryReserve += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //other reserves
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.StatementOfFP2, '%1', GLAccount.Statementoffp2::OtherReserves);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            OtherReserves += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //revaluation reservs
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.StatementOfFP2, '%1', GLAccount.Statementoffp2::RevaluationReserves);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            RevaluationReserves += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //tax payable
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.StatementOfFP2, '%1', GLAccount.Statementoffp2::TaxPayable);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TaxPayable += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //other liabilities
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.StatementOfFP2, '%1', GLAccount.Statementoffp2::OtherLiabilities);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            OtherLiabilities += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //investment in company shares
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.StatementOfFP, '%1', GLAccount.Statementoffp::Investmentincompanies);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Investmentincompanies += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //other assets
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.StatementOfFP, '%1', GLAccount.Statementoffp::"Other Assets");
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            OtherAssets += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //intangible assets
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.StatementOfFP, '%1', GLAccount.Statementoffp::IntangibleAssets);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            IntangibleAssets += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //current year surplus
                CurrentYearSurplus := 0;
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '20800');
                GLAccount.SetFilter(GLAccount."Date Filter", '<=%1', Asat);
                if GLAccount.FindSet then begin
                    GLAccount.CalcFields(GLAccount."Net Change");
                    CurrentYearSurplus := CurrentYearSurplus + GLAccount."Net Change";
                end;
                //MESSAGE(FORMAT(CurrentYearSurplus));

                CashCashEquivalent := Cashatbank + Cashinhand;
                FinancialInvestments := GovernmentSecurities + Placement + CollectiveInvestment + Derivatives + EquityInvestments + Investmentincompanies + CommercialPapers;
                NetLoanPortfolio := GrossLoanPortfolio + AllowanceforLoanLoss;
                AccountsReceivables := TaxRecoverable + DeferredTaxAssets + RetirementBenefitAssets;
                PropertyEquipmentOtheassets := InvestmentProperties + PropertyEquipment + PrepaidLeaseentals + OtherAssets + IntangibleAssets;
                TotalAssets := CashCashEquivalent + FinancialInvestments + NetLoanPortfolio + AccountsReceivables + PropertyEquipmentOtheassets + PrepaymentsSundryReceivables;

                AccountsPayableOtherLiabilities := TaxPayable + DividendPayable + DeferredTaxLiability + ExternalBorrowings + RetirementBenefitsLiability + OtherLiabilities;
                EQUITY := ShareCapital + CapitalGrants;
                RetainedEarnings := PrioryarRetainedEarnings - CurrentYearSurplus;
                OtherEquityAccounts := StatutoryReserve + OtherReserves + RevaluationReserves + AdjustmenttoEquity + ProposedDividends;
                TotalEquity := EQUITY + RetainedEarnings + OtherEquityAccounts;
                TotalLiabilitiesNew := Nonwithdrawabledeposits + AccountsPayableOtherLiabilities;
                TotalLiabilitiesandEquity := TotalEquity + TotalLiabilitiesNew;
            end;

            trigger OnPreDataItem()
            begin
                Date := CalcDate('-CY', Asat);
                DateFilter := Format(Date) + '..' + Format(Asat);
                DateFilter11 := Format(Date) + '..' + Format(Asat);
                FinancialYear := Date2dmy(Asat, 3);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(Asat; Asat)
                {
                    ApplicationArea = Basic;
                    Caption = 'Asat';
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
#pragma warning disable AL0275
        CompanyInformation: Record "Company Information";
#pragma warning restore AL0275
        Cashinhand: Decimal;
        FinancialYear: Integer;
        StartDate: Date;
        Cashatbank: Decimal;
        CashCashEquivalent: Decimal;
#pragma warning disable AL0275
        GLEntry: Record "G/L Entry";
#pragma warning restore AL0275
#pragma warning disable AL0275
        GLAccount: Record "G/L Account";
#pragma warning restore AL0275
        DateFilter: Text;
        Date: Date;
        DateFilter11: Text;
        Asat: Date;
        PrepaymentsSundryReceivables: Decimal;
        FinancialInvestments: Decimal;
        GovernmentSecurities: Decimal;
        Placement: Decimal;
        CommercialPapers: Decimal;
        CollectiveInvestment: Decimal;
        Derivatives: Decimal;
        EquityInvestments: Decimal;
        Investmentincompanies: Decimal;
        GrossLoanPortfolio: Decimal;
        PropertyEquipment: Decimal;
        AllowanceforLoanLoss: Decimal;
        Nonwithdrawabledeposits: Decimal;
        TaxPayable: Decimal;
        RetirementBenefitsLiability: Decimal;
        OtherLiabilities: Decimal;
        DeferredTaxLiability: Decimal;
        ExternalBorrowings: Decimal;
        TotalLiabilities: Decimal;
        ShareCapital: Decimal;
        StatutoryReserve: Decimal;
        OtherReserves: Decimal;
        RevaluationReserves: Decimal;
        ProposedDividends: Decimal;
        AdjustmenttoEquity: Decimal;
        PrioryarRetainedEarnings: Decimal;
        CurrentYearSurplus: Decimal;
        TaxRecoverable: Decimal;
        DeferredTaxAssets: Decimal;
        RetirementBenefitAssets: Decimal;
        OtherAssets: Decimal;
        IntangibleAssets: Decimal;
        PrepaidLeaseentals: Decimal;
        InvestmentProperties: Decimal;
        DividendPayable: Decimal;
        NetLoanPortfolio: Decimal;
        AccountsReceivables: Decimal;
        PropertyEquipmentOtheassets: Decimal;
        AccountsPayableOtherLiabilities: Decimal;
        CapitalGrants: Decimal;
        EQUITY: Decimal;
        RetainedEarnings: Decimal;
        OtherEquityAccounts: Decimal;
        TotalEquity: Decimal;
        TotalLiabilitiesandEquity: Decimal;
        TotalLiabilitiesNew: Decimal;
        TotalAssets: Decimal;
}
