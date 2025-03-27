report 51516027 "Credit Loans Register"
{
    ApplicationArea = All;
    Caption = 'Credit Loans Register';
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
