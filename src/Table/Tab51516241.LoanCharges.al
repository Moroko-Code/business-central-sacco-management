#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516241 "Loan Charges"
{
    DrillDownPageID = "Loan Charges";
    LookupPageID = "Loan Charges";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
        }
        field(3; Amount; Decimal)
        {
        }
        field(7; Amount2; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Percentage; Decimal)
        {
        }
        field(5; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(6; "Use Perc"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
