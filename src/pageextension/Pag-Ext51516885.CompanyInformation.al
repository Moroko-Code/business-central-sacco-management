pageextension 51516885 "Company Information" extends "Company Information"
{
    layout
    {
        modify("VAT Registration No.")
        {
            Visible = false;
        }
        addafter(Address)
        {
            field("Company P.I.N"; "Company P.I.N")
            {
                ApplicationArea = all;
                Caption = 'Company Information';
            }
        }
    }
}
