report 51516051 MembershipApplicationReport
{
    ApplicationArea = All;
    Caption = 'Member application report.';
    RDLCLayout = './Layout/MembershipApplicationReport.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Membership Applications"; "Membership Applications")
        {
            DataItemTableView = sorting("No.") order(descending);
            RequestFilterFields = Status;
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
            column(No; "No.") { }
            column(Name; Name) { }
            column(ID_No_; "ID No.") { }
            column(EntryNo; EntryNo) { }
            column(Phone_No_; "Phone No.") { }

            trigger OnAfterGetRecord();
            var
            begin

                ;
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
    // trigger OnPreReport()
    // begin
    //     CompanyInfo.Get();
    //     Datefilter := Customer.GetFilter("Date Filter");
    // end;

    var
        CompanyInfo: Record "Company Information";
        EntryNo: Integer;
}
