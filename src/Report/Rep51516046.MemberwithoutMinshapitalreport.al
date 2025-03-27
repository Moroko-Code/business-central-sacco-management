report 51516046 "MemberwithoutMinshapitalreport"
{
    ApplicationArea = All;
    Caption = 'Members without minimum share capital report.';
    RDLCLayout = './Layout/MemberwithoutMinshapitalreport.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.") order(descending);
            RequestFilterFields = "No.", "Date Filter";
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
            column(Sharecapital; Sharecapital) { }
            trigger OnPreDataItem()
            begin
                Sharecapital := 0;
            end;

            trigger OnAfterGetRecord();
            var
            begin
                Cust.SetFilter(Cust."Date Filter", Datefilter);
                if cust.get(Customer."No.") then begin
                    cust.SetAutoCalcFields(Cust."Share Capital");
                    Sharecapital := cust."Share Capital";
                end;
                Gensetup.Get();
                // SetAutoCalcFields("Share Capital");
                // Sharecapital := "Current Shares";
                If Sharecapital > Gensetup."Retained Shares" then
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
        Sharecapital: Decimal;
        Datefilter: Text[100];
        Cust: Record Customer;
        Gensetup: Record "Sacco General Set-Up";
}
