page 57 "payroll Employee trans"
{
    ApplicationArea = All;
    Caption = 'payroll Employee trans';
    PageType = List;
    SourceTable = "Payroll Employee Transactions.";
    UsageCategory = Lists;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Loan Number"; Rec."Loan Number")
                {
                    ToolTip = 'Specifies the value of the Loan Number field.', Comment = '%';
                }
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.', Comment = '%';
                }
                field("No of Repayments"; Rec."No of Repayments")
                {
                    ToolTip = 'Specifies the value of the No of Repayments field.', Comment = '%';
                }
                field("No of Units"; Rec."No of Units")
                {
                    ToolTip = 'Specifies the value of the No of Units field.', Comment = '%';
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ToolTip = 'Specifies the value of the Original Amount field.', Comment = '%';
                }
                field("Original Deduction Amount"; Rec."Original Deduction Amount")
                {
                    ToolTip = 'Specifies the value of the Original Deduction Amount field.', Comment = '%';
                }
            }
        }
    }
}
