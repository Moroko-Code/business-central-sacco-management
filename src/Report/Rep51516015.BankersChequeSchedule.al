report 51516015 "Bankers Cheque Schedule"
{
    ApplicationArea = All;
    Caption = 'Bankers Cheque Schedule';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Transactions; Transactions)
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
