#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50025 "State of financial Position"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/StatementOfFinancialPosition.rdlc';
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
            column(LCashCashEquivalent; LCashCashEquivalent)
            {
            }
            column(PrepaymentsSundryReceivables; PrepaymentsSundryReceivables)
            {
            }
            column(FinancialInvestments; FinancialInvestments)
            {
            }
            column(LFinancialInvestments; LFinancialInvestments)
            {
            }
            column(InterestonMemberdeposits; InterestonMemberdeposits)
            {
            }
            column(LInterestonMemberDeposits; LInterestonMemberDeposits)
            {
            }
            column(Hononaria; Hononaria)
            {
            }
            column(LHononaria; LHononaria)
            {
            }
            column(CurrentYear; CurrentYear)
            {
            }
            column(PreviousYear; PreviousYear)
            {
            }
            column(EndofLastyear; EndofLastyear) { }
            column(CommercialPapers; CommercialPapers)
            {
            }
            column(CollectiveInvestment; CollectiveInvestment)
            {
            }
            column(LTotalAssets; LTotalAssets)
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
            column(LGrossLoanPortfolio; LGrossLoanPortfolio)
            {
            }
            column(PropertyEquipment; PropertyEquipment)
            {
            }
            column(LPropertyEquipment; LPropertyEquipment)
            {
            }
            column(Nonwithdrawabledeposits; Nonwithdrawabledeposits)
            {
            }
            column(LNonwithdrawabledeposits; LNonwithdrawabledeposits)
            {
            }
            column(TaxPayable; TaxPayable)
            {
            }
            column(LTaxPayable; LTaxPayable)
            {
            }
            column(TradeandOtherPayables; TradeandOtherPayables)
            {
            }
            column(LTradeandOtherPayables; LTradeandOtherPayables)
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
            column(LTotalLiabilities; LTotalLiabilities)
            {
            }
            column(ShareCapital; ShareCapital)
            {
            }
            column(LShareCapital; LShareCapital)
            { }
            column(StatutoryReserve; StatutoryReserve)
            {
            }
            column(LStatutoryReserve; LStatutoryReserve)
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
            column(ReceivableandPrepayments; ReceivableandPrepayments)
            {
            }
            column(LReceivableandPrepayments; LReceivableandPrepayments)
            {
            }
            column(LoanandAdvances; LoanandAdvances)
            {
            }
            column(LLoanandAdvances; LLoanandAdvances)
            {
            }
            column(RevenueReservers; (RevenueReservers))
            {
            }
            column(lRevenueReservers; (lRevenueReservers))
            {
            }
            column(FinancialAssets; FinancialAssets)
            {
            }
            column(LFinancialAssets; LFinancialAssets)
            {
            }
            column(IntangibleAssets; IntangibleAssets)
            {
            }
            column(LIntangibleAssets; LIntangibleAssets)
            {
            }
            column(InvestmentProperties; InvestmentProperties)
            {
            }
            column(DividendPayable; DividendPayable)
            {
            }
            column(LDividendPayable; LDividendPayable)
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
            column(LPropertyEquipmentOtheassets; LPropertyEquipmentOtheassets)
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
            column(LTotalEquity; LTotalEquity)
            {
            }
            column(TotalLiabilitiesandEquity; TotalLiabilitiesandEquity)
            {
            }
            column(LTotalLiabilitiesandEquity; LTotalLiabilitiesandEquity)
            {
            }
            column(TotalAssets; TotalAssets)
            {
            }
            column(Surplus; Surplus)
            {
            }
            column(LSurplus; LSurplus)
            {
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                InputDate: Date;
                DateFormula: Text;
                DateExpr: Text;
            begin
                CashCashEquivalent := 0;
                CashCashEquivalent := 0;
                DateFormula := '<-CY-1D>';
                DateExpr := '<-1y>';
                InputDate := Asat;
                LShareCapital := 0;
                ShareCapital := 0;
                EndofLastyear := InputDate;

                CurrentYear := Date2DMY(EndofLastyear, 3);
                LastYearButOne := CalcDate(DateFormula, EndofLastyear);
                PreviousYear := CurrentYear - 1;

                //Assets
                //Cash And cash Equivalents
                // Cashinhand := 0;
                // GLAccount.Reset;
                // GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::CashAndEquivalents);
                // if GLAccount.FindSet then begin
                //     repeat
                //         GLEntry.Reset;
                //         GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                //         GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                //         if GLEntry.FindSet then begin
                //             GLEntry.CalcSums(Amount);
                //             Cashinhand += 1 * GLEntry.Amount;
                //         end;
                //     until GLAccount.Next = 0;
                // end;
                // LCashinhand := 0;
                // GLAccount.Reset;
                // GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::CashAndEquivalents);
                // if GLAccount.FindSet then begin
                //     repeat
                //         GLEntry.Reset;
                //         GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                //         GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                //         if GLEntry.FindSet then begin
                //             GLEntry.CalcSums(Amount);
                //             LCashinhand += 1 * GLEntry.Amount;
                //         end;

                //     until GLAccount.Next = 0;
                // end;

                Cashatbank := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::CashAndEquivalents);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Cashatbank += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                LCashatbank := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::CashAndEquivalents);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LCashatbank += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //End of Cash and Cash Equivalents
                //Receivables And Prepayments
                ReceivableandPrepayments := 0;
                LReceivableandPrepayments := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::ReceivablesAndPrepayements);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ReceivableandPrepayments += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::ReceivablesAndPrepayements);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LReceivableandPrepayments += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //End of Receivables and Prepayments
                //LoanLoass
                ProvisionLoanLoss := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::LoanLoss);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ProvisionLoanLoss += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                LProvisionLoanLoss := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::LoanLoss);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LProvisionLoanLoss += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //End of Loans Loss
                //LoanandAdvances
                LoanandAdvances := 0;
                LLoanandAdvances := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::LoansAndAdvances);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LoanandAdvances += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::LoansAndAdvances);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LLoanandAdvances += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                LoanandAdvances := LoanandAdvances - ProvisionLoanLoss;
                LLoanandAdvances := LLoanandAdvances - LProvisionLoanLoss;

                //EndofLoanandAdavances
                //Financial Assets
                FinancialAssets := 0;
                LFinancialAssets := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::FinancialAssets);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            FinancialAssets += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                GLAccount.Reset;
                GLAccount.SetFilter(Assets, '%1', GLAccount.Assets::FinancialAssets);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LFinancialAssets += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //End Of Financial Assets

                //Property,Plant and equipment
                PropertyEquipment := 0;
                LPropertyEquipment := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(Assets, '%1', GLAccount.Assets::propertyplantandEquipment);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            PropertyEquipment += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                GLAccount.Reset;
                GLAccount.SetFilter(Assets, '%1', GLAccount.Assets::propertyplantandEquipment);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LPropertyEquipment += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //End of propert plant and Equipments
                //intangible assets
                IntangibleAssets := 0;
                LIntangibleAssets := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(Assets, '%1', GLAccount.Assets::Intangiableassets);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            IntangibleAssets += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                GLAccount.Reset;
                GLAccount.SetFilter(Assets, '%1', GLAccount.Assets::Intangiableassets);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LIntangibleAssets += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                TotalAssets := 0;
                LTotalAssets := 0;

                TotalAssets := Cashatbank + ReceivableandPrepayments + LoanandAdvances + FinancialAssets + PropertyEquipment + IntangibleAssets;
                LTotalAssets := LCashatbank + LReceivableandPrepayments + LLoanandAdvances + LFinancialAssets + LPropertyEquipment + LIntangibleAssets;
                //END OF ASSETS

                //LIABILITIES
                //Member Deposits
                GLAccount.Reset;
                GLAccount.SetFilter(MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::MemberDeposits);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Nonwithdrawabledeposits += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                GLAccount.Reset;
                GLAccount.SetFilter(MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::MemberDeposits);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LNonwithdrawabledeposits += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                // EmdMember deposits
                //Dividends
                InterestonMemberdeposits := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::dividendsandInterestPayable);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            InterestonMemberdeposits += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                LInterestonMemberdeposits := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::dividendsandInterestPayable);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LInterestonMemberdeposits += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //End of Dividends
                //TradeandOtherPayables
                TradeandOtherPayables := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::TradeandotherPayables);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TradeandOtherPayables += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                LTradeandOtherPayables := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::TradeandotherPayables);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LTradeandOtherPayables += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //EndofTradeAndotherPayables

                //Honoraria
                Hononaria := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::Honoria);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Hononaria += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                LHononaria := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::Honoria);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LHononaria += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //EndofHonaria
                //TaxPayable
                TaxPayable := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::Taxpayable);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TaxPayable += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                LTaxPayable := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::Taxpayable);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LTaxPayable += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //EndofTaxpayable
                //END LIABILITIES
                //Sharecapital

                //Financed BY
                //statutory
                StatutoryReserve := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(FinancedBy, '%1', GLAccount.FinancedBy::StatutoryReserves);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            StatutoryReserve += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                LStatutoryReserve := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(FinancedBy, '%1', GLAccount.FinancedBy::StatutoryReserves);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LStatutoryReserve += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //Statutory

                //RevenueReserves
                RevenueReservers := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(FinancedBy, '%1', GLAccount.FinancedBy::RevenueReserves);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            RevenueReservers += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                LRevenueReservers := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(FinancedBy, '%1', GLAccount.FinancedBy::RevenueReserves);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LRevenueReservers += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //LRevenueReserves
                //Sharecapital
                ShareCapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ShareCapital += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                LShareCapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LShareCapital += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //Endofsharecapital

                //End of Financed By
                TotalLiabilities := 0;
                LTotalLiabilities := 0;

                TotalLiabilities := TradeandOtherPayables + Nonwithdrawabledeposits + InterestonMemberdeposits + Hononaria + TaxPayable;
                LTotalLiabilities := LTradeandOtherPayables + LNonwithdrawabledeposits + LInterestonMemberdeposits + LHononaria + LTaxPayable;

                //Suplus
                LSurplus := 0;

                //Incomes
                Incomes := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(Financials, '%1', GLAccount.Financials::Revenue);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Incomes += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                // LIncomes := 0;
                // GLAccount.Reset;
                // GLAccount.SetFilter(GLAccount.Financials, '%1', GLAccount.Financials::Revenue);
                // if GLAccount.FindSet then begin
                //     repeat
                //         GLEntry.Reset;
                //         GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                //         GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                //         if GLEntry.FindSet then begin
                //             GLEntry.CalcSums(Amount);
                //             LIncomes += -1 * GLEntry.Amount;
                //         end;
                //     until GLAccount.Next = 0;
                // end;
                //Expense
                Expenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(Financials, '%1', GLAccount.Financials::Expenses);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Expenses += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                // LExpenses := 0;
                // GLAccount.Reset;
                // GLAccount.SetFilter(GLAccount.Financials, '%1', GLAccount.Financials::Expenses);
                // if GLAccount.FindSet then begin
                //     repeat
                //         GLEntry.Reset;
                //         GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                //         GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', LastYearButOne);
                //         if GLEntry.FindSet then begin
                //             GLEntry.CalcSums(Amount);
                //             LExpenses += -1 * GLEntry.Amount;
                //         end;
                //     until GLAccount.Next = 0;
                // end;
                Surplus := 0;
                Surplus := Incomes + Expenses;
                //LSurplus := LIncomes - LExpenses;

                //End Of Expense
                RevenueReservers := RevenueReservers + Surplus;

                TotalEquity := 0;
                LTotalEquity := 0;

                TotalEquity := StatutoryReserve + RevenueReservers + ShareCapital;
                LTotalEquity := LStatutoryReserve + LRevenueReservers + LShareCapital;

                //End of Incomes
                TotalLiabilitiesandEquity := 0;
                LTotalLiabilitiesandEquity := 0;

                TotalLiabilitiesandEquity := TotalEquity + TotalLiabilities;
                LTotalLiabilitiesandEquity := LTotalEquity + LTotalLiabilities;
                //End of Suplus

                //MESSAGE(FORMAT(CurrentYearSurplus));

                CashCashEquivalent := Cashatbank + Cashinhand;
                LCashCashEquivalent := LCashatbank + LCashinhand;
                FinancialInvestments := GovernmentSecurities + Placement + CollectiveInvestment + Derivatives + EquityInvestments + Investmentincompanies + CommercialPapers;
                LFinancialInvestments := GovernmentSecurities + Placement + CollectiveInvestment + Derivatives + EquityInvestments + Investmentincompanies + CommercialPapers;
                NetLoanPortfolio := GrossLoanPortfolio + AllowanceforLoanLoss;
                AccountsReceivables := TaxRecoverable + DeferredTaxAssets + RetirementBenefitAssets;
                PropertyEquipmentOtheassets := InvestmentProperties + PropertyEquipment + PrepaidLeaseentals + OtherAssets + IntangibleAssets;
                LPropertyEquipmentOtheassets := LInvestmentProperties + LPropertyEquipment + LPrepaidLeaseentals + LOtherAssets + LIntangibleAssets;

                AccountsPayableOtherLiabilities := TaxPayable + DividendPayable + DeferredTaxLiability + ExternalBorrowings + RetirementBenefitsLiability + OtherLiabilities;
                EQUITY := ShareCapital + CapitalGrants;
                RetainedEarnings := PrioryarRetainedEarnings - CurrentYearSurplus;
                OtherEquityAccounts := StatutoryReserve + OtherReserves + RevaluationReserves + AdjustmenttoEquity + ProposedDividends;

                TotalLiabilitiesandEquity := TotalEquity + TotalLiabilities;
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
        ProvisionLoanLoss: Decimal;
        LProvisionLoanLoss: Decimal;
        StatutoryReserves: Decimal;
        LStatutoryReserves: Decimal;
        RevenueReservers: Decimal;
        LRevenueReservers: Decimal;
        Surplus: Decimal;
        LSurplus: Decimal;
        Incomes: Decimal;
        Expenses: Decimal;
        LIncomes: Decimal;
        LExpenses: Decimal;
        LInvestmentProperties: Decimal;
        Hononaria: Decimal;
        LHononaria: Decimal;
        ShareCapitalValue: Decimal;
        LPropertyEquipment: Decimal;
        LPrepaidLeaseentals: Decimal;
        LIntangibleAssets: Decimal;
        LOtherAssets: Decimal;
        PreviousYear: Integer;
        LInterestonMemberDeposits: Decimal;
        InterestonMemberdeposits: Decimal;
        EndofLastyear: date;
        LastYearButOne: Date;
        CurrentYear: Integer;
        ReceivableandPrepayments: Decimal;
        LReceivableandPrepayments: Decimal;
        LoanandAdvances: Decimal;
        LLoanandAdvances: Decimal;
        FinancialAssets: Decimal;
        LFinancialAssets: Decimal;
        PropertyPlantandequipment: Decimal;
        LPropertyPlantandequipment: Decimal;
        CompanyInformation: Record "Company Information";
