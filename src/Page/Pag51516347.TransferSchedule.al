#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516347 "Transfer Schedule"
{
    ApplicationArea = Basic;
    PageType = ListPart;
    SourceTable = "BOSA Transfer Schedule";
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Source Type"; "Source Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Type';
                    
                }
                field("Source Account No."; "Source Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account to Debit(BOSA)';
                }
                field("Source Account Name"; "Source Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Line Description"; "Line Description")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Type"; "Charge Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Charge Amount"; "Charge Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Loan; Loan)
                {
                    ApplicationArea = Basic;
                }
                // field("Transaction Amount"; "Transaction Amount")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Type"; "Destination Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account No."; "Destination Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Name"; "Destination Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Loan"; "Destination Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Type"; "Destination Type")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}
