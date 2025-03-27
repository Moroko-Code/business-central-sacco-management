page 51516936 "Sub-Sector"
{
    ApplicationArea = All;
    Caption = 'Sub-Sector';
    PageType = List;
    SourceTable = "Sub-Sector";
    Editable = true;
    InsertAllowed = true;
    UsageCategory = Lists;

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
