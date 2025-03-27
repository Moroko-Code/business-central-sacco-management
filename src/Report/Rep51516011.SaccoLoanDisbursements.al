report 51516011 "Sacco Loan Disbursements"
{
    Caption = 'Loan Disbursements Report';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Sacco Loan Disbursements.rdl';
    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Loan  No.", "Loan Product Type", "Branch Code", "Date filter";
            column(Loan__No_; "Loan  No.")
            {
            }
            column(Client_Code; "Client Code")
            {
            }
            column(Client_Name; "Client Name")
            {
            }
            column(Approved_Amount; "Approved Amount")
            {
            }
            column(Outstanding_Balance; "Outstanding Balance")
            {
            }
            column(Loan_Product_Type; "Loan Product Type")
            {
            }
            column(Loan_Disbursement_Date; "Loan Disbursement Date")
            {
            }
            column(Recovery_Mode; "Recovery Mode")
            {
            }
            column(Installments; Installments)
            {
            }
            column(Expected_Date_of_Completion; "Expected Date of Completion")
            {
            }
            column(EntyNo; EntyNo)
            {
            }
            trigger OnPreDataItem()
            begin
                "Loans Register".SetFilter("Loans Register"."Loan Disbursement Date", DateFilter);
            end;

            trigger OnAfterGetRecord()
            begin
                LoansTable.Reset();
                LoansTable.SetRange(LoansTable."Loan  No.", "Loans Register"."Loan  No.");
                if LoansTable.Find('-') then
                    repeat
                        EntyNo := EntyNo + 1;
                    until LoansTable.Next = 0;
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
        DateFilter := "Loans Register".GetFilter("Loans Register"."Date filter");
        if DateFilter = '' then
            DateFilter := '..' + Format(Today);
        EntyNo := 0;
    end;

    trigger OnPostReport()
    begin
    end;

    var
        DateFilter: Text;
        LoansTable: Record "Loans Register";
        EntyNo: Integer;
}
