#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516340 "Paybill Keywords"
{
    fields
    {
        field(1; Keyword; Text[50])
        {
            NotBlank = true;
        }
        field(2; "Loan Code"; Code[20])
        {
            // TableRelation = "Loan Product Types".Code;
        }
        field(3; "Destination Type"; Option)
        {
            OptionMembers = "None","Loan Repayment","Shares Capital","Deposit Contribution","Benevolent Funds";
        }
    }

    keys
    {
        key(Key1; Keyword)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
