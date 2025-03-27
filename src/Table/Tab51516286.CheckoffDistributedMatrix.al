#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516286 "Checkoff Distributed Matrix"
{
    fields
    {
        field(1; "Employer Code"; Code[50])
        {
            TableRelation = "Sacco Employers".Code;
        }
        field(2; "Loan Product Code"; Code[50])
        {
            TableRelation = "Loan Products Setup".Code;
        }
        field(3; "Check off Code"; Code[50])
        {
        }
        field(4; "check Interest"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Employer Code", "Loan Product Code", "Check off Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
