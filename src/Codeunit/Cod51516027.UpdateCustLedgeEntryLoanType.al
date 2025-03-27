codeunit 51516027 "Update CustLedgeEntryLoanType"
{
    trigger OnRun()
    begin
        //FnUpdateLoanProductType();
    end;

    procedure FnUpdateLoanProductType()
    var
        atrecord: Integer;
    begin
        CustLedgeEntry.Reset();
        CustLedgeEntry.SetFilter(CustLedgeEntry."Loan No", '<>%1', ' ');
        CustLedgeEntry.SetFilter(CustLedgeEntry."Loan product Type", '%1', ' ');
        CustLedgeEntry.SetRange(CustLedgeEntry."Posting Date", Today);
        if CustLedgeEntry.Find('-') then
            repeat
                atrecord := atrecord + 1;
                CustLedgeEntry."Loan product Type" := FnGetLoanProductType(CustLedgeEntry."Loan No");
                CustLedgeEntry.Modify();
            until CustLedgeEntry.Next = 0;
    end;

    local procedure FnGetLoanProductType(LoanNo: Code[20]): Code[20]
    var
        LoansRegister: Record "Loans Register";
    begin
        LoansRegister.Reset();
        LoansRegister.SetRange(LoansRegister."Loan  No.", LoanNo);
        LoansRegister.SetRange(LoansRegister.Posted, true);
        if LoansRegister.Find('-') then
            exit(LoansRegister."Loan Product Type");
    end;

    var
        CustLedgeEntry: Record "Cust. Ledger Entry";
}
