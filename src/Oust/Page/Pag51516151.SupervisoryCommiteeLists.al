page 51516151 "Supervisory Commitee Lists"
{
    ApplicationArea = All;
    Caption = 'Supervisory comitee  List';
    PageType = ListPart;
    SourceTable = "Supervisory Commitee";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    TableRelation = customer."No.";
                    trigger OnValidate()
                    begin
                        if Cust.Get("No.") then
                            Name := cust.Name;
                    end;
                }
                field(Name; Rec.Name)
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(Active; Rec.Active)
                {
                }
                field(Designation; Designation) { }
            }
        }
    }
    var
        Cust: Record customer;
}
