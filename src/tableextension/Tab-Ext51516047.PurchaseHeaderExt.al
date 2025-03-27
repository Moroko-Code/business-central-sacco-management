tableextension 51516047 "PurchaseHeaderExt" extends "Purchase Header"
{
    fields
    {
        field(2000; DocApprovalType; Enum DocApprovalType)
        {
            Caption = 'DocApprovalType';
            DataClassification = ToBeClassified;
        }
    }
}
