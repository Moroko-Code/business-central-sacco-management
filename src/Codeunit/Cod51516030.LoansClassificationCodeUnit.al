Codeunit 51516030 "LoansClassificationCodeUnit"
{
    trigger OnRun()
    begin
        //FnClassifyLoan
    end;

    var
        LoansReg: Record "Loans Register";
        RepaymentSchedule: Record "Loan Repayment Schedule";
        MemberLedgerEntry: Record "Cust. Ledger Entry";
        LoanBalAsAtFilterDate: Decimal;
        ScheduleExpectedLoanBal: Decimal;
        ArreasPresent: Decimal;
        LoansRegTablw: Record "Loans Register";
        RepaymentScheduleAmount: Decimal;

    procedure FnClassifyLoan(LoanNo: Code[30]; AsAt: Date)

    begin
        //..................Check if Loan expected date of completion is attained,if yes loan is loss
        if IsLoanSupposedToBeCompleted(LoanNo, AsAt) = true then begin
            //Mark LoaN As A Loss
            LoansRegTablw.Reset;
            LoansRegTablw.SetAutocalcFields(LoansRegTablw."Outstanding Balance");
            LoansRegTablw.SetRange(LoansRegTablw."Loan  No.", LoanNo);
            if LoansRegTablw.Find('-') then begin
                if LoansRegTablw."Outstanding Balance" > 0 then begin
                    //--Function to Get Days In Arrears and modify;
                    LoansRegTablw."Amount in Arrears" := LoansRegTablw."Outstanding Balance";
                    LoansRegTablw."No of Months in Arrears" := ROUND(LoansRegTablw."Amount in Arrears" / LoansRegTablw."Loan Principle Repayment", 1, '=');
                    LoansRegTablw."Loans Category-SASRA" := LoansRegTablw."Loans Category-SASRA"::Loss;
                end else
                    if LoansRegTablw."Outstanding Balance" <= 0 then begin
                        LoansRegTablw."Amount in Arrears" := 0;
                        LoansRegTablw."No of Months in Arrears" := 0;
                        LoansRegTablw."Loans Category-SASRA" := LoansRegTablw."Loans Category-SASRA"::Perfoming;
                        //LoansRegTablw."Loans Category-SASRA" := LoansRegTablw."loans category-sasra"::Perfoming;
                    end;
                LoansRegTablw.Modify(true);
            end;
        end
        else
            if IsLoanSupposedToBeCompleted(LoanNo, AsAt) = false then begin
                //Check member ledger entry to know loan balance as at that date was how much
                // If
                // LoanBalAsAtFilterDate := 0;
                LoanBalAsAtFilterDate := GetLoanBalAsAtFilterDate(LoanNo, AsAt);
                //Check repayment schedule to know the expected balance
                ScheduleExpectedLoanBal := 0;
                ScheduleExpectedLoanBal := GetExpectedBalAsPerSchedule(LoanNo, AsAt);
                //Determine if any areas
                ArreasPresent := 0;
                if LoanBalAsAtFilterDate > ScheduleExpectedLoanBal then
                    ArreasPresent := LoanBalAsAtFilterDate - ScheduleExpectedLoanBal
                else
                    if (LoanBalAsAtFilterDate <= ScheduleExpectedLoanBal) then
                        ArreasPresent := 0;
                //MESSAGE('The loan balance is '+FORMAT(LoanBalAsAtFilterDate)+' the expected balance is '+FORMAT(ScheduleExpectedLoanBal));
                //if there are areas then,,determine the days in areas
                if ArreasPresent > 0 then
                    //--Function to Get Days In Arrears and modify;
                    FnUpdateLoanStatusWithArrears(LoanNo, ArreasPresent, AsAt)
                else
                    if ArreasPresent <= 0 then
                        FnUpdateLoanStatusNonArrears(LoanNo);
            end;
        //Classify
    end;

    local procedure GetLoanBalAsAtFilterDate(LoanNos: Code[30]; FilterDate: Date): Decimal
    var
        TotalPayments: Decimal;
    begin
        TotalPayments := 0;
        MemberLedgerEntry.Reset;
        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '%1|%2', MemberLedgerEntry."transaction type"::Loan, MemberLedgerEntry."transaction type"::Repayment);
        MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", LoanNos);
        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Posting Date", '%1..%2', 0D, FilterDate);
        MemberLedgerEntry.SetRange(MemberLedgerEntry.Reversed, false);
        if MemberLedgerEntry.Find('-') then
            repeat
                TotalPayments += MemberLedgerEntry."Amount Posted";
            until MemberLedgerEntry.Next = 0;
        exit(TotalPayments);
    end;

    local procedure GetExpectedBalAsPerSchedule(LoanNos: Code[20]; DateFiltering: Date): Decimal
    var
        ScheduleExpectedBal: Decimal;
        ActualDate: Date;
        DateFormula: Text;
        i: Integer;
        TotalPrincipalRepayment: Decimal;
        LoanBalance: Decimal;
    begin
        ScheduleExpectedBal := 0;
        DateFormula := '<-1M>';
        ActualDate := CalcDate(DateFormula, DateFiltering);
        RepaymentSchedule.Reset;
        RepaymentSchedule.SetRange(RepaymentSchedule."Loan No.", LoanNos);
        RepaymentSchedule.SetFilter(RepaymentSchedule."Repayment Date", '%1..%2', 0D, DateFiltering);
        if RepaymentSchedule.FindLast then
            repeat
                i := i + 1;
                TotalPrincipalRepayment := ROUND(TotalPrincipalRepayment + RepaymentSchedule."Principal Repayment");
                if i = 1 then
                    LoanBalance := (RepaymentSchedule."Loan Amount")
                else
                    LoanBalance := (RepaymentSchedule."Loan Amount" - TotalPrincipalRepayment +
                    RepaymentSchedule."Principal Repayment");
                ScheduleExpectedBal := LoanBalance;
                ScheduleExpectedBal := ROUND(RepaymentSchedule."Loan Balance");
            until RepaymentSchedule.Next = 0;
        exit(ScheduleExpectedBal);
    end;

    local procedure FnUpdateLoanStatusNonArrears(LoanNo: Code[30])
    begin
        LoansReg.Reset;
        LoansReg.SetRange(LoansReg."Loan  No.", LoanNo);
        if LoansReg.Find('-') then begin
            LoansReg."Amount in Arrears" := 0;
            LoansReg."No of Months in Arrears" := 0;
            LoansReg."Loans Category-SASRA" := LoansReg."loans category-sasra"::Perfoming;
            LoansReg."Loans Category-SASRA" := LoansReg."Loans Category-SASRA"::Perfoming;
            LoansReg.Modify(true);
        end;
    end;

    local procedure FnUpdateLoanStatusWithArrears(LoanNo: Code[30]; AmountInArearsPassed: Decimal; Datefilter: Date)
    begin
        LoansReg.Reset;
        LoansReg.SetRange(LoansReg."Loan  No.", LoanNo);
        if LoansReg.Find('-') then begin
            if LoansReg."Repayment Start Date" >= Datefilter then
                LoansReg."Amount in Arrears" := 0
            else
                LoansReg."Amount in Arrears" := AmountInArearsPassed;
            RepaymentScheduleAmount := 0;
            RepaymentScheduleAmount := GetRepayment(LoanNo, Datefilter);
            if RepaymentScheduleAmount <= 0 then
                RepaymentScheduleAmount := LoansReg."Loan Principle Repayment";
            //..................................................................................Repayment
            IF LoansRegTablw.Installments = 0 THEN
                LoansRegTablw.Installments := 12;
            LoansReg."No of Months in Arrears" := ROUND(LoansReg."Amount in Arrears" / RepaymentScheduleAmount, 1, '=');
            if LoansReg."No of Months in Arrears" = 0 then
                LoansReg."Loans Category-SASRA" := LoansReg."Loans Category-SASRA"::Perfoming
            // LoansReg."Loans Category-SASRA" := LoansReg."loans category-sasra"::Perfoming;
            else
                if (LoansReg."No of Months in Arrears" > 0) and (LoansReg."No of Months in Arrears" <= 1) then
                    // LoansReg."Loans Category-SASRA" := LoansReg."Loans Category-SASRA"::Watch;
                    LoansReg."Loans Category-SASRA" := LoansReg."loans category-sasra"::Watch
                else
                    if (LoansReg."No of Months in Arrears" > 1) and (LoansReg."No of Months in Arrears" <= 6) then
                        // LoansReg."Loans Category-SASRA" := LoansReg."Loans Category-SASRA"::Substandard;
                        LoansReg."Loans Category-SASRA" := LoansReg."loans category-sasra"::Substandard
                    else
                        if (LoansReg."No of Months in Arrears" > 6) and (LoansReg."No of Months in Arrears" <= 12) then
                            // LoansReg."Loans Category-SASRA" := LoansReg."Loans Category-SASRA"::Doubtful;
                            LoansReg."Loans Category-SASRA" := LoansReg."loans category-sasra"::Doubtful
                        else
                            if (LoansReg."No of Months in Arrears" > 12) then
                                // LoansReg."Loans Category-SASRA" := LoansReg."Loans Category-SASRA"::Loss;
                                LoansReg."Loans Category-SASRA" := LoansReg."loans category-sasra"::Loss;
            LoansReg.Modify(true);
        end;
    end;

    local procedure GetRepayment(LoanNos: Code[20]; DateFiltering: Date): Decimal
    var
        RepaymentAmount: Decimal;
        ActualDate: Date;
        DateFormula: Text;
    begin
        RepaymentAmount := 0;
        DateFormula := '<-1M>';
        ActualDate := CalcDate(DateFormula, DateFiltering);
        RepaymentSchedule.Reset;
        RepaymentSchedule.SetRange(RepaymentSchedule."Loan No.", LoanNos);
        RepaymentSchedule.SetFilter(RepaymentSchedule."Repayment Date", '%1..%2', 0D, DateFiltering);
        if RepaymentSchedule.FindLast then
            repeat
                RepaymentAmount := ROUND(RepaymentSchedule."Principal Repayment");
            until RepaymentSchedule.Next = 0;
        exit(RepaymentAmount);
    end;

    local procedure IsLoanSupposedToBeCompleted(LoanNoss: Code[20]; datefilter: Date): Boolean
    begin
        LoansReg.Reset;
        LoansReg.SetRange(LoansReg."Loan  No.", LoanNoss);
        if LoansReg.Find('-') then
            if LoansReg."Expected Date of Completion" < datefilter then
                exit(true)
            else
                if LoansReg."Expected Date of Completion" >= datefilter then
                    exit(false);
    end;
}
