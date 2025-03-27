#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516283 "Sacco Employers card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Sacco Employers";

    layout
    {
        area(content)
        {
            field("Code"; Code)
            {
                ApplicationArea = Basic;
            }
            field(Description; Description)
            {
                ApplicationArea = Basic;
            }
            field("Repayment Method"; "Repayment Method")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Check Off"; "Check Off")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("No. of Members"; "No. of Members")
            {
                ApplicationArea = Basic;
            }
            field(Male; Male)
            {
                ApplicationArea = Basic;
            }
            field(Female; Female)
            {
                ApplicationArea = Basic;
            }
            field("Vote Code"; "Vote Code")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Can Guarantee Loan"; "Can Guarantee Loan")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Active Members"; "Active Members")
            {
                ApplicationArea = Basic;
            }
            field("Dormant Members"; "Dormant Members")
            {
                ApplicationArea = Basic;
            }
            field(Withdrawn; Withdrawn)
            {
                ApplicationArea = Basic;
            }
            field(Deceased; Deceased)
            {
                ApplicationArea = Basic;
            }
            field("Join Date"; "Join Date")
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }
}
