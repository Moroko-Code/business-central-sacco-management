#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516022 "SURESTEP Factory"
{
    trigger OnRun()
    begin
    end;

    var
        ObjTransCharges: Record "Transaction Charges";
        UserSetup: Record "User Setup";
        ObjVendor: Record Vendor;
        ObjProducts: Record "Loan Products Setup";
        ObjMemberLedgerEntry: Record "Cust. Ledger Entry";
        ObjLoans: Record "Loans Register";
        ObjBanks: Record "Bank Account";
        ObjLoanProductSetup: Record "Loan Products Setup";
        ObjProductCharges: Record "Loan Product Charges";
        ObjMembers: Record Customer;
        ObjMembers2: Record Customer;
        ObjGenSetUp: Record "Sacco General Set-Up";
        ObjCompInfo: Record "Company Information";
        BAND1: Decimal;
        BAND2: Decimal;
        BAND3: Decimal;
        BAND4: Decimal;
        BAND5: Decimal;
        NLInterest: Decimal;
        TheMessage: Codeunit "Email Message";
        Email: Codeunit Email;

    //  procedure SendEmailWithAttachment(FileName:Text[100];EmailAddress:Text[100]; EmailSubject: text[100]; EmailBody: Text[200])
    // var
    //  ";
    // begin
    //     TheMessage.Create(EmailAddress,EmailSubject,'',true);
    //     TheMessage.AddAttachment();
    //           Email.Send(TheMessage);
    // end;

    procedure FnGetCashierTransactionBudding(TransactionType: Code[100]; TransAmount: Decimal) TCharge: Decimal
    begin
        ObjTransCharges.Reset;
        ObjTransCharges.SetRange(ObjTransCharges."Transaction Type", TransactionType);
        ObjTransCharges.SetFilter(ObjTransCharges."Minimum Amount", '<=%1', TransAmount);
        ObjTransCharges.SetFilter(ObjTransCharges."Maximum Amount", '>=%1', TransAmount);
        TCharge := 0;
        if ObjTransCharges.FindSet then
            repeat
                TCharge := TCharge + ObjTransCharges."Charge Amount" + ObjTransCharges."Charge Amount" * 0.1;
            until ObjTransCharges.Next = 0;
    end;

    procedure FnCreateMembershipWithdrawalApplication(MemberNo: Code[20]; ApplicationDate: Date; Reason: Option Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other; ClosureDate: Date)
    var
        DateExp: Text[30];
        ObjNoSeries: Record "No. Series Line";
        ObjSalesSetup: Record "Sacco No. Series";
        ObjNoSeriesManagement: Codeunit NoSeriesManagement;
        ObjNextNo: Code[20];
        PostingDate: Date;
        ObjMembershipWithdrawal: Record "Membership Exist";

    begin
        DateExp := '<60D>';
        ObjGenSetUp.Get();
        //DateExp:=ObjGenSetUp."Withdrawal Period";

        PostingDate := WorkDate;
        ObjSalesSetup.GET;
        ApplicationDate := today;
        ObjSalesSetup.TestField(ObjSalesSetup."Closure  Nos");
        ObjNextNo := ObjNoSeriesManagement.TryGetNextNo(ObjSalesSetup."Closure  Nos", PostingDate);
        ObjNoSeries.RESET;
        ObjNoSeries.SETRANGE(ObjNoSeries."Series Code", ObjSalesSetup."Closure  Nos");
        IF ObjNoSeries.FINDSET THEN BEGIN
            ObjNoSeries."Last No. Used" := INCSTR(ObjNoSeries."Last No. Used");
            ObjNoSeries."Last Date Used" := TODAY;
            ObjNoSeries.MODIFY;
        END;
        ClosureDate := CalcDate(DateExp, ApplicationDate);

        ObjMembershipWithdrawal.INIT;
        ObjMembershipWithdrawal."No." := ObjNextNo;
        ObjMembershipWithdrawal."Member No." := MemberNo;
        ObjMembershipWithdrawal."Withdrawal Application Date" := ApplicationDate;
        ObjMembershipWithdrawal."Notice Date" := ApplicationDate;
        ObjMembershipWithdrawal."Closing Date" := ClosureDate;
        ObjMembershipWithdrawal."Reason For Withdrawal" := Reason;
        ObjMembershipWithdrawal.INSERT;

        ObjMembershipWithdrawal.VALIDATE(ObjMembershipWithdrawal."Member No.");
        ObjMembershipWithdrawal.MODIFY;

        // if ObjMembers.Get(MemberNo) then begin
        //     ObjMembers.Status := ObjMembers.Status::"Awaiting Exit";
        //     ObjMembers."Status - Withdrawal App." := ObjMembers."Status - Withdrawal App."::"Being Processed";
        //     ObjMembers.Modify;
        // end;

        message('The Member has been marked as awaiting exit.');
    end;

    procedure FnGetUserBranch() branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then
            branchCode := UserSetup.Branch;
        exit(branchCode);
    end;

    procedure FnGetChargeFee(ProductCode: Code[50]; InsuredAmount: Decimal; ChargeType: Code[100]) FCharged: Decimal
    begin
        FCharged := 0;
        if ObjLoanProductSetup.Get(ProductCode) then begin
            ObjProductCharges.Reset;
            ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
            ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
            if ObjProductCharges.Find('-') then
                if ObjProductCharges."Use Perc" = true then
                    FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100)
                else
                    if ObjProductCharges."Use Perc" = false then
                        if InsuredAmount < 1000000 then
                            FCharged := ObjProductCharges.Amount
                        else
                            FCharged := ObjProductCharges.Amount2;
        end;
        exit(FCharged);
    end;

    procedure FnGetAccountUserBranch(UserAccount: Code[50]) branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserAccount);
        if UserSetup.Find('-') then
            branchCode := UserSetup.Branch;
        exit(branchCode);
    end;

    procedure FnGetMemberMonthlyContributionDepositstier(MemberNo: Code[30]) VarMemberMonthlyContribution: Decimal
    var
        ObjMember: Record Customer;
        ObjLoans: Record "Loans Register";
        VarTotalLoansIssued: Decimal;
        ObjDeposittier: Record "Member Deposit Tier";
    begin
        VarTotalLoansIssued := 0;
        VarMemberMonthlyContribution := 0;

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", MemberNo);
        if ObjMember.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
            ObjLoans.SetRange(ObjLoans.Posted, true);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            if ObjLoans.FindSet then begin
                ObjLoans.CalcSums(ObjLoans."Approved Amount");
                VarTotalLoansIssued := ObjLoans."Approved Amount";
            end;

            ObjDeposittier.Reset;
            ObjDeposittier.SetFilter(ObjDeposittier."Minimum Amount", '<=%1', VarTotalLoansIssued);
            ObjDeposittier.SetFilter(ObjDeposittier."Maximum Amount", '>=%1', VarTotalLoansIssued);
            if ObjDeposittier.FindSet then
                VarMemberMonthlyContribution := ObjDeposittier.Amount;

            ObjGenSetUp.Get;
            if (ObjMember."Account Category" = ObjMember."account category"::Individual)
            and (VarMemberMonthlyContribution < ObjGenSetUp."Min. Contribution") then
                VarMemberMonthlyContribution := ObjGenSetUp."Min. Contribution";
            // if (ObjMember."Account Category" <> ObjMember."account category"::Individual)
            // and (VarMemberMonthlyContribution < ObjGenSetUp."Corporate Minimum Monthly Cont") then
            //     VarMemberMonthlyContribution := ObjGenSetUp."Corporate Minimum Monthly Cont";

            exit(VarMemberMonthlyContribution);
        end;
    end;

    procedure FnSendSMS(SMSSource: Text; SMSBody: Text[200]; CurrentAccountNo: Text; MobileNumber: Text)
    var
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
    begin
        ObjGenSetUp.Get;
        ObjCompInfo.Get;

        SMSMessage.Reset;
        //SMSMessage.LockTable(true);
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else
            iEntryNo := 1;

        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := CurrentAccountNo;
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := CurrentAccountNo;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := SMSSource;
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := SMSBody + '.' + ObjCompInfo.Name + ' ' + ObjGenSetUp."Customer Care No";
        SMSMessage."Telephone No" := MobileNumber;
        if ((MobileNumber <> '') and (SMSBody <> '')) then
            SMSMessage.Insert;
    end;

    procedure FnCreateGnlJournalLine(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    procedure FnGetFosaAccountBalance(Acc: Code[30]) Bal: Decimal
    var
        VendorTable: Record Vendor;
    begin
        VendorTable.Reset();
        VendorTable.SetRange(VendorTable."No.", Acc);
        VendorTable.SetAutoCalcFields(VendorTable."FOSA Balance");
        if VendorTable.Find('-') then
            exit(VendorTable."FOSA Balance" - 1200);
    end;

    procedure FnGetFosaAccountBalanceUsingBOSA(Acc: Code[30]) Bal: Decimal
    var
        VendorTable: Record Vendor;
    begin
        VendorTable.Reset();
        VendorTable.SetRange(VendorTable."Account Type", 'ORDINARY');
        VendorTable.SetRange(VendorTable."BOSA Account No", Acc);
        VendorTable.SetAutoCalcFields(VendorTable."FOSA Balance");
        if VendorTable.Find('-') then
            exit(VendorTable."FOSA Balance" - 1200);
        exit(0);
    end;

    local procedure FnGetMinimumAllowedBalance(ProductCode: Code[60]): Decimal
    begin
        /*ObjProducts.RESET;
        ObjProducts.SETRANGE(ObjProducts.Code,ProductCode);
        IF ObjProducts.FIND('-') THEN
          MinimumBalance:=ObjProducts."Minimum Balance";
          */
    end;

    local procedure FnGetMemberLoanBalance(LoanNo: Code[50]; DateFilter: Date; TotalBalance: Decimal)
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNo);
        ObjLoans.SetFilter(ObjLoans."Date filter", '..%1', DateFilter);
        if ObjMemberLedgerEntry.FindSet then
            TotalBalance := TotalBalance + ObjMemberLedgerEntry."Amount (LCY)";
    end;

    procedure FnGetTellerTillNo() TellerTillNo: Code[40]
    begin
        ObjBanks.Reset;
        ObjBanks.SetRange(ObjBanks."Account Type", ObjBanks."account type"::Cashier);
        ObjBanks.SetRange(ObjBanks.CashierID, UserId);
        if ObjBanks.Find('-') then
            TellerTillNo := ObjBanks."No.";
        exit(TellerTillNo);
    end;

    procedure FnGetMpesaAccount() TellerTillNo: Code[40]
    begin
        /*ObjBanks.RESET;
        ObjBanks.SETRANGE(ObjBanks."Account Type",ObjBanks."Account Type"::"3");
        ObjBanks.SETRANGE(ObjBanks."Bank Account Branch",FnGetUserBranch());
        IF ObjBanks.FIND('-') THEN BEGIN
        TellerTillNo:=ObjBanks."No.";
        END;
        EXIT(TellerTillNo);
        */
    end;

    procedure FnGetChargeFee(ProductCode: Code[50]; MemberCategory: Option Single,Joint,Corporate,Group,Parish,Church,"Church Department",Staff; InsuredAmount: Decimal; ChargeType: Code[100]) FCharged: Decimal
    begin
        if ObjLoanProductSetup.Get(ProductCode) then begin
            ObjProductCharges.Reset;
            ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
            ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
            if ObjProductCharges.Find('-') then
                if ObjProductCharges."Use Perc" = true then
                    FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100)
                else
                    FCharged := ObjProductCharges.Amount;
        end;
        exit(FCharged);
    end;

    procedure FnGetChargeAccount(ProductCode: Code[50]; MemberCategory: Option Single,Joint,Corporate,Group,Parish,Church,"Church Department",Staff; ChargeType: Code[100]) ChargeGLAccount: Code[50]
    begin
        if ObjLoanProductSetup.Get(ProductCode) then begin
            ObjProductCharges.Reset;
            ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
            ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
            if ObjProductCharges.Find('-') then
                ChargeGLAccount := ObjProductCharges."G/L Account";
        end;
        exit(ChargeGLAccount);
    end;

    local procedure FnUpdateMonthlyContributions()
    begin
        ObjMembers.Reset;
        ObjMembers.SetCurrentkey(ObjMembers."No.");
        ObjMembers.SetRange(ObjMembers."Monthly Contribution", 0.0);
        if ObjMembers.FindSet then begin
            repeat
                ObjMembers2."Monthly Contribution" := 500;
                ObjMembers2.Modify;
            until ObjMembers.Next = 0;
            Message('Succesfully done');
        end;
    end;

    procedure FnGetUserBranchB(varUserId: Code[100]) branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", varUserId);
        if UserSetup.Find('-') then
            branchCode := UserSetup.Branch;
        exit(branchCode);
    end;

    procedure FnGetMemberBranch(MemberNo: Code[100]) MemberBranch: Code[100]
    var
        ObjMemberLocal: Record Customer;
    begin
        ObjMemberLocal.Reset;
        ObjMemberLocal.SetRange(ObjMemberLocal."No.", MemberNo);
        if ObjMemberLocal.Find('-') then
            MemberBranch := ObjMemberLocal."Global Dimension 2 Code";
        exit(MemberBranch);
    end;

    local procedure FnReturnRetirementDate(MemberNo: Code[50]): Date
    var
        ObjMembers: Record Customer;
    begin
        ObjGenSetUp.Get();
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then
            Message(Format(CalcDate(ObjGenSetUp."Retirement Age", ObjMembers."Date of Birth")));
        exit(CalcDate(ObjGenSetUp."Retirement Age", ObjMembers."Date of Birth"));
    end;

    procedure FnGetTransferFee(DisbursementMode: Option " ",Cheque,"Bank Transfer",EFT,RTGS,"Cheque NonMember"): Decimal
    var
        TransferFee: Decimal;
    begin
        ObjGenSetUp.Get();
        case DisbursementMode of
            Disbursementmode::"Bank Transfer":
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-FOSA";

            Disbursementmode::Cheque:
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-Cheque";

            Disbursementmode::"Cheque NonMember":
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-EFT";

            Disbursementmode::EFT:
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-RTGS";
        end;
        exit(TransferFee);
    end;



    procedure FnCreateGnlJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; BalancingAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member; BalancingAccountNo: Code[40])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    procedure FnChargeExcise(ChargeCode: Code[100]): Boolean
    var
        ObjProductCharges: Record "Loan Product Charges";
    begin
        /*ObjProductCharges.RESET;
        ObjProductCharges.SETRANGE(Code,ChargeCode);
        IF ObjProductCharges.FIND('-') THEN
          EXIT(ObjProductCharges."Charge Excise");
          */
    end;

    procedure FnGetInterestDueTodate(ObjLoans: Record "Loans Register"): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", '..' + Format(Today));
        ObjLoans.CalcFields("Schedule Interest to Date", "Outstanding Balance");
        exit(ObjLoans."Schedule Interest to Date");
    end;

    procedure FnGetPhoneNumber(ObjLoans: Record "Loans Register"): Code[50]
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange("No.", ObjLoans."BOSA No");
        if ObjMembers.Find('-') then
            exit(ObjMembers."Phone No.");
    end;

    procedure FnGenerateRepaymentSchedule(LoanNumber: Code[50])
    var
        LoansRec: Record "Loans Register";
        TotalsInSchedule: Decimal;
        LoanAmountSchedule: Decimal;
        RSchedule: Record "Loan Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrPrinciple: Integer;
        GrInterest: Integer;
        RepayCode: Code[10];
        WhichDay: Integer;
        InterestVarianceOnlyNafaka: Decimal;
    begin
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
        //LoansRec.SetFilter(LoansRec.Posted, '=%1', false);
        if LoansRec.Find('-') then
            if (LoansRec."Repayment Start Date" <> 0D) then begin
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
                RSchedule.DeleteAll;

                LoanAmount := LoansRec."Approved Amount";
                InterestRate := LoansRec.Interest;
                RepayPeriod := LoansRec.Installments;
                InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
                LBalance := LoansRec."Approved Amount";
                RunDate := LoansRec."Repayment Start Date";
                InstalNo := 0;

                //Repayment Frequency
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                    RunDate := CalcDate('-1D', RunDate)
                else
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('-1W', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                            RunDate := CalcDate('-1M', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                RunDate := CalcDate('-1Q', RunDate);
                //Repayment Frequency

                repeat
                    InstalNo := InstalNo + 1;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                RunDate := CalcDate('1M', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                    RunDate := CalcDate('1Q', RunDate);

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                        LoansRec.TestField(LoansRec.Installments);
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin

                        LoansRec.TestField(LoansRec.Repayment);

                        LPrincipal := LoansRec.Repayment;
                        LInterest := Round((LoansRec."Loan Interest Repayment") / LoansRec.Installments, 0.0001, '>');
                    end;

                    //Grace Period
                    if GrPrinciple > 0 then
                        LPrincipal := 0
                    else
                        LBalance := LBalance - LPrincipal;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    Evaluate(RepayCode, Format(InstalNo));

                    RSchedule.Init;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := LoansRec."Loan  No.";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    //RSchedule."Repayment Date" := RunDate;
                    RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                    RSchedule."Member No." := LoansRec."Client Code";
                    RSchedule."Loan Category" := LoansRec."Loan Product Type";
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule."Loan Balance" := LBalance;
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1;
            end;

        Commit;
    end;

    procedure FnGetInterestDueFiltered(ObjLoans: Record "Loans Register"; DateFilter: Text): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", DateFilter);
        ObjLoans.CalcFields("Schedule Interest to Date", "Outstanding Balance");
        exit(ObjLoans."Schedule Interest to Date");
    end;

    procedure FnGetUpfrontsTotal(ProductCode: Code[50]; InsuredAmount: Decimal) FCharged: Decimal
    var
        ObjLoanCharges: Record "Loan Product Charges";
    begin
        ObjProductCharges.Reset;
        ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
        if ObjProductCharges.Find('-') then
            repeat
                if ObjProductCharges."Use Perc" = true then begin
                    FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100) + FCharged;
                    if ObjLoanCharges.Get(ObjProductCharges.Code) then
                        if ObjLoanCharges."Charge Excise" = true then
                            FCharged := FCharged + (InsuredAmount * (ObjProductCharges.Percentage / 100)) * 0.1;
                end
                else begin
                    FCharged := ObjProductCharges.Amount + FCharged;
                    if ObjLoanCharges.Get(ObjProductCharges.Code) then
                        if ObjLoanCharges."Charge Excise" = true then
                            FCharged := FCharged + ObjProductCharges.Amount * 0.1;
                end
            until ObjProductCharges.Next = 0;

        exit(FCharged);
    end;

    procedure FnGetPrincipalDueFiltered(ObjLoans: Record "Loans Register"; DateFilter: Text): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", DateFilter);
        ObjLoans.CalcFields(ObjLoans."Schedule Repayments", ObjLoans."Principal Paid", ObjLoans."Outstanding Balance");
        if ObjLoans."Outstanding Balance" > 0 then
            exit((ObjLoans."Schedule Repayments") - (ObjLoans."Approved Amount" - ObjLoans."Outstanding Balance"));
        exit(0);
    end;

    local procedure FnGetDate(DFilter: Text): Date
    var
        strDate1: Text;
        date1: Date;
        convString: Text;
    begin
        Evaluate(date1, CopyStr(DFilter, 1, 10));
        exit(date1);
    end;

    procedure FnLoanPaidAmount(ObjLoans: Record "Loans Register"; DFilter: Text) LoanBalance: Decimal
    var
        ObjLoansRegister: Record "Loans Register";
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan  No.", ObjLoans."Loan  No.");
        ObjLoansRegister.SetFilter("Date filter", DFilter);
        if ObjLoansRegister.Find('-') then begin
            ObjLoansRegister.CalcFields(ObjLoansRegister."Principal Paid");
            LoanBalance := ObjLoansRegister."Principal Paid";
        end;
        exit(LoanBalance);
    end;

    procedure FnGetSavingsProductAccount(MemberNo: Code[50]; ProductCode: Code[100]) FosaAccount: Code[50]
    var
        ObjVendor: Record Vendor;
    begin
        ObjVendor.Reset;
        ObjVendor.SetRange(ObjVendor."BOSA Account No", MemberNo);
        ObjVendor.SetRange(ObjVendor."Account Type", ProductCode);
        if ObjVendor.Find('-') then
            FosaAccount := ObjVendor."No.";
        exit(FosaAccount);
    end;

    procedure FnCreateGnlJournalLineMC(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; GroupCode: Code[100])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."Group Code" := GroupCode;
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    procedure FnCreateGnlJournalLineAtm(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; TraceID: Code[100])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."ATM SMS" := true;
        GenJournalLine."Trace ID" := TraceID;
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    procedure FnCreateGnlJournalLineBalancedCashier(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; BalancingAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member; BalancingAccountNo: Code[40]; OverdraftNo: Code[100]; OverDraftTransaction: Option " ","Overdraft Granted","Overdraft Paid","Interest Accrued","Interest paid")
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;

        GenJournalLine."Overdraft codes" := OverDraftTransaction;
        GenJournalLine."Overdraft NO" := OverdraftNo;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    procedure FnGetBosaTransferFeeBudding(TransAmount: Decimal) TCharge: Decimal
    var
        ObjBosaTransferFee: Record "BOSA Transaction Fees";
    begin
        ObjBosaTransferFee.Reset;
        ObjBosaTransferFee.SetFilter(ObjBosaTransferFee."Lower Limit", '<=%1', TransAmount);
        ObjBosaTransferFee.SetFilter(ObjBosaTransferFee."Upper Limit", '>=%1', TransAmount);
        TCharge := 0;
        if ObjBosaTransferFee.Find('-') then
            exit(ObjBosaTransferFee."Charge Amount");
    end;



    procedure FnPrincipalOverPaymentDetected(TransactionAmount: Decimal; OutstandingBalance: Decimal): Boolean
    begin
        exit((OutstandingBalance - TransactionAmount) < 0);
    end;

    procedure FnGetOutstandingBalance(LoanNumber: Code[100]; DateFilter: Text): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNumber);
        ObjLoans.SetFilter("Date filter", DateFilter);
        if ObjLoans.Find('-') then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            exit(ObjLoans."Outstanding Balance");
        end;
    end;

    procedure FnCreateGnlJournalLineBalancedFOSA(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; ObjVendor: Record Vendor; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; BalancingAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member; BalancingAccountNo: Code[40])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := ObjVendor."Global Dimension 1 Code";
        GenJournalLine."Shortcut Dimension 2 Code" := ObjVendor."Global Dimension 2 Code";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    procedure FnGenereateDocumentNo(PostingDate: Date): Code[100]
    var
        rtVal: Code[100];
    begin
        case Date2dmy(PostingDate, 2) of
            1:
                rtVal := 'JAN';
            2:
                rtVal := 'FEB';
            3:
                rtVal := 'MAR';
            4:
                rtVal := 'APR';
            5:
                rtVal := 'MAY';
            6:
                rtVal := 'JUN';
            7:
                rtVal := 'JUL';
            8:
                rtVal := 'AUG';
            9:
                rtVal := 'SEP';
            10:
                rtVal := 'OCT';
            11:
                rtVal := 'NOV';
            12:
                rtVal := 'DEC';
        end;
        exit(rtVal + Format(Date2dmy(PostingDate, 3)));
    end;

    // procedure FnGetLoanOfficerFromMemberNo(MemberNo: Code[100]): Code[100]
    // var
    //     ObjMembers: Record Customer;
    //     ObjGroups: Record Customer;
    //     ObjLoanOfficers: Record "Loan Officers Details";
    // begin
    //     ObjMembers.Reset;
    //     ObjMembers.SetRange(ObjMembers."No.", MemberNo);
    //     if ObjMembers.Find('-') then begin
    //         ObjGroups.Reset;
    //         // ObjGroups.SetRange(ObjGroups."No.", ObjMembers."Group Account No");
    //         if ObjGroups.Find('-') then begin
    //             ObjLoanOfficers.Reset;
    //             ObjLoanOfficers.SetRange(ObjLoanOfficers.Name, ObjGroups."Loan Officer Name");
    //             if ObjLoanOfficers.Find('-') then
    //                 exit(ObjLoanOfficers."Account No.");
    //         end
    //     end;
    // end;

    procedure FnGenerateRepaymentScheduleHistorical(LoanNumber: Code[50])
    var
        LoansRec: Record "Loans Register";
        RSchedule: Record "Loan Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrPrinciple: Integer;
        GrInterest: Integer;
        RepayCode: Code[10];
        WhichDay: Integer;
        InterestVarianceOnlyNafaka: Decimal;
    begin
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
        LoansRec.SetFilter(LoansRec.Posted, '=%1', true);
        if LoansRec.Find('-') then
            if ((LoansRec."Issued Date" <> 0D) and (LoansRec."Repayment Start Date" <> 0D)) then begin
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
                RSchedule.DeleteAll;

                LoanAmount := LoansRec."Approved Amount";
                InterestRate := LoansRec.Interest;
                RepayPeriod := LoansRec.Installments;
                InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
                LBalance := LoansRec."Approved Amount";
                RunDate := LoansRec."Repayment Start Date";
                InstalNo := 0;

                //Repayment Frequency
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                    RunDate := CalcDate('-1D', RunDate)
                else
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('-1W', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                            RunDate := CalcDate('-1M', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                RunDate := CalcDate('-1Q', RunDate);
                //Repayment Frequency

                repeat
                    InstalNo := InstalNo + 1;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                RunDate := CalcDate('1M', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                    RunDate := CalcDate('1Q', RunDate);

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                        //LoansRec.TESTFIELD(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
                        LoansRec.TestField(LoansRec.Repayment);
                        if LBalance < LoansRec.Repayment then
                            LPrincipal := LBalance
                        else
                            LPrincipal := LoansRec.Repayment;
                        LInterest := LoansRec.Interest;
                    end;

                    //Grace Period
                    if GrPrinciple > 0 then
                        LPrincipal := 0
                    else
                        LBalance := LBalance - LPrincipal;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    Evaluate(RepayCode, Format(InstalNo));

                    RSchedule.Init;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := LoansRec."Loan  No.";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                    RSchedule."Member No." := LoansRec."Client Code";
                    RSchedule."Loan Category" := LoansRec."Loan Product Type";
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1
            end;

        Commit;
    end;

    procedure FnPostGnlJournalLine(TemplateName: Text; BatchName: Text)
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name", TemplateName);
        GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name", BatchName);
        IF GenJournalLine.FINDSET THEN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
    end;

    procedure FnCreateGnlJournalLineBalanced(JTemplate: Code[20]; JBatch: Code[20]; DocNo: Code[20]; LineNo: Integer; TransType: Option; Accounttype: Option; ChargeAccount: Code[20]; Today: Date; arg1: Text; Balaccounttype: Option; LodgeFeeAccount: Code[20]; LodgeFee: Decimal; arg2: Text; arg3: Text)
    begin
        Error('Procedure FnCreateGnlJournalLineBalanced not implemented.');
    end;


    //-----------------------------------------
    procedure FnGetMemberLiability(MemberNo: Code[30]) VarTotaMemberLiability: Decimal
    var
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        ObjLoans: Record "Loans Register";
        //  ObjLoanSecurities: Record "Loan Collateral Details";
        ObjLoanGuarantors2: Record "Loans Guarantee Details";
        VarTotalGuaranteeValue: Decimal;
        VarMemberAnountGuaranteed: Decimal;
        VarApportionedLiability: Decimal;
        VarLoanOutstandingBal: Decimal;
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin

            VarTotalGuaranteeValue := 0;
            VarApportionedLiability := 0;
            VarTotaMemberLiability := 0;
            //Loans Guaranteed=======================================================================
            ObjLoanGuarantors.CalcFields(ObjLoanGuarantors."Outstanding Balance");
            ObjLoanGuarantors.Reset;
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Member No", MemberNo);
            ObjLoanGuarantors.SetFilter(ObjLoanGuarantors."Outstanding Balance", '>%1', 0);
            if ObjLoanGuarantors.FindSet then
                repeat
                    if ObjLoanGuarantors."Amont Guaranteed" > 0 then begin
                        ObjLoanGuarantors.CalcFields(ObjLoanGuarantors."Total Loans Guaranteed");
                        if ObjLoans.Get(ObjLoanGuarantors."Loan No") then begin
                            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                            if ObjLoans."Outstanding Balance" > 0 then begin
                                VarLoanOutstandingBal := ObjLoans."Outstanding Balance";
                                if ObjLoanGuarantors."Total Loans Guaranteed" <> 0 then
                                    VarApportionedLiability := ROUND((ObjLoanGuarantors."Amont Guaranteed" / ObjLoanGuarantors."Total Loans Guaranteed") * VarLoanOutstandingBal, 0.5, '=');
                            end
                        end;
                    end;
                    VarTotaMemberLiability := VarTotaMemberLiability + VarApportionedLiability;
                until ObjLoanGuarantors.Next = 0;
        end;
        exit(VarTotaMemberLiability);
    end;

    procedure FnRunGetLoanPayoffAmount(VarLoanNo: Code[30]) VarLoanPayoffAmount: Decimal
    var
        ObjLoans: Record "Loans Register";
        VarInsurancePayoff: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarOutstandingInterest: Decimal;
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarLoanInsuranceCharged: Decimal;
        VarLoanInsurancePaid: Decimal;
        VarOutstandingInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
        VarTotalInterestPaid: Decimal;
        VarTotalPenaltyPaid: Decimal;
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
            ObjLoans."Interest Paid");
            //============================================================Loan Insurance Repayment
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
            if ObjLoans.Find('-') then begin

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
                    ObjLoans."Interest Paid");

                    if (ObjLoans."Outstanding Balance" <> 0) then begin
                        VarEndYear := CalcDate('CY', Today);

                        ObjLoanSchedule.Reset;
                        ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNo);
                        ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '>%1&<=%2', WorkDate, VarEndYear);
                        if ObjLoanSchedule.FindSet then
                            VarInsurancePayoff := 0;
                    end;
                end;

                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNo);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<=%1', WorkDate);
                if ObjLoanSchedule.FindSet then
                    repeat
                        VarLoanInsuranceCharged := 0;
                        VarLoanInsurancePaid := 0;
                    until ObjLoanSchedule.Next = 0;

                VarOutstandingInsurance := 0;

                VarOutstandingInterest := ObjLoans."Interest Due" - (ObjLoans."Interest Paid");
                if VarOutstandingInterest < 0 then
                    VarOutstandingInterest := 0;

                VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid");
                if VarOutstandingPenalty < 0 then
                    VarOutstandingPenalty := 0;

                VarTotalInterestPaid := ObjLoans."Interest Paid";
                VarTotalPenaltyPaid := ObjLoans."Penalty Paid";
                if ObjLoans.Get(VarLoanNo) then begin
                    ObjLoans."Outstanding Penalty" := VarOutstandingPenalty;
                    ObjLoans."Outstanding Insurance" := VarOutstandingInsurance;
                    ObjLoans."Loan Insurance Charged" := VarLoanInsuranceCharged;
                    ObjLoans."Total Insurance Paid" := VarLoanInsurancePaid;
                    ObjLoans."Total Penalty Paid" := VarTotalPenaltyPaid;
                    ObjLoans."Total Interest Paid" := VarTotalInterestPaid;
                    ObjLoans."Insurance Payoff" := VarInsurancePayoff;
                    ObjLoans.Modify;
                end;
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                VarLoanPayoffAmount := ObjLoans."Outstanding Balance" + VarOutstandingInterest + VarOutstandingPenalty + (VarOutstandingInsurance + VarInsurancePayoff);
                exit(VarLoanPayoffAmount);
            end;
        end;
    end;
    //=-----------------------
    procedure FnGeneratePostedLoansMissingRepaymentSchedule(LoanNumber: Code[50])
    var
        LoansRec: Record "Loans Register";
        RSchedule: Record "Loan Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrPrinciple: Integer;
        GrInterest: Integer;
        RepayCode: Code[10];
        WhichDay: Integer;
        InterestVarianceOnlyNafaka: Decimal;
    begin
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
        LoansRec.SetRange(LoansRec.Posted, true);
        if LoansRec.Find('-') then
            if (LoansRec."Repayment Start Date" <> 0D) then begin
                if LoansRec."Loan Disbursement Date" = 0D then
                    LoansRec."Loan Disbursement Date" := 20170101D;
                if LoansRec."Repayment Start Date" = 0D then
                    LoansRec."Repayment Start Date" := 20170201D;
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");
                if LoansRec.Interest = 0 then
                    LoansRec.Interest := 10;
                if LoansRec.Installments = 0 then
                    LoansRec.Installments := 12;

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
                if RSchedule.Find('-') = false then begin
                    LoanAmount := LoansRec."Approved Amount";
                    InterestRate := LoansRec.Interest;
                    RepayPeriod := LoansRec.Installments;
                    InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
                    LBalance := LoansRec."Approved Amount";
                    RunDate := LoansRec."Repayment Start Date";
                    InstalNo := 0;

                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('-1D', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                            RunDate := CalcDate('-1W', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                RunDate := CalcDate('-1M', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                    RunDate := CalcDate('-1Q', RunDate);
                    //Repayment Frequency

                    repeat
                        InstalNo := InstalNo + 1;
                        //Repayment Frequency
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                            RunDate := CalcDate('1D', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                                RunDate := CalcDate('1W', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                    RunDate := CalcDate('1M', RunDate)
                                else
                                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                        RunDate := CalcDate('1Q', RunDate);

                        if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                            //LoansRec.TESTFIELD(LoansRec.Interest);
                            LoansRec.TestField(LoansRec.Installments);
                            TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                            LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                            LPrincipal := TotalMRepay - LInterest;
                        end;

                        if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                            LoansRec.TestField(LoansRec.Interest);
                            LoansRec.TestField(LoansRec.Installments);
                            LPrincipal := LoanAmount / RepayPeriod;
                            LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                        end;

                        if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
                            LoansRec.TestField(LoansRec.Interest);
                            LoansRec.TestField(LoansRec.Installments);
                            LPrincipal := LoanAmount / RepayPeriod;
                            LInterest := (InterestRate / 12 / 100) * LBalance;
                        end;

                        if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
                            //LoansRec.TestField(LoansRec.Repayment);
                            // if LBalance < LoansRec.Repayment then
                            //     LPrincipal := LBalance
                            // else
                            LPrincipal := LoansRec.Repayment;
                            LInterest := Round((LoansRec."Loan Interest Repayment") / LoansRec.Installments, 0.0001, '>');
                        end;

                        //Grace Period
                        if GrPrinciple > 0 then
                            LPrincipal := 0
                        else
                            LBalance := LBalance - LPrincipal;

                        GrPrinciple := GrPrinciple - 1;
                        GrInterest := GrInterest - 1;
                        Evaluate(RepayCode, Format(InstalNo));

                        RSchedule.Init;
                        RSchedule."Repayment Code" := RepayCode;
                        RSchedule."Interest Rate" := InterestRate;
                        RSchedule."Loan No." := LoansRec."Loan  No.";
                        RSchedule."Loan Amount" := LoanAmount;
                        RSchedule."Instalment No" := InstalNo;
                        RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                        RSchedule."Member No." := LoansRec."Client Code";
                        RSchedule."Loan Category" := LoansRec."Loan Product Type";
                        RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                        RSchedule."Monthly Interest" := LInterest;
                        RSchedule."Principal Repayment" := LPrincipal;
                        RSchedule.Insert;
                        WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                    until LBalance < 1
                end;
            end;

        Commit;
    end;

    procedure FnGetDocumentApprover(DocumentNo: Code[20]): Code[100]
    var
        ApprovedEntries: Record "Posted Approval Entry";
    begin
        ApprovedEntries.Reset();
        ApprovedEntries.SetRange(ApprovedEntries."Document No.", DocumentNo);
        if ApprovedEntries.Find('-') then
            exit(ApprovedEntries."Approver ID");
        exit('Direct Posting');
    end;
    //.......................................................
    procedure FnCreateJournalLines(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: enum TransactionTypesEnum; AccountType: enum "Gen. Journal Account Type";
                                                                                                                                    AccountNo: Code[50];
                                                                                                                                    TransactionDate: Date;
                                                                                                                                    TransactionAmount: Decimal;
                                                                                                                                    DimensionActivity: Code[40];
                                                                                                                                    ExternalDocumentNo: Code[50];
                                                                                                                                    TransactionDescription: Text;
                                                                                                                                    LoanNumber: Code[50])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;
    //........................................Fn Recover On LoanOverdrafts

}
