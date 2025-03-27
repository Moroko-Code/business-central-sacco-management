#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516320 "Stations"
{
    // DrillDownPageID = UnknownPage50238;
    // LookupPageID = UnknownPage50238;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Employer Code"; Code[20])
        {
            //TableRelation = Table51516191.Field1;
        }
    }

    keys
    {
        key(Key1; "Employer Code", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
