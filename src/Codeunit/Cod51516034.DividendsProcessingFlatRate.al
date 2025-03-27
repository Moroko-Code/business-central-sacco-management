// codeunit 51516034 "Dividends Processing-Flat Rate"
// {
//     trigger OnRun()
//     begin
//     end;

//     var
//         MemberRegister: Record customer;
//         CustLedgerEntry: Record "Cust. Ledger Entry";
//         DivRegister: Record "Dividends Register Flat Rate";
//         SaccoGenSetUp: Record "Sacco General Set-Up";
//         GenJournalLine: Record "Gen. Journal Line";
//         LineNo: Integer;
//         ComputerSharesInterestEarned: Decimal;
//         EntryNo: Integer;
//         VanSharesInterestEarned: Decimal;
//         PreferentialSharesInterestEarned: Decimal;
//         LiftSharesInterestEarned: Decimal;
//         TambaaSharesInterestEarned: Decimal;
//         PepeaSharesInterestEarned: Decimal;
//         HousingSharesInterestEarned: Decimal;
//         NWDSharesInterestEarned: Decimal;
//         FOSASharesInterestEarned: Decimal;
//         NetDividendsPayableToMember: Decimal;
//         CapitalizedDividendAmount: Decimal;
//         NetTransferToFOSA: Decimal;
//         RunningBalance: Decimal;
//     //.................................Dividends Processing flat rate start
//     procedure FnProcessDividendsFlatRate(MemberNo: Code[50]; StartDate: Date; EndDate: Date)
//     begin
//         MemberRegister.reset;
//         MemberRegister.SetRange(MemberRegister."No.", MemberNo);
//         MemberRegister.SetAutoCalcFields(MemberRegister."Current Shares", MemberRegister."Fosa Shares", MemberRegister."van Shares", MemberRegister."Preferencial Building Shares", MemberRegister."Lift Shares", MemberRegister."Tamba Shares", MemberRegister."Pepea Shares", MemberRegister."Housing Deposits");
//         if MemberRegister.find('-') then begin
//             //2 Delete Previous Entries Of the Member
//             DivRegister.Reset();
//             DivRegister.SetRange(DivRegister."Member No", MemberNo);
//             DivRegister.SetRange(DivRegister."Dividend Year", format(DATE2DMY((EndDate), 3)));
//             if DivRegister.Find('-') then begin
//                 DivRegister.DeleteAll();
//             end;
//             //1 Get NWD Shares Earned
//             NWDSharesInterestEarned := 0;
//             NWDSharesInterestEarned := FnProcessInterestEarnedOnCurrentShares(MemberRegister."No.", StartDate, EndDate, MemberRegister."Current Shares");
//             //2 Get FOSA Shares Interest Earned
//             // FOSASharesInterestEarned := 0;
//             // FOSASharesInterestEarned := FnProcessInterestEarnedOnFOSAShares(MemberRegister."No.", StartDate, EndDate, MemberRegister."Fosa Shares");
//             //3 Computer Shares Interest Earned
//             // ComputerSharesInterestEarned := 0;
//             // ComputerSharesInterestEarned := FnProcessInterestEarnedOnComputerShares(MemberRegister."No.", StartDate, EndDate, MemberRegister."Computer Shares");
//             //4 Van Shares Interest Earned
//             // VanSharesInterestEarned := 0;
//             // VanSharesInterestEarned := FnProcessInterestEarnedOnVanShares(MemberRegister."No.", StartDate, EndDate, MemberRegister."van Shares");
//             //5 Preferential Shares Interest Earned
//             // PreferentialSharesInterestEarned := 0;
//             // PreferentialSharesInterestEarned := FnProcessInterestEarnedOnPreferentialShares(MemberRegister."No.", StartDate, EndDate, MemberRegister."Preferencial Building Shares");
//             //6 Lift Shares Interest Earned
//             // LiftSharesInterestEarned := 0;
//             LiftSharesInterestEarned := FnProcessInterestEarnedOnLiftShares(MemberRegister."No.", StartDate, EndDate, MemberRegister."Lift Shares");
//             //7 Tambaa Shares Interest Earned
//             // TambaaSharesInterestEarned := 0;
//             // TambaaSharesInterestEarned := FnProcessInterestEarnedOnTambaaShares(MemberRegister."No.", StartDate, EndDate, MemberRegister."Tamba Shares");
//             //8 Pepea Shares Interest Earned
//             // PepeaSharesInterestEarned := 0;
//             // PepeaSharesInterestEarned := FnProcessInterestEarnedOnPepeaShares(MemberRegister."No.", StartDate, EndDate, MemberRegister."Pepea Shares");
//             //9 Housing Shares Interest Earned
//             // HousingSharesInterestEarned := 0;
//             // HousingSharesInterestEarned := FnProcessInterestEarnedOnHousingShares(MemberRegister."No.", StartDate, EndDate, MemberRegister."Housing Deposits");
//             //--------------GET NET DIVIDENDS PAYABLE TO MEMBER(Inclusive of capitalzed amount)
//             NetDividendsPayableToMember := 0;
//             NetDividendsPayableToMember := ComputerSharesInterestEarned + FOSASharesInterestEarned + NWDSharesInterestEarned + VanSharesInterestEarned + PreferentialSharesInterestEarned + LiftSharesInterestEarned + PepeaSharesInterestEarned + TambaaSharesInterestEarned + HousingSharesInterestEarned;
//             //--------------Get Capitalized Amount
//             CapitalizedDividendAmount := 0;
//             CapitalizedDividendAmount := FnCapitalizeDividendsAmount(NetDividendsPayableToMember, MemberRegister."No.", EndDate);
//             //--------------Net Transfer To  Member FOSA A/c
//             NetTransferToFOSA := 0;
//             NetTransferToFOSA := FnTransferNetDividendToFOSA((NetDividendsPayableToMember - CapitalizedDividendAmount), MemberRegister."No.", EndDate);
//             //--------------Deduct processing fees

