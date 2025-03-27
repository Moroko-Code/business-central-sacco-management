page 50316 "Payroll Deductions List."
{
    // version Payroll ManagementV1.0(Surestep Systems)
    ApplicationArea = Basic, Suite;
    Caption = 'Payroll Deductions List';
    UsageCategory = Lists;
    CardPageID = "Payroll Deductions Card.";
    PageType = List;
    SourceTable = "Payroll Transaction Code.";
    SourceTableView = WHERE("Transaction Type" = CONST(Deduction));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; "Transaction Code")
                {
                    ApplicationArea = All;
                }
                field("Transaction Name"; "Transaction Name")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = All;
                }
                field(Taxable; Taxable)
                {
                    ApplicationArea = All;
                }
                field("Is Formulae"; "Is Formulae")
                {
                    ApplicationArea = All;
                }
                field("Co-Op Parameters"; "Co-Op Parameters")
                {
                    ApplicationArea = All;
                }
                field(Formulae; Formulae)
                {
                    ApplicationArea = All;
                }
                field("G/L Account"; "G/L Account")
                {
                    ApplicationArea = All;
                }
                field("G/L Account Name"; "G/L Account Name")
                {
                    ApplicationArea = All;
                }
                field("Sacco Code"; "Sacco Code")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = All;
                }
                field("pay period"; "pay period")
                {
                    ApplicationArea = All;
                }
                field("Insurance Code"; "Insurance Code")
                {
                    ApplicationArea = All;
                }
                field("Bank code"; "Bank code")
                {
                    ApplicationArea = All;
                }
                field("Welfare code"; "Welfare code")
                {
                    ApplicationArea = All;
                }
                field("Is Loan Account"; "Is Loan Account")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Transaction Type" := "Transaction Type"::Deduction;
    end;
}
