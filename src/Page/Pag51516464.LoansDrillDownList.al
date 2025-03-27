#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516464 "Loans DrillDown List"
{
    ApplicationArea = Basic;
    CardPageID = "Loans DrillDown Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Loan  No."; "Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Date of Completion"; "Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Client Code"; "Client Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("BOSA No"; "BOSA No")
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date"; "Issued Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Client Name"; "Client Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Repayment; Repayment)
                {
                    ApplicationArea = Basic;
                }
            
                field("Loan Monthly Principal"; Repayment)
                {
                    ApplicationArea = all;
                }
                field("Loan Principle Repayment"; "Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Loan Interest Repayment"; "Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Requested Amount"; "Requested Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Balance"; "Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field(Installments; Installments)
                {
                    ApplicationArea = Basic;
                    Caption = 'Installments';
                    Editable = false;
                }
                field(Interest; Interest)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Status"; "Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                // field("Last Pay Date"; "Last Pay Date")
                // {
                //     ApplicationArea = Basic;
                // }
                // field(Source; Source)
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Recovery Mode"; "Recovery Mode")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Loan Disbursement Date"; "Loan Disbursement Date")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Repayment Start Date"; "Repayment Start Date")
                // {
                //     ApplicationArea = Basic;
                // }

                // field("Months in Arrears"; "No of Months in Arrears")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Principal In Arrears"; "Principal In Arrears")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Interest In Arrears"; "Interest In Arrears")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Total Amount In Arrears"; "Amount in Arrears")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Loans Status"; "Loans Category-SASRA")
                // {
                //     ApplicationArea = Basic;
                // }
            }
        }
    }
    // var
    //     "Current Loan Repayment": Decimal;
}
