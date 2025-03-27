page 50381 EmployerReceivables
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Customer;
    CardPageId = "Customer Card";
    SourceTableView = sorting("No.") order(ascending) where("Customer Type" = filter(Checkoff));
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Balance (LCY)"; "Balance (LCY)")
                {
                    Caption = 'Balance';
                    ApplicationArea = all;
                }
                field("Receivables Amount"; "Receivables Amount")
                {
                    ApplicationArea = all;
                }
                field("Credit Amount"; "Credit Amount")
                {
                    ApplicationArea = all;
                }
                field("Net Change"; "Net Change")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(Factboxes)
        {
        }

    }
}