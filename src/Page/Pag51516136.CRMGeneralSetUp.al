page 51516136 "CRM General SetUp"
{
    ApplicationArea = All;
    Caption = 'CRM General SetUp';
    PageType = List;
    SourceTable = "Crm General Setup.";
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cases nos"; Rec."Cases nos")
                {
                }
                field("Crm logs Nos"; Rec."Crm logs Nos")
                {
                }
                field("General Enquiries Nos"; Rec."General Enquiries Nos")
                {
                }
                field("Lead Nos"; Rec."Lead Nos")
                {
                }
            }
        }
    }
}
