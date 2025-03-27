page 51516118 "Member FeedBack Card"
{
    PageType = Card;
    LinksAllowed = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Member FeedBack";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Type of Feed Back"; "Type of Feed Back")
                {
                    ApplicationArea = all;
                }
                field("Customer FeedBack"; "Customer FeedBack")
                {
                    ApplicationArea = all;
                    Editable = true;
                    MultiLine = true;
                    RowSpan = 10;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                end;
            }
        }
    }
}