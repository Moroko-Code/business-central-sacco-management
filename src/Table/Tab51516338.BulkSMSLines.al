#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516338 "Bulk SMS Lines"
{
    fields
    {
        field(1; No; Code[20])
        {
            NotBlank = true;
            TableRelation = "Bulk SMS Header".No;
        }
        field(2; "Phone No"; Text[50])
        {
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1; No, "Phone No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
