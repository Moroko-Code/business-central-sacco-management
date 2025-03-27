page 51516441 "Funds Transaction Types"
{
    ApplicationArea = All;
    Caption = 'Funds Transaction Types';
    PageType = List;
    SourceTable = "Funds Transaction Types";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No"; Rec."Account No")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field("Default Grouping"; Rec."Default Grouping")
                {
                }
            }
        }
    }
}
