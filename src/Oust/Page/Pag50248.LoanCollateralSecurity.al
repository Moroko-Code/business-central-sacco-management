#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50248 "Loan Collateral Security"
{
    PageType = ListPart;
    SourceTable = "Loan Collateral Details";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;

                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = Basic;
                }

                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Multiplier"; Rec."Collateral Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Guarantee Value"; Rec."Guarantee Value")
                {
                    ApplicationArea = Basic;
                }
                // field("View Document"; "View Document")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                field("Assesment Done By"; Rec."Assesment Done By")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
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

