page 51516096 "Account Types Savings List"
{
    ApplicationArea = All;
    Caption = 'Account Types Savings List';
    PageType = List;
    SourceTable = "Account Types-Saving Products";
    CardPageId = "Account Types Product Card";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Account No Prefix"; Rec."Account No Prefix")
                {
                    ToolTip = 'Specifies the value of the Account No Prefix field.';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ToolTip = 'Specifies the value of the Date Entered field.';
                }
                field("Default Account"; Rec."Default Account")
                {
                    ToolTip = 'Specifies the value of the Default Account field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Dormancy Period (M)"; Rec."Dormancy Period (M)")
                {
                    ToolTip = 'Specifies the value of the Dormancy Period (M) field.';
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ToolTip = 'Specifies the value of the Time Entered field.';
                }
            }
        }
    }
}
