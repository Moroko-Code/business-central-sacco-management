#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516032 "Funds Transfer Lines"
{
    PageType = ListPart;
    SourceTable = "Funds Transfer Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receiving Bank Account"; "Receiving Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Balance"; "Bank Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                // field("Bank Balance(LCY)"; "Bank Balance(LCY)")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                //     Visible = false;
                // }
                field("Pay Mode"; "Pay Mode")
                {
                    ApplicationArea = Basic;
                }
                // field("Bank Account No."; "Bank Account No.")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Currency Code"; "Currency Code")
                // {
                //     ApplicationArea = Basic;
                //     Visible = false;
                // }
                // field("Currency Factor"; "Currency Factor")
                // {
                //     ApplicationArea = Basic;
                //     Visible = false;
                // }
                field("Amount to Receive"; "Amount to Receive")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Receive (LCY)"; "Amount to Receive (LCY)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                // field("External Doc No."; "External Doc No.")
                // {
                //     ApplicationArea = Basic;
                // }
            }
        }
    }

    actions
    {
    }
}
