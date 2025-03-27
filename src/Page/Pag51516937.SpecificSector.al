page 51516937 "Specific Sector"
{
    ApplicationArea = All;
    Editable = true;
    InsertAllowed = true;
    Caption = 'Specific Sector';
    PageType = List;
    SourceTable = "Specific-Sector";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}
