#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516275 "Loan Products Setup Card"
{
    DeleteAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Products Setup";

    layout
    {
        area(content)
        {
            group(General)
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
                field("Charge Interest Upfront"; "Charge Interest Upfront")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        // if "Charge Interest Upfront" = true then Error('Load All Loan Interest MUST be false');

                    end;
                }
                field("Load All Loan Interest"; "Load All Loan Interest")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        if "Charge Interest Upfront" = true then Error('Charge Interest Upfront MUST be false');

                    end;
                }
                field("Interest rate"; "Interest rate")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate-Outstanding >1.5"; "Interest Rate-Outstanding >1.5")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Rate-Total Outstanding above 1.5 M';
                }
                field("Repayment Method"; "Repayment Method")
                {
                    ApplicationArea = Basic;
                }
                field("Grace Period - Principle (M)"; "Grace Period - Principle (M)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Grace Period - Interest (M)"; "Grace Period - Interest (M)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Use Cycles"; "Use Cycles")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Instalment Period"; "Instalment Period")
                {
                    ApplicationArea = Basic;
                }
                field("No of Installment"; "No of Installment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Maximum Instalments';
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
                    Caption = 'BOSA Deposits Multiplier';
                }
                field("Penalty Calculation Method"; "Penalty Calculation Method")
                {
                    ApplicationArea = Basic;
                }
                field("Self guaranteed Multiplier"; "Self guaranteed Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Expiry Date"; "Loan Product Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Paid Account"; "Penalty Paid Account")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Charged Account"; "Penalty Charged Account")
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
                field("Check Off Recovery"; "Check Off Recovery")
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
                field("Receivable Insurance Accounts"; "Receivable Insurance Accounts")
                {
                    ApplicationArea = Basic;
                }
                field("Top Up Commision Account"; "Top Up Commision Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Levy on Bridging Loans Account';
                }
                field("Top Up Commision"; "Top Up Commision")
                {
                    ApplicationArea = Basic;
                    Caption = 'Top Up Commision Levy %';
                }
                field("Repayment Frequency"; "Repayment Frequency")
                {
                    ApplicationArea = Basic;
                }
                field("Deposits Multiplier"; "Deposits Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Deposits"; "Sacco Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Pepea Deposits"; "Pepea Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Dont Recover Repayment"; "Dont Recover Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Post to Deposits"; "Post to Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Share Cap %"; "Share Cap %")
                {
                    ApplicationArea = Basic;
                }
                field("Max Share Cap"; "Max Share Cap")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Bank Account"; "Loan Bank Account")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Qualification Criteria")
            {
                Caption = 'Qualification Criteria';
                field("Appraise Deposits"; "Appraise Deposits")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits';
                }
                field("Appraise Shares"; "Appraise Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Shares';
                }
                field("Appraise Salary"; "Appraise Salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary';
                }
                field("Appraise Guarantors"; "Appraise Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Business"; "Appraise Business")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Dividend"; "Appraise Dividend")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Collateral"; "Appraise Collateral")
                {
                    ApplicationArea = Basic;
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
