report 51516024 "Member Accounts List"
{
    ApplicationArea = All;
    Caption = ' Member register report.';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/MemberListReport.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", Status;

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
            }
            column(Status; Status)
            {
            }
            column(Date_of_Birth; "Date of Birth")
            {
            }
            column(Age; Age)
            {
            }
            trigger OnAfterGetRecord();
            var
            begin
                Customer.SetFilter(Customer."Registration Date", Datefilter);
                if (Datefilter <> '') and ("Registration Date" = 0D) THEN
                    CurrReport.Skip();
                EntryNo := EntryNo + 1;
            end;

            trigger OnPreDataItem()
            begin
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
        Datefilter := Customer.GetFilter("Date Filter");
    end;

    var
        EntryNo: Integer;
        Datefilter: Text[100];
        CompanyInfo: Record "Company Information";
}
