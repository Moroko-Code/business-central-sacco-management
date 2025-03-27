#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516036 "Loans Calculator List"
{
    ApplicationArea = Basic;
    CardPageID = "Loans Calculator";
    Editable = false;
    PageType = List;
    SourceTable = "Loans Calculator";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Product Description"; "Product Description")
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
                field(Installments; Installments)
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Start Date"; "Repayment Start Date")
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
