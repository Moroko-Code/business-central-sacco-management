#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516454 "Sent SMS Messages Log"
{
    fields
    {
        field(1; "Loan Number"; Code[30])
        {
        }
        field(2; "SMS Log Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Loan Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
