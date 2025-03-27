tableextension 51516068 "PurchaseLinesExt" extends "Purchase Line"
{
    fields
    {
        field(1000; "Expense Code"; Code[100])
        {
            Caption = 'Expense Code';
            DataClassification = ToBeClassified;
        }
    }
}
