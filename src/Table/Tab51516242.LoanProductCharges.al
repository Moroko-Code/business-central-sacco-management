#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516242 "Loan Product Charges"
{
    fields
    {
        field(1; "Product Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Loan Products Setup".Code;
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Loan Charges".Code;

            trigger OnValidate()
            begin
                if Charges.Get(Code) then begin
                    Description := Charges.Description;
                    Amount := Charges.Amount;
                    Percentage := Charges.Percentage;
                    "G/L Account" := Charges."G/L Account";
                    Amount2 := Charges.Amount2;
                    "Use Perc" := Charges."Use Perc";
                end;
            end;
        }
        field(3; Description; Text[30])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Percentage; Decimal)
        {
        }
        field(6; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(7; "Use Perc"; Boolean)
        {
        }
        field(8; "Use Band"; Boolean)
        {
            trigger OnValidate()
            begin
                if "Use Band" then
                    Amount := 0;
                Percentage := 0;
                "Use Perc" := false;
            end;
        }
        field(9; "Charge Excise"; Boolean)
        {
        }
        field(11; "Above 1M"; Boolean)
        {
        }
        field(12; "Amount2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Product Code", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Charges: Record "Loan Charges";
        loantype: Record "Loan Products Setup";
}
