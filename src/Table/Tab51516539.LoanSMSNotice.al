#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516539 "Loan SMS Notice"
{
    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Loan No"; Code[50])
        {
        }
        field(3; "SMS 7 Day"; Date)
        {
        }
        field(4; "SMS Due Date today"; Date)
        {
        }
        field(5; "Notice SMS 1"; Date)
        {
        }
        field(6; "Notice SMS 2"; Date)
        {
        }
        field(7; "Notice SMS 3"; Date)
        {
        }
        field(8; "Guarantor SMS"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
