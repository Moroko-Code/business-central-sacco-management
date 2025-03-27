#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516494 "CRM Member List"
{
    ApplicationArea = Basic;
    Caption = 'CRM Member List';
    //CardPageID = "Member Account Card";
    InsertAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = Customer;
    SourceTableView = sorting("No.")
                      order(ascending)
                      where("Customer Type" = filter(Member));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                // field("Registration Date"; "Registration Date")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile Phone';
                }
            
                field("Payroll/Staff No"; "Payroll/Staff No")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part("CRM Member Statistics"; "CRM Member Statistics")
            {
                SubPageLink = "No." = field("No.");
                Visible = true;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group(ActionGroup1102755013)
            {
                action("Compose SMS")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loans Guarantee Details";
                    Image = MachineCenter;
                    Visible = false;
                }
                action("Compose E-mail")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    Image = Email;
                    PromotedCategory = Process;
                    RunObject = Page "Loans Guarantee Details";
                    Visible = false;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
    end;

    var
        Cust: Record Customer;
        GeneralSetup: Record "Sacco General Set-Up";
        Gnljnline: Record "Gen. Journal Line";
        TotalRecovered: Decimal;
        TotalAvailable: Integer;
        Loans: Record "Loans Register";
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        TotalDefaulterR: Decimal;
        Value2: Decimal;
        AvailableShares: Decimal;
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        RoundingDiff: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        LoansR: Record "Loans Register";
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";
}