//             //--------------Recover Dividend Loan interest
//             If FnOutstandingDivLoanIntBal(MemberRegister."No.") > 0 then begin
//                 RunningBalance := FnRecoverOutstDivInterest(MemberRegister."No.", NetTransferToFOSA, EndDate);
//             end;
//             //--------------Recover Dividend Loan Balance
//             if RunningBalance > 0 then begin
//                 FnRecoverOutstDivBal(MemberRegister."No.", RunningBalance, EndDate);
//             end;
//         end;
//     end;

//     local procedure FnProcessInterestEarnedOnCurrentShares(No: Code[20]; StartDate: Date; EndDate: Date; CurrentShares: Decimal): Decimal
//     var
//         QualifyingDepositContribs: Decimal;
//     begin
//         //1_Get the Qualifying Deposit Contributions Amounts
//         QualifyingDepositContribs := 0;
//         CustLedgerEntry.Reset();
//         CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Deposit Contribution");
//         CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', 0D, EndDate);
//         IF CustLedgerEntry.FIND('-') then begin
//             repeat
//                 QualifyingDepositContribs += (CustLedgerEntry."Amount Posted") * -1;
//             until CustLedgerEntry.next = 0;
//         end;

//         //3 Process the amounts One Qualifies to be paid
//         DivRegister.Reset();
//         if DivRegister.Find('+') = true then begin
//             EntryNo := DivRegister."Entry No" + 1;
//         end else
//             if DivRegister.Find('+') = false then begin
//                 EntryNo := 1;
//             end;
//         SaccoGenSetUp.Get();
//         DivRegister.Init();
//         DivRegister."Entry No" := EntryNo;
//         DivRegister."Member No" := No;
//         DivRegister."Date Processed" := Today;
//         DivRegister."Dividend Year" := format(DATE2DMY((EndDate), 3));
//         DivRegister."Current Shares" := CurrentShares;
//         DivRegister."Qualifying Current Shares" := QualifyingDepositContribs;
//         DivRegister."Gross Interest -Current Shares" := (((SaccoGenSetUp."Interest On Current Shares") / 100) * QualifyingDepositContribs);
//         DivRegister."WTX -Current Shares" := ((SaccoGenSetUp."Withholding Tax (%)" / 100) * DivRegister."Gross Interest -Current Shares");
//         DivRegister."Net Interest -Current Shares" := (DivRegister."Gross Interest -Current Shares") - (DivRegister."WTX -Current Shares");
//         DivRegister.Insert();
//         //4 Insert To GL's
//         //A)GROSS
//         //i)Bank Account
//         SaccoGenSetUp.Get();
//         SaccoGenSetUp.TestField(SaccoGenSetUp."Dividends Paying Bank Account");
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
//         GenJournalLine."Account No." := SaccoGenSetUp."Dividends Paying Bank Account";
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Gross Interest Earned On NWD Year-' + format(DATE2DMY((EndDate), 3)) + ' paid to-' + Format(No);
//         GenJournalLine.Amount := DivRegister."Gross Interest -Current Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         //ii)Member Account
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Gross Interest Earned On NWD Year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := -DivRegister."Gross Interest -Current Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;

//         //B)WTX
//         SaccoGenSetUp.Get();
//         if DivRegister."WTX -Current Shares" <> 0 then begin
//             SaccoGenSetUp.TestField(SaccoGenSetUp."Withholding Tax Account");
//         end;
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Witholding Tax On-Gross Interest(NWD) Year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := DivRegister."WTX -Current Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
//         GenJournalLine."Bal. Account No." := SaccoGenSetUp."Withholding Tax Account";
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         exit(DivRegister."Net Interest -Current Shares");
//     end;

//     //------------------------------------------------------------------------------------------------------------------------------------------------
//     local procedure FnProcessInterestEarnedOnFOSAShares(No: Code[20]; StartDate: Date; EndDate: Date; FosaShares: Decimal): Decimal
//     var
//         QualifyingFOSAShares: Decimal;
//     begin
//         //1_Get the Qualifying Deposit Contributions Amounts
//         // QualifyingFOSAShares := 0;
//         // CustLedgerEntry.Reset();
//         // CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         // CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"FOSA Shares");
//         // CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         // CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', 0D, EndDate);
//         // IF CustLedgerEntry.FIND('-') then begin
//         //     repeat
//         //         QualifyingFOSAShares += (CustLedgerEntry."Amount Posted") * -1;
//         //     until CustLedgerEntry.next = 0;
//         // end;

//         //2 Process the amounts One Qualifies to be paid

//         SaccoGenSetUp.Get();
//         SaccoGenSetUp.Get();
//         DivRegister.Reset();
//         DivRegister.SetRange(DivRegister."Member No", No);
//         DivRegister.SetRange(DivRegister."Dividend Year", format(DATE2DMY((EndDate), 3)));
//         if DivRegister.Find('-') = true then begin
//             DivRegister."FOSA Shares" := FosaShares;
//             DivRegister."Qualifying FOSA Shares" := QualifyingFOSAShares;
//             DivRegister."Gross Interest -FOSA Shares" := (((SaccoGenSetUp."Interest On FOSA Shares") / 100) * QualifyingFOSAShares);
//             DivRegister."WTX -FOSA Shares" := ((SaccoGenSetUp."Withholding Tax (%)" / 100) * DivRegister."Gross Interest -FOSA Shares");
//             DivRegister."Net Interest -FOSA Shares" := (DivRegister."Gross Interest -FOSA Shares") - (DivRegister."WTX -FOSA Shares");
//             DivRegister.Modify(true);
//         end else
//             if DivRegister.Find('-') = false then begin
//                 Error('Could not insert into dividends register');
//             end;
//         //4 Insert To GL's
//         //A)GROSS
//         //i)Bank Account
//         SaccoGenSetUp.Get();
//         SaccoGenSetUp.TestField(SaccoGenSetUp."Dividends Paying Bank Account");
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
//         GenJournalLine."Account No." := SaccoGenSetUp."Dividends Paying Bank Account";
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Gross Interest Earned On FOSA Shares Year-' + format(DATE2DMY((EndDate), 3)) + ' paid to-' + Format(No);
//         GenJournalLine.Amount := DivRegister."Gross Interest -FOSA Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         //ii)Member Account
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Gross Interest Earned On FOSA Shares Year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := -DivRegister."Gross Interest -FOSA Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;

