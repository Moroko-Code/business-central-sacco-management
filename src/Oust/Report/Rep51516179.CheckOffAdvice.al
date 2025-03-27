#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516179 "Check Off Advice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Check Off Advice.rdlc';

    dataset
    {
        dataitem("Members Register"; Customer)
        {
            DataItemTableView = where(Status = filter(Active));
            RequestFilterFields = "No.", "Employer Code", "Date Filter";
            column(ReportForNavId_1; 1)
            {
            }
            column(MonthlyContribution_MembersRegister; "Members Register"."Monthly Contribution")
            {
            }
            column(No_MembersRegister; "Members Register"."No.")
            {
            }
            column(Name_MembersRegister; "Members Register".Name)
            {
            }
            column(EmployerCode_MembersRegister; "Members Register"."Employer Code")
            {
            }
            column(Total_Loan_Repayment; TRepayment)
            {
            }
            column(MonthlyAdvice; MonthlyAdvice)
            {
            }
            column(mothlcommitment; "Members Register"."Monthly Contribution")
            {
            }
            column(Insurancecontributions; Insurance)
            {
            }

            column(Share_Capital; scapital)
            {
            }

            column(Deposit_Contribution; DEPOSIT)
            {
            }

            column(LoanRepayment; LoanRepayment)
            {
            }
            column(EmployerName; LoansRec."Employer Name")
            {
            }
            column(Employercode; LoansRec."Employer Code")
            {
            }
            column(DOCNAME; DOCNAME)
            {
            }
            column(CName; CompanyInfo.Name)
            {
            }
            column(Caddress; CompanyInfo.Address)
            {
            }
            column(CmobileNo; CompanyInfo."Phone No.")
            {
            }
            column(clogo; CompanyInfo.Picture)
            {
            }
            column(Cwebsite; CompanyInfo."Home Page")
            {
            }
            column(Employer_Name; employername)
            {
            }

            column(Junior_Monthly_Contribution; "Junior Monthly Contribution") { }


            trigger OnAfterGetRecord()
            begin
                DOCNAME := 'EMPLOYER CHECKOFF ADVICE';
                Prepayment := 0;
                IntRepayment := 0;
                RecomendedRepayment := 0;
                TRepayment := 0;
                PrincipalInterest := 0;
                MonthlyAdvice := 0;
                LoanRepayment := 0;
                DEPOSIT := 0;

                Cust.Reset;
                Cust.SetRange(Cust."No.", "Members Register"."No.");
                Cust.SetRange(Cust."Employer Code", "Members Register"."Employer Code");
                if Cust.Find('-') then begin
                    Gsetup.Get();
                    Cust.CalcFields(Cust."Shares Retained");
                    if Cust."Shares Retained" < Gsetup."Retained Shares" then
                        scapital := cust."Monthly ShareCap Cont.";
                    DEPOSIT := Cust."Monthly Contribution" + cust."Monthly ShareCap Cont." + Cust."Monthly Fixed Deposits Cont.";



                    //Loan Repayment
                    TRepayment := 0;
                    loans.Reset;
                    loans.SetRange(loans."Client Code", "Members Register"."No.");
                    // loans.SetRange(loans."Recovery Mode", loans."Recovery Mode");
                    loans.SetRange(loans.Posted, true);
                    loans.SetAutocalcFields(loans."Outstanding Balance");
                    loans.SetFilter(loans."Outstanding Balance", '>0');
                    if loans.FindSet() then begin
                        repeat
                            TRepayment := Loans."Outstanding Balance";
                            RecomendedRepayment := Loans."Recommended Repayment";
                            if RecomendedRepayment > 0 then begin
                                if RecomendedRepayment > TRepayment then begin
                                    LoanRepayment := LoanRepayment + TRepayment;

                                end else begin
                                    LoanRepayment := LoanRepayment + RecomendedRepayment;

                                end;
                            end else begin
                                if loans.Repayment > TRepayment then begin
                                    LoanRepayment := LoanRepayment + TRepayment;

                                end else begin
                                    LoanRepayment := LoanRepayment + loans.Repayment;
                                end;
                            end;

                        until loans.Next = 0;
                    end;

                    MonthlyAdvice := LoanRepayment + DEPOSIT;
                end;
            end;
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

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        RunningBalance: Decimal;
        LoansRec: Record "Loans Register";
        Prepayment: Decimal;
        IntRepayment: Decimal;
        TRepayment: Decimal;
        PrincipalInterest: Decimal;
        DEPOSIT: Decimal;
        MonthlyAdvice: Decimal;
        DOCNAME: Text[30];
        CompanyInfo: Record "Company Information";
        Gsetup: Record "Sacco General Set-Up";
        Insurance: Decimal;
        insuranceContribution: Decimal;
        scapital: Decimal;
        RecomendedRepayment: Decimal;
        principle: Decimal;
        loans: Record "Loans Register";
        maxscap: Decimal;
        Cust: Record customer;
        employername: Text;
        member: Record "Sacco Employers";
        LoanRepayment: Decimal;
}
