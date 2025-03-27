#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516118 "SasraLoanClassificationCues"
{
    Caption = 'SasraLoanClassificationCues';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Watchful Loans"; Integer)
        {
            //CalcFormula = COUNT("Loans Register" WHERE("Loans Category-SASRA" = CONST(Watch), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Issued), Source = const(BOSA)));
        }
        field(3; "Substandard Loans"; Integer)
        {
            // CalcFormula = COUNT("Loans Register" WHERE("Loans Category-SASRA" = CONST(Substandard), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Issued), Source = const(BOSA)));
        }
        field(4; "Doubtful Loans"; Integer)
        {
            //CalcFormula = COUNT("Loans Register" WHERE("Loans Category-SASRA" = CONST(doubtful), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Issued), Source = const(BOSA)));
        }
        field(5; "Watchful FOSA Loans"; Integer)
        {
            //CalcFormula = COUNT("Loans Register" WHERE("Loans Category-SASRA" = CONST(watch), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Issued), Source = const(FOSA)));
        }
        field(6; "Substandard FOSA Loans"; Integer)
        {
            //CalcFormula = COUNT("Loans Register" WHERE("Loans Category-SASRA" = CONST(Substandard), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Issued), Source = const(FOSA)));
        }
        field(7; "Doubtful FOSA Loans"; Integer)
        {
            //CalcFormula = COUNT("Loans Register" WHERE("Loans Category-SASRA" = CONST(Doubtful),"Loans Category-SASRA" = CONST(Loss),"Loans Category-SASRA" = CONST(Loss), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Issued), Source = const(FOSA)));
        }
        field(8; "Watchful MICRO Loans"; Integer)
        {
            //CalcFormula = COUNT("Loans Register" WHERE("Loans Category-SASRA" = CONST(Watch), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Issued), Source = const(MICRO)));
        }
        field(9; "Substandard MICRO Loans"; Integer)
        {
            //CalcFormula = COUNT("Loans Register" WHERE("Loans Category-SASRA" = CONST(Substandard), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Issued), Source = const(MICRO)));
        }
        field(10; "Doubtful MICRO Loans"; Integer)
        {
            //CalcFormula = COUNT("Loans Register" WHERE("Loans Category-SASRA" = CONST(Doubtful), "Loans Category-SASRA" = CONST(Loss), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Issued), Source = const(MICRO)));
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
