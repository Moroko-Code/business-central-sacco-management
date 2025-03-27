tableextension 51516048 "PurchaseSetUpExtension" extends "Purchases & Payables Setup"
{
    fields
    {
        field(1000; "Quotation Request No"; Code[100])
        {
            Caption = 'Quotation Request No';
            DataClassification = ToBeClassified;
        }
        field(1001; "Stores Requisition No"; Code[100])
        {
            Caption = 'Stores Requisition No';
            DataClassification = ToBeClassified;
        }
    }
}
