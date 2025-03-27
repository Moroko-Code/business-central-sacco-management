#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516226 "Loans Guaranteed"
{
    DefaultLayout = RDLC;
    ApplicationArea = all;
    RDLCLayout = './Layouts/Loans Guaranteed.rdlc';

    dataset
    {
        dataitem(Members; Customer)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(ReportForNavId_7301; 7301)
            {
            }
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(CurrentShares_Members; Members."Current Shares")
            {
            }
            column(Status_Members; Members.Status)
            {
            }
            dataitem("Loan Guarantors"; "Loans Guarantee Details")
            {
                DataItemLink = "Member No" = field("No.");
                DataItemTableView = where("Outstanding Balance" = filter(> 0), Substituted = const(false));
                RequestFilterFields = Substituted, "Amont Guaranteed";
                column(ReportForNavId_5140; 5140)
                {
                }
                column(LoanNo_LoanGuarantors; "Loan Guarantors"."Loan No")
                {
                }
                column(MemberNo_LoanGuarantors; "Loan Guarantors"."Member No")
                {
                }
                column(Name_LoanGuarantors; "Loan Guarantors".Name)
                {
                }
                column(LoanBalance_LoanGuarantors; "Loan Guarantors"."Loans Outstanding")
                {
                }
                column(Shares_LoanGuarantors; "Loan Guarantors".Shares)
                {
                }
                column(NoOfLoansGuaranteed_LoanGuarantors; "Loan Guarantors"."No Of Loans Guaranteed")
                {
                }
                column(Substituted_LoanGuarantors; "Loan Guarantors".Substituted)
                {
                }
                column(Date_LoanGuarantors; "Loan Guarantors".Date)
                {
                }
                column(SharesRecovery_LoanGuarantors; "Loan Guarantors"."Shares Recovery")
                {
                }
                column(NewUpload_LoanGuarantors; "Loan Guarantors"."New Upload")
                {
                }
                column(AmontGuaranteed_LoanGuarantors; "Loan Guarantors"."Amont Guaranteed")
                {
                }
                column(StaffPayrollNo_LoanGuarantors; "Loan Guarantors"."Staff/Payroll No.")
                {
                }
                column(AccountNo_LoanGuarantors; "Loan Guarantors"."Account No.")
                {
                }
                column(SelfGuarantee_LoanGuarantors; "Loan Guarantors"."Self Guarantee")
                {
                }
                column(IDNo_LoanGuarantors; "Loan Guarantors"."ID No.")
                {
                }
                column(OutstandingBalance_LoanGuarantors; "Loan Guarantors"."Outstanding Balance")
                {
                }
                column(MemberGuaranteed_LoanGuarantors; "Loan Guarantors"."Transferable shares")
                {
                }
                column(MemberGuar; MemberGuar)
                {
                }
                column(MemberNo; MemberNo)
                {
                }
                column(DuePeriod; Period)
                {
                }
                column(AmountCommitedRe; AmountCommitedRe)
                {

                }
                column(FreeShares_LoanGuarantors; "Free Shares")
                {
                }
                dataitem("Loans Register"; "Loans Register")
                {
                    DataItemLink = "Loan  No." = field("Loan No");
                    DataItemTableView = sorting("Loan  No.") order(ascending) where(Posted = const(true));
                    column(ReportForNavId_1120054000; 1120054000)
                    {
                    }
                    column(ClientCode_LoansRegister; "Loans Register"."Client Code")
                    {
                    }
                    column(ClientName_LoansRegister; "Loans Register"."Client Name")
                    {
                    }
                    column(OutstandingBalance_LoansRegister; "Loans Register"."Outstanding Balance")
                    {
                    }
                    column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
                    {
                    }
                    column(EmployerCode_LoansRegister; "Loans Register"."Employer Code")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                var
                    LoanGuarantors: Record "Loans Guarantee Details";
                    LoanAmount: Decimal;
                begin
                    Shares := 0;
                    //"Transferable shares":='';
                    if Loans.Get("Loan No") then begin
                        Loans.CalcFields(Loans."Outstanding Balance");
                        MemberGuar := Loans."Client Name";
                        MemberNo := Loans."Client Code";
                        if Loans."Issued Date" <> 0D then begin
                            expected := ROUND((Currdate - Loans."Issued Date") / 30, 1.0, '<');
                            Period := Loans.Installments - expected;
                            LoanAmount := Loans."Approved Amount";
                        end;

                        if Cust.Get(Members."No.") then begin
                            Cust.CalcFields(Cust."Current Shares");
                            Shares := -1 * Cust."Current Shares";
                        end;
                    end;
                    "Loan Guarantors".CalcFields("Loan Guarantors"."Outstanding Balance");
                    If Substituted = false then begin



                        // "Loan Guarantors"."% Proportion" := LoanAmount / "Loan Guarantors"."Amont Guaranteed";
                        // "Loan Guarantors".Modify();

                        AmountCommitedRe := "Loan Guarantors"."Outstanding Balance" * ("Loan Guarantors"."% Proportion" / 100);
                    end;
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                // field(Currdate; Currdate)
                // {
                //     ApplicationArea = all;
                // }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if Members."Date Filter" = 0D then
            Currdate := Today
        else
            Currdate := Members."Date Filter";
    end;

    var
        Loans: Record "Loans Register";
        Cust: Record Customer;
        Shares: Decimal;
        Cust2: Record Customer;
        LoanGaurantors: Record "Loans Guarantee Details";
        LCount: Integer;
        A: Decimal;
        T: Decimal;
        AmountCommitedRe: Decimal;
        LoanApps: Record "Loans Register";
        Lamount: Decimal;
        LGBalance: Decimal;
        "Account No": Code[10];
        Loan_GuaranteedCaptionLbl: label 'Loan Guaranteed';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Personal_No_CaptionLbl: label 'Personal No.';
        NameCaptionLbl: label 'Name';
        Oustanding_BalanceCaptionLbl: label 'Oustanding Balance';
        Loan_AmountCaptionLbl: label 'Loan Amount';
        Current_SharesCaptionLbl: label 'Current Shares';
        Staff_No_CaptionLbl: label 'Staff No.';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Total_DepositsCaptionLbl: label 'Total Deposits';
        MNo_CaptionLbl: label 'MNo.';
        MemberGuar: Text;
        MemberNo: Code[10];
        "No.LoansGuaranteed": Integer;
        Guar: Record "Loans Guarantee Details";
        Period: Decimal;
        expected: Decimal;
        Currdate: Date;
}
