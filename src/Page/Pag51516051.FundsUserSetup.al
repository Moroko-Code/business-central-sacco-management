#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516051 "Funds User Setup"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Funds User Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(UserID; UserID)
                {
                    ApplicationArea = Basic;
                }
                field("Receipt Journal Template"; "Receipt Journal Template")
                {
                    ApplicationArea = Basic;
                }
                field("Receipt Journal Batch"; "Receipt Journal Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Journal Template"; "Payment Journal Template")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Journal Batch"; "Payment Journal Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Petty Cash Template"; "Petty Cash Template")
                {
                    ApplicationArea = Basic;
                }
                field("Petty Cash Batch"; "Petty Cash Batch")
                {
                    ApplicationArea = Basic;
                }
                field("FundsTransfer Template Name"; "FundsTransfer Template Name")
                {
                    ApplicationArea = Basic;
                }
                field("FundsTransfer Batch Name"; "FundsTransfer Batch Name")
                {
                    ApplicationArea = Basic;
                }
                field("Default Receipts Bank"; "Default Receipts Bank")
                {
                    ApplicationArea = Basic;
                }
                field("Default Payment Bank"; "Default Payment Bank")
                {
                    ApplicationArea = Basic;
                }
                field("Default Petty Cash Bank"; "Default Petty Cash Bank")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Cash Collection"; "Max. Cash Collection")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Cheque Collection"; "Max. Cheque Collection")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Deposit Slip Collection"; "Max. Deposit Slip Collection")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor ID"; "Supervisor ID")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Pay In Journal Template"; "Bank Pay In Journal Template")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Pay In Journal Batch"; "Bank Pay In Journal Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Imprest Template"; "Imprest Template")
                {
                    ApplicationArea = Basic;
                }
                field("Imprest  Batch"; "Imprest  Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Template"; "Claim Template")
                {
                    ApplicationArea = Basic;
                }
                field("Claim  Batch"; "Claim  Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Advance Template"; "Advance Template")
                {
                    ApplicationArea = Basic;
                }
                field("Advance  Batch"; "Advance  Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Advance Surr Template"; "Advance Surr Template")
                {
                    ApplicationArea = Basic;
                }
                field("Advance Surr Batch"; "Advance Surr Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Dim Change Journal Template"; "Dim Change Journal Template")
                {
                    ApplicationArea = Basic;
                }
                field("Dim Change Journal Batch"; "Dim Change Journal Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Journal Voucher Template"; "Journal Voucher Template")
                {
                    ApplicationArea = Basic;
                }
                field("Journal Voucher Batch"; "Journal Voucher Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Template"; "Payroll Template")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Batch"; "Payroll Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff Template"; "Checkoff Template")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff Batch"; "Checkoff Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Salaries Template"; "Salaries Template")
                {
                    ApplicationArea = Basic;
                }
                field("Salaries Batch"; "Salaries Batch")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}
