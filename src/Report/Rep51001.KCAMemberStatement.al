Report 51001 "KCA Member Statement"
{
    RDLCLayout = 'Layout/Statement.rdlc';
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Date Filter";

            column(UserId; UserId)
            {
            }
            column(PayrollStaffNo_Members; Customer."Payroll/Staff No")
            {
            }
            column(No_Members; Customer."No.")
            {
            }
            column(Name_Members; Customer.Name)
            {
            }
            column(EmployerCode_Members; Customer."Employer Code")
            {
            }
            column(Shares_Retained; Customer."Shares Retained")
            {
            }
            column(ShareCapBF; ShareCapBF)
            {
            }
            column(IDNo_Members; Customer."ID No.")
            {
            }
            column(Current_Shares; Customer."Current Shares") { }
            column(Date_of_Registration; Customer."Registration Date") { }
            column(Monthly_Contribution; Customer."Monthly Contribution") { }
            column(GlobalDimension2Code_Members; Customer."Global Dimension 2 Code")
            {
            }
            // column("OutLoanApplicationfee"; "Out. Loan Application fee")
            // {
            // }
            // column("OutLoanInsurancefee"; "Out. Loan Insurance fee")
            // {
            // }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Client Code" = field("No."), "Date filter" = field("Date Filter"), "Loan  No." = field("Loan No. Filter");
                DataItemTableView = sorting("Loan  No.") where(Posted = const(true));
                column(PrincipleBF; PrincipleBF)
                {
                }
                column(Client_Code; "Client Code")
                {
                }
                column(LoanNumber; Loans."Loan  No.")
                {
                }
                column(ProductType; Loans."Loan Product Type")
                {
                }
                column(RequestedAmount; Loans."Requested Amount")
                {
                }
                column(Interest; Loans.Interest)
                {
                }
                column(Installments; Loans.Installments)
                {
                }
                column(Loan_Status; Loans."Loan Status") { }
                column(LoanPrincipleRepayment; Loans."Loan Principle Repayment")
                {
                }
                column(ApprovedAmount_Loans; Loans."Approved Amount")
                {
                }
                column(LoanProductTypeName_Loans; Loans."Loan Product Type")
                {
                }
                column(Repayment_Loans; Loans.Repayment)
                {
                }
                column(ModeofDisbursement_Loans; Loans."Mode of Disbursement")
                {
                }
                column(OutstandingBalance_Loans; Loans."Outstanding Balance")
                {
                }
                column(Issued_Date; loans."Issued Date") { }

                column(Paymts; PaymtsDone) { }
                column(PaymtsRemaining; PaymtsRemaining)
                {
                }
                column(Interest_Repayment; Loans."Loan Interest Repayment")
                {
                    Caption = 'Interest Repayment';
                }
                column(TotalRepayment; TotalRepayment)
                {
                }
                trigger OnAfterGetRecord()
                var
                    RepaymentsDone: Decimal;
                begin
                    LoansR.Get("Loan  No.");

                    LoansR.Reset();
                    //LoansR.SetFilter("Outstanding Balance", '>1');
                    LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");

                    if LoansR.FindSet()
                    then
                        repeat
                            // if LoansR."Outstanding Balance" <= 0 then
                            //     PaymtsDone := Installments * 1

                            // else begin
                            TotalRepayment := 0;
                            PaymtsDone := 0;
                            RepaymentsDone := 0;
                            PaymtsRemaining := 0;
                            LoansR.CalcFields(LoansR."Outstanding Balance");
                            RepaymentsDone := LoansR."Approved Amount" - LoansR."Outstanding Balance"; //the amunt yenye imelipa
                            PaymtsDone := Round((RepaymentsDone / LoansR."Loan Principle Repayment"), 0.1, '>'); //the number payments done
                            // end;
                            PaymtsRemaining := LoansR.Installments - PaymtsDone;// the number of payments remaining
                            if LoansR."Outstanding Balance" > 0 then
                                TotalRepayment := LoansR."Loan Principle Repayment" + LoansR."Loan Interest Repayment";
                        until LoansR.Next = 0;
                    if "Outstanding Balance" <= 0 then
                        CurrReport.Skip();
                end;
            }

            trigger OnPreDataItem();
            begin
                if Customer.GetFilter("Date Filter") <> '' then
                    DateFilterBF := '..' + Format(CalcDate('-1D', Customer.GetRangeMin("Date Filter")));
            end;

            trigger OnAfterGetRecord();
            begin
                SaccoEmp.Reset;
                SaccoEmp.SetRange(SaccoEmp.Code, Customer."Employer Code");
                if SaccoEmp.Find('-') then
                    EmployerName := SaccoEmp.Description;
                SharesBF := 0;
                InsuranceBF := 0;
                ShareCapBF := 0;
                RiskBF := 0;
                HseBF := 0;
                Dep1BF := 0;
                Dep2BF := 0;
                if DateFilterBF <> '' then begin
                    Cust.Reset;
                    Cust.SetRange("No.", "No.");
                    Cust.SetFilter("Date Filter", DateFilterBF);
                    if Cust.Find('-') then begin
                        Cust.CalcFields("Shares Retained", "Current Shares");
                        SharesBF := Cust."Current Shares";
                        ShareCapBF := Cust."Shares Retained";
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
        end;
    }

    trigger OnInitReport()
    begin
        ;
    end;

    trigger OnPostReport()
    begin
        // CurrReport.SaveAsPdf(Customer.Name);
    end;

    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
        ;
    end;

    var
        TotalRepayment: Decimal;
        PaymtsRemaining: Decimal;
        PaymtsDone: Decimal;
        Cust: Record Customer;
        LoansR: Record "Loans Register";
        DateFilterBF: Text[150];
        SharesBF: Decimal;
        InsuranceBF: Decimal;
        PrincipleBF: Decimal;
        ShareCapBF: Decimal;
        RiskBF: Decimal;
        Company: Record "Company Information";
        HseBF: Decimal;
        Dep1BF: Decimal;
        Dep2BF: Decimal;
        SaccoEmp: Record "Sacco Employers";
        EmployerName: Text[100];
}