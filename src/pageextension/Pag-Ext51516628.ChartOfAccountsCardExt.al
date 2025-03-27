pageextension 51516628 "ChartOfAccountsCardExt" extends "G/L Account Card"
{
    layout
    {
        addafter(Reporting)
        {
            group(Budgetary)
            {
                Visible = false;

                field("Budgeted Amount"; "Budgeted Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Budgeted Credit Amount"; "Budgeted Credit Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Budgeted Debit Amount"; "Budgeted Debit Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("SASRA REPORTS SETUP")
            {
                Caption = 'SASRA REPORTS SETUP';
                field(StatementOfFP; StatementOfFP)
                {
                    ApplicationArea = Basic;
                }
                field(StatementOfFP2; StatementOfFP2)
                {
                    ApplicationArea = Basic;
                }
                field("Form2F(Statement of C Income)"; "Form2F(Statement of C Income)")
                {
                    ApplicationArea = Basic;
                }
                field("Form2F1(Statement of C Income)"; "Form2F1(Statement of C Income)")
                {
                    ApplicationArea = Basic;
                }
                field("Capital adequecy"; "Capital adequecy")
                {
                    ApplicationArea = Basic;
                }
                field(Liquidity; Liquidity)
                {
                    ApplicationArea = Basic;
                }
                field("Form2E(investment)"; "Form2E(investment)")
                {
                    ApplicationArea = Basic;
                }
                field("Form 2H other disc"; "Form 2H other disc")
                {
                    ApplicationArea = Basic;
                }
                field("Form2E(investment)New"; "Form2E(investment)New")
                {
                    ApplicationArea = Basic;
                }
                field("Form2E(investment)Land"; "Form2E(investment)Land")
                {
                    ApplicationArea = Basic;
                }
                field(ChangesInEquity; ChangesInEquity)
                {
                    ApplicationArea = Basic;
                }
            }
            group("Mkopo Setup")
            {
                field(Assets; Assets)
                {
                    ApplicationArea = all;
                }
                field(MkopoLiabilities; MkopoLiabilities)
                {
                    ApplicationArea = all;
                    Caption = 'Liabilities';
                }
                field(FinancedBy; FinancedBy)
                {
                    ApplicationArea = all;
                    Caption = 'Financed By';
                }
                field(Financials; Financials)
                {
                    ApplicationArea = all;
                }
                field(Incomes; Incomes)
                {
                    Caption = 'Incomes and Expenses';
                    ApplicationArea = all;
                }
                field(Others; Others)
                {
                    Caption = 'Other Mkopo Paramters';
                    ApplicationArea = all;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Accessed and read the G/L account page no-' + Format("No.") + ' Name-' + Format(Name));
    end;

    trigger OnClosePage()
    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Closed G/L account page no-' + Format("No.") + ' Name-' + Format(Name));
    end;

    var
        AuditLog: Codeunit "Audit Log Codeunit";
}