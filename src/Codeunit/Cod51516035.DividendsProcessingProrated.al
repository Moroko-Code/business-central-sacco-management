// codeunit 51516035 "Dividends Processing-Prorated"
// {
//     trigger OnRun()
//     begin
//     end;

//     var
//         MemberRegister: Record customer;
//         CustLedgerEntry: Record "Cust. Ledger Entry";
//         DividendsProgression: Record "Dividends Progression";
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
//     //.................................Dividends Processing Prorated start
//     procedure FnProcessDividendsProrated(MemberNo: Code[50]; StartDate: Date; EndDate: Date)
//     begin
//         MemberRegister.reset;
//         MemberRegister.SetRange(MemberRegister."No.", MemberNo);
//         MemberRegister.SetAutoCalcFields(MemberRegister."Current Shares", MemberRegister."Fosa Shares", MemberRegister."van Shares", MemberRegister."Preferencial Building Shares", MemberRegister."Lift Shares", MemberRegister."Tamba Shares", MemberRegister."Pepea Shares", MemberRegister."Housing Deposits");
//         if MemberRegister.find('-') then begin
//             //2 Delete Previous Entries Of the Member
//             DividendsProgression.Reset();
//             DividendsProgression.SetRange(DividendsProgression."Member No", MemberNo);
//             DividendsProgression.SetRange(DividendsProgression."Dividend Year", format(DATE2DMY((EndDate), 3)));
//             if DividendsProgression.Find('-') then begin
//                 DividendsProgression.DeleteAll();
//             end;
//             //1 Get NWD Shares Earned
//             NWDSharesInterestEarned := 0;
//             NWDSharesInterestEarned := FnProcessInterestEarnedOnCurrentShares(MemberRegister."No.", StartDate, EndDate, MemberRegister."Current Shares");

//             //--------------GET NET DIVIDENDS PAYABLE TO MEMBER(Inclusive of capitalzed amount)
//             NetDividendsPayableToMember := 0;
//             NetDividendsPayableToMember := ComputerSharesInterestEarned + FOSASharesInterestEarned + NWDSharesInterestEarned + VanSharesInterestEarned + PreferentialSharesInterestEarned + LiftSharesInterestEarned + PepeaSharesInterestEarned + TambaaSharesInterestEarned + HousingSharesInterestEarned;
//             //--------------Get Capitalized Amount
//             // CapitalizedDividendAmount := 0;
//             // CapitalizedDividendAmount := FnCapitalizeDividendsAmount(NetDividendsPayableToMember, MemberRegister."No.", EndDate);
//             //--------------Net Transfer To  Member FOSA A/c
//             // NetTransferToFOSA := 0;
//             // NetTransferToFOSA := FnTransferNetDividendToFOSA((NetDividendsPayableToMember - CapitalizedDividendAmount), MemberRegister."No.", EndDate);
//             // //--------------Deduct processing fees

//             // // --------------Recover Dividend Loan interest
//             // If FnOutstandingDivLoanIntBal(MemberRegister."No.") > 0 then begin
//             //     RunningBalance := FnRecoverOutstDivInterest(MemberRegister."No.", NetTransferToFOSA, EndDate);
//             // end;
//             // // --------------Recover Dividend Loan Balance
//             // if RunningBalance > 0 then begin
//             //     FnRecoverOutstDivBal(MemberRegister."No.", RunningBalance, EndDate);
//             // end;
//         end;
//     end;