//         //B)WTX
//         SaccoGenSetUp.Get();
//         if DivRegister."WTX -FOSA Shares" <> 0 then begin
//             SaccoGenSetUp.TestField(SaccoGenSetUp."Withholding Tax Account");
//         end;
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Witholding Tax On-Gross FOSA Interest Year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := DivRegister."WTX -FOSA Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
//         GenJournalLine."Bal. Account No." := SaccoGenSetUp."Withholding Tax Account";
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         exit(DivRegister."Net Interest -FOSA Shares");
//     end;
//     //------------------------------------------------------------------------------------------------------------------------------------------------
//     // local procedure FnProcessInterestEarnedOnComputerShares(No: Code[20]; StartDate: Date; EndDate: Date; ComputerShares: Decimal): Decimal
//     // var
//     //     QualifyingComputerShares: Decimal;
//     // begin
//     //     //1_Get the Qualifying Deposit Contributions Amounts
//     //     QualifyingComputerShares := 0;
//     //     CustLedgerEntry.Reset();
//     //     CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//     //     CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Computer Shares");
//     //     CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//     //     CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', 0D, EndDate);
//     //     IF CustLedgerEntry.FIND('-') then begin
//     //         repeat
//     //             QualifyingComputerShares += (CustLedgerEntry."Amount Posted") * -1;
//     //         until CustLedgerEntry.next = 0;
//     //     end;

//     //     //2 Process the amounts One Qualifies to be paid
//     //     SaccoGenSetUp.Get();
//     //     DivRegister.Reset();
//     //     DivRegister.SetRange(DivRegister."Member No", No);
//     //     DivRegister.SetRange(DivRegister."Dividend Year", format(DATE2DMY((EndDate), 3)));
//     //     if DivRegister.Find('-') = true then begin
//     //         DivRegister."Computer Shares" := ComputerShares;
//     //         DivRegister."Qualifying Computer Shares" := QualifyingComputerShares;
//     //         DivRegister."Gross Interest-Computer Shares" := (((SaccoGenSetUp."Interest On Computer Shares") / 100) * QualifyingComputerShares);
//     //         DivRegister."WTX -Computer Shares" := ((SaccoGenSetUp."Withholding Tax (%)" / 100) * DivRegister."Gross Interest-Computer Shares");
//     //         DivRegister."Net Interest -Computer Shares" := (DivRegister."Gross Interest-Computer Shares") - (DivRegister."WTX -Computer Shares");
//     //         DivRegister.Modify(true);
//     //     end else
//     //         if DivRegister.Find('-') = false then begin
//     //             Error('Could not insert into dividends register');
//     //         end;
//     //     //4 Insert To GL's
//     //     //A)GROSS
//     //     //i)Bank Account
//     //     SaccoGenSetUp.Get();
//     //     SaccoGenSetUp.TestField(SaccoGenSetUp."Dividends Paying Bank Account");
//     //     LineNo := LineNo + 10000;
//     //     GenJournalLine.Init;
//     //     GenJournalLine."Journal Template Name" := 'GENERAL';
//     //     GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//     //     GenJournalLine."Line No." := LineNo;
//     //     GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
//     //     GenJournalLine."Account No." := SaccoGenSetUp."Dividends Paying Bank Account";
//     //     GenJournalLine.Validate(GenJournalLine."Account No.");
//     //     GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//     //     GenJournalLine."Posting Date" := Today;
//     //     GenJournalLine.Description := 'Gross Interest Earned On Computer Shares Year-' + format(DATE2DMY((EndDate), 3)) + ' paid to-' + Format(No);
//     //     GenJournalLine.Amount := DivRegister."Gross Interest-Computer Shares";
//     //     GenJournalLine.Validate(GenJournalLine.Amount);
//     //     GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//     //     GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//     //     if GenJournalLine.Amount <> 0 then
//     //         GenJournalLine.Insert;
//     //     //ii)Member Account
//     //     LineNo := LineNo + 10000;
//     //     GenJournalLine.Init;
//     //     GenJournalLine."Journal Template Name" := 'GENERAL';
//     //     GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//     //     GenJournalLine."Line No." := LineNo;
//     //     GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//     //     GenJournalLine."Account No." := No;
//     //     GenJournalLine.Validate(GenJournalLine."Account No.");
//     //     GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//     //     GenJournalLine."Posting Date" := Today;
//     //     GenJournalLine.Description := 'Gross Interest Earned On Computer Shares Year-' + format(DATE2DMY((EndDate), 3));
//     //     GenJournalLine.Amount := -DivRegister."Gross Interest-Computer Shares";
//     //     GenJournalLine.Validate(GenJournalLine.Amount);
//     //     GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//     //     GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//     //     GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//     //     if GenJournalLine.Amount <> 0 then
//     //         GenJournalLine.Insert;

