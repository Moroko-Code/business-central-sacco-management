table 51516908 Counties
{
    Caption = 'Counties';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Counties List";
    LookupPageId = "Counties List";

    fields
    {
        field(1; No; Code[10])
        {
            Caption = 'No';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
}
