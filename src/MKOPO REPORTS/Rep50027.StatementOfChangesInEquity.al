report 50027 StatementOfChangesInEquity
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Statement of Changes in Equity';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Statementofchangesinequity.rdlc';

    dataset
    {
        dataitem("Sacco Information"; "Sacco Information")
        {
            column(Code; Code)
            {
            }
            column(ShareCapital; ShareCapital)
            {
            }
            column(LShareCapital; LShareCapital)
            { }
            column(RLTransfertoStatury; RLTransfertoStatury) { }
            column(RTransfertoStatury; RTransfertoStatury) { }
            column(contShareCapital; contShareCapital)
            { }
            column(contLShareCapital; contLShareCapital)
            { }
            column(PriorYearAdjustment; PriorYearAdjustment) { }
            column(LPriorYearAdjustment; LPriorYearAdjustment) { }
            column(TransfertoStatury; TransfertoStatury) { }
            column(LTransfertoStatury; LTransfertoStatury) { }
            column(StatutoryReserve; StatutoryReserve) { }
            column(LStatutoryReserve; LStatutoryReserve) { }
            column(RetainedEarnings; RetainedEarnings) { }
            column(LRetainedEarnings; LRetainedEarnings) { }
            column(ThisYear; ThisYear)
            {
            }
            column(EndofLastyear; EndofLastyear)
            {
            }
            column(PreviousYear; PreviousYear)
            {
            }
            column(CurrentYear; CurrentYear)
            {
            }
            column(StartofPreviousyear; StartofPreviousyear) { }
            column(StartofThisYear; StartofThisYear) { }
            column(Proposeddividends; Proposeddividends) { }
            column(LProposeddividends; LProposeddividends) { }
            column(Honoraria; Honoraria) { }
            column(LHonoraria; LHonoraria) { }
            column(Surplus; Surplus) { }
            column(LSurplus; LSurplus) { }
            trigger OnAfterGetRecord()
            var
                DateExpr: Text;
                DateFormula: Text;
                DateFormulaOne: text;

            begin
                DateFormula := '<-CY-1D>';
                DateExpr := '<-1y>';
                DateFormulaOne := '<-CY>';

                ThisYear := AsAt;
                StartofThisYear := CalcDate(DateFormulaOne, AsAt);
                StartofPreviousyear := CalcDate(DateExpr, StartofThisYear);
                CurrentYear := Date2DMY(AsAt, 3);
                EndofLastyear := CalcDate(DateFormula, AsAt);
                PreviousYear := CurrentYear - 1;

                //Sharecapital
                ShareCapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', StartofThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ShareCapital += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //contribution during the Year

                contShareCapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofThisYear, AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            contShareCapital += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //end of contributiosn during the year

                contLShareCapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofPreviousyear, EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            contLShareCapital += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //Endofsharecapital

                //contribution as at end of Last year
                LShareCapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', StartofPreviousyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LShareCapital += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //contribution as at end of last year

                //Prior Year Adjustments
                PriorYearAdjustment := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Others, '%1', GLAccount.Others::PriorYearAdjustments);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            PriorYearAdjustment += 1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                LPriorYearAdjustment := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Others, '%1', GLAccount.Others::PriorYearAdjustments);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LPriorYearAdjustment += 1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //End of prior Year Adjustments

                //Retained Earnings
                RetainedEarnings := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::RevenueReserves);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', StartofThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            RetainedEarnings += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                LRetainedEarnings := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::RevenueReserves);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', StartofPreviousyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LRetainedEarnings += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //End Of Retained Earnings
                //Statutory Reserves
                StatutoryReserve := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::StatutoryReserves);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', StartofThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            StatutoryReserve += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                LStatutoryReserve := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::StatutoryReserves);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', StartofPreviousyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LStatutoryReserve += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //End of Statutory Reserves

                //End Of Retained Earnings

                //Transfer to Statutory
                TransfertoStatury := (RetainedEarnings * 0.2);
                LTransfertoStatury := (LRetainedEarnings * 0.2);

                RTransfertoStatury := -1 * TransfertoStatury;
                RLTransfertoStatury := -LTransfertoStatury;

                //End of Transfer to Statutory

                //calculate surplus for the year

                //Suplus

                Surplus := 0;

                //Incomes
                Incomes := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Financials, '%1', GLAccount.Financials::Revenue);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Incomes += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //Expense
                Expenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Financials, '%1', GLAccount.Financials::Expenses);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Expenses += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                Surplus := Incomes - Expenses;

                //Suplus

                LSurplus := 0;

                //Incomes
                Incomes := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Financials, '%1', GLAccount.Financials::Revenue);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LIncomes += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //Expense
                LExpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Financials, '%1', GLAccount.Financials::Expenses);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LExpenses += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                LSurplus := LIncomes - LExpenses;
                //calculate surplus for the year
                //Proposed Dividends

                //contribution as at end of Last year
                BalSharecapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            BalSharecapital += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                LBalSharecapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LBalSharecapital += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                SaccoInfo.Get();
                Proposeddividends := 0;
                LProposeddividends := 0;
                Proposeddividends := -(BalSharecapital * (SaccoInfo."Dividends Interest" * 0.01));
                LProposeddividends := -(LBalSharecapital * (SaccoInfo."Previous Dividends Interest" * 0.01));

                //End of Proposed Dividends

                //Proposed Honoraria
                Honoraria := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::Honoria);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Honoraria += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                LHonoraria := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::Honoria);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LHonoraria += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                // End Of Proposed Honoraria
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(AsAt; AsAt)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        SaccoInfo: Record "Sacco Information";
        AsAt: Date;
        LSurplus: Decimal;
        LExpenses: Decimal;
        Expenses: Decimal;
        Surplus: Decimal;
        Incomes: Decimal;
        LIncomes: Decimal;
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
        TransfertoStatury: Decimal;
        LTransfertoStatury: Decimal;
        RTransfertoStatury: Decimal;
        RLTransfertoStatury: Decimal;
        BalSharecapital: Decimal;
        LBalSharecapital: Decimal;
        StatutoryReserve: Decimal;
        LStatutoryReserve: Decimal;
        RetainedEarnings: Decimal;
        LRetainedEarnings: Decimal;
        PreviousYear: Integer;
        CurrentYear: Integer;
        StartofPreviousyear: Date;
        EndofLastyear: date;
        ThisYear: Date;
        StartofThisYear: Date;
        ShareCapital: Decimal;
        LShareCapital: Decimal;
        contShareCapital: Decimal;
        contLShareCapital: Decimal;
        PriorYearAdjustment: Decimal;
        LPriorYearAdjustment: Decimal;
        Proposeddividends: Decimal;
        LProposeddividends: Decimal;
        Honoraria: Decimal;
        LHonoraria: Decimal;
}