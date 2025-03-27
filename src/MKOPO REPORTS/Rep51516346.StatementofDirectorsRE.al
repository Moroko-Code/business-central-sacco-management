report 51516346 "Statement of Directors'RE"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Word;
    WordLayout = './Layout/statementofDirectors.docx';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(Asat; Format(Asat))
            {
            }
            column(CurrentYear; CurrentYear)
            {
            }
            column(LastYearButOne; LastYearButOne) { }
            column(PreviousYear; PreviousYear)
            {
            }
            column(EndofLastyear; EndofLastyear)
            {
            }
            column(Now; Now) { }
            trigger OnAfterGetRecord()
            var
                DateExpr: Text;
                InputDate: Date;
                DateFormula: Text;

            begin
                DateFormula := '<-CY-1D>';
                DateExpr := '<-1y>';
                InputDate := Asat;

                EndofLastyear := CalcDate(DateFormula, Asat);
                CurrentYear := Date2DMY(EndofLastyear, 3);
                LastYearButOne := CalcDate(DateExpr, EndofLastyear);
                PreviousYear := CurrentYear - 1;
                Now := CurrentYear + 1;
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
                    field(Asat; Asat)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    var
        Asat: Date;
        LastYearButOne: Date;

        CurrentYear: Integer;
        PreviousYear: Integer;
        EndofLastyear: date;
        Now: Integer;
}