//     local procedure FnProcessInterestEarnedOnCurrentShares(No: Code[20]; StartDate: Date; EndDate: Date; CurrentShares: Decimal): Decimal
//     var
//         QualifyingDepositContribs: Decimal;
//         GrossNWDMonth1: Decimal;
//         GrossNWDMonth2: Decimal;
//         GrossNWDMonth3: Decimal;
//         GrossNWDMonth4: Decimal;
//         GrossNWDMonth5: Decimal;
//         GrossNWDMonth6: Decimal;
//         GrossNWDMonth7: Decimal;
//         GrossNWDMonth8: Decimal;
//         GrossNWDMonth9: Decimal;
//         GrossNWDMonth10: Decimal;
//         GrossNWDMonth11: Decimal;
//         GrossNWDMonth12: Decimal;
//         TotalGrossNWD: Decimal;
//     begin
//         //-----------------------1st month
//         QualifyingDepositContribs := 0;
//         CustLedgerEntry.Reset();
//         CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Deposit Contribution");
//         CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', 0D, CalcDate('CM', StartDate));//End date of first month
//         IF CustLedgerEntry.FIND('-') then begin
//             repeat
//                 QualifyingDepositContribs += (CustLedgerEntry."Amount Posted") * -1;
//             until CustLedgerEntry.next = 0;
//         end;

//         SaccoGenSetUp.Get();
//         DividendsProgression.Init();
//         DividendsProgression."Member No" := No;
//         DividendsProgression.Date := CalcDate('CM', StartDate);
//         DividendsProgression."Qualifying Current Shares" := (QualifyingDepositContribs) * 12 / 12;
//         DividendsProgression."Gross Current Shares" := (DividendsProgression."Qualifying Current Shares" * ((SaccoGenSetUp."Interest On Current Shares") / 100));
//         DividendsProgression."WTax-Current Shares" := DividendsProgression."Gross Current Shares" * (SaccoGenSetUp."Withholding Tax (%)" / 100);
//         DividendsProgression."Net Current Shares" := DividendsProgression."Gross Current Shares" - DividendsProgression."WTax-Current Shares";
//         DividendsProgression."Dividend Year" := format(DATE2DMY((EndDate), 3));
//         DividendsProgression.Insert();
//         GrossNWDMonth1 := DividendsProgression."Gross Current Shares";
//         //---------2nd month
//         QualifyingDepositContribs := 0;
//         CustLedgerEntry.Reset();
//         CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Deposit Contribution");
//         CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', CalcDate('-CM', (CalcDate('1M', StartDate))), CalcDate('CM', (CalcDate('1M', StartDate))));//End date of 2nd month
//         IF CustLedgerEntry.FIND('-') then begin
//             repeat
//                 QualifyingDepositContribs += (CustLedgerEntry."Amount Posted") * -1;
//             until CustLedgerEntry.next = 0;
//         end;

//         SaccoGenSetUp.Get();
//         DividendsProgression.Init();
//         DividendsProgression."Member No" := No;
//         DividendsProgression.Date := CalcDate('CM', (CalcDate('1M', StartDate)));
//         DividendsProgression."Qualifying Current Shares" := (QualifyingDepositContribs) * 11 / 12;
//         DividendsProgression."Gross Current Shares" := (DividendsProgression."Qualifying Current Shares" * ((SaccoGenSetUp."Interest On Current Shares") / 100));
//         DividendsProgression."WTax-Current Shares" := DividendsProgression."Gross Current Shares" * (SaccoGenSetUp."Withholding Tax (%)" / 100);
//         DividendsProgression."Net Current Shares" := DividendsProgression."Gross Current Shares" - DividendsProgression."WTax-Current Shares";
//         DividendsProgression."Dividend Year" := format(DATE2DMY((EndDate), 3));
//         DividendsProgression.Insert();
//         GrossNWDMonth2 := DividendsProgression."Gross Current Shares";

//         //---------3rd month
//         QualifyingDepositContribs := 0;
//         CustLedgerEntry.Reset();
//         CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Deposit Contribution");
//         CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', CalcDate('-CM', (CalcDate('2M', StartDate))), CalcDate('CM', (CalcDate('2M', StartDate))));//End date of 3rd month
//         IF CustLedgerEntry.FIND('-') then begin
//             repeat
//                 QualifyingDepositContribs += (CustLedgerEntry."Amount Posted") * -1;
//             until CustLedgerEntry.next = 0;
//         end;

