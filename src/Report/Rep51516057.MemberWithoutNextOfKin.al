report 51516057 "MemberWithoutNextOfKin"
{
    ApplicationArea = All;
    Caption = 'Members without Next report.';
    RDLCLayout = './Layout/MemberWithoutNextOfKin.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.") order(descending);

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
                EntryNo := EntryNo + 1;
                NextOfKin.Reset();
                NextOfKin.SetRange(NextOfKin."Account No", "No.");
                if NextOfKin.Find('-') then
                    if NextOfKin.IsEmpty = false then
                        CurrReport.Skip();
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
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        Datefilter := Customer.GetFilter("Date Filter");
    end;

    var
        CompanyInfo: Record "Company Information";
        EntryNo: Integer;
        Datefilter: Text[100];
        NextOfKin: Record "Accounts Next Of Kin Details";
}
