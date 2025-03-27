#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516869 "Project General Setup"
{
    fields
    {
        field(10; "Primary Key"; Code[10])
        {
        }
        field(11; "Project Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(12; "Auto Allocate Cost"; Boolean)
        {
        }
        field(13; "Depreciation Book"; Code[20])
        {
            TableRelation = "Depreciation Book".Code;
        }
        field(14; "Projects Analysis Code"; Code[20])
        {
            //TableRelation = Dimension.Code where (Field51516830=const(Yes));
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
