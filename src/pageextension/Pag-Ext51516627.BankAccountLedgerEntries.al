pageextension 51516627 BankAccountLedgerEntries extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter(Amount)
        {
            field("External Document No."; "External Document No.")
            {
                ApplicationArea = Basic;
            }
            field("DebitAmount"; "Debit Amount")
            {
                ApplicationArea = Basic;
                Caption = 'Debit Amount';
            }
            field("CreditAmount"; "Credit Amount")
            {
                ApplicationArea = Basic;
                Caption = 'Credit Amount';
            }
            field("User"; "User ID")
            {
                ApplicationArea = Basic;
                Caption = 'User ID';
            }
        }
        modify(GLEntriesPart)
        {
            Visible = false;
        }
        modify(Open)
        {
            Visible = false;
        }
        modify("Document Type")
        {
            Visible = false;
        }
    }
    actions
    {
        modify("Reverse Transaction")
        {
            Visible = false;
        }
    }
}
