#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516906 "Cheque Processing Charges"
{
    fields
    {
        field(1; "Lower Limit"; Decimal)
        {
        }
        field(2; "Upper Limit"; Decimal)
        {
        }
        field(3; Charges; Decimal)
        {
        }
        field(4; Range; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Lower Limit")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
