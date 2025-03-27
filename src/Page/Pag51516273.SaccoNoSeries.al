#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516273 "Sacco No. Series"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = true;
    SourceTable = "Sacco No. Series";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("SMS Request Series"; "SMS Request Series")
                {
                    ApplicationArea = Basic;
                }
            }
            group(BOSA)
            {
                Caption = 'BOSA';
                field("Member Application Nos"; "Member Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Top Up Loan Nos"; "Top Up Loan Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Appeal Numbers"; "Loan Appeal Numbers")
                {
                    ApplicationArea = Basic;
                }
                field("Guarantor Sub No."; "Guarantor Sub No.")
                {
                    ApplicationArea = Basic;
                }
                field("Members Nos"; "Members Nos")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Loans Nos"; "BOSA Loans Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Loans Batch Nos"; "Loans Batch Nos")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Receipts Nos"; "BOSA Receipts Nos")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Transfer Nos"; "BOSA Transfer Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Closure  Nos"; "Closure  Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Share Capital Transfer No.s"; "Share Capital Transfer No.s")
                {
                    ApplicationArea = Basic;
                }
                field("Bosa Transaction Nos"; "Bosa Transaction Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Micro Transactions"; "Micro Transactions")
                {
                    ApplicationArea = Basic;
                }
                field("Micro Finance Transactions"; "Micro Finance Transactions")
                {
                    ApplicationArea = Basic;
                }
                field("Micro Group Nos."; "Micro Group Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Teller Bulk Trans Nos."; "Teller Bulk Trans Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Paybill Processing"; "Paybill Processing")
                {
                    ApplicationArea = Basic;
                }
                field(BosaNumber; BosaNumber)
                {
                    ApplicationArea = Basic;
                    Caption = 'Bosa member Number';
                    Visible = false;
                }
                field("Member Re-Application No.s"; "Member Re-Application No.s")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff-Proc Distributed Nos"; "Checkoff-Proc Distributed Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Tracker no"; "Tracker no")
                {
                    ApplicationArea = Basic;
                }
                field("Activation Nos"; "Activation Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Top Up Nos"; "Top Up Nos")
                {
                    ApplicationArea = Basic;
                }
                field("OVerdraft Nos"; "OVerdraft Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Last Memb No."; "Last Memb No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Recovery Nos"; "Loan Recovery Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Change Request No"; "Change Request No")
                {
                    ApplicationArea = Basic;
                }
            }
            group(FOSA)
            {
                Caption = 'FOSA';
                Visible = false;
                field("FOSA Loans Nos"; "FOSA Loans Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Member Periodics Nos"; "Member Periodics Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Okoa No."; "Okoa No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Nos."; "Transaction Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Treasury Nos."; "Treasury Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Standing Orders Nos."; "Standing Orders Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Current Account"; "FOSA Current Account")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Current Account"; "BOSA Current Account")
                {
                    ApplicationArea = Basic;
                }
                field("Teller Transactions No"; "Teller Transactions No")
                {
                    ApplicationArea = Basic;
                }
                field("Treasury Transactions No"; "Treasury Transactions No")
                {
                    ApplicationArea = Basic;
                }
                field("Applicants Nos."; "Applicants Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("STO Register No"; "STO Register No")
                {
                    ApplicationArea = Basic;
                }
                field("EFT Header Nos."; "EFT Header Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("EFT Details Nos."; "EFT Details Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Salaries Nos."; "Salaries Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Applications"; "ATM Applications")
                {
                    ApplicationArea = Basic;
                }
                field("Banking Shares Nos"; "Banking Shares Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Application Nos"; "Cheque Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Receipts Nos"; "Cheque Receipts Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Receipts Nos"; "Receipts Nos")
                {
                    ApplicationArea = all;
                }
                field("Member Agent/NOK Change"; "Member Agent/NOK Change")
                {
                    ApplicationArea = Basic;
                }
                field("Agent Serial Nos"; "Agent Serial Nos")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Others)
            {
                Caption = 'Others';
                field("Requisition No"; "Requisition No")
                {
                    ApplicationArea = Basic;
                }
                field("Internal Requisition No."; "Internal Requisition No.")
                {
                    ApplicationArea = Basic;
                }
                field("Internal Purchase No."; "Internal Purchase No.")
                {
                    ApplicationArea = Basic;
                }
                field("Quatation Request No"; "Quatation Request No")
                {
                    ApplicationArea = Basic;
                }
                field("Stores Requisition No"; "Stores Requisition No")
                {
                    ApplicationArea = Basic;
                }
                field("Requisition Default Vendor"; "Requisition Default Vendor")
                {
                    ApplicationArea = Basic;
                }
                field("Use Procurement limits"; "Use Procurement limits")
                {
                    ApplicationArea = Basic;
                }
                field("Request for Quotation Nos"; "Request for Quotation Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Investors Nos"; "Investors Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Property Nos"; "Property Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Investment Project Nos"; "Investment Project Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax %"; "Withholding Tax %")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax Account"; "Withholding Tax Account")
                {
                    ApplicationArea = Basic;
                }
                field("VAT %"; "VAT %")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Account"; "VAT Account")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Investor)
            {
                Visible = false;
                Caption = 'Investor';
                field("Investor Application Nos"; "Investor Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Investor Nos"; "Investor Nos")
                {
                    ApplicationArea = Basic;
                }
            }
            group("S-PESA")
            {
                Caption = 'S-PESA';
                Visible = false;
                field("MPESA Change Nos"; "MPESA Change Nos")
                {
                    ApplicationArea = Basic;
                }
                field("MPESA Application Nos"; "MPESA Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Change MPESA PIN Nos"; "Change MPESA PIN Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Change MPESA Application Nos"; "Change MPESA Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("SurePESA Registration Nos"; "SurePESA Registration Nos")
                {
                    ApplicationArea = all;
                }
            }
            group(CRM)
            {
                field("Customer Care Log Nos"; "Customer Care Log Nos")
                {
                    ApplicationArea = Basic;
                    Caption = 'CRM Log Nos';
                }
                field("Lead Nos"; "Lead Nos")
                {
                    ApplicationArea = Basic;
                    Caption = 'Opportunity Nos';
                }
                field("Disciplinary Cases Nos."; "Disciplinary Cases Nos.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Case Nos';
                }
            }
        }
    }

    trigger OnInit()

    begin
        if Rec.IsEmpty() then
            Rec.Insert();
    end;
}
