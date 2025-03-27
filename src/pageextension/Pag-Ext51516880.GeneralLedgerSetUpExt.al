pageextension 51516880 "GeneralLedgerSetUpExt" extends "General Ledger Setup"
{
    layout
    {
        addafter("Shortcut Dimension 8 Code")
        {
            group(MOBILESETUPS)
            {
                field("Mobile Transfer Charge"; "Mobile Transfer Charge")
                {
                    ApplicationArea = Basic;
                }
                field("CloudPESA Comm Acc"; "CloudPESA Comm Acc")
                {
                    ApplicationArea = Basic;
                }
                field("CloudPESA Charge"; "CloudPESA Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Agency Application Nos"; "Agency Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Agency Charges Acc"; "Agency Charges Acc")
                {
                    ApplicationArea = Basic;
                }
                field("MPESA Recon Acc"; "MPESA Recon Acc")
                {
                    ApplicationArea = Basic;
                }
                field("M-banking Charges Acc"; "M-banking Charges Acc")
                {
                    ApplicationArea = Basic;
                }
                field(PaybillAcc; PaybillAcc)
                {
                    ApplicationArea = Basic;
                }
                field(AirTimeSettlAcc; AirTimeSettlAcc)
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Charge"; "Mobile Charge")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
}
