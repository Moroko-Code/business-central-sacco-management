Table 51516457 "Log in time"
{
    fields
    {
        field(1; no; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "user ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; TimeLogIn; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(5; TimeLogOut; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(6; DateLogIn; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; DateLogOut; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Entry No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; LineNo; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Minute; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Minutes; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; LineNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
