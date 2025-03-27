report 51516036 "New Member Accounts"
{
    ApplicationArea = All;
    Caption = 'New Member Accounts';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/NewMemberAccounts.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Registration Date", "No.", "Global Dimension 2 Code";
            column(EntryNo; EntryNo)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPic; CompanyInfo.Picture)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(No_; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Employer_Code; "Employer Code")
            {
            }
            column(Employer_Name; "Employer Name")
            {
            }
            column(Account_Category; "Account Category")
            {
            }
            column(Account_Type; "Account Type")
            {
            }
            column(ID_No_; "ID No.")
            {
            }
            column(Mobile_Phone_No; "Mobile Phone No")
            {
            }
            column(Gender; Gender)
            {
            }
            column(Registration_Date; "Registration Date")
            {
            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {
                Caption = 'Branch';
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
                Caption = 'Activity';
            }
            column(RegisteredBy; RegisteredBy)
            {
            }
            column(Status; Status)
            {
            }
            column(Date_of_Birth; "Date of Birth")
            {
            }

            trigger OnAfterGetRecord();
            begin
                EntryNo := EntryNo + 1;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnInitReport()
    begin
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
    end;

    var
        EntryNo: Integer;
        CompanyInfo: Record "Company Information";
        RegisteredBy: Code[100];
}
