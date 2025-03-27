#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516278 "Bosa Paybill Lines"
{
    PageType = ListPart;
    SourceTable = "Paybill Processing Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receipt Line No"; "Receipt Line No")
                {
                    ApplicationArea = Basic;
                }
                field("Trans Type"; "Trans Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Staff/Payroll No"; "Staff/Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; "Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Staff Not Found"; "Staff Not Found")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Member Found"; "Member Found")
                {
                    ApplicationArea = Basic;
                }
                field("Search Index"; "Search Index")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
         
            }
        }
    }

    actions
    {
    }
}
