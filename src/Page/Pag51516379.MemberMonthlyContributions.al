#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516379 "Member Monthly Contributions"
{
    PageType = List;
    SourceTable = "Member Monthly Contributions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; "Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Off"; "Amount Off")
                {
                    ApplicationArea = Basic;
                }
                field("Amount ON"; "Amount ON")
                {
                    ApplicationArea = Basic;
                }
                field("Check Off Priority"; "Check Off Priority")
                {
                    ApplicationArea = Basic;
                }
                field("Last Advice Date"; "Last Advice Date")
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Balance 2"; "Balance 2")
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
