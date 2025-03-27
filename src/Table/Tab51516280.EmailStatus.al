#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516280 "Email Status"
{
    fields
    {
        field(1; "Member No"; Code[20])
        {
        }
        field(2; Period; Date)
        {
        }
        field(3; Date; Date)
        {
        }
        field(4; Sent; Boolean)
        {
        }
        field(5; "Member Name"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
