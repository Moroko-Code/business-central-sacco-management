Page 51516247 "Loans Guarantee Details"
{
    PageType = ListPart;
    SourceTable = "Loans Guarantee Details";
    SourceTableView = where(Substituted = const(false));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Loan No"; "Loan No")
                {
                    Editable = false;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    var
                        cust: Record Customer;
                    begin

                        if cust.get(rec."Member No") then begin
                            cust.CalcFields(cust."Current Shares", "Loans Guaranteed");
                            FnGetOustandingGuarantorAmount(rec."Member No");
                            Rec.Name := cust.Name;
                            rec.Shares := cust."Current Shares";
                            Rec."Total Loans Guaranteed" := FnGetOustandingGuarantorAmount(rec."Member No");
                            Rec."Free Shares" := (rec.Shares - Rec."Total Loans Guaranteed");
                            rec."ID No." := cust."ID No.";
                            rec.Date := Today;
                            //rec."Loan Balance" := FnGetPersonGuarantingLoanBal(rec."Member No");
                            //rec."Outstanding Balance" := FnGetPersonGuarantingLoanBal(rec."Member No");
                            rec."Self Guarantee" := FnIsSelfGuarantee(rec."Loan No", rec."Member No");
                        end;
                    end;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Balance"; "Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Ambiguous;
                }
                field(Shares; Shares)
                {
                    ApplicationArea = Basic;
                    Visible = true;
                    caption = 'Current Deposits';
                    Editable = false;
                }
                field("Free Shares"; "Free Shares")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Amont Guaranteed"; "Amont Guaranteed")
                {
                    Caption = 'Amount To Guarantee';
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        Guranteedamount: Decimal;
                        PercentageAmount: Decimal;
                        TotalAmount: Decimal;
                    begin
                        TotalAmount := 0;
                        Guranteedamount := 0;
                        PercentageAmount := 0;
                        TotalAmount := 0;
                        // if "Self Guarantee" = false then begin
                        //     if "Free Shares" < "Amont Guaranteed" then
                        //         Error('The Guarantor has no enough Deposits to Guarantee')
                        // end
                        // else
                        // if "Self Guarantee" = true then begin
                        //     if "Free Shares" < "Amont Guaranteed" then begin
                        //         if (0.50 * rec."Total Loans Guaranteed") < "Amont Guaranteed" then begin
                        //             Error('The Guarantor has no enough Deposits to Guarantee')
                        //         end else if "Free Shares" > "Amont Guaranteed" then begin
                        //             Guranteedamount := "Free Shares";
                        //             PercentageAmount := 0.50 * rec."Total Loans Guaranteed";
                        //             TotalAmount := Guranteedamount + PercentageAmount;
                        //             if TotalAmount < "Amont Guaranteed" then begin
                        //                 Error('The Guarantor has no enough Deposits to Guarantee')
                        //             end;

                        //         end;
                        //         rec."Total Amount Guaranteed" := FnRunGetCummulativeAmountGuaranteed(Rec."Loan No");
                        //     end;
                        // end;

                        rec."Total Amount Guaranteed" := FnRunGetCummulativeAmountGuaranteed(Rec."Loan No");
                    end;

                }
                field("Total Amount Guaranteed"; "Total Amount Guaranteed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Strong;
                }
                field("Self Guarantee"; "Self Guarantee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Date; Date)
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        RunningBalance: Decimal;

    local procedure FnGetPersonGuarantingLoanBal(MemberNo: Code[20]): Decimal
    var
        LoansRegister: Record "Loans Register";
        LoanBalTotal: Decimal;
    begin
        LoanBalTotal := 0;
        LoansRegister.Reset();
        LoansRegister.SetRange(LoansRegister."Client Code", MemberNo);
        LoansRegister.SetAutoCalcFields(LoansRegister."Outstanding Balance");
        if LoansRegister.Find('-') then
            repeat
                LoanBalTotal += LoansRegister."Outstanding Balance";
            until LoansRegister.Next = 0;
        exit(LoanBalTotal);
    end;

    local procedure FnIsSelfGuarantee(LoanNo: Code[20]; MemberNo: Code[20]): Boolean
    var
        LoansRegister: Record "Loans Register";
    begin
        LoansRegister.Reset;
        LoansRegister.SetRange(LoansRegister."Loan  No.", LoanNo);
        if LoansRegister.Find('-') then begin
            if LoansRegister."Client Code" = MemberNo then
                exit(true);
        end
        else
            exit(false);
    end;

    local procedure FnRunGetCummulativeAmountGuaranteed(VarLoanNo: Code[30]): Decimal
    var
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
    begin
        RunningBalance := 0;

        LoansGuaranteeDetails.Reset;
        LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails."Loan No", VarLoanNo);
        if LoansGuaranteeDetails.FindSet then
            repeat
                RunningBalance := RunningBalance + LoansGuaranteeDetails."Amont Guaranteed";
            until LoansGuaranteeDetails.Next = 0;
    end;

    local procedure FnGetOustandingGuarantorAmount(VarMemberNo: Code[30]): Decimal
    var
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
        OustandingBalance: Decimal;
        Balance: Decimal;
    begin
        OustandingBalance := 0;
        Balance := 0;
        LoansGuaranteeDetails.Reset;
        LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails."Member No", VarMemberNo);
        LoansGuaranteeDetails.SetAutoCalcFields(LoansGuaranteeDetails."Outstanding Balance");
        LoansGuaranteeDetails.SetRange("Self Guarantee", false);
        LoansGuaranteeDetails.SetFilter(LoansGuaranteeDetails."Outstanding Balance", '>%1', 0);
        if LoansGuaranteeDetails.FindSet() then begin
            repeat
                OustandingBalance := (OustandingBalance + (LoansGuaranteeDetails."Outstanding Balance" * (LoansGuaranteeDetails."% Proportion" / 100)));
            until LoansGuaranteeDetails.next = 0;
            exit(OustandingBalance);
        end;

    end;
}
