table 50036 "Online Portal OTP"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Member Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; OTP; Integer)
        {
        }
        field(4; Authenticated; Boolean)
        {
        }
        field(5; "Created Date"; DateTime)
        {
        }
    }

    keys
    {
        key(PK; "Member No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin
    end;

    trigger OnRename()
    begin
    end;
}