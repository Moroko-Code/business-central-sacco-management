#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516875 "Loan Totals Per Employer"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Totals Per Employer.rdlc';

    dataset
    {
        dataitem(Loans; "Loans Register")
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Issued Date";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(BranchCode_Loans; Loans."Branch Code")
            {
            }
            column(EmployerCode_Loans; Loans."Employer Code")
            {
            }
            column(LoanProductType_Loans; Loans."Loan Product Type")
            {
            }
            column(LoanNo_Loans; Loans."Loan  No.")
            {
            }
            column(ApplicationDate_Loans; Loans."Application Date")
            {
            }
            column(ClientCode_Loans; Loans."Client Code")
            {
            }
            column(GroupCode_Loans; Loans."Group Code")
            {
            }
            column(Savings_Loans; Loans.Savings)
            {
            }
            column(Source_Loans; Loans.Source)
            {
            }
            column(ExistingLoan_Loans; Loans."Existing Loan")
            {
            }
            column(RequestedAmount_Loans; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount_Loans; Loans."Approved Amount")
            {
            }
       
            column(OutstandingBalance_Loans; Loans."Outstanding Balance")
            {
            }
            column(IssuedDate_Loans; Loans."Issued Date")
            {
            }
            column(Month; Month)
            {
            }
            column(Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if (Loans."Issued Date" <> 0D) then
                    Month := Date2dmy(Loans."Issued Date", 2)
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(CompanyInfo.Picture);
                Month := 0;
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Month: Integer;
        CompanyInfo: Record "Company Information";
}
