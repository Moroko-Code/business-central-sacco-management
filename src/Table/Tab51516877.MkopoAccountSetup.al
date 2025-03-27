table 51516877 "Mkopo Account Setup"
{
    Caption = 'Mkopo Account Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[30])
        {
            Caption = 'No.';
            TableRelation = "G/L Account"."No.";
            trigger OnValidate()
            var
                GLAccount: Record "G/L Account";

            begin
                GLAccount.Reset();
                GLAccount.SetRange(GLAccount."No.", "No.");
                if GLAccount.FindSet() then
                    Name := GLAccount.Name;
            end;
        }
        field(2; Name; Code[100])
        {
            Caption = 'Name';
        }
        field(3; Pk; Integer)
        {
            Caption = 'Pk';
            AutoIncrement = true;
        }
    }
    keys
    {
        key(PK; Pk)
        {
            Clustered = true;
        }
    }
}
