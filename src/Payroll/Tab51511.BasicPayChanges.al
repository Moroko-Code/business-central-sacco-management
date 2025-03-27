table 51511 "Basic Pay Changes"
{
    fields
    {
        field(1; "Payroll No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Old Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "New Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Date effected"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Effected By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Payroll No", "Old Pay", "New Pay")
        {
        }
    }

    fieldgroups
    {
    }
}
