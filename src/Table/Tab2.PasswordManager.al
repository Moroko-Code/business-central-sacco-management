table 50601 "Password Manager"
{
    Caption = 'Password Manager';
    DataClassification = ToBeClassified;

    fields
    {
        field(2; MemberNo; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; MemberName; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Email; Text[50])
        {
            Caption = 'Email';
            DataClassification = ToBeClassified;
        }
        field(5; Activated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Username; Text[50])
        {
            Caption = 'Username';
            DataClassification = ToBeClassified;
        }
        field(7; Password; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; OTP; Integer)
        {
            Caption = 'OTP';
            DataClassification = ToBeClassified;
        }
        field(9; ID_Number; Code[50])
        {
            Caption = 'ID Number';
            DataClassification = ToBeClassified;
        }
        field(10; Phone_Number; Text[30])
        {
            Caption = 'Phone Number';
            DataClassification = ToBeClassified;
        }



    }
    keys
    {
        key(PK; "MemberNo")
        {
            Clustered = true;
        }
    }
}