//         SaccoGenSetUp.Get();
//         DividendsProgression.Init();
//         DividendsProgression."Member No" := No;
//         DividendsProgression.Date := CalcDate('CM', (CalcDate('2M', StartDate)));
//         DividendsProgression."Qualifying Current Shares" := (QualifyingDepositContribs) * 10 / 12;
//         DividendsProgression."Gross Current Shares" := (DividendsProgression."Qualifying Current Shares" * ((SaccoGenSetUp."Interest On Current Shares") / 100));
//         DividendsProgression."WTax-Current Shares" := DividendsProgression."Gross Current Shares" * (SaccoGenSetUp."Withholding Tax (%)" / 100);
//         DividendsProgression."Net Current Shares" := DividendsProgression."Gross Current Shares" - DividendsProgression."WTax-Current Shares";
//         DividendsProgression."Dividend Year" := format(DATE2DMY((EndDate), 3));
//         DividendsProgression.Insert();
//         GrossNWDMonth3 := DividendsProgression."Gross Current Shares";

//         //---------4th month
//         QualifyingDepositContribs := 0;
//         CustLedgerEntry.Reset();
//         CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Deposit Contribution");
//         CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', CalcDate('-CM', (CalcDate('3M', StartDate))), CalcDate('CM', (CalcDate('3M', StartDate))));//End date of 4 month
//         IF CustLedgerEntry.FIND('-') then begin
//             repeat
//                 QualifyingDepositContribs += (CustLedgerEntry."Amount Posted") * -1;
//             until CustLedgerEntry.next = 0;
//         end;

//         SaccoGenSetUp.Get();
//         DividendsProgression.Init();
//         DividendsProgression."Member No" := No;
//         DividendsProgression.Date := CalcDate('CM', (CalcDate('3M', StartDate)));
//         DividendsProgression."Qualifying Current Shares" := (QualifyingDepositContribs) * 9 / 12;
//         DividendsProgression."Gross Current Shares" := (DividendsProgression."Qualifying Current Shares" * ((SaccoGenSetUp."Interest On Current Shares") / 100));
//         DividendsProgression."WTax-Current Shares" := DividendsProgression."Gross Current Shares" * (SaccoGenSetUp."Withholding Tax (%)" / 100);
//         DividendsProgression."Net Current Shares" := DividendsProgression."Gross Current Shares" - DividendsProgression."WTax-Current Shares";
//         DividendsProgression."Dividend Year" := format(DATE2DMY((EndDate), 3));
//         DividendsProgression.Insert();
//         GrossNWDMonth4 := DividendsProgression."Gross Current Shares";

//         //---------5th month
//         QualifyingDepositContribs := 0;
//         CustLedgerEntry.Reset();
//         CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Deposit Contribution");
//         CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', CalcDate('-CM', (CalcDate('4M', StartDate))), CalcDate('CM', (CalcDate('4M', StartDate))));//End date of 5 month
//         IF CustLedgerEntry.FIND('-') then begin
//             repeat
//                 QualifyingDepositContribs += (CustLedgerEntry."Amount Posted") * -1;
//             until CustLedgerEntry.next = 0;
//         end;

//         SaccoGenSetUp.Get();
//         DividendsProgression.Init();
//         DividendsProgression."Member No" := No;
//         DividendsProgression.Date := CalcDate('CM', (CalcDate('4M', StartDate)));
//         DividendsProgression."Qualifying Current Shares" := (QualifyingDepositContribs) * 8 / 12;
//         DividendsProgression."Gross Current Shares" := (DividendsProgression."Qualifying Current Shares" * ((SaccoGenSetUp."Interest On Current Shares") / 100));
//         DividendsProgression."WTax-Current Shares" := DividendsProgression."Gross Current Shares" * (SaccoGenSetUp."Withholding Tax (%)" / 100);
//         DividendsProgression."Net Current Shares" := DividendsProgression."Gross Current Shares" - DividendsProgression."WTax-Current Shares";
//         DividendsProgression."Dividend Year" := format(DATE2DMY((EndDate), 3));
//         DividendsProgression.Insert();
//         GrossNWDMonth5 := DividendsProgression."Gross Current Shares";

