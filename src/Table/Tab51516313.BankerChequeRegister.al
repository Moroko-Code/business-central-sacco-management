#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516313 "Banker Cheque Register"
{
    fields
    {
        field(1; "Banker Cheque No."; Code[30])
        {
        }
        field(2; Issued; Boolean)
        {
        }
        field(3; Cancelled; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Banker Cheque No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