//     //     //B)WTX
//     //     SaccoGenSetUp.Get();
//     //     if DivRegister."WTX -FOSA Shares" <> 0 then begin
//     //         SaccoGenSetUp.TestField(SaccoGenSetUp."Withholding Tax Account");
//     //     end;
//     //     LineNo := LineNo + 10000;
//     //     GenJournalLine.Init;
//     //     GenJournalLine."Journal Template Name" := 'GENERAL';
//     //     GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//     //     GenJournalLine."Line No." := LineNo;
//     //     GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//     //     GenJournalLine."Account No." := No;
//     //     GenJournalLine.Validate(GenJournalLine."Account No.");
//     //     GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//     //     GenJournalLine."Posting Date" := Today;
//     //     GenJournalLine.Description := 'Witholding Tax On-Gross Computer Interest Year-' + format(DATE2DMY((EndDate), 3));
//     //     GenJournalLine.Amount := DivRegister."WTX -Computer Shares";
//     //     GenJournalLine.Validate(GenJournalLine.Amount);
//     //     GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//     //     GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//     //     GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//     //     GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
//     //     GenJournalLine."Bal. Account No." := SaccoGenSetUp."Withholding Tax Account";
//     //     if GenJournalLine.Amount <> 0 then
//     //         GenJournalLine.Insert;
//     //     exit(DivRegister."Net Interest -Computer Shares");
//     // end;
//     // //---------------------------------------------------------------------------------------------
//     local procedure FnProcessInterestEarnedOnVanShares(No: Code[20]; StartDate: Date; EndDate: Date; vanShares: Decimal): Decimal
//     var
//         QualifyingVanShares: Decimal;
//     begin
//         //1_Get the Qualifying Deposit Contributions Amounts
//         // QualifyingVanShares := 0;
//         // CustLedgerEntry.Reset();
//         // CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         // CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Van Shares");
//         // CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         // CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', 0D, EndDate);
//         // IF CustLedgerEntry.FIND('-') then begin
//         //     repeat
//         //         QualifyingVanShares += (CustLedgerEntry."Amount Posted") * -1;
//         //     until CustLedgerEntry.next = 0;
//         // end;

//         //2 Process the amounts One Qualifies to be paid
//         SaccoGenSetUp.Get();
//         DivRegister.Reset();
//         DivRegister.SetRange(DivRegister."Member No", No);
//         DivRegister.SetRange(DivRegister."Dividend Year", format(DATE2DMY((EndDate), 3)));
//         if DivRegister.Find('-') = true then begin
//             DivRegister."Van Shares" := VanShares;
//             DivRegister."Qualifying Van Shares" := QualifyingVanShares;
//             DivRegister."Gross Interest-Van Shares" := (((SaccoGenSetUp."Interest On Van Shares") / 100) * QualifyingVanShares);
//             DivRegister."WTX -Van Shares" := ((SaccoGenSetUp."Withholding Tax (%)" / 100) * DivRegister."Gross Interest-Van Shares");
//             DivRegister."Net Interest -Van Shares" := (DivRegister."Gross Interest-Van Shares") - (DivRegister."WTX -Van Shares");
//             DivRegister.Modify(true);
//         end else
//             if DivRegister.Find('-') = false then begin
//                 Error('Could not insert into dividends register');
//             end;
//         //4 Insert To GL's
//         //A)GROSS
//         //i)Bank Account
//         SaccoGenSetUp.Get();
//         SaccoGenSetUp.TestField(SaccoGenSetUp."Dividends Paying Bank Account");
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
//         GenJournalLine."Account No." := SaccoGenSetUp."Dividends Paying Bank Account";
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Gross Interest Earned On Van Shares Year-' + format(DATE2DMY((EndDate), 3)) + ' paid to-' + Format(No);
//         GenJournalLine.Amount := DivRegister."Gross Interest-Van Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         //ii)Member Account
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Gross Interest Earned On Van Shares Year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := -DivRegister."Gross Interest-Van Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;

//         //B)WTX
//         SaccoGenSetUp.Get();
//         if DivRegister."WTX -FOSA Shares" <> 0 then begin
//             SaccoGenSetUp.TestField(SaccoGenSetUp."Withholding Tax Account");
//         end;
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Witholding Tax On-Gross Van Interest Year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := DivRegister."WTX -Van Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
//         GenJournalLine."Bal. Account No." := SaccoGenSetUp."Withholding Tax Account";
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         exit(DivRegister."Net Interest -Van Shares");
//     end;

//     local procedure FnProcessInterestEarnedOnPreferentialShares(No: Code[20]; StartDate: Date; EndDate: Date; PreferentialShares: Decimal): Decimal
//     var
//         QualifyingPreferentialShares: Decimal;
//     begin
//         //1_Get the Qualifying Deposit Contributions Amounts
//         // QualifyingPreferentialShares := 0;
//         // CustLedgerEntry.Reset();
//         // CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         // CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Preferencial Building Shares");
//         // CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         // CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', 0D, EndDate);
//         // IF CustLedgerEntry.FIND('-') then begin
//         //     repeat
//         //         QualifyingPreferentialShares += (CustLedgerEntry."Amount Posted") * -1;
//         //     until CustLedgerEntry.next = 0;
//         // end;

//         //2 Process the amounts One Qualifies to be paid
//         SaccoGenSetUp.Get();
//         DivRegister.Reset();
//         DivRegister.SetRange(DivRegister."Member No", No);
//         DivRegister.SetRange(DivRegister."Dividend Year", format(DATE2DMY((EndDate), 3)));
//         if DivRegister.Find('-') = true then begin
//             DivRegister."Preferential Shares" := PreferentialShares;
//             DivRegister."Qualifying Preferential Shares" := QualifyingPreferentialShares;
//             DivRegister."Gross Int-Preferential Shares" := (((SaccoGenSetUp."Interest On PreferentialShares") / 100) * QualifyingPreferentialShares);
//             DivRegister."WTX -Preferential Shares" := ((SaccoGenSetUp."Withholding Tax (%)" / 100) * DivRegister."Gross Int-Preferential Shares");
//             DivRegister."Net Int-Preferential Shares" := (DivRegister."Gross Int-Preferential Shares") - (DivRegister."WTX -Preferential Shares");
//             DivRegister.Modify(true);
//         end else
//             if DivRegister.Find('-') = false then begin
//                 Error('Could not insert into dividends register');
//             end;
//         //4 Insert To GL's
//         //A)GROSS
//         //i)Bank Account
//         SaccoGenSetUp.Get();
//         SaccoGenSetUp.TestField(SaccoGenSetUp."Dividends Paying Bank Account");
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
//         GenJournalLine."Account No." := SaccoGenSetUp."Dividends Paying Bank Account";
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Gross Interest Earned On Preferential Shares Year-' + format(DATE2DMY((EndDate), 3)) + ' paid to-' + Format(No);
//         GenJournalLine.Amount := DivRegister."Gross Int-Preferential Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         //ii)Member Account
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Gross Interest Earned On Preferential Shares Year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := -DivRegister."Gross Int-Preferential Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;

