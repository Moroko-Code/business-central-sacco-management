#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516007 "Imprest Line"
{
    fields
    {
        field(10; "Line No"; Integer)
        {
        }
        field(11; "Document No"; Code[10])
        {
            TableRelation = "Payment Header"."No.";
        }
        field(12; "Document Type"; Option)
        {
            OptionCaption = 'Normal,Cash Purchase,Petty Cash,Express';
            OptionMembers = Normal,"Cash Purchase","Petty Cash",Express;
        }
        field(13; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(14; "Currency Factor"; Decimal)
        {
        }
        field(15; "Transaction Type"; Code[20])
        {
            TableRelation = "Funds Transaction Types"."Transaction Code";
        }
        field(16; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Item';
            OptionMembers = "G/L Account",Customer,Vendor,Item;
        }
        field(17; "Account No"; Code[20])
        {
        }
        field(18; "Account Name"; Text[50])
        {
        }
        field(19; "Transaction Type Description"; Text[50])
        {
        }
        field(20; "Payment Description"; Text[50])
        {
        }
        field(21; Amount; Decimal)
        {
        }
        field(22; "Amount(LCY)"; Decimal)
        {
        }
        field(23; "VAT Code"; Code[10])
        {
        }
        field(24; "VAT Amount"; Decimal)
        {
        }
        field(25; "VAT Amount(LCY)"; Decimal)
        {
        }
        field(26; "W/TAX Code"; Code[10])
        {
        }
        field(27; "W/TAX Amount"; Decimal)
        {
        }
        field(28; "W/TAX Amount(LCY)"; Decimal)
        {
        }
        field(29; "Retention Code"; Code[10])
        {
        }
        field(30; "Retention Amount"; Decimal)
        {
        }
        field(31; "Retention Amount(LCY)"; Decimal)
        {
        }
        field(32; "Net Amount"; Decimal)
        {
        }
        field(33; "Net Amount(LCY)"; Decimal)
        {
        }
        field(34; Committed; Boolean)
        {
        }
        field(35; "Vote Book"; Code[20])
        {
        }
        field(36; "Gen. Bus. Posting Group"; Code[20])
        {
        }
        field(37; "Gen. Prod. Posting Group"; Code[20])
        {
        }
        field(38; "VAT Bus. Posting Group"; Code[20])
        {
        }
        field(39; "VAT Prod. Posting Group"; Code[20])
        {
        }
        field(40; "Global Dimension 1 Code"; Code[10])
        {
        }
        field(41; "Global Dimension 2 Code"; Code[10])
        {
        }
        field(42; "Shortcut Dimension 3 Code"; Code[10])
        {
        }
        field(43; "Shortcut Dimension 4 Code"; Code[10])
        {
        }
        field(44; "Shortcut Dimension 5 Code"; Code[10])
        {
        }
        field(45; "Shortcut Dimension 6 Code"; Code[10])
        {
        }
        field(46; "Shortcut Dimension 7 Code"; Code[10])
        {
        }
        field(47; "Shortcut Dimension 8 Code"; Code[10])
        {
        }
        field(48; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(49; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup()
            var
                VendLedgEntry: Record "Vendor Ledger Entry";
                PayToVendorNo: Code[20];
                OK: Boolean;
                Text000: label 'You must specify %1 or %2.';
            begin
            end;
        }
        field(50; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            var
                TempVendLedgEntry: Record "Vendor Ledger Entry";
            begin
            end;
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
