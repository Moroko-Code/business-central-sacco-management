#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516334 "MPESA Transactions"
{
    // DrillDownPageID = UnknownPage39004062;
    // LookupPageID = UnknownPage39004062;

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Transaction Date"; Date)
        {
        }
        field(3; "Account No."; Code[50])
        {
        }
        field(4; Description; Text[220])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "Transaction Type"; Text[30])
        {
        }
        field(8; "Transaction Time"; Date)
        {
        }
        field(9; "Bal. Account No."; Code[30])
        {
        }
        field(10; "Document Date"; Date)
        {
        }
        field(11; "Date Posted"; Date)
        {
        }
        field(12; "Time Posted"; Time)
        {
        }
        field(13; "Account Status"; Text[30])
        {
        }
        field(14; Messages; Text[200])
        {
        }
        field(15; "Needs Change"; Boolean)
        {
        }
        field(16; "Change Transaction No"; Code[20])
        {
            TableRelation = "Member Monthly Contributions"."No.";
        }
        field(17; "Old Account No"; Code[50])
        {
        }
        field(18; Changed; Boolean)
        {
        }
        field(19; "Date Changed"; Date)
        {
        }
        field(20; "Time Changed"; Time)
        {
        }
        field(21; "Changed By"; Code[30])
        {
        }
        field(22; "Approved By"; Code[30])
        {
        }
        field(23; "Original Account No"; Code[50])
        {
        }
        field(24; "Account Balance"; Decimal)
        {
        }
        field(25; "Key Word"; Text[30])
        {
        }
        field(26; TelephoneNo; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error('You cannot delete MPESA transactions.');
    end;

    trigger OnModify()
    begin
        if Posted = true then
            Error('You cannot modify posted MPESA transactions.');
    end;
}