//         //B)WTX
//         SaccoGenSetUp.Get();
//         if DivRegister."WTX -FOSA Shares" <> 0 then begin
//             SaccoGenSetUp.TestField(SaccoGenSetUp."Withholding Tax Account");
//         end;
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Witholding Tax On-Gross Preferential Interest Year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := DivRegister."WTX -Preferential Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
//         GenJournalLine."Bal. Account No." := SaccoGenSetUp."Withholding Tax Account";
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         exit(DivRegister."Net Int-Preferential Shares");
//     end;
//     //-------------------------------------------------------------------------------------------
//     local procedure FnProcessInterestEarnedOnLiftShares(No: Code[20]; StartDate: Date; EndDate: Date; LiftShares: Decimal): Decimal
//     var
//         QualifyingLiftShares: Decimal;
//     begin
//         //1_Get the Qualifying Deposit Contributions Amounts
//         QualifyingLiftShares := 0;
//         CustLedgerEntry.Reset();
//         CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Lift Shares");
//         CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', 0D, EndDate);
//         IF CustLedgerEntry.FIND('-') then begin
//             repeat
//                 QualifyingLiftShares += (CustLedgerEntry."Amount Posted") * -1;
//             until CustLedgerEntry.next = 0;
//         end;

//         //2 Process the amounts One Qualifies to be paid
//         SaccoGenSetUp.Get();
//         DivRegister.Reset();
//         DivRegister.SetRange(DivRegister."Member No", No);
//         DivRegister.SetRange(DivRegister."Dividend Year", format(DATE2DMY((EndDate), 3)));
//         if DivRegister.Find('-') = true then begin
//             DivRegister."Lift Shares" := LiftShares;
//             DivRegister."Qualifying Lift Shares" := QualifyingLiftShares;
//             DivRegister."Gross Int-Lift Shares" := (((SaccoGenSetUp."Interest On LiftShares") / 100) * QualifyingLiftShares);
//             DivRegister."WTX -Lift Shares" := ((SaccoGenSetUp."Withholding Tax (%)" / 100) * DivRegister."Gross Int-Lift Shares");
//             DivRegister."Net Int-Lift Shares" := (DivRegister."Gross Int-Lift Shares") - (DivRegister."WTX -Lift Shares");
//             DivRegister.Modify(true);
//         end else
//             if DivRegister.Find('-') = false then begin
//                 Error('Could not insert into dividends register');
//             end;
//         //4 Insert To GL's
//         //A)GROSS
//         //i)Bank Account
//         SaccoGenSetUp.Get();
//         SaccoGenSetUp.TestField(SaccoGenSetUp."Dividends Paying Bank Account");
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
//         GenJournalLine."Account No." := SaccoGenSetUp."Dividends Paying Bank Account";
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Gross Interest Earned On Lift Shares Year-' + format(DATE2DMY((EndDate), 3)) + ' paid to-' + Format(No);
//         GenJournalLine.Amount := DivRegister."Gross Int-Lift Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         //ii)Member Account
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Gross Interest Earned On Lift Shares Year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := -DivRegister."Gross Int-Lift Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;

//         //B)WTX
//         SaccoGenSetUp.Get();
//         if DivRegister."WTX -FOSA Shares" <> 0 then begin
//             SaccoGenSetUp.TestField(SaccoGenSetUp."Withholding Tax Account");
//         end;
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Witholding Tax On-Gross Lift Interest Year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := DivRegister."WTX -Lift Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
//         GenJournalLine."Bal. Account No." := SaccoGenSetUp."Withholding Tax Account";
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         exit(DivRegister."Net Int-Lift Shares");
//     end;
//     //------------------------------------------------------------------------------------------------
//     local procedure FnProcessInterestEarnedOnTambaaShares(No: Code[20]; StartDate: Date; EndDate: Date; TambaShares: Decimal): Decimal
//     var
//         QualifyingTambaaShares: Decimal;
//     begin
//         //1_Get the Qualifying Deposit Contributions Amounts
//         QualifyingTambaaShares := 0;
//         CustLedgerEntry.Reset();
//         CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Tamba Shares");
//         CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', 0D, EndDate);
//         IF CustLedgerEntry.FIND('-') then begin
//             repeat
//                 QualifyingTambaaShares += (CustLedgerEntry."Amount Posted") * -1;
//             until CustLedgerEntry.next = 0;
//         end;

//         //2 Process the amounts One Qualifies to be paid
//         SaccoGenSetUp.Get();
//         DivRegister.Reset();
//         DivRegister.SetRange(DivRegister."Member No", No);
//         DivRegister.SetRange(DivRegister."Dividend Year", format(DATE2DMY((EndDate), 3)));
//         if DivRegister.Find('-') = true then begin
//             DivRegister."Tambaa Shares" := TambaShares;
//             DivRegister."Qualifying Tambaa Shares" := QualifyingTambaaShares;
//             DivRegister."Gross Int-Tambaa Shares" := (((SaccoGenSetUp."Interest On TambaaShares") / 100) * QualifyingTambaaShares);
//             DivRegister."WTX -Tambaa Shares" := ((SaccoGenSetUp."Withholding Tax (%)" / 100) * DivRegister."Gross Int-Tambaa Shares");
//             DivRegister."Net Int-Tambaa Shares" := (DivRegister."Gross Int-Tambaa Shares") - (DivRegister."WTX -Tambaa Shares");
//             DivRegister.Modify(true);
//         end else
//             if DivRegister.Find('-') = false then begin
//                 Error('Could not insert into dividends register');
//             end;
//         //4 Insert To GL's
//         //A)GROSS
//         //i)Bank Account
//         SaccoGenSetUp.Get();
//         SaccoGenSetUp.TestField(SaccoGenSetUp."Dividends Paying Bank Account");
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
//         GenJournalLine."Account No." := SaccoGenSetUp."Dividends Paying Bank Account";
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Gross Interest Earned On Tambaa Shares Year-' + format(DATE2DMY((EndDate), 3)) + ' paid to-' + Format(No);
//         GenJournalLine.Amount := DivRegister."Gross Int-Tambaa Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         //ii)Member Account
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Gross Interest Earned On Tambaa Shares Year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := -DivRegister."Gross Int-Tambaa Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;

