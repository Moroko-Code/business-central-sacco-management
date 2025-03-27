page 51516950 "PaymentList"
{
    ApplicationArea = All;
    Caption = 'Payment List';
    PageType = List;
    SourceTable = "Payment Header";
    UsageCategory = Lists;
    CardPageId = PaymentCard;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = Basic;
                }
                field(Payee; Payee)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount(LCY)"; "Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Cashier; Cashier)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Payment Mode" := "payment mode"::Cheque;
        "Payment Type" := "payment type"::Normal;
    end;

    trigger OnOpenPage()
    begin
        SetRange(Cashier, UserId);
    end;
}
