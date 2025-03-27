#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516495 "Recovery From Dividends"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", Status;
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Cust.Reset();
                Cust.SetRange(Cust."No.", Customer."No.");
                if cust.FindSet() then begin
                    Cust.CalcFields("Dividend Amount");
                    if Cust."Dividend Amount" > 0 then begin
                        TheRunbal := "Dividend Amount";
                        FnRecoverLoansinArrears(Cust."No.", TheRunbal);
                    end;
                end;
            end;

            trigger OnPreDataItem();
            begin
                LastFieldNo := FIELDNO("No.");

                Cust.RESET;
                // Cust.MODIFYALL(Cust."Net Dividend Payable", 0);
                //Initialize Poosting==============================================================================
                BATCH_TEMPLATE := 'PAYMENTS';
                BATCH_NAME := 'DIVIDEND';
                DOCUMENT_NO := 'DILRE_' + FORMAT(PostingDate);
                ObjGensetup.GET();
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SETRANGE("Journal Batch Name", BATCH_NAME);
                GenJournalLine.DELETEALL;
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then
                    Page.Run(page::"General Journal", GenJournalLine);
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
    begin
    end;

    local procedure FnRecoverLoansinArrears(MemberNo: Code[30]; VarRuningBal: Decimal)
    var
        ObjLoans: Record "Loans Register";
        VarAmountinArrears: Decimal;
        ObjMember: Record Customer;

        VarAmountRecovered: Decimal;
        InterestToRecover: Decimal;
    begin
        ObjGensetup.GET;
        ObjLoans.RESET;
        ObjLoans.SETRANGE(ObjLoans."Client Code", MemberNo);
        ObjLoans.SETFILTER(ObjLoans."Loans Category-SASRA", '=%1|%2|%3', ObjLoans."Loans Category-SASRA"::Doubtful, ObjLoans."Loans Category-SASRA"::Loss, ObjLoans."Loans Category-SASRA"::Substandard);
        ObjLoans.SETFILTER(ObjLoans."Outstanding Balance", '>%1', 0);

        IF ObjLoans.FINDSET THEN
            ObjMember.RESET;
        ObjMember.SETRANGE(ObjMember."No.", MemberNo);
        IF ObjMember.FINDSET THEN
            ObjMember.CALCFIELDS(ObjMember."Dividend Amount");
        // VarRuningBal := ObjMember."Dividend Amount";
        // VarRuningBal := Runbal;

        REPEAT
            IntToRecover := 0;
            LoanToRecover := 0;
            // VarAmountinArrears:=SFactory.FnGetLoanAmountinArrears(ObjLoans."Loan  No.");
        
            VarAmountinArrears := ObjLoans."Amount in Arrears";
           
            //----------------------Recover Interest--------------------------------------------------------

            IF InterestToRecover > 0 THEN BEGIN
                IF VarRuningBal <= InterestToRecover THEN
                    InterestToRecover := VarRuningBal
                ELSE
                    InterestToRecover := InterestToRecover;

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Dividend,
                GenJournalLine."Account Type"::Customer, MemberNo, PostingDate, InterestToRecover, 'BOSA', ObjLoans."Loan  No.",
                'Loan outstanding int Recovered- ' + FORMAT(ObjLoans."Loan  No."), ObjLoans."Loan  No.");

                //------------------------------------2.1. CREDIT MEMBER interest outstanding-----------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                GenJournalLine."Account Type"::Customer, MemberNo, PostingDate, InterestToRecover * -1, 'BOSA', ObjLoans."Loan  No.",
                'Loan outstanding int Recovered From Dividend- ' + FORMAT(PostingDate), ObjLoans."Loan  No.");
                VarRuningBal := VarRuningBal - InterestToRecover;
            END;

            IF VarAmountinArrears > 0 THEN BEGIN

                // IF (ObjLoans."Loans Category-SASRA" <> ObjLoans."Loans Category-SASRA"::Watch) AND (ObjLoans."Loans Category-SASRA" <> ObjLoans."Loans Category-SASRA"::Perfoming) THEN BEGIN
                IF (ObjLoans."Loans Category-SASRA" = ObjLoans."Loans Category-SASRA"::Substandard)
                  OR (ObjLoans."Loans Category-SASRA" <> ObjLoans."Loans Category-SASRA"::Doubtful)
                  OR (ObjLoans."Loans Category-SASRA" <> ObjLoans."Loans Category-SASRA"::Loss)
                  THEN BEGIN

                    IF VarRuningBal >= VarAmountinArrears THEN
                        VarAmountRecovered := VarAmountinArrears
                    ELSE
                        VarAmountRecovered := VarRuningBal;

                    //------------------------------------2. DEBIT MEMBER DIVIDEND A/C_LOAN IN ARREARS-------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Dividend,
                    GenJournalLine."Account Type"::Customer, MemberNo, PostingDate, VarAmountRecovered, 'BOSA', ObjLoans."Loan  No.",
                    'Loan in Arrears Recovered- ' + FORMAT(ObjLoans."Loan  No."), ObjLoans."Loan  No.");
                    //--------------------------------(Debit Member Dividend A/C_Loan In Arrears)-------------------------------------------------------------

                    //------------------------------------2.1. CREDIT MEMBER LOAN IN AREARS-----------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                    GenJournalLine."Account Type"::Customer, MemberNo, PostingDate, VarAmountRecovered * -1, 'BOSA', ObjLoans."Loan  No.",
                    'Loan In Arrears Recovered From Dividend- ' + FORMAT(PostingDate), ObjLoans."Loan  No.");
                    //----------------------------------(Credit Member Loan In Arrears)-----------------------------------------------------------------------------
                    VarRuningBal := VarRuningBal - VarAmountRecovered;
                END;
                IntToRecover := InterestToRecover;
                LoanToRecover := VarAmountRecovered;
            END;
        UNTIL ObjLoans.NEXT = 0;
    end;

    var
        QualifyingShares: Decimal;
        WthTAxTotal: Decimal;
        CustomerCaptionLbl: label 'Customer';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Cust: Record Customer;
        Asat: Date;
        DateFilter: Text[100];
        FromDate: Date;
        ToDate: Date;
        FromDateS: Text[100];
        ToDateS: Text[100];
        DivTotal: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        CDeposits: Decimal;
        CustDiv: Record Customer;
        DivProg: Record "Dividends Progression";
        CDiv: Decimal;
        CInterest: Decimal;
        BDate: Date;
        CustR: Record Customer;
        IntOnDeposits: Decimal;
        CIntReb: Decimal;
        LineNo: Integer;
        Gnjlline: Record "Gen. Journal Line";
        PostingDate: Date;
        "W/Tax": Decimal;
        CommDiv: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        SFactory: Codeunit "SURESTEP Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[50];
        ObjGensetup: Record "Sacco General Set-Up";
        Totalpay: Decimal;
        WithTaxTotal: Decimal;
        DividendsOnshareCapital: Decimal;
        LoanType: Record "Loan Products Setup";
        TheRunbal: Decimal;
        Calculations: Decimal;
        Remainder: Decimal;
        IntToRecover: Decimal;
        LoanToRecover: Decimal;
}
