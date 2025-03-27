#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516035 "Destination Rates"
{
    fields
    {
        field(1; "Advance Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Funds Transaction Types" where("Transaction Type" = const(Imprest));
        }
        field(2; "Destination Code"; Code[10])
        {
            NotBlank = true;
        }
        field(3; Currency; Code[10])
        {
            NotBlank = false;
            TableRelation = Currency;
        }
        field(4; "Destination Type"; Option)
        {
            Editable = false;
            OptionMembers = "local",Foreign;
        }
        field(5; "Daily Rate (Amount)"; Decimal)
        {
        }
        field(6; "Employee Job Group"; Code[10])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = "Employee Statistics Group";
        }
        field(7; "Destination Name"; Text[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Advance Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