//         //---------6th month
//         QualifyingDepositContribs := 0;
//         CustLedgerEntry.Reset();
//         CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Deposit Contribution");
//         CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', CalcDate('-CM', (CalcDate('5M', StartDate))), CalcDate('CM', (CalcDate('5M', StartDate))));//End date of 6 month
//         IF CustLedgerEntry.FIND('-') then begin
//             repeat
//                 QualifyingDepositContribs += (CustLedgerEntry."Amount Posted") * -1;
//             until CustLedgerEntry.next = 0;
//         end;

//         SaccoGenSetUp.Get();
//         DividendsProgression.Init();
//         DividendsProgression."Member No" := No;
//         DividendsProgression.Date := CalcDate('CM', (CalcDate('5M', StartDate)));
//         DividendsProgression."Qualifying Current Shares" := (QualifyingDepositContribs) * 7 / 12;
//         DividendsProgression."Gross Current Shares" := (DividendsProgression."Qualifying Current Shares" * ((SaccoGenSetUp."Interest On Current Shares") / 100));
//         DividendsProgression."WTax-Current Shares" := DividendsProgression."Gross Current Shares" * (SaccoGenSetUp."Withholding Tax (%)" / 100);
//         DividendsProgression."Net Current Shares" := DividendsProgression."Gross Current Shares" - DividendsProgression."WTax-Current Shares";
//         DividendsProgression."Dividend Year" := format(DATE2DMY((EndDate), 3));
//         DividendsProgression.Insert();
//         GrossNWDMonth6 := DividendsProgression."Gross Current Shares";

//         //---------7th month
//         QualifyingDepositContribs := 0;
//         CustLedgerEntry.Reset();
//         CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Deposit Contribution");
//         CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', CalcDate('-CM', (CalcDate('6M', StartDate))), CalcDate('CM', (CalcDate('6M', StartDate))));//End date of 7 month
//         IF CustLedgerEntry.FIND('-') then begin
//             repeat
//                 QualifyingDepositContribs += (CustLedgerEntry."Amount Posted") * -1;
//             until CustLedgerEntry.next = 0;
//         end;

//         SaccoGenSetUp.Get();
//         DividendsProgression.Init();
//         DividendsProgression."Member No" := No;
//         DividendsProgression.Date := CalcDate('CM', (CalcDate('6M', StartDate)));
//         DividendsProgression."Qualifying Current Shares" := (QualifyingDepositContribs) * 6 / 12;
//         DividendsProgression."Gross Current Shares" := (DividendsProgression."Qualifying Current Shares" * ((SaccoGenSetUp."Interest On Current Shares") / 100));
//         DividendsProgression."WTax-Current Shares" := DividendsProgression."Gross Current Shares" * (SaccoGenSetUp."Withholding Tax (%)" / 100);
//         DividendsProgression."Net Current Shares" := DividendsProgression."Gross Current Shares" - DividendsProgression."WTax-Current Shares";
//         DividendsProgression."Dividend Year" := format(DATE2DMY((EndDate), 3));
//         DividendsProgression.Insert();
//         GrossNWDMonth7 := DividendsProgression."Gross Current Shares";

//         //---------8th month
//         QualifyingDepositContribs := 0;
//         CustLedgerEntry.Reset();
//         CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Deposit Contribution");
//         CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', CalcDate('-CM', (CalcDate('7M', StartDate))), CalcDate('CM', (CalcDate('7M', StartDate))));//End date of 8 month
//         IF CustLedgerEntry.FIND('-') then begin
//             repeat
//                 QualifyingDepositContribs += (CustLedgerEntry."Amount Posted") * -1;
//             until CustLedgerEntry.next = 0;
//         end;

//         SaccoGenSetUp.Get();
//         DividendsProgression.Init();
//         DividendsProgression."Member No" := No;
//         DividendsProgression.Date := CalcDate('CM', (CalcDate('7M', StartDate)));
//         DividendsProgression."Qualifying Current Shares" := (QualifyingDepositContribs) * 5 / 12;
//         DividendsProgression."Gross Current Shares" := (DividendsProgression."Qualifying Current Shares" * ((SaccoGenSetUp."Interest On Current Shares") / 100));
//         DividendsProgression."WTax-Current Shares" := DividendsProgression."Gross Current Shares" * (SaccoGenSetUp."Withholding Tax (%)" / 100);
//         DividendsProgression."Net Current Shares" := DividendsProgression."Gross Current Shares" - DividendsProgression."WTax-Current Shares";
//         DividendsProgression."Dividend Year" := format(DATE2DMY((EndDate), 3));
//         DividendsProgression.Insert();
//         GrossNWDMonth8 := DividendsProgression."Gross Current Shares";

