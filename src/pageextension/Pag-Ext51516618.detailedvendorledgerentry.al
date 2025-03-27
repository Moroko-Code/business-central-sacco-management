pageextension 51516618 "detailedvendorledgerentry" extends "Detailed Vendor Ledg. Entries"
{
    layout
    {
        addafter(Amount)
        {
            field("Amount Posted"; "Amount Posted")
            {
                ApplicationArea = Basic;
            }
            field("Transaction Type"; "Transaction Type")
            {
                ApplicationArea = Basic;
            }
        }
        modify("Entry Type")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("Initial Entry Due Date")
        {
            Visible = false;
        }
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }
    }
}
