#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516020 "Insider Lending"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Insider Lending.rdlc';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where("Sacco Insider" = filter(true));
            RequestFilterFields = "Date filter";

            column(var1; var1)
            {
            }
            column(var2; var2)
            {
            }
            column(LoanCategoryAsAtPeriod; LoanCategoryAsAtPeriod)
            {
            }
            column(DateFilter; DateFilter)
            {
            }
            column(ClientName; "Loans Register"."Client Name")
            {
            }
            column(ClientCode; "Loans Register"."Client Code")
            {
            }
            column(POSITIONHELD; POSITIONHELD)
            {
            }
            column(LoanProductType; "Loans Register"."Loan Product Type Name")
            {
            }
            column(AmountApplied; "Loans Register"."Requested Amount")
            {
            }
            column(ApprovedAmount; "Loans Register"."Approved Amount")
            {
            }
            column(IssuedDate; "Loans Register"."Issued Date")
            {
            }
            column(AMOUNTOFBOSADEPOSITS; AMOUNTOFBOSADEPOSITS)
            {
            }
            column(RepaymentStartDate; "Loans Register"."Repayment Start Date")
            {
            }
            column(Period; "Loans Register".Installments)
            {
            }
            column(OutstandingBalance_LoansRegister; "Loans Register"."Outstanding Balance")
            {
            }
            column(CurrentShares_LoansRegister; "Loans Register"."Current Shares")
            {
            }
            column(LoanDisbursementDate_LoansRegister; "Loans Register"."Loan Disbursement Date")
            {
            }

            trigger OnAfterGetRecord()
            var
                UpdateLoanClassification: Codeunit UpdateLoanClassification;
            begin

                "Loans Register".SetFilter("Loans Register"."Date filter", DateFilter);
                "Loans Register".SetAutoCalcFields("Loans Register"."Outstanding Balance");
                if "Loans Register"."Outstanding Balance" > 0 then begin
                    OUTSTANDINGAMOUNT := "Loans Register"."Outstanding Balance";
                    AMOUNTOFBOSADEPOSITS := FnGetMemberDeposits("Loans Register"."Client Code");
                    POSITIONHELD := FnGetMemberPosition("Loans Register"."Client Code");
                    LoanCategoryAsAtPeriod := UpdateLoanClassification.FnCheckPreviousLoanStatus("Loans Register"."Loan  No.", DateFilter);
                end else
                    if "Loans Register"."Outstanding Balance" <= 0 then
                        CurrReport.skip;
                var1 := var1 + 1;
                var2 := var2 + 1;
            end;
            //......................
            trigger OnPreDataItem()
            begin
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
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
    var
        MembersReg: Record Customer;
    begin

        CompanyInformation.Get;
        DateFilter := "Loans Register".GetFilter("Loans Register"."Date filter");
        OUTSTANDINGAMOUNT := 0;
        AMOUNTOFBOSADEPOSITS := 0;
        POSITIONHELD := '';
        LoanCategoryAsAtPeriod := '';
        var1 := 0;
        var2 := 0;
        //.......................
        MembersReg.Reset();
        MembersReg.SetRange(MembersReg."Sacco Insider", true);
        if MembersReg.find('-') then
            repeat
                MembersReg."Sacco Insider" := false;
                MembersReg.Modify();
            until MembersReg.Next = 0;
        //.......................
        MembersReg.Reset();
        MembersReg.SetRange(MembersReg.Board, true);
        if MembersReg.find('-') then
            repeat
                MembersReg."Sacco Insider" := true;
                MembersReg.Modify();
            until MembersReg.Next = 0;
        //.......................
        MembersReg.Reset();
        MembersReg.SetRange(MembersReg.staff, true);
        if MembersReg.find('-') then
            repeat
                MembersReg."Sacco Insider" := true;
                MembersReg.Modify();
            until MembersReg.Next = 0;
        Commit();
    end;

    local procedure FnGetMemberDeposits(BOSANo: Code[20]): Decimal
    var
        memberreg: record customer;
        vendor: Record Vendor;
    begin
        memberreg.Reset();
        memberreg.SetFilter(memberreg."Date Filter", DateFilter);
        memberreg.SetRange(memberreg."No.", BOSANo);
        memberreg.SetAutoCalcFields(memberreg."Current Shares");
        if memberreg.Find('-') then
            exit(memberreg."Current Shares");
        memberreg.Reset();
        memberreg.SetFilter(memberreg."Date Filter", DateFilter);
        memberreg.SetRange(memberreg."No.", BOSANo);
        memberreg.SetAutoCalcFields(memberreg."Current Shares");
        if memberreg.Find('-') then
            exit(memberreg."Current Shares");
        vendor.Reset();
        vendor.SetRange(vendor."No.", BOSANo);
        if vendor.Find('-') then begin
            memberreg.Reset();
            memberreg.SetFilter(memberreg."Date Filter", DateFilter);
            memberreg.SetRange(memberreg."No.", vendor."BOSA Account No");
            memberreg.SetAutoCalcFields(memberreg."Current Shares");
            if memberreg.Find('-') then
                exit(memberreg."Current Shares");
        end;
    end;

    local procedure FnGetMemberPosition(BOSANo: Code[20]): Text
    var
        memberreg: Record Customer;
    begin
        memberreg.Reset();
        memberreg.SetRange(memberreg."No.", BOSANo);
        if memberreg.Find('-') then
            if memberreg.Board = true then
                exit('Board')
            else
                if memberreg.staff = true then
                    exit('Staff');
        memberreg.Reset();
        memberreg.SetRange(memberreg."No.", BOSANo);
        if memberreg.Find('-') then
            if memberreg.Board = true then
                exit('Board')
            else
                if memberreg.Board = true then
                    exit('Staff');
    end;

    var
        DateFilter: text;
        var1: Integer;
        var2: Integer;
        MembersReg: Record Customer;
        LoanCategoryAsAtPeriod: Text[100];
        POSITIONHELD: Text;
        AMOUNTGRANTED: Decimal;
        DATEAPPROVED: Date;
        AMOUNTOFBOSADEPOSITS: Decimal;
        NATUREOFSECURITY: Text;
        REPAYMENTCOMMENCEMENT: Date;
        REPAYMENTPERIOD: DateFormula;
        OUTSTANDINGAMOUNT: Decimal;
        PERFORMANCE: Text;
        MemberRegister: Record Customer;
        CompanyInformation: Record "Company Information";
}
