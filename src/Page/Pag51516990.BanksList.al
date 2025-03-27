page 51516990 "Banks List"
{
    ApplicationArea = All;
    Caption = 'Banks List';
    PageType = List;
    SourceTable = Banks;
    UsageCategory = Administration;
    CardPageId = Banks;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Bank Code"; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                // field(Branch; Rec.Branch)
                // {
                //     ToolTip = 'Specifies the value of the Branch field.';
                // }
            }
        }
    }
}
