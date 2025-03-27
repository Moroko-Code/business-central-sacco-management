#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516480 "Members Cue"
{
    fields
    {
        field(1; "Primary Key"; Code[20])
        {
        }
        field(2; "Active Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Active)));
            FieldClass = FlowField;
        }
        field(3; "Non-Active Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const("Non-Active")));
            FieldClass = FlowField;
        }
        field(4; "Dormant Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Dormant)));
            FieldClass = FlowField;
        }
        field(5; "Blocked Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Blocked)));
            FieldClass = FlowField;
        }
        field(6; "Reinstated Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const("Re-instated")));
            FieldClass = FlowField;
        }
        field(7; "Defaulted members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Defaulter)));
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
