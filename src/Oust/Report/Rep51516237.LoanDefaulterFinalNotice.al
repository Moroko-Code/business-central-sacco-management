#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516237 "Loan Defaulter Final Notice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Defaulter Final Notice.rdlc';

    dataset
    {
        dataitem("<LoansRec>"; "Loans Register")
        {
            RequestFilterFields = "Client Code", "Loan  No.", "Loans Category-SASRA";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(OutstandingBalance_Loans; "Loans Register"."Outstanding Balance")
            {
            }
            column(LoanNo_Loans; "Loans Register"."Loan  No.")
            {
            }
            column(ClientName_Loans; "Loans Register"."Client Name")
            {
            }
            column(ClientCode_Loans; "Loans Register"."Client Code")
            {
            }
            column(OutstandingBalance_LoansRec; "<LoansRec>"."Outstanding Balance")
            {
            }
        
            column(CurrentShares_LoansRec; "<LoansRec>"."Current Shares")
            {
            }
            column(ApprovedAmount_LoansRec; "<LoansRec>"."Approved Amount")
            {
            }
            column(Penaltycharge_on_offset; Penaltcharge)
            {
            }
            column(AmouuntToRecover; AmouuntToRecover)
            {
            }
            column(OutstandingInt; OutstandingInt)
            {
            }
            column(LoanNo; LoanNo)
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
            column(Email; CompanyInfo."E-Mail")
            {
            }
            dataitem("Members Register"; Customer)
            {
                DataItemLink = "No." = field("Client Code");
                column(ReportForNavId_1102755005; 1102755005)
                {
                }
                column(Name_Members; "Members Register".Name)
                {
                }
                column(No_Members; "Members Register"."No.")
                {
                }
                column(City_Members; "Members Register".City)
                {
                }
                column(Address2_Members; "Members Register"."Address 2")
                {
                }
                column(Address_Members; "Members Register".Address)
                {
                }

                trigger OnPreDataItem()
                begin
                    CalcFields("Members Register"."Current Shares", "Members Register"."Shares Retained");
                end;
            }
            dataitem("Loans Register"; "Loans Register")
            {
                DataItemLink = "Loan  No." = field("Loan  No.");
                column(ReportForNavId_1102755011; 1102755011)
                {
                }
                dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
                {
                    DataItemLink = "Loan No" = field("Loan  No.");
                    column(ReportForNavId_1102755009; 1102755009)
                    {
                    }
                    column(MemberNo_LoanGuarantors; "Loans Guarantee Details"."Member No")
                    {
                    }
                    column(Name_LoanGuarantors; "Loans Guarantee Details".Name)
                    {
                    }
                    column(ApprovedAmount_Loans; "Loans Register"."Approved Amount")
                    {
                    }
             
                    column(CurrentSavings_Members; "Members Register"."Current Savings")
                    {
                    }
                    column(Loan_Officer; Lofficer)
                    {
                    }
                    dataitem("Default Notices Register"; "Default Notices Register")
                    {
                        column(ReportForNavId_1120054000; 1120054000)
                        {
                        }
                        column(AmountInArrears_DefaultNoticesRegister; "Default Notices Register"."Amount In Arrears")
                        {
                        }
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin


                AmouuntToRecover := ("Outstanding Balance"  + Penaltcharge) - "Current Shares";
               
                LoanNo := "Loan  No.";
            end;

            trigger OnPreDataItem()
            begin
                CalcFields("Outstanding Balance", "Current Shares");
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);

        DOCNAME := 'FINAL DEFAULTER NOTICE';
        Lofficer := UserId;
    end;

    var
        Balance: Decimal;
        SenderName: Text[150];
        DearM: Text[60];
        BalanceType: Text[100];
        SharesB: Decimal;
        LastPDate: Date;
        LoansR: Record "Loans Register";
        SharesAlllocated: Decimal;
        ABFAllocated: Decimal;
        LBalance: Decimal;
        PersonalNo: Code[50];
        GAddress: Text[250];
        Cust: Record Customer;
        Vend: Record Vendor;
        OutstandingBalLoan: Decimal;
        AmouuntToRecover: Decimal;
        OutstandingInt: Decimal;
        LoanNo: Code[30];
        DOCNAME: Text[30];
        CompanyInfo: Record "Company Information";
        Penaltcharge: Decimal;
        Lofficer: Text;
}
