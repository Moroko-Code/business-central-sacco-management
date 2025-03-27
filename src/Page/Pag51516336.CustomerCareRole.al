#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516336 "Customer Care Role"
{
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1000000004)
            {
                part("Credit Processor"; "Loan Offset Detail List")
                {
                }
                systempart(Control1000000002; Outlook)
                {
                }
                systempart(Control1000000001; MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Loans Calculator")
            {
                ApplicationArea = Basic;
                Image = AdjustEntries;
                //RunObject = Page UnknownPage50026;
            }
            action("Membership Applications")
            {
                ApplicationArea = Basic;
                Image = Add;
                // RunObject = Page UnknownPage51516151;
            }
            action("Members  List")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                //RunObject = Page UnknownPage51516157;
            }
            action("Bosa Loans")
            {
                ApplicationArea = Basic;
                Image = Aging;
                // RunObject = Page "Payroll Employee Card";
            }
        }
        area(creation)
        {
            action("Fosa Loans")
            {
                ApplicationArea = Basic;
                Image = View;
                RunObject = Page "Members Kin Details List";
            }
            action("Fosa Accounts")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                //RunObject = Page UnknownPage51516206;
            }
        }
    }
}
