#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516030 "Loan Guarantors"
{
    DefaultLayout = RDLC;
    ApplicationArea = all;
    RDLCLayout = './Layouts/Loan Guarantors.rdlc';

    dataset
    {
        dataitem(Members; Customer)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(ReportForNavId_1102755000; 1102755000)
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
            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Client Code" = field("No.");
                DataItemTableView = where("Outstanding Balance" = filter(> 0));
                column(ReportForNavId_1102755001; 1102755001)
                {
                }
                column(LoanNo_Loans; Loans."Loan  No.")
                {
                }
                column(ApplicationDate_Loans; Loans."Application Date")
                {
                }
                column(LoanProductType_Loans; Loans."Loan Product Type")
                {
                }
                column(RequestedAmount_Loans; Loans."Requested Amount")
                {
                }
                column(ApprovedAmount_Loans; Loans."Approved Amount")
                {
                }
                dataitem("Loan Guarantors"; "Loans Guarantee Details")
                {
                    DataItemLink = "Loan No" = field("Loan  No.");
                    column(ReportForNavId_1102755002; 1102755002)
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
                    column(AmountCommitedRe; AmountCommitedRe) { }
                    column(Proportion; "% Proportion") { }
                    trigger OnAfterGetRecord()
                    var
                        OustandingBalance: Decimal;
                        LoanGuar: Record "Loans Guarantee Details";

                    begin
                        "Loan Guarantors".CalcFields("Loan Guarantors"."Outstanding Balance");


                        AmountCommitedRe := "Loan Guarantors"."Outstanding Balance" * ("Loan Guarantors"."% Proportion" / 100);


                    end;
                }
            }
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
    var
        AmountCommitedRe: Decimal;
}
