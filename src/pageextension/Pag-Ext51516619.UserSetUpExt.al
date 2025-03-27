pageextension 51516619 "UserSetUpExt" extends "User Setup"
{
    layout
    {
        addafter("Allow Posting To")
        {
            field("Financial User"; "Financial User")
            {
            }
            field("Payroll User"; "Payroll User")
            {
            }
            field("View Cashier Report"; "View Cashier Report")
            {
            }
            field("Reversal Right"; "Reversal Right")
            {
            }
            field("User Can Process Dividends"; "User Can Process Dividends")
            {
            }
            field("Exempt OTP On LogIn"; "Exempt OTP On LogIn")
            {
            }
            field("Post Leave Days Allocations"; "Post Leave Days Allocations")
            {
            }
            field(Branch; Branch)
            {
            }
            field(Activity; Activity)
            {
            }
            field("Exempt Posting Date Update"; "Exempt Posting Date Update")
            {
            }
            field("Exempt Logs"; "Exempt Logs")
            {
            }
            field("Can POST Loans"; "Can POST Loans")
            {
                ApplicationArea = all;
            }
        }
        modify("Allow Deferral Posting From")
        {
            Visible = false;
        }
        modify("Allow Deferral Posting To")
        {
            Visible = false;
        }
        modify("Salespers./Purch. Code")
        {
            Visible = false;
        }
        modify("Sales Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify("Purchase Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify("Service Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify("Time Sheet Admin.")
        {
            Visible = false;
        }
    }

    actions
    {
    }
}
