page 51516313 "Payroll Employee Earnings."
{
    // version Payroll ManagementV1.0(Surestep Systems)
    ApplicationArea = Basic, Suite;
    Caption = 'Payroll Employee Earnings.';
    UsageCategory = Lists;
    DeleteAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Payroll Employee Transactions.";
    SourceTableView = WHERE("Transaction Type" = CONST(Income));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; "Transaction Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                    TableRelation = "Payroll Transaction Code."."Transaction Code" where("Transaction Type" = CONST(Income));
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Transaction Name"; "Transaction Name")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount(LCY)"; "Amount(LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = All;
                }
                field("Balance(LCY)"; "Balance(LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Period Month"; "Period Month")
                {
                    ApplicationArea = All;
                }
                field("Period Year"; "Period Year")
                {
                    ApplicationArea = All;
                }
                field("Payroll Period"; "Payroll Period")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        PayrollCalender.Reset;
        PayrollCalender.SetRange(Closed, false);
        if PayrollCalender.FindFirst then
            SetRange("Payroll Period", PayrollCalender."Date Opened");
    end;

    var
        PayrollCalender: Record "Payroll Calender.";
}
