report 51516220 "Budget Comparison"
{
    ApplicationArea = All;
    Caption = 'Budget Comparison';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/Budgetcomparison.rdlc';
    dataset
    {
        dataitem(GLAccount; "G/L Account")
        {
            DataItemTableView = sorting("No.") where(Blocked = filter(false));
            column(No_; "No.") { }
            column(Name; Name) { }
            column(CurrentYear; CurrentYear) { }
            column(PreviousYear; PreviousYear) { }
            column(CurrAmount; CurrAmount) { }
            column(PrevAmount; PrevAmount) { }
            trigger OnAfterGetRecord()
            var

                InputDate: Date;
                DateFormula: Text;
                DateFormula2: Text;
                DateExpr: Text;
                DatefilterOne: Text;
                DatefilterTwo: Text;
            begin
                DateFormula2 := '-CY';
                DateFormula := '<CY>';
                DateExpr := '<-1y>';

                CurrAmount := 0;
                PrevAmount := 0;
                InputDate := Asat;
                CurrentStartofYear := CalcDate(DateFormula2, Asat);
                CurrentEndofYear := CalcDate(DateFormula, Asat);
                CurrentYear := Date2DMY(CurrentEndofYear, 3);
                previousEndofYear := CalcDate(DateExpr, CurrentEndofYear);
                previousStartofYear := CalcDate(DateFormula2, previousEndofYear);
                PreviousYear := CurrentYear - 1;
                DatefilterOne := Format(CurrentStartofYear) + '..' + Format(CurrentEndofYear);
                DatefilterTwo := Format(previousStartofYear) + '..' + Format(previousEndofYear);

                GL.Reset();
                GL.SetRange(GL."No.", "No.");
                GL.SetFilter(GL."Date Filter", DatefilterOne);
                if FindSet() then begin

                    GL.CalcFields(GL."Net Change");
                    CurrAmount := GL."Net Change";
                end;
                GL.Reset();
                GL.SetRange(GL."No.", "No.");
                Gl.SetFilter(GL."Date Filter", DatefilterTwo);
                if Findset then begin

                    Gl.CalcFields(GL."Net Change");
                    PrevAmount := GL."Net Change";
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(Asat; Asat) { }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        Asat: Date;
        GL: Record "G/L Account";
        PreviousYear: Integer;
        CurrentEndofYear: date;
        CurrentStartofYear: date;
        previousEndofYear: Date;
        previousStartofYear: Date;
        CurrentYear: Integer;
        CurrAmount: Decimal;
        PrevAmount: Decimal;
}
