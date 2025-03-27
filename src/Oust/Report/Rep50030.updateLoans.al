report 50030 updateLoans
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            column(Loan__No_; "Loan  No.")
            {
            }
            trigger OnAfterGetRecord()
            var
                Loans: Record "Loans Register";
                cust: Record Customer;
                LoanRepayment: Record "Loan Repayment Schedule";
                SFactory: Codeunit "SURESTEP Factory";
            begin
                // Loans.Reset();
                // Loans.SetRange(Loans."Client Code", Cust."No.");
                // If cust.get("Client Code") then begin
                //     "Client Name" := Cust.Name;
                //     "Loans Register".Modify(true);
                // end;
                Loans.Reset();
                Loans.SetRange(Loans."Loan  No.", "Loan  No.");
                if Loans.FindSet() then begin

                    SFactory.FnGenerateRepaymentSchedule(Loans."Loan  No.");

                    LoanRepayment.Reset();
                    LoanRepayment.SetRange("Loan No.", Loans."Loan  No.");
                    if LoanRepayment.FindFirst() then begin
                        Loans.Repayment := Round(LoanRepayment."Monthly Repayment", 1, '>');
                        Loans."Loan Principle Repayment" := LoanRepayment."Principal Repayment";
                        Loans."Loan Interest Repayment" := LoanRepayment."Monthly Interest";
                        Loans.Modify();
                    end;
                    //Loans.Repayment := Loans."Loan Principle Repayment" + "Loan Interest Repayment";
                    // if "Loan Disbursement Date" <> 0D then begin
                    //     if Date2dmy("Loan Disbursement Date", 1) <= 10 then
                    //         Loans."Repayment Start Date" := CalcDate('CM', "Loan Disbursement Date")
                    //     else
                    //         Loans."Repayment Start Date" := CalcDate('CM', CalcDate('CM+1M', "Loan Disbursement Date"));
                    //     Loans."Expected Date of Completion" := CalcDate('CM', CalcDate('CM+' + Format(Loans.Installments) + 'M', Loans."Loan Disbursement Date"));
                    // end;
                    Loans.Modify();
                end;
            end;
        }
    }
}