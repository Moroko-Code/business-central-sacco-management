page 51516934 MainSector
{
    ApplicationArea = All;
    Caption = 'MainSector';
    PageType = List;
    SourceTable = "Main Sector";
    Editable = true;
    InsertAllowed = true;
    UsageCategory = Administration;

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
