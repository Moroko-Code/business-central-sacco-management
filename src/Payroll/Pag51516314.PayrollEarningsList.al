page 51516314 "Payroll Earnings List."
{
    // version Payroll ManagementV1.0(Surestep Systems)
    ApplicationArea = Basic, Suite;
    Caption = 'Payroll Earnings List';
    UsageCategory = Lists;
    CardPageID = "Payroll Earnings Card.";
    PageType = List;
    SourceTable = "Payroll Transaction Code.";
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
                field(Formulae; Formulae)
                {
                    ApplicationArea = All;
                }
                field("G/L Account Name"; "G/L Account Name")
                {
                    ApplicationArea = All;
                }
                field("G/L Account"; "G/L Account")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Transaction Type" := "Transaction Type"::Income;
    end;
}
