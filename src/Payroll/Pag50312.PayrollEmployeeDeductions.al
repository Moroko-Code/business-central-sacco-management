Page 50312 "Payroll Employee Deductions."
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Payroll Employee Transactions.";
    SourceTableView = where("Transaction Type" = const(Deduction));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; "Transaction Code")
                {
                    ApplicationArea = Basic;
                    TableRelation = "Payroll Transaction Code."."Transaction Code" where("Transaction Type" = const(Deduction));
                }
                field("Transaction Name"; "Transaction Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Number"; "Loan Number")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Original Deduction Amount"; "Original Deduction Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Interest Charged"; "Interest Charged")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount(LCY)"; "Amount(LCY)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Amtzd Loan Repay Amt"; "Amtzd Loan Repay Amt")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Balance(LCY)"; "Balance(LCY)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Period Month"; "Period Month")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Period Year"; "Period Year")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Payroll Period"; "Payroll Period")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Original Amount"; "Original Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Outstanding Interest"; "Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Sacco Membership No."; "Sacco Membership No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then
            VarOpenPeriod := ObjPayrollCalender."Date Opened";

        SetFilter("Payroll Period", '%1', VarOpenPeriod);
    end;

    var
        ObjPayrollCalender: Record "Payroll Calender.";
        VarOpenPeriod: Date;
}
