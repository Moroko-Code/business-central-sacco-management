page 50324 "Payroll Employee Assignments."
{
    // version Payroll ManagementV1.0(Surestep Systems)

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Payroll Employee.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Full Name"; "Full Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pays PAYE"; "Pays PAYE")
                {
                    ApplicationArea = All;
                }
                field("Pays NSSF"; "Pays NSSF")
                {
                    ApplicationArea = All;
                }
                field("Pays NHIF"; "Pays NHIF")
                {
                    ApplicationArea = All;
                }
                field(Secondary; Secondary)
                {
                    ApplicationArea = All;
                }
            }
            group(Numbers)
            {
                field("National ID No"; "National ID No")
                {
                    ApplicationArea = All;
                }
                field("PIN No"; "PIN No")
                {
                    ApplicationArea = All;
                }
                field("NHIF No"; "NHIF No")
                {
                    ApplicationArea = All;
                }
                field("NSSF No"; "NSSF No")
                {
                    ApplicationArea = All;
                }
            }
            group("PAYE Relief and Benefit")
            {
                field(GetsPayeRelief; GetsPayeRelief)
                {
                    ApplicationArea = All;
                }
                field(GetsPayeBenefit; GetsPayeBenefit)
                {
                    ApplicationArea = All;
                }
                field(PayeBenefitPercent; PayeBenefitPercent)
                {
                    ApplicationArea = All;
                }
            }
            group("Employee Company")
            {
                field(Company; Company)
                {
                    ApplicationArea = All;
                    OptionCaption = '';
                }
            }
        }
    }

    actions
    {
    }
}
