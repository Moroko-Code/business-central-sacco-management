#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516017 "UpdateLoanClassification"
{
    trigger OnRun()
    begin
        //FnUpdateLoanStatus('LN001618');
    end;

    var
        LoansReg: Record "Loans Register";
        PrPaid: Decimal;
        PrExp: Decimal;
        outInt: Decimal;
        Variance: Decimal;
        LoansSchedule: Record "Loan Repayment Schedule";
        ExpectedPaymentsToDate: Decimal;
        AmountInArrears: Decimal;
        NoOfMonthsInArrears: Decimal;

    procedure FnUpdateLoanStatus(LoanNo: Code[50])//As at today
    begin
        LoansReg.Reset;
        LoansReg.SetRange(LoansReg."Loan  No.", LoanNo);
        if LoansReg.Find('-') then begin
            if LoansReg.Repayment < 0 then
                LoansReg.Validate("Approved Amount");
            LoansReg.CalcFields(LoansReg."Outstanding Balance", LoansReg."Schedule Repayments");
            if LoansReg."Outstanding Balance" > 0 then begin
                ExpectedPaymentsToDate := 0;
                PrPaid := 0;
                PrExp := 0;
                outInt := 0;
                LoansSchedule.Reset;
                LoansSchedule.SetRange(LoansSchedule."Loan No.", LoanNo);
                LoansSchedule.SetFilter(LoansSchedule."Repayment Date", '%1..%2', 0D, Today);
                if LoansSchedule.Find('-') then
                    repeat
                        ExpectedPaymentsToDate += LoansSchedule."Monthly Repayment";
                    until LoansSchedule.Next = 0;
                Variance := (LoansReg."Outstanding Balance") - (LoansReg."Approved Amount" - ExpectedPaymentsToDate);
            end;
            //--------------------------------------------------------------------Variance=No of Months In Arrears
            if Variance < 0 then
                Variance := 0;
            if LoansReg.Repayment > 0 then begin
                NoOfMonthsInArrears := 0;
                NoOfMonthsInArrears := ROUND(Variance / LoansReg.Repayment, 1, '<');
            end else
                if LoansReg.Repayment <= 0 then begin
                    NoOfMonthsInArrears := 0;
                    NoOfMonthsInArrears := ROUND(Variance / 12, 1, '<');
                end;
            AmountInArrears := 0;

            AmountInArrears := Variance;
            //---------------------------------------------------------------------
            case NoOfMonthsInArrears of
                0:
                    begin
                        LoansReg."Loans Category-SASRA" := LoansReg."loans category-sasra"::Perfoming;
                        LoansReg."No of Months in Arrears" := NoOfMonthsInArrears;
                        LoansReg."Amount in Arrears" := AmountInArrears;
                        LoansReg.Modify;
                    end;
                1:
                    begin
                        LoansReg."Loans Category-SASRA" := LoansReg."loans category-sasra"::Watch;
                        LoansReg."No of Months in Arrears" := NoOfMonthsInArrears;
                        LoansReg."Amount in Arrears" := AmountInArrears;
                        LoansReg.Modify;
                    end;
                2, 3, 4, 5, 6:
                    begin
                        LoansReg."Loans Category-SASRA" := LoansReg."loans category-sasra"::Substandard;
                        LoansReg."No of Months in Arrears" := NoOfMonthsInArrears;
                        LoansReg."Amount in Arrears" := AmountInArrears;
                        LoansReg.Modify;
                    end;
                7, 8, 9, 10, 11, 12:
                    begin
                        LoansReg."Loans Category-SASRA" := LoansReg."loans category-sasra"::Doubtful;
                        LoansReg."No of Months in Arrears" := NoOfMonthsInArrears;
                        LoansReg."Amount in Arrears" := AmountInArrears;
                        LoansReg.Modify;
                    end
                else begin
                    LoansReg."Loans Category-SASRA" := LoansReg."loans category-sasra"::Loss;
                    LoansReg."No of Months in Arrears" := NoOfMonthsInArrears;
                    LoansReg."Amount in Arrears" := AmountInArrears;
                    LoansReg.Modify;
                end;
            end;
        end;
        //--------------------------------------------------------------------
    end;

    procedure FnCheckPreviousLoanStatus(LoanNo: Code[50]; AsAt: text[100]): text[100]//without updating records
    begin
        LoansReg.Reset;
        LoansReg.SetRange(LoansReg."Loan  No.", LoanNo);
        if LoansReg.Find('-') then begin
            if LoansReg.Repayment < 0 then
                LoansReg.Validate("Approved Amount");
            LoansReg.SetFilter(LoansReg."Date filter", AsAt);
            LoansReg.CalcFields(LoansReg."Outstanding Balance", LoansReg."Schedule Repayments");
            if LoansReg."Outstanding Balance"  > 0 then begin
                ExpectedPaymentsToDate := 0;
                PrPaid := 0;
                PrExp := 0;
                outInt := 0;
                LoansSchedule.Reset;
                LoansSchedule.SetRange(LoansSchedule."Loan No.", LoanNo);
                LoansSchedule.SetFilter(LoansSchedule."Repayment Date", AsAt);
                if LoansSchedule.Find('-') then
                    repeat
                        ExpectedPaymentsToDate += LoansSchedule."Monthly Repayment";
                    until LoansSchedule.Next = 0;
                Variance := (LoansReg."Outstanding Balance") - (LoansReg."Approved Amount" - ExpectedPaymentsToDate);
            end;
            //--------------------------------------------------------------------Variance=No of Months In Arrears
            if Variance < 0 then
                Variance := 0;
            if LoansReg.Repayment > 0 then begin
                NoOfMonthsInArrears := 0;
                NoOfMonthsInArrears := ROUND(Variance / LoansReg.Repayment, 1, '<');
            end else
                if LoansReg.Repayment <= 0 then begin
                    NoOfMonthsInArrears := 0;
                    NoOfMonthsInArrears := ROUND(Variance / 12, 1, '<');
                end;
            AmountInArrears := 0;

            AmountInArrears := Variance;
            //---------------------------------------------------------------------
            case NoOfMonthsInArrears of
                0:

                    Exit('Performing');
                1:

                    Exit('Watch');
                2, 3, 4, 5, 6:

                    Exit('Substandard');
                7, 8, 9, 10, 11, 12:

                    Exit('Doubtful');
                else
                    Exit('Loss');
            end;
        end;
        //--------------------------------------------------------------------
    end;
}
