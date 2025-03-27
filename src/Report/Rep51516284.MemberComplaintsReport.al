report 51516284 MemberComplaintsReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Layouts/MemberComplaintsReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Member FeedBack"; "Member FeedBack")

        {
            DataItemTableView = sorting(INCCode) where("Type of Feed Back" = filter("Member Feedback and Satisfaction Report"));
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
            column(Name; Name) { }
            column(Customer_FeedBack; "Customer FeedBack") { }
            column(EntryNo; EntryNo) { }
            trigger OnAfterGetRecord()
            begin
                EntryNo := 0;
                EntryNo := EntryNo + 1;
            end;
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.get;
    end;

    var
        EntryNo: Integer;
        CompanyInfo: Record "Company Information";
}