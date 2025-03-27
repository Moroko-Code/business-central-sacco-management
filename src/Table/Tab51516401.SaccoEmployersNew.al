#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516401 "Sacco Employers(New)"
{
    // DrillDownPageID = UnknownPage51516422;
    // LookupPageID = UnknownPage51516422;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                //Description:=  cust.Name;
                //MODIFY;
            end;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Repayment Method"; Option)
        {
            OptionMembers = " ",Amortised,"Reducing Balance","Straight Line",Constants;
        }
        field(4; "Check Off"; Boolean)
        {
        }
        field(5; "No. of Members"; Integer)
        {
            // CalcFormula = count(Table51516364 where(Field68012 = filter(0 | 3 | 4 | 8 | 9),
            //                                          Field68017 = field(Code),
            //                                          Field21 = const(MEMBER)));
            // FieldClass = FlowField;
        }
        field(6; Male; Integer)
        {
            // CalcFormula = count(Table51516364 where(Field68012 = filter(0 | 3 | 4 | 8 | 9),
            //                                          Field68017 = field(Code),
            //                                          Field21 = const(MEMBER),
            //                                          Field68032 = const(0)));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(7; Female; Integer)
        {
            // CalcFormula = count(Table51516364 where(Field68012 = filter(0 | 3 | 4 | 8 | 9),
            //                                          Field68017 = field(Code),
            //                                          Field21 = const(MEMBER),
            //                                          Field68032 = const(1)));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(8; "Vote Code"; Code[20])
        {
        }
        field(9; "Can Guarantee Loan"; Boolean)
        {
        }
        field(10; "Active Members"; Integer)
        {
            // CalcFormula = count(Table51516364 where(Field68012 = filter(0),
            //                                          Field68017 = field(Code),
            //                                          Field21 = const(MEMBER)));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(11; "Dormant Members"; Integer)
        {
            // CalcFormula = count(Table51516364 where(Field68012 = filter(3),
            //                                          Field68017 = field(Code),
            //                                          Field21 = const(MEMBER)));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(12; Withdrawn; Integer)
        {
            // CalcFormula = count(Table51516364 where(Field68012 = filter(6),
            //                                          Field68017 = field(Code),
            //                                          Field21 = const(MEMBER)));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(13; Deceased; Integer)
        {
            // CalcFormula = count(Table51516364 where(Field68012 = filter(5),
            //                                          Field68017 = field(Code),
            //                                          Field21 = const(MEMBER)));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(14; "Join Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Code", Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }

    var
        cust: Record Customer;
}
