#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516161 "Absence Preferences"
{
    fields
    {
        field(1; "Include Weekends"; Boolean)
        {
        }
        field(2; "Include Holidays"; Boolean)
        {
        }
        field(3; "Year-Start Date"; Date)
        {
        }
        field(27; "doc prsent"; Boolean)
        {
        }
        field(69026; prsent; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Include Weekends", "Include Holidays")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
