#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516479 "loans Cues"
{
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Applied Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Open)));
            FieldClass = FlowField;
        }
        field(3; "Approved Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved)));
            FieldClass = FlowField;
        }
        field(4; "Pending Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Pending)));
            FieldClass = FlowField;
        }
        field(5; "Rejected Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Rejected)));
            FieldClass = FlowField;
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
