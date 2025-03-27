pageextension 51516620 "CustomerLookupExt" extends "Customer Lookup"
{
    layout
    {
        addafter(Name)
        {
            field("ID No."; "ID No.")
            {
            }
      
            field("Mobile Phone No"; "Mobile Phone No")
            {
            }
            field("Account Category"; "Account Category")
            {
            }

            field("Posting Group"; "Customer Posting Group")
            {
            }
    
        }
        modify("Phone No.")
        {
            Visible = false;
        }
        modify(Contact)
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}
