pageextension 51516884 "Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Blanket Order Nos.")
        {
            field("BOSA Transfer Nos"; "BOSA Transfer Nos")
            {
                ApplicationArea = all;
            }
            field("Collateral Register No"; "Collateral Register No")
            {
                ApplicationArea = all;
            }
            field("Custodian No."; "Custodian No.")
            {
                ApplicationArea = all;
            }
            field("Safe Custody Package Nos"; "Safe Custody Package Nos")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}