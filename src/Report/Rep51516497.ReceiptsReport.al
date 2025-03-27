#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516497 "Receipts Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ReceiptsReport.rdlc';

    dataset
    {
        dataitem(Receipts; "Receipts & Payments")
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Transaction Date";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(TransactionNo_Receipts; Receipts."Transaction No.")
            {
            }
            column(AccountNo_Receipts; Receipts."Account No.")
            {
            }
            column(Name_Receipts; Receipts.Name)
            {
            }
            column(Amount_Receipts; Receipts.Amount)
            {
            }
            column(ChequeNo_Receipts; Receipts."Cheque No.")
            {
            }
            column(ChequeDate_Receipts; Receipts."Cheque Date")
            {
            }
            column(Posted_Receipts; Receipts.Posted)
            {
            }
            column(TransactionDate_Receipts; Receipts."Transaction Date")
            {
            }
            dataitem(Allocations; "Receipt Allocation")
            {
                DataItemLink = "Document No" = field("Transaction No.");
                RequestFilterFields = "Transaction Type";
                column(ReportForNavId_1000000009; 1000000009)
                {
                }
                column(DocumentNo_Allocations; Allocations."Document No")
                {
                }
                column(TransactionType_Allocations; Allocations."Transaction Type")
                {
                }
                column(LoanNo_Allocations; Allocations."Loan No.")
                {
                }
                column(Amount_Allocations; Allocations.Amount)
                {
                }
                column(InterestAmount_Allocations; Allocations."Interest Amount")
                {
                }
            }
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
}
