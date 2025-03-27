#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516395 "Receipt Allocation(Posted)"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Receipt Allocation";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                    OptionCaption = ' ,Registration Fee,Loan,Repayment,Withdrawal,Interest Due,Interest Paid,Benevolent Fund,Deposit Contribution,Penalty Charged,Application Fee,Appraisal Fee,Investment,Unallocated Funds,Shares Capital,Loan Adjustment,Dividend,Withholding Tax,Administration Fee,Insurance Contribution,Prepayment,Ordinary Building Shares(2),Xmas Contribution,Penalty Paid,Dev Shares,Co-op Shares,Welfare Contribution 2,Loan Penalty,Loan Guard,Preferencial Building Shares,Van Shares,Bus Shares,Computer Shares,Ordinary Building Shares,Housing Deposits Shares,M Pesa Charge ,Insurance Charge,Insurance Paid,FOSA Account,Partial Disbursement,Loan Due,FOSA Shares,Loan Form Fee,Kuscco Shares,CIC shares,COOP Shares,Pepea Shares';
                }
                field("Loan No."; "Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Interest Amount"; "Interest Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount"; "Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Balance"; "Amount Balance")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Interest Balance"; "Interest Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Prepayment Date"; "Prepayment Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Insurance"; "Loan Insurance")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        sto.Reset;
        sto.SetRange(sto."No.", "Document No");
        if sto.Find('-') then
            if sto.Status = sto.Status::Approved then
                CurrPage.Editable := false
            else
                CurrPage.Editable := true;
    end;

    var
        sto: Record "Standing Orders";
        Loan: Record "Loans Register";
        ReceiptAllocation: Record "Receipt Allocation";
}
