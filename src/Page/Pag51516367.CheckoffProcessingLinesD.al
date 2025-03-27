#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516367 "Checkoff Processing Lines-D"
{
    PageType = ListPart;
    SourceTable = "Checkoff Lines-Distributed";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receipt Header No"; "Receipt Header No")
                {
                    ApplicationArea = Basic;
                }
                field("Staff/Payroll No"; "Staff/Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; "Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("Loan No."; "Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type"; "Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Amount"; "Expected Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Balance"; "Loan Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Not Found"; "Staff Not Found")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Entry No"; "Entry No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Multiple Receipts"; "Multiple Receipts")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Account type"; "Account type")
                {
                    ApplicationArea = Basic;
                }
                field(Reference; Reference)
                {
                    ApplicationArea = Basic;
                }
                field(Variance; Variance)
                {
                    ApplicationArea = Basic;
                }
                field("Loans Not found"; "Loans Not found")
                {
                    ApplicationArea = Basic;
                }
                field("Date Filter"; "Date Filter")
                {
                    ApplicationArea = Basic;
                }
                field("No Repayment"; "No Repayment")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}
