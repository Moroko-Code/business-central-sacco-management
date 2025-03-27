page 51516135 "CRM Case Types"
{
    ApplicationArea = All;
    Caption = 'CRM Case Types';
    PageType = List;
    SourceTable = "CRM Case Types";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
}
