report 51516048 "Total Loans After TopUps"
{
    Caption = 'Total Loans After TopUps';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Total Loans After TopUps.rdlc';
    dataset
    {
        dataitem(LoansRegister; "Loans Register")
        {
            column(LoanNo; "Loan  No.")
            {
            }
            column(Approved_Amount; "Approved Amount")
            {
            }

            trigger OnPreDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            begin
                if LoansRegisterTable.Find(LoansRegister."Loan  No.") then
                    EntriesLoanAmount := 0;
            end;

            trigger OnPostDataItem()
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
        LoansRegister.SetAutoCalcFields(LoansRegister."Outstanding Balance");
        LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>%1', 0);
        EntriesLoanAmount := 0;
    end;

    trigger OnPostReport()
    begin
    end;

    var
        LoansRegisterTable: Record "Loans Register";
        EntriesLoanAmount: Decimal;
}
