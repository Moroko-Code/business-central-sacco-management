page 51516099 "Member Applications -Closed"
{
    ApplicationArea = Basic;
    CardPageID = "Membership Application Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";
    SourceTableView = where(Status = const(Closed));
    UsageCategory = Lists;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }

                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Centre"; "Responsibility Centre")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll/Staff No"; "Payroll/Staff No")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No.";"Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Category")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
    }

    trigger OnOpenPage()
    begin
        if UserId <> 'MMHSACCO\ADMINISTRATOR' then
            SetRange("User ID", UserId);
    end;
}