//         //B)WTX
//         SaccoGenSetUp.Get();
//         if DivRegister."WTX -FOSA Shares" <> 0 then begin
//             SaccoGenSetUp.TestField(SaccoGenSetUp."Withholding Tax Account");
//         end;
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Witholding Tax On-Gross Tambaa Interest Year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := DivRegister."WTX -Tambaa Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
//         GenJournalLine."Bal. Account No." := SaccoGenSetUp."Withholding Tax Account";
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         exit(DivRegister."Net Int-Tambaa Shares");
//     end;
//     //----------------------------------------------------------------------------------------------
//     local procedure FnProcessInterestEarnedOnPepeaShares(No: Code[20]; StartDate: Date; EndDate: Date; PepeaShares: Decimal): Decimal
//     var
//         QualifyingPepeaShares: Decimal;
//     begin
//         //1_Get the Qualifying Deposit Contributions Amounts
//         QualifyingPepeaShares := 0;
//         CustLedgerEntry.Reset();
//         CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Pepea Shares");
//         CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', 0D, EndDate);
//         IF CustLedgerEntry.FIND('-') then begin
//             repeat
//                 QualifyingPepeaShares += (CustLedgerEntry."Amount Posted") * -1;
//             until CustLedgerEntry.next = 0;
//         end;

//         //2 Process the amounts One Qualifies to be paid
//         SaccoGenSetUp.Get();
//         DivRegister.Reset();
//         DivRegister.SetRange(DivRegister."Member No", No);
//         DivRegister.SetRange(DivRegister."Dividend Year", format(DATE2DMY((EndDate), 3)));
//         if DivRegister.Find('-') = true then begin
//             DivRegister."Pepea Shares" := PepeaShares;
//             DivRegister."Qualifying Pepea Shares" := QualifyingPepeaShares;
//             DivRegister."Gross Int-Pepea Shares" := (((SaccoGenSetUp."Interest On PepeaShares") / 100) * QualifyingPepeaShares);
//             DivRegister."WTX -Pepea Shares" := ((SaccoGenSetUp."Withholding Tax (%)" / 100) * DivRegister."Gross Int-Pepea Shares");
//             DivRegister."Net Int-Pepea Shares" := (DivRegister."Gross Int-Pepea Shares") - (DivRegister."WTX -Pepea Shares");
//             DivRegister.Modify(true);
//         end else
//             if DivRegister.Find('-') = false then begin
//                 Error('Could not insert into dividends register');
//             end;
//         //4 Insert To GL's
//         //A)GROSS
//         //i)Bank Account
//         SaccoGenSetUp.Get();
//         SaccoGenSetUp.TestField(SaccoGenSetUp."Dividends Paying Bank Account");
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
//         GenJournalLine."Account No." := SaccoGenSetUp."Dividends Paying Bank Account";
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Gross Interest Earned On Pepea Shares Year-' + format(DATE2DMY((EndDate), 3)) + ' paid to-' + Format(No);
//         GenJournalLine.Amount := DivRegister."Gross Int-Pepea Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         //ii)Member Account
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Gross Interest Earned On Pepea Shares Year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := -DivRegister."Gross Int-Pepea Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;

//         //B)WTX
//         SaccoGenSetUp.Get();
//         if DivRegister."WTX -FOSA Shares" <> 0 then begin
//             SaccoGenSetUp.TestField(SaccoGenSetUp."Withholding Tax Account");
//         end;
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Witholding Tax On-Gross Pepea Interest Year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := DivRegister."WTX -Pepea Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
//         GenJournalLine."Bal. Account No." := SaccoGenSetUp."Withholding Tax Account";
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         exit(DivRegister."Net Int-Pepea Shares");
//     end;
//     //-------------------------------------------------------------------------------------------------------------------
//     local procedure FnProcessInterestEarnedOnHousingShares(No: Code[20]; StartDate: Date; EndDate: Date; Housing: Decimal): Decimal
//     var
//         QualifyingHousingShares: Decimal;
//     begin
//         //1_Get the Qualifying Deposit Contributions Amounts
//         QualifyingHousingShares := 0;
//         CustLedgerEntry.Reset();
//         CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::Investment);
//         CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', 0D, EndDate);
//         IF CustLedgerEntry.FIND('-') then begin
//             repeat
//                 QualifyingHousingShares += (CustLedgerEntry."Amount Posted") * -1;
//             until CustLedgerEntry.next = 0;
//         end;