//         //---------9th month
//         QualifyingDepositContribs := 0;
//         CustLedgerEntry.Reset();
//         CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Deposit Contribution");
//         CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', CalcDate('-CM', (CalcDate('8M', StartDate))), CalcDate('CM', (CalcDate('8M', StartDate))));//End date of 9 month
//         IF CustLedgerEntry.FIND('-') then begin
//             repeat
//                 QualifyingDepositContribs += (CustLedgerEntry."Amount Posted") * -1;
//             until CustLedgerEntry.next = 0;
//         end;

//         SaccoGenSetUp.Get();
//         DividendsProgression.Init();
//         DividendsProgression."Member No" := No;
//         DividendsProgression.Date := CalcDate('CM', (CalcDate('8M', StartDate)));
//         DividendsProgression."Qualifying Current Shares" := (QualifyingDepositContribs) * 4 / 12;
//         DividendsProgression."Gross Current Shares" := (DividendsProgression."Qualifying Current Shares" * ((SaccoGenSetUp."Interest On Current Shares") / 100));
//         DividendsProgression."WTax-Current Shares" := DividendsProgression."Gross Current Shares" * (SaccoGenSetUp."Withholding Tax (%)" / 100);
//         DividendsProgression."Net Current Shares" := DividendsProgression."Gross Current Shares" - DividendsProgression."WTax-Current Shares";
//         DividendsProgression."Dividend Year" := format(DATE2DMY((EndDate), 3));
//         DividendsProgression.Insert();
//         GrossNWDMonth9 := DividendsProgression."Gross Current Shares";

//         //---------10th month
//         QualifyingDepositContribs := 0;
//         CustLedgerEntry.Reset();
//         CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Deposit Contribution");
//         CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', CalcDate('-CM', (CalcDate('9M', StartDate))), CalcDate('CM', (CalcDate('9M', StartDate))));//End date of 10 month
//         IF CustLedgerEntry.FIND('-') then begin
//             repeat
//                 QualifyingDepositContribs += (CustLedgerEntry."Amount Posted") * -1;
//             until CustLedgerEntry.next = 0;
//         end;

//         SaccoGenSetUp.Get();
//         DividendsProgression.Init();
//         DividendsProgression."Member No" := No;
//         DividendsProgression.Date := CalcDate('CM', (CalcDate('9M', StartDate)));
//         DividendsProgression."Qualifying Current Shares" := (QualifyingDepositContribs) * 3 / 12;
//         DividendsProgression."Gross Current Shares" := (DividendsProgression."Qualifying Current Shares" * ((SaccoGenSetUp."Interest On Current Shares") / 100));
//         DividendsProgression."WTax-Current Shares" := DividendsProgression."Gross Current Shares" * (SaccoGenSetUp."Withholding Tax (%)" / 100);
//         DividendsProgression."Net Current Shares" := DividendsProgression."Gross Current Shares" - DividendsProgression."WTax-Current Shares";
//         DividendsProgression."Dividend Year" := format(DATE2DMY((EndDate), 3));
//         DividendsProgression.Insert();
//         GrossNWDMonth10 := DividendsProgression."Gross Current Shares";

//         //---------11th month
//         QualifyingDepositContribs := 0;
//         CustLedgerEntry.Reset();
//         CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Deposit Contribution");
//         CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', CalcDate('-CM', (CalcDate('10M', StartDate))), CalcDate('CM', (CalcDate('10M', StartDate))));//End date of 11 month
//         IF CustLedgerEntry.FIND('-') then begin
//             repeat
//                 QualifyingDepositContribs += (CustLedgerEntry."Amount Posted") * -1;
//             until CustLedgerEntry.next = 0;
//         end;

