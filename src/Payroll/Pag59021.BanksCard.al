page 59021 "BanksCard"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Banks;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = all;
                }
                // field("Branch Code"; "Branch Code")
                // {
                //     ApplicationArea = all;
                // }
                // field("Branch Name"; "Branch Code")
                // {
                //     ApplicationArea = All;
                // }
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