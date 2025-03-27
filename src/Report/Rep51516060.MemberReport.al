report 51516060 MemberReport
{
    ApplicationArea = All;
    Caption = 'Member Report';
    RDLCLayout = './Layout/MemberReport.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.") order(descending);
            RequestFilterFields = "No.", "Date Filter", Status;
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
            column(Monthly_Contribution; "Monthly Contribution") { }
            column(Deposits; Deposits) { }
            column(ShareCapital; ShareCapital) { }
            column(LoanBalance; LoanBalance) { }
            trigger OnPreDataItem()
            begin
                Deposits := 0;
            end;

            trigger OnAfterGetRecord();
            var
            begin
                Cust.SetFilter(Cust."Date Filter", Datefilter);
                if cust.get(Customer."No.") then begin
                    cust.SetAutoCalcFields(Cust."Current Shares");
                    Deposits := cust."Current Shares";
                    ShareCapital := Cust."Share Capital";
                    LoanBalance := Cust."Outstanding Balance";
                end;
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
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        Datefilter := Customer.GetFilter("Date Filter");
    end;

    var
        CompanyInfo: Record "Company Information";
        EntryNo: Integer;
        LoanBalance: Decimal;
        ShareCapital: Decimal;
        Deposits: Decimal;
        Datefilter: Text[100];
        Cust: Record Customer;
}
