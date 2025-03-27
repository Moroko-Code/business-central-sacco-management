#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516278 "Loan Charge Band"
{
    fields
    {
        field(1; "Loan Type"; Code[20])
        {
        }
        field(2; "Charge Type"; Code[20])
        {
        }
        field(3; "Lower Limit"; Decimal)
        {
        }
        field(4; "Upper Limit"; Decimal)
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Use (%)"; Boolean)
        {
        }
        field(7; Rate; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Loan Type", "Charge Type", "Lower Limit")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
