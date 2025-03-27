page 51796 "Payroll Bank Details"
{
    DeleteAllowed = true;
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Bank deatails";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; "Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Branch Name"; "Branch Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No"; "Bank Account No")
                {
                    ApplicationArea = All;
                }
                field("Bank Location"; "Bank Location")
                {
                    ApplicationArea = All;
                }
                field("Payroll Period"; "Payroll Period")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