//         SaccoGenSetUp.Get();
//         DividendsProgression.Init();
//         DividendsProgression."Member No" := No;
//         DividendsProgression.Date := CalcDate('CM', (CalcDate('10M', StartDate)));
//         DividendsProgression."Qualifying Current Shares" := (QualifyingDepositContribs) * 2 / 12;
//         DividendsProgression."Gross Current Shares" := (DividendsProgression."Qualifying Current Shares" * ((SaccoGenSetUp."Interest On Current Shares") / 100));
//         DividendsProgression."WTax-Current Shares" := DividendsProgression."Gross Current Shares" * (SaccoGenSetUp."Withholding Tax (%)" / 100);
//         DividendsProgression."Net Current Shares" := DividendsProgression."Gross Current Shares" - DividendsProgression."WTax-Current Shares";
//         DividendsProgression."Dividend Year" := format(DATE2DMY((EndDate), 3));
//         DividendsProgression.Insert();
//         GrossNWDMonth11 := DividendsProgression."Gross Current Shares";

//         //---------12th month
//         QualifyingDepositContribs := 0;
//         CustLedgerEntry.Reset();
//         CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", No);
//         CustLedgerEntry.SetRange(CustLedgerEntry."Transaction Type", CustLedgerEntry."Transaction Type"::"Deposit Contribution");
//         CustLedgerEntry.SetRange(CustLedgerEntry.Reversed, false);
//         CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '%1..%2', CalcDate('-CM', (CalcDate('11M', StartDate))), CalcDate('CM', (CalcDate('11M', StartDate))));//End date of 12 month
//         IF CustLedgerEntry.FIND('-') then begin
//             repeat
//                 QualifyingDepositContribs += (CustLedgerEntry."Amount Posted") * -1;
//             until CustLedgerEntry.next = 0;
//         end;

//         SaccoGenSetUp.Get();
//         DividendsProgression.Init();
//         DividendsProgression."Member No" := No;
//         DividendsProgression.Date := CalcDate('CM', (CalcDate('11M', StartDate)));
//         DividendsProgression."Qualifying Current Shares" := (QualifyingDepositContribs) * 1 / 12;
//         DividendsProgression."Gross Current Shares" := (DividendsProgression."Qualifying Current Shares" * ((SaccoGenSetUp."Interest On Current Shares") / 100));
//         DividendsProgression."WTax-Current Shares" := DividendsProgression."Gross Current Shares" * (SaccoGenSetUp."Withholding Tax (%)" / 100);
//         DividendsProgression."Net Current Shares" := DividendsProgression."Gross Current Shares" - DividendsProgression."WTax-Current Shares";
//         DividendsProgression."Dividend Year" := format(DATE2DMY((EndDate), 3));
//         DividendsProgression.Insert();
//         GrossNWDMonth12 := DividendsProgression."Gross Current Shares";
//         //4 Insert To GL's
//         //A)GROSS
//         TotalGrossNWD := 0;
//         TotalGrossNWD := GrossNWDMonth1 + GrossNWDMonth2 + GrossNWDMonth3 + GrossNWDMonth4 + GrossNWDMonth5 + GrossNWDMonth6 + GrossNWDMonth7 + GrossNWDMonth8 + GrossNWDMonth9 + GrossNWDMonth10 + GrossNWDMonth11 + GrossNWDMonth12;
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
//         GenJournalLine.Amount := TotalGrossNWD;
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
//         GenJournalLine.Amount := -TotalGrossNWD;
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
//         GenJournalLine.Amount := TotalGrossNWD * (SaccoGenSetUp."Withholding Tax (%)" / 100);
//         GenJournalLine.Validate(GenJournalLine.Amount);
//         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;
//         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//         GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchCode(No);
//         GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
//         GenJournalLine."Bal. Account No." := SaccoGenSetUp."Withholding Tax Account";
//         if GenJournalLine.Amount <> 0 then
//             GenJournalLine.Insert;
//         exit(TotalGrossNWD);
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
