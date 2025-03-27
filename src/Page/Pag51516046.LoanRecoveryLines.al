page 51516046 "Loan Recovery Lines"
{
    ApplicationArea = All;
    Caption = 'Loan Recovery Lines';
    PageType = List;
    SourceTable = "Loan Recovery List";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Source; Rec.Source)
                {
                }
                field("Member No"; Rec."Member No")
                {
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                }
                field("Loan No."; Rec."Loan No.")
                {
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    Editable = false;
                }
                field("Total Amount To Recover"; "Total Amount To Recover")
                {
                    Style = Strong;
                    trigger OnValidate()
                    begin
                        ABC := 0;
                        ABC := "Total Amount To Recover";
                        if "Total Amount To Recover" < 0 then
                            error('Amount recovered cannot be less than zero')
                        else
                            if "Total Amount To Recover" = 0 then begin
                                "Principal Amount To Recover" := 0;
                                "Interest Amount To Recover" := 0;
                            end else
                                if "Total Amount To Recover" > 0 then begin
                                    loansreg.Reset();
                                    loansreg.SetRange(loansreg."Loan  No.", "Loan No.");
                                    loansreg.SetAutoCalcFields(loansreg."Outstanding Balance");
                                    if loansreg.Find('-') then
                                        if ABC > 0 then
                                            IF loansreg."Outstanding Balance" > 0 THEN
                                                if ABC > loansreg."Outstanding Balance" then
                                                    "Principal Amount To Recover" := loansreg."Outstanding Balance"
                                                else
                                                    if ABC <= loansreg."Outstanding Balance" then
                                                        "Principal Amount To Recover" := ABC;
                                    ABC := ABC - "Principal Amount To Recover";
                                    If ABC > 0 then
                                        Error('Your recovery amount of Ksh. ' + Format("Total Amount To Recover") + 'is greater than the total loan balance of Ksh. ' + Format("Outstanding Balance" + "Outstanding Interest"));
                                end else
                                    if (loansreg."Loan Product Type" = 'OVERDRAFT') OR (loansreg."Loan Product Type" = 'OKOA') then
                                        FnRecoverOVOKOALoans();
                    end;

                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    Editable = false;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    Editable = false;
                }
                field("Amount In Arrears"; Rec."Amount In Arrears")
                {
                    Editable = false;
                }
                field("Principal To Recover"; "Principal Amount To Recover")
                {
                    Style = StandardAccent;
                }
                field("Interest To Recover"; "Interest Amount To Recover")
                {
                    Style = StandardAccent;
                }
                field("Approved Loan Amount"; Rec."Approved Loan Amount")
                {
                    Editable = false;
                }
                field("Loan Instalments"; Rec."Loan Instalments")
                {
                    Editable = false;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    Editable = false;
                }
            }
        }
    }
    var
        loansreg: Record "Loans Register";
        ABC: Decimal;

    local procedure FnRecoverOVOKOALoans()
    var
        DueInterestIs: Decimal;
    begin
        //If loan is due then recover outstanding Interest(Only Outstanding)
        ABC := 0;
        ABC := "Total Amount To Recover";
        if "Outstanding Interest" > 0 then begin
            If FnLoanInterestIsDue() then begin
                DueInterestIs := 0;
                DueInterestIs := FnGetDueInterest();
                if ABC > DueInterestIs then
                    "Interest Amount To Recover" := DueInterestIs
                else
                    if ABC <= DueInterestIs then
                        "Interest Amount To Recover" := ABC;
            end else
                If not FnLoanInterestIsDue() then
                    if ABC > FnGetMonthlyInterest() then
                        "Interest Amount To Recover" := FnGetMonthlyInterest()
                    else
                        if ABC <= FnGetMonthlyInterest() then
                            "Interest Amount To Recover" := ABC;
            ABC := ABC - "Interest Amount To Recover";
        end;
        if "Outstanding Balance" > 0 then
            if ABC > 0 then
                if ABC > "Outstanding Balance" then
                    "Principal Amount To Recover" := "Outstanding Balance"
                else
                    if ABC <= "Outstanding Balance" then
                        "Principal Amount To Recover" := ABC;

        //If Not Due make sure than Interest is also accomodated

        //"Interest Amount To Recover" := Fn
    end;

    local procedure FnLoanInterestIsDue(): Boolean
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.", "Loan No.");
        LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', 0D, Today);
        if LoanRepaymentSchedule.Find('-') = true then
            exit(true);
        exit(false);
    end;

    local procedure FnGetDueInterest(): Decimal
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        DueAmounts: Decimal;
    begin
        DueAmounts := 0;
        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.", "Loan No.");
        LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', 0D, Today);
        if LoanRepaymentSchedule.Find('-') = true then begin
            repeat
                DueAmounts += LoanRepaymentSchedule."Monthly Interest";
            until LoanRepaymentSchedule.Next = 0;
            exit(DueAmounts);
        end;
        exit(DueAmounts);
    end;

    local procedure FnGetMonthlyInterest(): Decimal
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.", "Loan No.");
        if LoanRepaymentSchedule.Find('-') = true then
            exit(LoanRepaymentSchedule."Monthly Interest");
    end;
}
