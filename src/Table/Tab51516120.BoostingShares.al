#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516120 "Boosting Shares"
{
    // DrillDownPageID = UnknownPage39004250;
    // LookupPageID = UnknownPage39004250;

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(2; "Client Code"; Code[20])
        {
        }
        field(3; "Boosting Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                Commision := ("Boosting Amount" * 0.1);
            end;
        }
        field(4; Commision; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Client Code")
        {
            Clustered = true;
            SumIndexFields = "Boosting Amount";
        }
    }

    fieldgroups
    {
    }

    var
        Loans: Record "Loans Register";
        Loantypes: Record "Loan Products Setup";
        Interest: Decimal;
        Cust: Record Customer;
}