//         //2 Process the amounts One Qualifies to be paid
//         SaccoGenSetUp.Get();
//         DivRegister.Reset();
//         DivRegister.SetRange(DivRegister."Member No", No);
//         DivRegister.SetRange(DivRegister."Dividend Year", format(DATE2DMY((EndDate), 3)));
//         if DivRegister.Find('-') = true then begin
//             DivRegister."Housing Shares" := Housing;
//             DivRegister."Qualifying Housing Shares" := QualifyingHousingShares;
//             DivRegister."Gross Int-Housing Shares" := (((SaccoGenSetUp."Interest On HousingShares") / 100) * QualifyingHousingShares);
//             DivRegister."WTX -Housing Shares" := ((SaccoGenSetUp."Withholding Tax (%)" / 100) * DivRegister."Gross Int-Housing Shares");
//             DivRegister."Net Int-Housing Shares" := (DivRegister."Gross Int-Housing Shares") - (DivRegister."WTX -Housing Shares");
//             DivRegister.Modify(true);
//         end else
//             if DivRegister.Find('-') = false then begin
//                 Error('Could not insert into dividends register');
//             end;
//         //4 Insert To GL's
//         //A)GROSS
//         //i)Bank Account
//         SaccoGenSetUp.Get();
//         SaccoGenSetUp.TestField(SaccoGenSetUp."Dividends Paying Bank Account");
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
//         GenJournalLine."Account No." := SaccoGenSetUp."Dividends Paying Bank Account";
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Gross Interest Earned On Housing Shares Year-' + format(DATE2DMY((EndDate), 3)) + ' paid to-' + Format(No);
//         GenJournalLine.Amount := DivRegister."Gross Int-Housing Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         //ii)Member Account
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Gross Interest Earned On Housing Shares Year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := -DivRegister."Gross Int-Housing Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;

//         //B)WTX
//         SaccoGenSetUp.Get();
//         if DivRegister."WTX -FOSA Shares" <> 0 then begin
//             SaccoGenSetUp.TestField(SaccoGenSetUp."Withholding Tax Account");
//         end;
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Witholding Tax On-Gross Housing Interest Year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := DivRegister."WTX -Housing Shares";
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
//         GenJournalLine."Bal. Account No." := SaccoGenSetUp."Withholding Tax Account";
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         exit(DivRegister."Net Int-Housing Shares");
//     end;

//     //*******************************************************************************************************************************************************************************

//     local procedure FnCapitalizeDividendsAmount(NetDividendsPayableToMember: Decimal; No: Code[20]; EndDate: Date): Decimal
//     begin
//         SaccoGenSetUp.Get();
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Capitalized dividends year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := (NetDividendsPayableToMember * ((SaccoGenSetUp."Dividends Capitalization Rate") / 100));
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         //--
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Capitalized dividends year-' + format(DATE2DMY((EndDate), 3));
//         GenJournalLine.Amount := -(NetDividendsPayableToMember * ((SaccoGenSetUp."Dividends Capitalization Rate") / 100));
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Pepea Shares";
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         //..............................Modify the dividends register with the capitalized amount
//         DivRegister.Reset();
//         DivRegister.SetRange(DivRegister."Member No", No);
//         DivRegister.SetRange(DivRegister."Dividend Year", format(DATE2DMY((EndDate), 3)));
//         if DivRegister.Find('-') = true then begin
//             DivRegister."Capitalized Amount" := (NetDividendsPayableToMember * ((SaccoGenSetUp."Dividends Capitalization Rate") / 100));
//             DivRegister.Modify(true);
//         end;
//         exit((NetDividendsPayableToMember * ((SaccoGenSetUp."Dividends Capitalization Rate") / 100)));
//     end;

//     local procedure FnTransferNetDividendToFOSA(arg: Decimal; No: Code[20]; EndDate: Date): Decimal
//     begin
//         //Withdrawal from member dividend account
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//         GenJournalLine."Account No." := No;
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Net Dividends Year-' + format(DATE2DMY((EndDate), 3)) + ' TO Fosa Account';
//         GenJournalLine.Amount := arg;
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;

//         //Credit MemberFOSA Account
//         LineNo := LineNo + 10000;
//         GenJournalLine.Init;
//         GenJournalLine."Journal Template Name" := 'GENERAL';
//         GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//         GenJournalLine."Line No." := LineNo;
//         GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//         GenJournalLine."Account No." := FnGetMemberFOSAAc(No);
//         GenJournalLine.Validate(GenJournalLine."Account No.");
//         GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//         GenJournalLine."Posting Date" := Today;
//         GenJournalLine.Description := 'Net Dividends Year-' + format(DATE2DMY((EndDate), 3)) + 'earned';
//         GenJournalLine.Amount := -arg;
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         //..............................Modify the dividends register with the Net Amount Transfered To FOSA
//         DivRegister.Reset();
//         DivRegister.SetRange(DivRegister."Member No", No);
//         DivRegister.SetRange(DivRegister."Dividend Year", format(DATE2DMY((EndDate), 3)));
//         if DivRegister.Find('-') = true then begin
//             DivRegister."Net Pay To FOSA" := (arg);
//             DivRegister.Modify(true);
//         end;
//         exit(arg);

//     end;

//     local procedure FnGetMemberBranchCode(No: Code[20]): Code[20]
//     begin
//         MemberRegister.reset;
//         MemberRegister.SetRange(MemberRegister."No.", No);
//         if MemberRegister.Find('-') then begin
//             exit(MemberRegister."Global Dimension 2 Code");
//         end;
//     end;

//     local procedure FnGetMemberFOSAAc(No: Code[20]): Code[20]
//     var
//         VendorAccount: Record Vendor;
//     begin
//         VendorAccount.Reset();
//         VendorAccount.SetRange(VendorAccount."BOSA Account No", No);
//         VendorAccount.SetRange(VendorAccount."Account Type", 'ORDINARY');
//         if VendorAccount.Find('-') then begin
//             exit(VendorAccount."No.");
//         end;
//     end;

//     local procedure FnOutstandingDivLoanIntBal(No: Code[20]): Decimal
//     var
//         LoansReg: Record "Loans Register";
//     begin
//         LoansReg.Reset();
//         LoansReg.SetRange(LoansReg."Client Code", No);
//         LoansReg.SetRange(LoansReg."Loan Product Type", 'DIVIDEND');
//         LoansReg.SetAutoCalcFields(LoansReg."Oustanding Interest");
//         LoansReg.SetFilter(LoansReg."Oustanding Interest", '>%1', 0);
//         IF LoansReg.Find('-') = true THEN begin
//             exit(LoansReg."Oustanding Interest");
//         end ELSE
//             IF LoansReg.Find('-') = false THEN begin
//                 exit(0);
//             end;
//     end;

