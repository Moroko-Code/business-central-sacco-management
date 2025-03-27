pageextension 51516882 CustomerExtension extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Address)
        {
            field("Customer Type"; "Customer Type")
            {
                ApplicationArea = all;
            }
            field("Employer Code"; "Employer Code")
            {
                ApplicationArea = all;
            }
            field("Employer Name"; "Employer Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}