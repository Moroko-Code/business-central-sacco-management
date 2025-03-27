report 51516039 "Generate Monthly Interest"
{
    ApplicationArea = All;
    Caption = 'Generate Monthly Interest';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(LoansRegister; "Loans Register")
        {
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
}
