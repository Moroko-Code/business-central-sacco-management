#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516032 "Loans to Board"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/LoanstoBoard.rdlc';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where("Insider Board" = filter(true), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Date filter";

            column(StartDate; StartDate)
            {
            }
            column(MStartDate; MStartDate)
            {
            }
            column(MEndDate; MEndDate)
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(EmplNme; EmplNme)
            {
            }
            column(EmplNme1; EmplNme1)
            {
            }
            column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
            {
            }
            column(qwe; qwe)
            {
            }
            column(EmplNmeboard; EmplNmeboard)
            {
            }
            column(EmplNme1board; EmplNme1board)
            {
            }
            column(LoanNo; LoanNo)
            {
            }
            column(LoanNo1; LoanNo1)
            {
            }
            column(LoanNo2; LoanNo2)
            {
            }
            column(LoanNo3; LoanNo3)
            {
            }
            column(Insiderboard_LoansRegister; "Loans Register"."Insider Board")
            {
            }
            column(t; T)
            {
            }
            column(MEMBERNUMBER; MEMBERNUMBER)
            {
            }
            column(POSITIONHELD; POSITIONHELD)
            {
            }
            column(AMOUNTGRANTED; AMOUNTGRANTED)
            {
            }
            column(DATEAPPROVED; DATEAPPROVED)
            {
            }
            column(AMOUNTrequested; AMOUNT)
            {
            }
            column(AMOUNTOFBOSADEPOSITS; AMOUNTOFBOSADEPOSITS)
            {
            }
            column(NATUREOFSECURITY; NATUREOFSECURITY)
            {
            }
            column(REPAYMENTCOMMENCEMENT; REPAYMENTCOMMENCEMENT)
            {
            }
            column(REPAYMENTPERIOD; REPAYMENTPERIOD)
            {
            }
            column(LOANTYPENAME; LOANTYPENAME)
            {
            }
            column(OUTSTANDINGAMOUNT; OUTSTANDINGAMOUNT)
            {
            }
            column(PERFORMANCE; PERFORMANCE)
            {
            }
            column(LoansCategorySASRA_LoansRegister; "Loans Register"."Loans Category-SASRA")
            {
            }
            column(name; CompanyProperty.DisplayName)
            {
            }
            column(LoansCategory_LoansRegister; "Loans Register"."Loans Category-SASRA")
            {
            }
            column(SN; SN)
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(RequestedAmount_LoansRegister; "Loans Register"."Requested Amount")
            {
            }
            column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
            {
            }
            column(ClientName_LoansRegister; "Loans Register"."Client Name")
            {
            }
            column(IssuedDate_LoansRegister; "Loans Register"."Issued Date")
            {
            }
            column(Installments_LoansRegister; "Loans Register".Installments)
            {
            }
            column(LoanProductTypeName_LoansRegister; "Loans Register"."Loan Product Type Name")
            {
            }
            column(OutstandingBalance_LoansRegister; "Loans Register"."Outstanding Balance")
            {
            }
            column(CurrentShares_LoansRegister; "Loans Register"."Current Shares")
            {
            }
            column(RepaymentStartDate_LoansRegister; "Loans Register"."Repayment Start Date")
            {
            }
            column(LoanDisbursementDate_LoansRegister; "Loans Register"."Loan Disbursement Date")
            {
            }

            trigger OnAfterGetRecord()
            begin

                POSITIONHELD := 'Board';
                OUTSTANDINGAMOUNT := 0;
                MemberRegister.Reset;
                MemberRegister.SetRange(MemberRegister."No.", "Loans Register"."Client Code");
                MemberRegister.SetFilter(MemberRegister."Date Filter", '..%1', AsAt);
                MemberRegister.SetAutocalcFields("Current Shares");
                if MemberRegister.Find('-') then begin
                    MemberRegister.CalcFields(MemberRegister."Current Shares");
                    AMOUNTOFBOSADEPOSITS := MemberRegister."Current Shares";
                end;
                // SN:=SN+1;
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                LoanApp.SetRange(LoanApp."Client Code", "Loans Register"."Client Code");
                LoanApp.SetFilter(LoanApp."Date filter", '..%1', AsAt);
                LoanApp.SetAutocalcFields("Current Shares", "Outstanding Balance");
                if LoanApp.Find('-') then
                    OUTSTANDINGAMOUNT := LoanApp."Outstanding Balance";
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(AsAt; AsAt)
                {
                    ApplicationArea = Basic;
                    Caption = 'AsAt....';
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

    trigger OnPreReport()
    begin
        StartDate := CalcDate('-CY', AsAt);
        MStartDate := CalcDate('-CM', AsAt);
        MEndDate := CalcDate('CM', AsAt);
        NEWLoanFilter := Format(MStartDate) + '..' + Format(MEndDate);
        //MESSAGE('%1',NEWLoanFilter);
        OldLoanFilter := '..' + Format(MStartDate);
        CompanyInformation.Get;
    end;

    var
        StartDate: Date;
        MStartDate: Date;
        MEndDate: Date;
        NEWLoanFilter: Text;
        OldLoanFilter: Text;
        AsAt: Date;
        LoanApp: Record "Loans Register";
        EmplNme: Text;
        EmplNme1: Text[50];
        LoansRegister: Record "Loans Register";
        qwe: Text[50];
        EmplNmeboard: Text;
        EmplNme1board: Text;
        LoanNo: Code[20];
        LoanNo1: Code[20];
        LoanNo2: Code[20];
        LoanNo3: Code[20];
        T: Boolean;
        F: Boolean;
        MEMBERNUMBER: Code[30];
        POSITIONHELD: Text;
        LOANTYPENAME: Text;
        AMOUNT: Decimal;
        AMOUNTGRANTED: Decimal;
        DATEAPPROVED: Date;
        AMOUNTOFBOSADEPOSITS: Decimal;
        NATUREOFSECURITY: Text;
        REPAYMENTCOMMENCEMENT: Date;
        REPAYMENTPERIOD: DateFormula;
        OUTSTANDINGAMOUNT: Decimal;
        PERFORMANCE: Text;
        SN: Integer;
        MemberRegister: Record Customer;
        CompanyInformation: Record "Company Information";
}
