#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516016 "Risk Classification report"
{
    DefaultLayout = RDLC;
    Caption = 'Loans Risk Classification-SASRA';
    RDLCLayout = './Layouts/Consolidated loan report-sasra.rdlc';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where(Posted = filter(true));

            column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
            {
            }
            column(LoanProductType_LoansRegister; "Loans Register"."Loan Product Type")
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
            {
            }
            column(ClientName_LoansRegister; "Loans Register"."Client Name")
            {
            }
            column(RepaymentMethod_LoansRegister; "Loans Register"."Repayment Method")
            {
            }
            column(Interest_LoansRegister; "Loans Register".Interest)
            {
            }
            column(IssuedDate_LoansRegister; "Loans Register"."Issued Date")
            {
            }
            column(Installments_LoansRegister; "Loans Register".Installments)
            {
            }
            column(RepaymentFrequency_LoansRegister; "Loans Register"."Repayment Frequency")
            {
            }
            column(ExpectedDateofCompletion_LoansRegister; "Loans Register"."Expected Date of Completion")
            {
            }
            column(RepaymentStartDate_LoansRegister; "Loans Register"."Repayment Start Date")
            {
            }
            column(OutstandingBalance_LoansRegister; "Loans Register"."Outstanding Balance")
            {
            }
            column(LoansCategory_LoansRegister; "Loans Register"."Loans Category-SASRA")
            {
            }
            column(LoansCategorySASRA_LoansRegister; "Loans Register"."Loans Category-SASRA")
            {
            }
            column(DaysinArrears_LoansRegister; "Loans Register"."No of Months in Arrears")
            {
            }
            column(AmountInArrears_LoansRegister; "Loans Register"."Amount In Arrears")
            {
            }
            column(EmployerName; EmployerName)
            {
            }
            column(Asat; AsAt)
            {
            }
            column(LastAmtPay; LastAmtPay)
            {
            }
            column(DaysInArrears; DaysInArrears)
            {
            }
            column(CompanyName; CompInfor.Name)
            {
            }
            column(CompanyPic; CompInfor.Picture)
            {
            }
            column(CompanyEmail; CompInfor."E-Mail")
            {
            }
            column(CompanyAddress; CompInfor.Address)
            {
            }
            column(CompanyPhoneNo; CompInfor."Phone No.")
            {
            }
            column(CompanyCity; CompInfor.City)
            {
            }
            column(RunnungNo; RunnungNo)
            {
            }
            column(LoanSector_LoansRegister; "Loans Register"."Main Sector")
            {
            }
            column(IdNo; IdNo)
            {
            }
            column(ID; ID)
            {
            }
            column(DOB; DOB)
            {
            }
            column(monthsinarrears; monthsinarrears)
            {
            }
            column(Loancategory; Loancategory)
            {
            }
            column(amountinarrears; amountinarrears)
            {
            }
            column(OutstandingBal; OutstandingBal)
            {
            }

            trigger OnAfterGetRecord()
            begin
                EmployerName := '';
                IdNo := '';
                LastAmtPay := 0;
                DaysInArrears := 0;
                loansreg.Reset;
                loansreg.SetRange(loansreg."Loan  No.", "Loans Register"."Loan  No.");
                loansreg.SetFilter(loansreg."Issued Date", '%1..%2', 0D, AsAt);
                loansreg.CalcFields(loansreg."Outstanding Balance");
                if loansreg.Find('-') then begin
                    if ObjMemb.Get(loansreg."BOSA No") then begin
                        ObjMemb.Reset;
                        ObjMemb.SetRange(ObjMemb."No.", loansreg."BOSA No");
                        if ObjMemb.Find('-') then
                            IdNo := ObjMemb."ID No.";
                    end;
                    if ObjMemb.Get(loansreg."BOSA No") then begin
                        ObjEmployer.Reset;
                        ObjEmployer.SetRange(ObjEmployer.Code, ObjMemb."Employer Code");
                        if ObjEmployer.Find('-') then
                            EmployerName := ObjEmployer.Description;
                    end;
                    CUST.Reset;
                    CUST.SetRange(CUST."No.", loansreg."Client Code");
                    if CUST.Find('-') then begin
                        ID := CUST."ID No.";
                        DOB := CUST."Date of Birth";
                    end;
                    //.......................................get member outstanding Loan bal as at set date
                    OutstandingBal := 0;
                    ObjMembLedg.Reset;
                    ObjMembLedg.SetRange(ObjMembLedg."Loan No", loansreg."Loan  No.");
                    ObjMembLedg.SetFilter(ObjMembLedg."Posting Date", '%1..%2', 0D, AsAt);
                    ObjMembLedg.SetFilter(ObjMembLedg."Transaction Type", '%1|%2', ObjMembLedg."transaction type"::Repayment, ObjMembLedg."transaction type"::Loan);
                    if ObjMembLedg.Find('-') then
                        repeat
                            OutstandingBal += ObjMembLedg."Amount Posted";
                        until ObjMembLedg.Next = 0;
                    //..................................................
                    if OutstandingBal <= 0 then begin
                        amountinarrears := 0;
                        DaysInArrears := 0;
                        Loancategory := '';
                    end
                    else
                        if OutstandingBal > 0 then begin
                            //.......................................get expeceted bal as per schedule
                            expectedoutsatndingbal := 0;
                            expectedpay := 0;
                            loanrepaymentschedule.Reset;
                            loanrepaymentschedule.SetRange(loanrepaymentschedule."Loan No.", loansreg."Loan  No.");
                            loanrepaymentschedule.SetFilter(loanrepaymentschedule."Repayment Date", '%1..%2', 0D, AsAt);
                            if loanrepaymentschedule.Find('-') then
                                repeat
                                    expectedpay += loanrepaymentschedule."Principal Repayment";
                                until loanrepaymentschedule.Next = 0;
                            loanrepaymentschedule.Reset;
                            loanrepaymentschedule.SetRange(loanrepaymentschedule."Loan No.", loansreg."Loan  No.");
                            if loanrepaymentschedule.FindFirst then
                                expectedoutsatndingbal := loanrepaymentschedule."Loan Amount" - expectedpay;
                            //......................................get arrears amount and loans
                            if expectedoutsatndingbal < 0 then
                                expectedoutsatndingbal := 0;

                            amountinarrears := 0;
                            Loancategory := '';
                            amountinarrears := OutstandingBal - expectedoutsatndingbal;
                            if amountinarrears < 0 then begin
                                amountinarrears := 0;
                                Loancategory := Format(loansreg."loans category-sasra"::Perfoming);
                            end else
                                if amountinarrears > 0 then begin
                                    //----------------------------------get days in arrears
                                    loanrepaymentschedule.Reset;
                                    loanrepaymentschedule.SetRange(loanrepaymentschedule."Loan No.", loansreg."Loan  No.");
                                    if loanrepaymentschedule.FindLast then begin
                                        DaysInArrears := 0;
                                        monthsinarrears := 0;
                                        DaysInArrears := ROUND(amountinarrears / loanrepaymentschedule."Principal Repayment", 1, '>');
                                        monthsinarrears := ROUND(DaysInArrears / 30, 1, '>');
                                    end;
                                    //----------------------------------loan category
                                    //.................check on loan if its expected date of completion is over
                                    // IF (loansreg."Expected Date of Completion"<AsAt) OR (loansreg."Expected Date of Completion"=0D) THEN BEGIN
                                    //  DaysInArrears:=ROUND(DaysInArrears+(TODAY-loansreg."Expected Date of Completion"),1,'>');
                                    // monthsinarrears:=ROUND(DaysInArrears/30,1,'>');
                                    //  Loancategory:=FORMAT(loansreg."Loans Category-SASRA"::Loss);
                                    //END ELSE IF loansreg."Expected Date of Completion">=AsAt THEN BEGIN
                                    case monthsinarrears of
                                        0:

                                            Loancategory := Format(loansreg."loans category-sasra"::Perfoming);
                                        1:

                                            Loancategory := Format(loansreg."loans category-sasra"::Watch);
                                        2, 3, 4, 5, 6:

                                            Loancategory := Format(loansreg."loans category-sasra"::Substandard);
                                        7, 8, 9, 10, 11, 12:

                                            Loancategory := Format(loansreg."loans category-sasra"::Doubtful);
                                        else
                                            Loancategory := Format(loansreg."loans category-sasra"::Loss);
                                    end;
                                end;
                        end;
                    //....................................................
                end;
                //END;
                RunnungNo := RunnungNo + 1;
            end;

            trigger OnPreDataItem()
            begin
                if AsAt = 0D then
                    AsAt := Today;
                RunnungNo := 0;
                OutstandingBal := 0;
                expectedoutsatndingbal := 0;
                amountinarrears := 0;
                DaysInArrears := 0;
                Loancategory := '';
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field("As At Date"; AsAt)
                {
                    ApplicationArea = Basic;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompInfor.Get();
        CompInfor.CalcFields(CompInfor.Picture);
    end;

    var
        ObjMemb: Record Customer;
        ObjEmployer: Record "Sacco Employers";
        ObjMembLedg: Record "Cust. Ledger Entry";
        CompInfor: Record "Company Information";
        EmployerName: Text;
        LastAmtPay: Decimal;
        DaysInArrears: Decimal;
        ReportName: label 'LOAN LISTING REPORT SASRA';
        AsAt: Date;
        RunnungNo: Integer;
        IdNo: Code[100];
        ID: Code[100];
        CUST: Record Customer;
        DOB: Date;
        loansreg: Record "Loans Register";
        OutstandingBal: Decimal;
        loanrepaymentschedule: Record "Loan Repayment Schedule";
        expectedoutsatndingbal: Decimal;
        amountinarrears: Decimal;
        Loancategory: Text;
        monthsinarrears: Integer;
        expectedpay: Decimal;
}
