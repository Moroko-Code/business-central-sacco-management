#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516005 "Funds Transfer Line"
{
    fields
    {
        field(10; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(11; "Document No"; Code[10])
        {
        }
        field(12; "Document Type"; Code[10])
        {
        }
        field(13; Date; Date)
        {
        }
        field(14; "Posting Date"; Date)
        {
        }
        field(15; "Pay Mode"; Option)
        {
            OptionCaption = ' ,Cash,Cheque';
            OptionMembers = " ",Cash,Cheque;
        }
        field(16; "Receiving Bank Account"; Code[40])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                BankAcc.Reset;
                BankAcc.SetRange(BankAcc."No.", "Receiving Bank Account");
                if BankAcc.FindFirst then
                    "Bank Name" := BankAcc.Name;
            end;
        }
        field(17; "Bank Name"; Text[50])
        {
        }
        field(18; "Bank Balance"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Receiving Bank Account")));
            FieldClass = FlowField;
        }
        field(19; "Bank Balance(LCY)"; Decimal)
        {
        }
        field(20; "Bank Account No."; Code[20])
        {
        }
        field(21; "Currency Code"; Code[20])
        {
        }
        field(22; "Currency Factor"; Decimal)
        {
        }
        field(23; "Amount to Receive"; Decimal)
        {
        }
        field(24; "Amount to Receive (LCY)"; Decimal)
        {
            Editable = false;
        }
        field(25; "External Doc No."; Code[20])
        {
        }
        field(32; "Receiving Transfer Type"; Option)
        {
            OptionMembers = "Intra-Company","Inter-Company";
        }
    }

    keys
    {
        key(Key1; "Document No", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        BankAcc: Record "Bank Account";
}