//     local procedure FnRecoverOutstDivInterest(No: Code[20]; NetTransferToFOSA: Decimal; EndDate: Date): Decimal
//     var
//         LoansReg: Record "Loans Register";
//         AmountDeducted: Decimal;
//     begin
//         LoansReg.Reset();
//         LoansReg.SetRange(LoansReg."Client Code", No);
//         LoansReg.SetRange(LoansReg."Loan Product Type", 'DIVIDEND');
//         LoansReg.SetAutoCalcFields(LoansReg."Oustanding Interest");
//         LoansReg.SetFilter(LoansReg."Oustanding Interest", '>%1', 0);
//         AmountDeducted := 0;
//         IF LoansReg.Find('-') = true THEN begin
//             if LoansReg."Oustanding Interest" >= NetTransferToFOSA then begin
//                 AmountDeducted := NetTransferToFOSA;
//             end else
//                 if LoansReg."Oustanding Interest" < NetTransferToFOSA then begin
//                     AmountDeducted := LoansReg."Oustanding Interest";
//                 end;
//             //Deduct Member FOSA Account
//             LineNo := LineNo + 10000;
//             GenJournalLine.Init;
//             GenJournalLine."Journal Template Name" := 'GENERAL';
//             GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//             GenJournalLine."Line No." := LineNo;
//             GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//             GenJournalLine."Account No." := FnGetMemberFOSAAc(No);
//             GenJournalLine.Validate(GenJournalLine."Account No.");
//             GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//             GenJournalLine."Posting Date" := Today;
//             GenJournalLine.Description := 'Recovered Dividend Advance Interest-' + format(LoansReg."Loan  No.");
//             GenJournalLine.Amount := AmountDeducted;
//             GenJournalLine.Validate(GenJournalLine.Amount);
//             GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
//             GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//             if GenJournalLine.Amount <> 0 then
//                 GenJournalLine.Insert;

//             LineNo := LineNo + 10000;
//             GenJournalLine.Init;
//             GenJournalLine."Journal Template Name" := 'GENERAL';
//             GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//             GenJournalLine."Line No." := LineNo;
//             GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//             GenJournalLine."Account No." := No;
//             GenJournalLine.Validate(GenJournalLine."Account No.");
//             GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//             GenJournalLine."Posting Date" := Today;
//             GenJournalLine.Description := 'Recovered Dividend Advance Interest from dividends year-' + format(DATE2DMY((EndDate), 3));
//             GenJournalLine.Amount := -AmountDeducted;
//             GenJournalLine.Validate(GenJournalLine.Amount);
//             GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
//             GenJournalLine."Loan No" := LoansReg."Loan  No.";
//             GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//             GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//             if GenJournalLine.Amount <> 0 then
//                 GenJournalLine.Insert;
//         end;
//         exit(NetTransferToFOSA - AmountDeducted);
//     end;

//     local procedure FnRecoverOutstDivBal(No: Code[20]; RunningBalance: Decimal; EndDate: Date)
//     var
//         LoansReg: Record "Loans Register";
//         AmountDeducted: Decimal;
//     begin
//         LoansReg.Reset();
//         LoansReg.SetRange(LoansReg."Client Code", No);
//         LoansReg.SetRange(LoansReg."Loan Product Type", 'DIVIDEND');
//         LoansReg.SetAutoCalcFields(LoansReg."Outstanding Balance");
//         LoansReg.SetFilter(LoansReg."Outstanding Balance", '>%1', 0);
//         AmountDeducted := 0;
//         IF LoansReg.Find('-') = true THEN begin
//             if LoansReg."Outstanding Balance" >= NetTransferToFOSA then begin
//                 AmountDeducted := NetTransferToFOSA;
//             end else
//                 if LoansReg."Outstanding Balance" < NetTransferToFOSA then begin
//                     AmountDeducted := LoansReg."Outstanding Balance";
//                 end;
//             //Deduct Member FOSA Account
//             LineNo := LineNo + 10000;
//             GenJournalLine.Init;
//             GenJournalLine."Journal Template Name" := 'GENERAL';
//             GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//             GenJournalLine."Line No." := LineNo;
//             GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//             GenJournalLine."Account No." := FnGetMemberFOSAAc(No);
//             GenJournalLine.Validate(GenJournalLine."Account No.");
//             GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//             GenJournalLine."Posting Date" := Today;
//             GenJournalLine.Description := 'Recovered Dividend Advance Principle-' + format(LoansReg."Loan  No.");
//             GenJournalLine.Amount := AmountDeducted;
//             GenJournalLine.Validate(GenJournalLine.Amount);
//             GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
//             GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//             if GenJournalLine.Amount <> 0 then
//                 GenJournalLine.Insert;

//             LineNo := LineNo + 10000;
//             GenJournalLine.Init;
//             GenJournalLine."Journal Template Name" := 'GENERAL';
//             GenJournalLine."Journal Batch Name" := 'DIVIDEND';
//             GenJournalLine."Line No." := LineNo;
//             GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//             GenJournalLine."Account No." := No;
//             GenJournalLine.Validate(GenJournalLine."Account No.");
//             GenJournalLine."Document No." := format(DATE2DMY((EndDate), 3)) + 'DIVIDEND';
//             GenJournalLine."Posting Date" := Today;
//             GenJournalLine.Description := 'Recovered Dividend Advance Principle from dividends year-' + format(DATE2DMY((EndDate), 3));
//             GenJournalLine.Amount := -AmountDeducted;
//             GenJournalLine.Validate(GenJournalLine.Amount);
//             GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
//             GenJournalLine."Loan No" := LoansReg."Loan  No.";
//             GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//             GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//             if GenJournalLine.Amount <> 0 then
//                 GenJournalLine.Insert;
//         end;
//     end;
// }
