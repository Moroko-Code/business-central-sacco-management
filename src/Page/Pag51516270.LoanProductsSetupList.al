#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516270 "Loan Products Setup List"
{
    ApplicationArea = Basic;
    CardPageID = "Loan Products Setup Card";
    DeleteAllowed = true;
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Products Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                }
                field("Product Description"; "Product Description")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                }
                field("Interest rate"; "Interest rate")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Method"; "Repayment Method")
                {
                    ApplicationArea = Basic;
                }
                field("Grace Period - Principle (M)"; "Grace Period - Principle (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Grace Period - Interest (M)"; "Grace Period - Interest (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Use Cycles"; "Use Cycles")
                {
                    ApplicationArea = Basic;
                }
                field("Instalment Period"; "Instalment Period")
                {
                    ApplicationArea = Basic;
                }
                field("No of Installment"; "No of Installment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Maximum Number of Instalment';
                    ShowMandatory = true;
                }
                field("Default Installements"; "Default Installements")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Calculation Days"; "Penalty Calculation Days")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Percentage"; "Penalty Percentage")
                {
                    ApplicationArea = Basic;
                }
                field("Recovery Priority"; "Recovery Priority")
                {
                    ApplicationArea = Basic;
                }
                field("Min No. Of Guarantors"; "Min No. Of Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Min Re-application Period"; "Min Re-application Period")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Multiplier"; "Shares Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Calculation Method"; "Penalty Calculation Method")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Paid Account"; "Penalty Paid Account")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Loan Amount"; "Min. Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Loan Amount"; "Max. Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Account"; "Loan Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Interest Account"; "Loan Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field("Receivable Interest Account"; "Receivable Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field("Action"; Action)
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Account"; "BOSA Account")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Personal Loan Account"; "BOSA Personal Loan Account")
                {
                    ApplicationArea = Basic;
                }
                field("Top Up Commision Account"; "Top Up Commision Account")
                {
                    ApplicationArea = Basic;
                }
                field("Top Up Commision"; "Top Up Commision")
                {
                    ApplicationArea = Basic;
                }
                field("Check Off Loan No."; "Check Off Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Frequency"; "Repayment Frequency")
                {
                    ApplicationArea = Basic;
                }
                field("Pepea Deposits"; "Pepea Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Deposits"; "Sacco Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Interest Upfront"; "Charge Interest Upfront")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        if Source <> Source::FOSA then Error('Only FOSA Products Apply');
                    end;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Product)
            {
                Caption = 'Product';
                action("Product Charges")
                {
                    ApplicationArea = Basic;
                    Caption = 'Product Charges';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Product Charges";
                    RunPageLink = "Product Code" = field(Code);
                }
            }
        }
    }
}
