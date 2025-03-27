report 51516035 "Loans Register Report"
{
    ApplicationArea = All;
    Caption = 'Loans Register Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/LoansRegisterReport.rdlc';
    dataset
    {
        dataitem(LoansRegister; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") order(ascending) where(Posted = const(true));
            RequestFilterFields = "Loan Product Type", "Client Code";
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
            column(ClientCode; "Client Code")
            {
            }
            column(ClientName; "Client Name")
            {
            }
            column(LoanNo; "Loan  No.")
            {
            }
            column(LoanDisbursementDate; "Loan Disbursement Date")
            {
            }
            column(LoanDisbursedAmount; "Loan Disbursed Amount")
            {
            }
            column(LoanProductType; "Loan Product Type")
            {
            }
            column(LoanProductTypeName; "Loan Product Type Name")
            {
            }
            column(LoansCategorySASRA; "Loans Category-SASRA")
            {
            }
            column(Outstanding_Balance; "Outstanding Balance")
            {
            }
           
            column(IssuedDate; "Issued Date")
            {
            }
            column(Installments; Installments)
            {
            }
            trigger OnAfterGetRecord();
            begin
                EntryNo := EntryNo + 1;
                //.........................Calc fields

                //....................................
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
}
