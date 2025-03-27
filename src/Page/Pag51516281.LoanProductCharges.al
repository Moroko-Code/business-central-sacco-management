#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516281 "Loan Product Charges"
{
    PageType = List;
    SourceTable = "Loan Product Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Code"; "Product Code")
                {
                    ApplicationArea = Basic;
                }
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Amount2; Amount2)
                {
                    Caption = 'Loan Drsbursement Fee Above 1M';
                    ApplicationArea = Basic;
                }
                field(Percentage; Percentage)
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account"; "G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("Above 1M"; "Above 1M")
                {
                    ApplicationArea = basic;
                }
                field("Use Perc"; "Use Perc")
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
