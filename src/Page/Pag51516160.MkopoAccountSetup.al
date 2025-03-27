page 51516160 "Mkopo Account Setup"
{
    ApplicationArea = All;
    Caption = 'Mkopo Account Setup';
    PageType = Worksheet;
    SourceTable = "Mkopo Account Setup";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    Editable = false;
                }
            }
        }
    }
}