#pragma warning restore AL0275
        Cashinhand: Decimal;
        FinancialYear: Integer;
        StartDate: Date;
        Cashatbank: Decimal;
        LCashatbank: Decimal;
        LCashinhand: Decimal;
        CashCashEquivalent: Decimal;
        LCashCashEquivalent: Decimal;
#pragma warning disable AL0275
        GLEntry: Record "G/L Entry";
        LGrossLoanPortfolio: Decimal;
        GLAccount: Record "G/L Account";
#pragma warning restore AL0275
        DateFilter: Text;
        Date: Date;
        DateFilter11: Text;
        Asat: Date;
        PrepaymentsSundryReceivables: Decimal;
        FinancialInvestments: Decimal;
        LFinancialInvestments: Decimal;
        GovernmentSecurities: Decimal;
        Placement: Decimal;
        CommercialPapers: Decimal;
        CollectiveInvestment: Decimal;
        Derivatives: Decimal;
        EquityInvestments: Decimal;
        Investmentincompanies: Decimal;
        LInvestmentincompanies: Decimal;
        GrossLoanPortfolio: Decimal;
        PropertyEquipment: Decimal;
        AllowanceforLoanLoss: Decimal;
        Nonwithdrawabledeposits: Decimal;
        LNonwithdrawabledeposits: Decimal;
        TaxPayable: Decimal;
        LTaxPayable: Decimal;
        RetirementBenefitsLiability: Decimal;
        OtherLiabilities: Decimal;
        DeferredTaxLiability: Decimal;
        ExternalBorrowings: Decimal;
        LTotalLiabilities: Decimal;
        ShareCapital: Decimal;
        LShareCapital: Decimal;
        StatutoryReserve: Decimal;
        LStatutoryReserve: Decimal;
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
        LDividendPayable: Decimal;
        TradeandOtherPayables: Decimal;
        LTradeandOtherPayables: Decimal;
        NetLoanPortfolio: Decimal;
        AccountsReceivables: Decimal;
        PropertyEquipmentOtheassets: Decimal;
        LPropertyEquipmentOtheassets: Decimal;
        AccountsPayableOtherLiabilities: Decimal;
        CapitalGrants: Decimal;
        EQUITY: Decimal;
        RetainedEarnings: Decimal;
        OtherEquityAccounts: Decimal;
        TotalEquity: Decimal;
        LTotalEquity: Decimal;
        TotalLiabilitiesandEquity: Decimal;
        LTotalLiabilitiesandEquity: Decimal;
        TotalLiabilities: Decimal;
        TotalAssets: Decimal;
        LTotalAssets: Decimal;
}
