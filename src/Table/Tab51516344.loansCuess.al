#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516344 "loans Cuess"
{
    fields
    {
        field(1; "Primary Key"; Code[20])
        {
        }
        field(2; "Applied Loans"; Integer)
        {
            CalcFormula = COUNT("Loans Register" WHERE("Approval Status" = CONST(Open), "Approved Amount" = filter(> 0), "Loan Status" = const(Application), Source = const(BOSA)));
            FieldClass = FlowField;
        }
        field(3; "Active Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Issued), Source = const(BOSA)));
            FieldClass = FlowField;
        }
        field(4; "Pending Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Pending), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), Source = const(BOSA)));
            FieldClass = FlowField;
        }

        field(11; "EMERGENCY"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Loan Status" = const(Issued), "Outstanding Balance" = filter(> 0), "Loan Product Type" = const('EMERGENCY')));
            FieldClass = FlowField;
        }



        field(15; "SHORT TERM"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), "Loan Product Type" = const('SHORT_TERM')));
            FieldClass = FlowField;
        }
        field(16; "LONG TERM"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), "Loan Product Type" = const('LONG_TERM')));
            FieldClass = FlowField;
        }
        field(17; "LOG BOOK LOAN"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), "Loan Product Type" = const('LOG_BOOK')));
            FieldClass = FlowField;
        }
        field(18; "NORMAL"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), "Loan Product Type" = const('NORMAL')));
            FieldClass = FlowField;
        }

        field(20; "SAIDIKA PAP LOAN"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), "Loan Product Type" = const('SAIDIKA_PAP')));
            FieldClass = FlowField;
        }
        field(21; "SCHOOL FEES"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), "Loan Product Type" = const('SCH_FEES')));
            FieldClass = FlowField;
        }
        field(22; "Cleared Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Outstanding Balance" = filter(<= 0), "Loan Status" = const(Issued), Source = const(BOSA)));
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
