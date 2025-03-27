codeunit 51516056 "Send Loan Notifications"
{
    trigger OnRun()
    begin
    end;

    

    local procedure FnNextLoanRepaymentDate(LoanNo: Code[30]; NextLoanRepaymentDay: Date): Boolean
    var
        LoansRepaymentSchedule: record "Loan Repayment Schedule";
    begin
        LoansRepaymentSchedule.Reset();
        LoansRepaymentSchedule.SetRange(LoansRepaymentSchedule."Loan No.", LoanNo);
        LoansRepaymentSchedule.SetRange(LoansRepaymentSchedule."Repayment Date", NextLoanRepaymentDay);
        if LoansRepaymentSchedule.Find('-') then
            exit(true);
        exit(false);
    end;

    local procedure FnGetMobileNo(FOSAAccount: Code[100]): Text
    var
        VendorTable: Record Vendor;
    begin
        VendorTable.Reset();
        VendorTable.SetRange(VendorTable."No.", FOSAAccount);
        if VendorTable.Find('-') then
            exit(VendorTable."Phone No.");
    end;
}
