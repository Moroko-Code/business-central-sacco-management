// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Page 51516296 "Account Card"
// {
//     Caption = 'Account Card';
//     DeleteAllowed = false;
//     PageType = Card;
//     PromotedActionCategories = 'New,Process,Reports,Statements,Charges,Recoveries,Fixed Deposits';
//     RefreshOnActivate = true;
//     SourceTable = Vendor;
//     InsertAllowed = false;
//     //Editable = false;

//     layout
//     {
//         area(content)
//         {
//             group(AccountTab)
//             {
//                 Caption = 'General Information';
//                 Editable = false;
//                 field("No."; "No.")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Account No';
//                     Editable = false;

//                     trigger OnAssistEdit()
//                     begin
//                         if AssistEdit(xRec) then
//                             CurrPage.Update;
//                     end;
//                 }
//                 field(Name; Name)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Account Name';
//                     Editable = false;
//                 }
//                 field("ID No."; "ID No.")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'ID No.';
//                     Editable = false;
//                 }
//                 field("Passport No."; "Passport No.")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Staff No"; "Staff No")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Force No."; "Force No.")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Company Code"; "Company Code")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Station/Sections"; "Station/Sections")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field(txtGender; Gender)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Gender';
//                     Editable = false;
//                 }
//                 field("Marital Status"; "Marital Status")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Date of Birth"; "Date of Birth")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Date of Birth';
//                     Editable = false;
//                 }
//                 field("Phone No."; "Phone No.")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("MPESA Mobile No"; "MPESA Mobile No")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("EMail"; "E-Mail")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Sms Notification"; "Sms Notification")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 // field(Picture;Picture)
//                 // {
//                 //     ApplicationArea = Basic;
//                 //     Editable = false;
//                 // }
//                 field(Signature; Signature)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//             }
//             group(AccountTab1)
//             {
//                 Caption = 'Communication Details';
//                 Editable = false;
//                 visible = false;
//                 field(Address; Address)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Address 2"; "Address 2")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Post Code"; "Post Code")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Post Code/City';
//                 }
//                 field(City; City)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Mobile Phone No"; "Mobile Phone No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("E-Mail"; "E-Mail")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Home Page"; "Home Page")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Contact; Contact)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("ContacPerson Phone"; "ContacPerson Phone")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("ContactPerson Occupation"; "ContactPerson Occupation")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("ContactPerson Relation"; "ContactPerson Relation")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Home Address"; "Home Address")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             group(AccountInfo)
//             {
//                 Caption = 'Account Information';
//                 Editable = false;
//                 field("Account Type"; "Account Type")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Account Category"; "Account Category")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("BOSA Account No"; "BOSA Account No")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Uncleared Cheques"; "Uncleared Cheques")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Authorised Over Draft"; "Authorised Over Draft")
//                 {
//                     visible = false;
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Piggy Amount"; "Piggy Amount")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Balance (LCY)"; "Balance (LCY)")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(AvailableBal; ("Balance (LCY)" + "Authorised Over Draft") - ("Uncleared Cheques" + "ATM Transactions" + "EFT Transactions" + MinBalance + 90 + "Piggy Amount" + "Holiday Savings" + "Junior Trip"))
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Pepea Shares"; "Pepea Shares")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     visible = false;
//                 }
//                 field("ATM Transactions"; "ATM Transactions")
//                 {
//                     ApplicationArea = Basic;

//                 }
//                 field("Registration Date"; "Registration Date")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 field(Status; Status)
//                 {
//                     ApplicationArea = Basic;
//                     Style = Standard;
//                     StyleExpr = true;

//                     trigger OnValidate()
//                     begin
//                         TestField("Resons for Status Change");

//                         StatusPermissions.Reset;
//                         StatusPermissions.SetRange(StatusPermissions."User Id", UserId);
//                         StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Account Status");
//                         if StatusPermissions.Find('-') = false then
//                             Error('You do not have permissions to change the account status.');

//                         if "Account Type" = 'FIXED' then begin
//                             if "Balance (LCY)" > 0 then begin
//                                 CalcFields("Last Interest Date");

//                                 if "Call Deposit" = true then begin
//                                     if Status = Status::Closed then begin
//                                         if "Last Interest Date" < Today then
//                                             Error('Fixed deposit interest not UPDATED. Please update interest.');
//                                     end else begin
//                                         if "Last Interest Date" < "FD Maturity Date" then
//                                             Error('Fixed deposit interest not UPDATED. Please update interest.');
//                                     end;
//                                 end;
//                             end;
//                         end;

//                         if Status = Status::Active then begin
//                             if Confirm('Are you sure you want to re-activate this account? This will recover re-activation fee.', false) = false then begin
//                                 Error('Re-activation terminated.');
//                             end;

//                             Blocked := Blocked::" ";
//                             Modify;

//                         end;

//                         //Account Closure
//                         if Status = Status::Closed then begin
//                             TestField("Closure Notice Date");
//                             if Confirm('Are you sure you want to close this account? This will recover closure fee and any '
//                             + 'interest earned before maturity will be forfeited.', false) = false then begin
//                                 Error('Closure terminated.');
//                             end;

//                             GenJournalLine.Reset;
//                             GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
//                             GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
//                             if GenJournalLine.Find('-') then
//                                 GenJournalLine.DeleteAll;

//                             AccountTypes.Reset;
//                             AccountTypes.SetRange(AccountTypes.Code, "Account Type");
//                             if AccountTypes.Find('-') then begin
//                                 "Date Closed" := Today;

//                                 //Closure charges
//                                 /*Charges.RESET;
//                                 IF CALCDATE(AccountTypes."Closure Notice Period","Closure Notice Date") > TODAY THEN
//                                 Charges.SETRANGE(Charges.Code,AccountTypes."Closing Prior Notice Charge") */

//                                 Charges.Reset;
//                                 if CalcDate(AccountTypes."Closure Notice Period", "Closure Notice Date") > Today then
//                                     Charges.SetRange(Charges.Code, AccountType."Closing Charge")

//                                 else
//                                     Charges.SetRange(Charges.Code, AccountTypes."Closing Charge");
//                                 if Charges.Find('-') then begin
//                                     LineNo := LineNo + 10000;

//                                     GenJournalLine.Init;
//                                     GenJournalLine."Journal Template Name" := 'PURCHASES';
//                                     GenJournalLine."Journal Batch Name" := 'FTRANS';
//                                     GenJournalLine."Document No." := "No." + '-CL';
//                                     GenJournalLine."Line No." := LineNo;
//                                     GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                                     GenJournalLine."Account No." := "No.";
//                                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                                     GenJournalLine."Posting Date" := Today;
//                                     GenJournalLine.Description := Charges.Description;
//                                     GenJournalLine.Validate(GenJournalLine."Currency Code");
//                                     GenJournalLine.Amount := Charges."Charge Amount";
//                                     GenJournalLine.Validate(GenJournalLine.Amount);
//                                     GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                                     GenJournalLine."Bal. Account No." := Charges."GL Account";
//                                     GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                                     if GenJournalLine.Amount <> 0 then
//                                         GenJournalLine.Insert;

//                                 end;
//                                 //Closure charges

//                                 //Interest forfeited/Earned on maturity
//                                 CalcFields("Untranfered Interest");
//                                 if "Untranfered Interest" > 0 then begin
//                                     ForfeitInterest := true;
//                                     //If FD - Check if matured
//                                     if AccountTypes."Fixed Deposit" = true then begin
//                                         if "FD Maturity Date" <= Today then
//                                             ForfeitInterest := false;
//                                         if "Call Deposit" = true then
//                                             ForfeitInterest := false;

//                                     end;

//                                     //PKK INGORE MATURITY
//                                     ForfeitInterest := false;
//                                     //If FD - Check if matured

//                                     if ForfeitInterest = true then begin
//                                         LineNo := LineNo + 10000;

//                                         GenJournalLine.Init;
//                                         GenJournalLine."Journal Template Name" := 'PURCHASES';
//                                         GenJournalLine."Line No." := LineNo;
//                                         GenJournalLine."Journal Batch Name" := 'FTRANS';
//                                         GenJournalLine."Document No." := "No." + '-CL';
//                                         GenJournalLine."External Document No." := "No.";
//                                         GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
//                                         GenJournalLine."Account No." := AccountTypes."Interest Forfeited Account";
//                                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                                         GenJournalLine."Posting Date" := Today;
//                                         GenJournalLine.Description := 'Interest Forfeited';
//                                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                                         GenJournalLine.Amount := -"Untranfered Interest";
//                                         GenJournalLine.Validate(GenJournalLine.Amount);
//                                         GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                                         GenJournalLine."Bal. Account No." := AccountTypes."Interest Payable Account";
//                                         GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                                         GenJournalLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
//                                         GenJournalLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
//                                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                         if GenJournalLine.Amount <> 0 then
//                                             GenJournalLine.Insert;

//                                         InterestBuffer.Reset;
//                                         InterestBuffer.SetRange(InterestBuffer."Account No", "No.");
//                                         if InterestBuffer.Find('-') then
//                                             InterestBuffer.ModifyAll(InterestBuffer.Transferred, true);

//                                     end else begin
//                                         LineNo := LineNo + 10000;

//                                         GenJournalLine.Init;
//                                         GenJournalLine."Journal Template Name" := 'PURCHASES';
//                                         GenJournalLine."Line No." := LineNo;
//                                         GenJournalLine."Journal Batch Name" := 'FTRANS';
//                                         GenJournalLine."Document No." := "No." + '-CL';
//                                         GenJournalLine."External Document No." := "No.";
//                                         GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                                         if AccountTypes."Fixed Deposit" = true then
//                                             GenJournalLine."Account No." := "Savings Account No."
//                                         else
//                                             GenJournalLine."Account No." := "No.";
//                                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                                         GenJournalLine."Posting Date" := Today;
//                                         GenJournalLine.Description := 'Interest Earned';
//                                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                                         GenJournalLine.Amount := -"Untranfered Interest";
//                                         GenJournalLine.Validate(GenJournalLine.Amount);
//                                         GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                                         GenJournalLine."Bal. Account No." := AccountTypes."Interest Payable Account";
//                                         GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                                         if GenJournalLine.Amount <> 0 then
//                                             GenJournalLine.Insert;

//                                         InterestBuffer.Reset;
//                                         InterestBuffer.SetRange(InterestBuffer."Account No", "No.");
//                                         if InterestBuffer.Find('-') then
//                                             InterestBuffer.ModifyAll(InterestBuffer.Transferred, true);

//                                     end;

//                                     //Transfer Balance if Fixed Deposit
//                                     if AccountTypes."Fixed Deposit" = true then begin
//                                         CalcFields("Balance (LCY)");

//                                         TestField("Savings Account No.");

//                                         LineNo := LineNo + 10000;

//                                         GenJournalLine.Init;
//                                         GenJournalLine."Journal Template Name" := 'PURCHASES';
//                                         GenJournalLine."Line No." := LineNo;
//                                         GenJournalLine."Journal Batch Name" := 'FTRANS';
//                                         GenJournalLine."Document No." := "No." + '-CL';
//                                         GenJournalLine."External Document No." := "No.";
//                                         GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                                         GenJournalLine."Account No." := "Savings Account No.";
//                                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                                         GenJournalLine."Posting Date" := Today;
//                                         GenJournalLine.Description := 'FD Balance Tranfers';
//                                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                                         if "Amount to Transfer" <> 0 then
//                                             GenJournalLine.Amount := -"Amount to Transfer"
//                                         else
//                                             GenJournalLine.Amount := -"Balance (LCY)";
//                                         GenJournalLine.Validate(GenJournalLine.Amount);
//                                         if GenJournalLine.Amount <> 0 then
//                                             GenJournalLine.Insert;

//                                         LineNo := LineNo + 10000;

//                                         GenJournalLine.Init;
//                                         GenJournalLine."Journal Template Name" := 'PURCHASES';
//                                         GenJournalLine."Line No." := LineNo;
//                                         GenJournalLine."Journal Batch Name" := 'FTRANS';
//                                         GenJournalLine."Document No." := "No." + '-CL';
//                                         GenJournalLine."External Document No." := "No.";
//                                         GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                                         GenJournalLine."Account No." := "No.";
//                                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                                         GenJournalLine."Posting Date" := Today;
//                                         GenJournalLine.Description := 'FD Balance Tranfers';
//                                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                                         if "Amount to Transfer" <> 0 then
//                                             GenJournalLine.Amount := "Amount to Transfer"
//                                         else
//                                             GenJournalLine.Amount := "Balance (LCY)";
//                                         GenJournalLine.Validate(GenJournalLine.Amount);
//                                         if GenJournalLine.Amount <> 0 then
//                                             GenJournalLine.Insert;

//                                     end;

//                                     //Transfer Balance if Fixed Deposit

//                                 end;

//                                 //Interest forfeited/Earned on maturity

//                                 //Post New
//                                 GenJournalLine.Reset;
//                                 GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
//                                 GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
//                                 if GenJournalLine.Find('-') then begin
//                                     Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
//                                 end;
//                                 //Post New

//                                 Message('Funds transfered successfully to main account and account closed.');

//                             end;
//                         end;

//                         //Account Closure

//                     end;
//                 }
//                 field(Blocked; Blocked)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         TestField("Resons for Status Change");
//                     end;
//                 }
//                 field("ATM No."; "ATM No.")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Disable ATM Card"; "Disable ATM Card")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Reason For Disabling ATM Card"; "Reason For Disabling ATM Card")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Disabled By"; "Disabled By")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Last Date Modified"; "Last Date Modified")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Monthly Contribution"; "Monthly Contribution")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Closure Notice Date"; "Closure Notice Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Resons for Status Change"; "Resons for Status Change")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Bankers Cheque Amount"; "Bankers Cheque Amount")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Signing Instructions"; "Signing Instructions")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     MultiLine = true;
//                 }
//                 field("Salary Processing"; "Salary Processing")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Net Salary"; "Net Salary")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Modified By"; "Modified By")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             group("Fixed")
//             {
//                 Caption = 'Fixed Deposit';
//                 Editable = false;
//                 field(Regdate; "Registration Date")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Fixed Deposit Start Date';
//                     Editable = true;
//                 }
//                 field("Fixed Deposit Type"; "Fixed Deposit Type")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("FD Duration"; "FD Duration")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("FD Maturity Date"; "FD Maturity Date")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Maturity Date';
//                     Editable = false;
//                 }
//                 field("Neg. Interest Rate"; "Neg. Interest Rate")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Fixed Deposit Status"; "Fixed Deposit Status")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Call Deposit"; "Call Deposit")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Amount to Transfer"; "Amount to Transfer")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Amount to Transfer';
//                 }
//                 field("Savings Account No."; "Savings Account No.")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Account to transfer to';
//                     Editable = true;
//                 }
//                 field("Interest Earned"; "Interest Earned")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("FD Maturity Instructions"; "FD Maturity Instructions")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 field("Date Renewed"; "Date Renewed")
//                 {
//                     ApplicationArea = Basic;
//                     Enabled = false;
//                 }
//                 field("Transfer Type"; "Transfer Type")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             group("Loans Recovery")
//             {
//                 Caption = 'Loans Recovery';
//                 field("Loan No"; "Loan No")
//                 {
//                     ApplicationArea = Basic;
//                     TableRelation = "Loans Register" where(Source = filter(FOSA),
//                                                             Source = filter(MICRO), SOURCE = filter(BOSA));
//                 }
//                 field("Interest Amount"; "Interest Amount")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Principle Amount"; "Principle Amount")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }

//         area(factboxes)
//         {
//             part(Control1000000004; "FOSA Statistics FactBox")
//             {
//                 SubPageLink = "No." = field("No.");
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Account)
//             {
//                 Caption = 'Account';
//                 action("Ledger E&ntries")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Ledger E&ntries';
//                     Image = VendorLedger;
//                     RunObject = Page "Vendor Ledger Entries";
//                     RunPageLink = "Vendor No." = field("No.");
//                     RunPageView = sorting("Vendor No.");
//                     promoted = true;
//                     PromotedCategory = report;
//                     ShortCutKey = 'Ctrl+F7';

//                 }
//                 action("Co&mments")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page "Comment Sheet";
//                     RunPageLink = "Table Name" = const(Vendor),
//                                   "No." = field("No.");
//                     Visible = false;
//                 }
//                 action(Dimensions)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     RunObject = Page "Default Dimensions";
//                     RunPageLink = "Table ID" = const(23),
//                                   "No." = field("No.");
//                     ShortCutKey = 'Shift+Ctrl+D';
//                     Visible = false;
//                 }
//                 separator(Action108)
//                 {
//                 }
//                 action("Re-new Fixed Deposit")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Re-new Fixed Deposit';
//                     Image = "Report";
//                     promoted = true;
//                     PromotedCategory = Category7;
//                     visible = false;

//                     trigger OnAction()
//                     begin

//                         if AccountTypes.Get("Account Type") then begin
//                             if AccountTypes."Fixed Deposit" = true then begin
//                                 if "Call Deposit" = false then begin
//                                     TestField("Fixed Duration");
//                                     TestField("FD Maturity Date");
//                                     if "FD Maturity Date" > Today then
//                                         Error('Fixed deposit has not matured.');

//                                 end;

//                                 if "Don't Transfer to Savings" = false then
//                                     TestField("Savings Account No.");

//                                 CalcFields("Last Interest Date");

//                                 if "Call Deposit" = true then begin
//                                     if "Last Interest Date" < Today then
//                                         Error('Fixed deposit interest not UPDATED. Please update interest.');
//                                 end else begin
//                                     if "Last Interest Date" < "FD Maturity Date" then
//                                         Error('Fixed deposit interest not UPDATED. Please update interest.');
//                                 end;

//                                 if Confirm('Are you sure you want to renew this Fixed deposit. Interest will be transfered accordingly?') = false then
//                                     exit;

//                                 CalcFields("Untranfered Interest");

//                                 if "Call Deposit" = false then begin
//                                     "Date Renewed" := "FD Maturity Date";
//                                 end else
//                                     "Date Renewed" := Today;
//                                 Validate("Date Renewed");
//                                 Modify;

//                                 GenJournalLine.Reset;
//                                 GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
//                                 GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
//                                 if GenJournalLine.Find('-') then
//                                     GenJournalLine.DeleteAll;

//                                 LineNo := LineNo + 10000;

//                                 GenJournalLine.Init;
//                                 GenJournalLine."Journal Template Name" := 'PURCHASES';
//                                 GenJournalLine."Line No." := LineNo;
//                                 GenJournalLine."Journal Batch Name" := 'FTRANS';
//                                 GenJournalLine."Document No." := "No." + '-RN';
//                                 GenJournalLine."External Document No." := "No.";
//                                 GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                                 if "Don't Transfer to Savings" = false then
//                                     GenJournalLine."Account No." := "Savings Account No."
//                                 else
//                                     GenJournalLine."Account No." := "No.";
//                                 GenJournalLine.Validate(GenJournalLine."Account No.");
//                                 GenJournalLine."Posting Date" := Today;
//                                 GenJournalLine.Description := 'Interest Earned';
//                                 GenJournalLine.Validate(GenJournalLine."Currency Code");
//                                 GenJournalLine.Amount := -"Untranfered Interest";
//                                 GenJournalLine.Validate(GenJournalLine.Amount);
//                                 GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                                 GenJournalLine."Bal. Account No." := AccountTypes."Interest Payable Account";
//                                 GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                                 if GenJournalLine.Amount <> 0 then
//                                     GenJournalLine.Insert;

//                                 InterestBuffer.Reset;
//                                 InterestBuffer.SetRange(InterestBuffer."Account No", "No.");
//                                 if InterestBuffer.Find('-') then
//                                     InterestBuffer.ModifyAll(InterestBuffer.Transferred, true);

//                                 //Post
//                                 GenJournalLine.Reset;
//                                 GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
//                                 GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
//                                 if GenJournalLine.Find('-') then begin
//                                     Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
//                                 end;

//                                 Message('Fixed deposit renewed successfully');
//                             end;
//                         end;
//                     end;
//                 }
//                 separator(Action1102760068)
//                 {
//                 }
//                 separator(Action1102760082)
//                 {
//                 }
//                 action("<Page Member Page - BOSA>")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Member Page';
//                     Image = Planning;
//                     Visible = false;
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = New;
//                 }
//                 action("<Action11027600800>")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Loans Statements';
//                     Image = "Report";
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = "Report";
//                     visible = false;

//                     trigger OnAction()
//                     begin
//                         /*Cust.RESET;
//                         Cust.SETRANGE(Cust."No.","No.");
//                         IF Cust.FIND('-') THEN
//                         REPORT.RUN(,TRUE,TRUE,Cust)
//                         */

//                     end;
//                 }
//                 action("BOSA Statement")
//                 {
//                     ApplicationArea = Basic;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     PromotedIsBig = true;
//                     trigger OnAction()
//                     begin
//                         Cust.Reset;
//                         Cust.SetRange(Cust."No.", "BOSA Account No");
//                         //if Cust.Find('-') then
//                     end;
//                 }
//                 action("FOSA Loans")
//                 {
//                     ApplicationArea = Basic;
//                     Promoted = true;
//                     Visible = false;
//                 }
//                 action("Close Account")
//                 {
//                     ApplicationArea = Basic;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     //Visible = false;

//                     trigger OnAction()
//                     begin
//                         if Confirm('Are you sure you want to Close this Account?', false) = true then begin
//                             if "Balance (LCY)" <= 500 then
//                                 Error('This Member does not enough Savings to recover Withdrawal Fee')
//                             else
//                                 LineN := LineN + 10000;
//                             Gnljnline.Init;
//                             Gnljnline."Journal Template Name" := 'GENERAL';
//                             Gnljnline."Journal Batch Name" := 'CLOSURE';
//                             Gnljnline."Line No." := LineN;
//                             Gnljnline."Account Type" := Gnljnline."account type"::Vendor;
//                             Gnljnline."Account No." := "No.";
//                             Gnljnline.Validate(Gnljnline."Account No.");
//                             Gnljnline."Document No." := 'CLOSED-' + "No.";
//                             Gnljnline."Posting Date" := Today;
//                             Gnljnline.Amount := 500;
//                             Gnljnline.Description := 'Account Closure Fee';
//                             Gnljnline.Validate(Gnljnline.Amount);
//                             if Gnljnline.Amount <> 0 then
//                                 Gnljnline.Insert;

//                             LineN := LineN + 10000;
//                             Gnljnline.Init;
//                             Gnljnline."Journal Template Name" := 'GENERAL';
//                             Gnljnline."Journal Batch Name" := 'CLOSURE';
//                             Gnljnline."Line No." := LineN;
//                             Gnljnline."Account Type" := Gnljnline."bal. account type"::"G/L Account";
//                             Gnljnline."Bal. Account No." := '5423';
//                             Gnljnline.Validate(Gnljnline."Bal. Account No.");
//                             Gnljnline."Document No." := 'CLOSED-' + "No.";
//                             Gnljnline."Posting Date" := Today;
//                             Gnljnline.Amount := -500;
//                             Gnljnline.Description := 'Account Closure Fee';
//                             Gnljnline.Validate(Gnljnline.Amount);
//                             if Gnljnline.Amount <> 0 then
//                                 Gnljnline.Insert;

//                         end;
//                     end;
//                 }
//                 separator(Action1102760142)
//                 {
//                 }
//                 action("<Action110276013300>")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Update FDR Interest';
//                     Image = "Report";
//                     promoted = true;
//                     PromotedCategory = Category7;
//                     visible = false;

//                     trigger OnAction()
//                     begin
//                         if "Account Type" <> 'FIXED' then
//                             Error('Only applicable for Fixed Deposit accounts.');

//                         CalcFields("Last Interest Date");

//                         if "Last Interest Date" >= Today then
//                             Error('Interest Up to date.');

//                         //IF CONFIRM('Are you sure you want to update the Fixed deposit interest.?') = FALSE THEN
//                         //EXIT;

//                         Vend.Reset;
//                         Vend.SetRange(Vend."No.", "No.");
//                         if Vend.Find('-') then
//                             Report.Run(51516275, true, true, Vend)
//                     end;
//                 }
//             }
//             group(ActionGroup1102755009)
//             {
//                 action("Next Of Kin")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Next Of Kin';
//                     Image = Relationship;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                 }
//                 separator(Action1102755005)
//                 {
//                 }
//                 action("Transfer FD Amnt from Savings")
//                 {
//                     ApplicationArea = Basic;
//                     promoted = true;
//                     PromotedCategory = Category7;
//                     Visible = false;

//                     trigger OnAction()
//                     begin

//                         //Transfer Balance if Fixed Deposit

//                         AccountTypes.Reset;
//                         AccountTypes.SetRange(AccountTypes.Code, "Account Type");
//                         if AccountTypes.Find('-') then begin
//                             //IF AccountTypes."Fixed Deposit" <> TRUE THEN BEGIN
//                             if Vend.Get("Savings Account No.") then begin
//                                 if Confirm('Are you sure you want to effect the transfer from the savings account', false) = false then
//                                     exit else
//                                     GenJournalLine.Reset;
//                                 GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
//                                 GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
//                                 if GenJournalLine.Find('-') then
//                                     GenJournalLine.DeleteAll;

//                                 Vend.Reset;
//                                 if Vend.Find('-') then
//                                     Vend.CalcFields(Vend."Balance (LCY)");
//                                 //IF (Vend."Balance (LCY)" - 500) < "Fixed Deposit Amount" THEN
//                                 //ERROR('Savings account does not have enough money to facilate the requested trasfer.');
//                                 //MESSAGE('Katabaka ene!');
//                                 LineNo := LineNo + 10000;

//                                 GenJournalLine.Init;
//                                 GenJournalLine."Journal Template Name" := 'PURCHASES';
//                                 GenJournalLine."Line No." := LineNo;
//                                 GenJournalLine."Journal Batch Name" := 'FTRANS';
//                                 GenJournalLine."Document No." := "No." + '-OP';
//                                 GenJournalLine."External Document No." := "No.";
//                                 GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                                 GenJournalLine."Account No." := "Savings Account No.";
//                                 GenJournalLine.Validate(GenJournalLine."Account No.");
//                                 GenJournalLine."Posting Date" := Today;
//                                 GenJournalLine.Description := 'FD Balance Tranfers';
//                                 GenJournalLine.Validate(GenJournalLine."Currency Code");
//                                 //GenJournalLine.Amount:="Fixed Deposit Amount";
//                                 GenJournalLine.Amount := "Amount to Transfer";
//                                 GenJournalLine.Validate(GenJournalLine.Amount);
//                                 if GenJournalLine.Amount <> 0 then
//                                     GenJournalLine.Insert;
//                                 //MESSAGE('The FDR amount is %1 ',"Fixed Deposit Amount");
//                                 LineNo := LineNo + 10000;

//                                 GenJournalLine.Init;
//                                 GenJournalLine."Journal Template Name" := 'PURCHASES';
//                                 GenJournalLine."Line No." := LineNo;
//                                 GenJournalLine."Journal Batch Name" := 'FTRANS';
//                                 GenJournalLine."Document No." := "No." + '-OP';
//                                 GenJournalLine."External Document No." := "No.";
//                                 GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                                 GenJournalLine."Account No." := "No.";
//                                 GenJournalLine.Validate(GenJournalLine."Account No.");
//                                 GenJournalLine."Posting Date" := Today;
//                                 GenJournalLine.Description := 'FD Balance Tranfers';
//                                 GenJournalLine.Validate(GenJournalLine."Currency Code");
//                                 //GenJournalLine.Amount:=-"Fixed Deposit Amount";
//                                 GenJournalLine.Amount := -"Amount to Transfer";
//                                 GenJournalLine.Validate(GenJournalLine.Amount);
//                                 if GenJournalLine.Amount <> 0 then
//                                     GenJournalLine.Insert;

//                                 //END;
//                             end;
//                         end;
//                         /*
//                         GenJournalLine.RESET;
//                         GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
//                         GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
//                         IF GenJournalLine.FIND('-') THEN BEGIN
//                         REPEAT
//                         CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B",GenJournalLine);
//                         UNTIL GenJournalLine.NEXT = 0;
//                         END;
//                         */

//                         /*//Post New

//                         GenJournalLine.RESET;
//                         GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
//                         GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
//                         IF GenJournalLine.FIND('-') THEN BEGIN
//                         CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
//                         END;

//                         //Post New
//                         */

//                         /*
//                         GenJournalLine.RESET;
//                         GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
//                         GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
//                         GenJournalLine.DELETEALL;

//                            */
//                         //Transfer Balance if Fixed Deposit

//                     end;
//                 }
//                 action("Transfer FD Amount to Savings")
//                 {
//                     ApplicationArea = Basic;
//                     promoted = true;
//                     PromotedCategory = category7;
//                     Visible = false;

//                     trigger OnAction()
//                     begin

//                         //Transfer Balance if Fixed Deposit

//                         AccountTypes.Reset;
//                         AccountTypes.SetRange(AccountTypes.Code, "Account Type");
//                         if AccountTypes.Find('-') then begin
//                             if AccountTypes."Fixed Deposit" = true then begin
//                                 if Vend.Get("No.") then begin
//                                     if Confirm('Are you sure you want to effect the transfer from the Fixed Deposit account', false) = false then
//                                         exit;

//                                     GenJournalLine.Reset;
//                                     GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
//                                     GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
//                                     if GenJournalLine.Find('-') then
//                                         GenJournalLine.DeleteAll;

//                                     Vend.CalcFields(Vend."Balance (LCY)");
//                                     if (Vend."Balance (LCY)") < "Transfer Amount to Savings" then
//                                         Error('Fixed Deposit account does not have enough money to facilate the requested trasfer.');

//                                     LineNo := LineNo + 10000;

//                                     GenJournalLine.Init;
//                                     GenJournalLine."Journal Template Name" := 'PURCHASES';
//                                     GenJournalLine."Line No." := LineNo;
//                                     GenJournalLine."Journal Batch Name" := 'FTRANS';
//                                     GenJournalLine."Document No." := "No." + '-OP';
//                                     GenJournalLine."External Document No." := "No.";
//                                     GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                                     GenJournalLine."Account No." := "No.";
//                                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                                     GenJournalLine."Posting Date" := Today;
//                                     GenJournalLine.Description := 'FD Balance Tranfers';
//                                     GenJournalLine.Validate(GenJournalLine."Currency Code");
//                                     GenJournalLine.Amount := "Transfer Amount to Savings";
//                                     GenJournalLine.Validate(GenJournalLine.Amount);
//                                     if GenJournalLine.Amount <> 0 then
//                                         GenJournalLine.Insert;

//                                     LineNo := LineNo + 10000;

//                                     GenJournalLine.Init;
//                                     GenJournalLine."Journal Template Name" := 'PURCHASES';
//                                     GenJournalLine."Line No." := LineNo;
//                                     GenJournalLine."Journal Batch Name" := 'FTRANS';
//                                     GenJournalLine."Document No." := "No." + '-OP';
//                                     GenJournalLine."External Document No." := "No.";
//                                     GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                                     GenJournalLine."Account No." := "Savings Account No.";
//                                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                                     GenJournalLine."Posting Date" := Today;
//                                     GenJournalLine.Description := 'FD Balance Tranfers';
//                                     GenJournalLine.Validate(GenJournalLine."Currency Code");
//                                     GenJournalLine.Amount := -"Transfer Amount to Savings";
//                                     GenJournalLine.Validate(GenJournalLine.Amount);
//                                     if GenJournalLine.Amount <> 0 then
//                                         GenJournalLine.Insert;

//                                 end;
//                             end;
//                         end;

//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
//                         GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
//                         if GenJournalLine.Find('-') then begin
//                             repeat
//                             //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
//                             until GenJournalLine.Next = 0;
//                         end;

//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
//                         GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
//                         GenJournalLine.DeleteAll;

//                         Message('Amount transfered successfully.');
//                     end;
//                 }
//                 action("Renew Fixed deposit")
//                 {
//                     ApplicationArea = Basic;
//                     promoted = true;
//                     PromotedCategory = category7;
//                     Visible = false;

//                     trigger OnAction()
//                     begin

//                         if AccountTypes.Get("Account Type") then begin
//                             if AccountTypes."Fixed Deposit" = true then begin
//                                 if Confirm('Are you sure you want to renew the fixed deposit.', false) = false then
//                                     exit;

//                                 TestField("FD Maturity Date");
//                                 if FDType.Get("Fixed Deposit Type") then begin
//                                     "FD Maturity Date" := CalcDate(FDType.Duration, "FD Maturity Date");
//                                     "Date Renewed" := Today;
//                                     "FDR Deposit Status Type" := "fdr deposit status type"::Renewed;
//                                     Modify;

//                                     Message('Fixed deposit renewed successfully');
//                                 end;
//                             end;
//                         end;
//                     end;
//                 }
//                 action("Terminate Fixed Deposit")
//                 {
//                     ApplicationArea = Basic;
//                     promoted = true;
//                     PromotedCategory = Category7;
//                     Visible = false;

//                     trigger OnAction()
//                     begin

//                         //Transfer Balance if Fixed Deposit

//                         AccountTypes.Reset;
//                         AccountTypes.SetRange(AccountTypes.Code, "Account Type");
//                         if AccountTypes.Find('-') then begin
//                             if AccountTypes."Fixed Deposit" = true then begin
//                                 if Vend.Get("No.") then begin
//                                     if Confirm('Are you sure you want to Terminate this Fixed Deposit Contract?', false) = false then
//                                         exit;

//                                     GenJournalLine.Reset;
//                                     GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
//                                     GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
//                                     if GenJournalLine.Find('-') then
//                                         GenJournalLine.DeleteAll;

//                                     Vend.CalcFields(Vend."Balance (LCY)");
//                                     if (Vend."Balance (LCY)") < "Transfer Amount to Savings" then
//                                         Error('Fixed Deposit account does not have enough money to facilate the requested trasfer.');

//                                     LineNo := LineNo + 10000;

//                                     GenJournalLine.Init;
//                                     GenJournalLine."Journal Template Name" := 'PURCHASES';
//                                     GenJournalLine."Line No." := LineNo;
//                                     GenJournalLine."Journal Batch Name" := 'FTRANS';
//                                     GenJournalLine."Document No." := "No." + '-OP';
//                                     GenJournalLine."External Document No." := "No.";
//                                     GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                                     GenJournalLine."Account No." := "No.";
//                                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                                     GenJournalLine."Posting Date" := Today;
//                                     GenJournalLine.Description := 'FD Termination Tranfer';
//                                     GenJournalLine.Validate(GenJournalLine."Currency Code");
//                                     GenJournalLine.Amount := "Balance (LCY)";
//                                     GenJournalLine.Validate(GenJournalLine.Amount);
//                                     if GenJournalLine.Amount <> 0 then
//                                         GenJournalLine.Insert;

//                                     LineNo := LineNo + 10000;

//                                     GenJournalLine.Init;
//                                     GenJournalLine."Journal Template Name" := 'PURCHASES';
//                                     GenJournalLine."Line No." := LineNo;
//                                     GenJournalLine."Journal Batch Name" := 'FTRANS';
//                                     GenJournalLine."Document No." := "No." + '-OP';
//                                     GenJournalLine."External Document No." := "No.";
//                                     GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                                     GenJournalLine."Account No." := "Savings Account No.";
//                                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                                     GenJournalLine."Posting Date" := Today;
//                                     GenJournalLine.Description := 'FD Termination Tranfer';
//                                     GenJournalLine.Validate(GenJournalLine."Currency Code");
//                                     GenJournalLine.Amount := -"Balance (LCY)";
//                                     GenJournalLine.Validate(GenJournalLine.Amount);
//                                     if GenJournalLine.Amount <> 0 then
//                                         GenJournalLine.Insert;

//                                 end;
//                             end;
//                         end;

//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
//                         GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
//                         if GenJournalLine.Find('-') then begin
//                             repeat
//                             //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
//                             until GenJournalLine.Next = 0;
//                         end;

//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
//                         GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
//                         GenJournalLine.DeleteAll;

//                         Message('Amount transfered successfully back to the savings Account.');
//                         "FDR Deposit Status Type" := "fdr deposit status type"::Terminated;
//                         Modify;
//                         /*
//                        //Renew Fixed deposit - OnAction()

//                        IF AccountTypes.GET("Account Type") THEN BEGIN
//                        IF AccountTypes."Fixed Deposit" = TRUE THEN BEGIN
//                        IF CONFIRM('Are you sure you want to renew the fixed deposit.',FALSE) = FALSE THEN
//                        EXIT;

//                        TESTFIELD("FD Maturity Date");
//                        IF FDType.GET("Fixed Deposit Type") THEN BEGIN
//                        "FD Maturity Date":=CALCDATE(FDType.Duration,"FD Maturity Date");
//                        "Date Renewed":=TODAY;
//                        "FDR Deposit Status Type":="FDR Deposit Status Type"::Renewed;
//                        MODIFY;

//                        MESSAGE('Fixed deposit renewed successfully');
//                        END;
//                        END;
//                        END;
//                          */

//                     end;
//                 }
//                 action("Page Vendor Statement")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'FOSA Statement';
//                     Image = "Report";
//                     Promoted = true;
//                     PromotedIsBig = true;
//                     PromotedCategory = "Report";

//                     trigger OnAction()
//                     begin

//                         Vend.Reset;
//                         Vend.SetRange(Vend."No.", "No.");
//                         if Vend.Find('-') then
//                             Report.Run(51516248, true, false, Vend)
//                     end;
//                 }
//                 action("Page Vendor Statistics")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     RunObject = Page "FOSA Statistics";
//                     RunPageLink = "No." = field("No."),
//                                   "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
//                                   "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
//                     ShortCutKey = 'F7';
//                 }
//                 action("Charge Statement")
//                 {
//                     ApplicationArea = Basic;
//                     Image = PostApplication;
//                     Promoted = true;
//                     PromotedCategory = Category5;

//                     trigger OnAction()
//                     begin

//                         GenSetup.Get;

//                         DActivity := "Global Dimension 1 Code";
//                         DBranch := "Global Dimension 2 Code";

//                         if Confirm('Are you sure you want to charge statement fee? This will recover statement fee.', false) = false then
//                             exit;

//                         CalcFields("Balance (LCY)", "ATM Transactions");
//                         if ("Balance (LCY)" - "ATM Transactions") <= 0 then
//                             Error('This Account does not have sufficient funds');

//                         AccountTypes.Reset;
//                         AccountTypes.SetRange(AccountTypes.Code, "Account Type");
//                         if AccountTypes.Find('-') then begin

//                             //Closure charges
//                             Charges.Reset;
//                             Charges.SetRange(Charges.Code, AccountTypes."Statement Charge");
//                             if Charges.Find('-') then begin
//                                 GenJournalLine.Reset;
//                                 GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
//                                 GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
//                                 if GenJournalLine.Find('-') then
//                                     GenJournalLine.DeleteAll;

//                                 LineNo := LineNo + 10000;

//                                 GenJournalLine.Init;
//                                 GenJournalLine."Journal Template Name" := 'PURCHASES';
//                                 GenJournalLine."Journal Batch Name" := 'FTRANS';
//                                 GenJournalLine."Document No." := "No." + '-STM';
//                                 GenJournalLine."Line No." := LineNo;
//                                 GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                                 GenJournalLine."Account No." := "No.";
//                                 GenJournalLine.Validate(GenJournalLine."Account No.");
//                                 GenJournalLine."Posting Date" := Today;
//                                 GenJournalLine.Description := Charges.Description;
//                                 GenJournalLine.Validate(GenJournalLine."Currency Code");
//                                 GenJournalLine.Amount := Charges."Charge Amount";
//                                 GenJournalLine.Validate(GenJournalLine.Amount);
//                                 GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
//                                 GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
//                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                 GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                                 GenJournalLine."Bal. Account No." := Charges."GL Account";
//                                 GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                                 if GenJournalLine.Amount <> 0 then
//                                     GenJournalLine.Insert;

//                                 //excise
//                                 LineNo := LineNo + 10000;

//                                 GenJournalLine.Init;
//                                 GenJournalLine."Journal Template Name" := 'PURCHASES';
//                                 GenJournalLine."Journal Batch Name" := 'FTRANS';
//                                 GenJournalLine."Document No." := "No." + '-STM';
//                                 GenJournalLine."Line No." := LineNo;
//                                 GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                                 GenJournalLine."Account No." := "No.";
//                                 GenJournalLine.Validate(GenJournalLine."Account No.");
//                                 GenJournalLine."Posting Date" := Today;
//                                 GenJournalLine.Description := 'Excise Duty';
//                                 GenJournalLine.Validate(GenJournalLine."Currency Code");
//                                 GenJournalLine.Amount := (Charges."Charge Amount" * GenSetup."Excise Duty(%)") * 0.01;
//                                 GenJournalLine.Validate(GenJournalLine.Amount);
//                                 GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
//                                 GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
//                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                 GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                                 GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
//                                 GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                                 if GenJournalLine.Amount <> 0 then
//                                     GenJournalLine.Insert;

//                                 //excise

//                                 //Post New
//                                 GenJournalLine.Reset;
//                                 GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
//                                 GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
//                                 if GenJournalLine.Find('-') then begin
//                                     Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
//                                 end;

//                                 //Post New

//                             end;
//                             //Closure charges

//                         end;
//                     end;
//                 }
//                 separator(Action1000000069)
//                 {
//                 }
//                 action("Charge Account Openning")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Charge Account Opening';
//                     Enabled = true;
//                     Image = PostApplication;
//                     Promoted = true;
//                     PromotedIsBig = true;
//                     PromotedCategory = Category5;

//                     trigger OnAction()
//                     begin
//                         // To test Acc Open

//                         if (AccountOpening.FnCheckIfPaid("No.") = false) then
//                             GenSetup.Get;
//                         DActivity := "Global Dimension 1 Code";
//                         DBranch := "Global Dimension 2 Code";

//                         if Confirm('Are you sure you want to charge Account Opening fee? This will recover the fee.', false) = false then
//                             exit;

//                         CalcFields("Balance (LCY)", "ATM Transactions");
//                         if ("Balance (LCY)" - "ATM Transactions") <= 0 then
//                             Error('This Account does not have sufficient funds');

//                         AccountTypes.Reset;
//                         AccountTypes.SetRange(AccountTypes.Code, "Account Type");
//                         if AccountTypes.Find('-') then begin

//                             GenJournalLine.Reset;
//                             GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
//                             GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'ACC OPEN');
//                             if GenJournalLine.Find('-') then
//                                 GenJournalLine.DeleteAll;

//                             LineNo := LineNo + 10000;

//                             GenJournalLine.Init;
//                             GenJournalLine."Journal Template Name" := 'GENERAL';
//                             GenJournalLine."Journal Batch Name" := 'ACC OPEN';
//                             GenJournalLine."Document No." := "BOSA Account No" + '-ACC OPEN';
//                             GenJournalLine."Line No." := LineNo;
//                             GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                             GenJournalLine."Account No." := "No.";
//                             GenJournalLine.Validate(GenJournalLine."Account No.");
//                             GenJournalLine."Posting Date" := Today;
//                             GenJournalLine.Description := 'Form Fee';
//                             GenJournalLine.Amount := GenSetup."Form Fee";
//                             GenJournalLine.Validate(GenJournalLine.Amount);
//                             GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                             GenJournalLine."Bal. Account No." := GenSetup."Form Fee Account";
//                             GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                             GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
//                             GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
//                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                             if GenJournalLine.Amount <> 0 then
//                                 GenJournalLine.Insert;

//                             LineNo := LineNo + 10000;

//                             GenJournalLine.Init;
//                             GenJournalLine."Journal Template Name" := 'GENERAL';
//                             GenJournalLine."Journal Batch Name" := 'ACC OPEN';
//                             GenJournalLine."Document No." := "BOSA Account No" + '-ACC OPEN';
//                             GenJournalLine."Line No." := LineNo;
//                             GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                             GenJournalLine."Account No." := "No.";
//                             GenJournalLine.Validate(GenJournalLine."Account No.");
//                             GenJournalLine."Posting Date" := Today;
//                             GenJournalLine.Description := 'PassCard Fee';
//                             GenJournalLine.Amount := GenSetup."Passcard Fee";
//                             GenJournalLine.Validate(GenJournalLine.Amount);
//                             GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                             GenJournalLine."Bal. Account No." := GenSetup."Membership Form Acct";
//                             GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                             GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
//                             GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
//                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                             if GenJournalLine.Amount <> 0 then
//                                 GenJournalLine.Insert;

//                             LineNo := LineNo + 10000;

//                             GenJournalLine.Init;
//                             GenJournalLine."Journal Template Name" := 'GENERAL';
//                             GenJournalLine."Journal Batch Name" := 'ACC OPEN';
//                             GenJournalLine."Document No." := "BOSA Account No" + '-ACC OPEN';
//                             GenJournalLine."Line No." := LineNo;
//                             GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                             GenJournalLine."Account No." := "No.";
//                             GenJournalLine.Validate(GenJournalLine."Account No.");
//                             GenJournalLine."Posting Date" := Today;
//                             GenJournalLine.Description := 'Form Ex Duty';
//                             GenJournalLine.Amount := (GenSetup."Form Fee") * (GenSetup."Excise Duty(%)" / 100);
//                             GenJournalLine.Validate(GenJournalLine.Amount);
//                             GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                             GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
//                             GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                             GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
//                             GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
//                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                             if GenJournalLine.Amount <> 0 then
//                                 GenJournalLine.Insert;

//                             LineNo := LineNo + 10000;

//                             GenJournalLine.Init;
//                             GenJournalLine."Journal Template Name" := 'GENERAL';
//                             GenJournalLine."Journal Batch Name" := 'ACC OPEN';
//                             GenJournalLine."Document No." := "BOSA Account No" + '-ACC OPEN';
//                             GenJournalLine."Line No." := LineNo;
//                             GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                             GenJournalLine."Account No." := "No.";
//                             GenJournalLine.Validate(GenJournalLine."Account No.");
//                             GenJournalLine."Posting Date" := Today;
//                             GenJournalLine.Description := 'PassCard Ex Duty';
//                             GenJournalLine.Amount := (GenSetup."Passcard Fee") * (GenSetup."Excise Duty(%)" / 100);
//                             GenJournalLine.Validate(GenJournalLine.Amount);
//                             GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                             GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
//                             GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                             GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
//                             GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
//                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                             if GenJournalLine.Amount <> 0 then
//                                 GenJournalLine.Insert;
//                             /*
//                             Memb.RESET;
//                             Memb.SETRANGE(Memb."No.","No.");
//                             IF Memb.FIND('-') THEN
//                             */
//                             LineNo := LineNo + 10000;

//                             GenJournalLine.Init;
//                             GenJournalLine."Journal Template Name" := 'GENERAL';
//                             GenJournalLine."Journal Batch Name" := 'ACC OPEN';
//                             GenJournalLine."Document No." := "BOSA Account No" + '-ACC OPEN';
//                             GenJournalLine."Line No." := LineNo;
//                             GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                             GenJournalLine."Account No." := "No.";
//                             GenJournalLine.Validate(GenJournalLine."Account No.");
//                             GenJournalLine."Posting Date" := Today;
//                             GenJournalLine.Description := 'Share Capital';
//                             GenJournalLine.Amount := GenSetup."share Capital";
//                             GenJournalLine.Validate(GenJournalLine.Amount);
//                             GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
//                             GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
//                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                             if GenJournalLine.Amount <> 0 then
//                                 GenJournalLine.Insert;

//                             LineNo := LineNo + 10000;

//                             GenJournalLine.Init;
//                             GenJournalLine."Journal Template Name" := 'GENERAL';
//                             GenJournalLine."Journal Batch Name" := 'ACC OPEN';
//                             GenJournalLine."Document No." := "BOSA Account No" + '-ACC OPEN';
//                             GenJournalLine."Line No." := LineNo;
//                             GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//                             //GenJournalLine."Account No.":="No.";
//                             GenJournalLine."Account No." := "BOSA Account No";
//                             GenJournalLine.Validate(GenJournalLine."Account No.");
//                             GenJournalLine."Posting Date" := Today;
//                             GenJournalLine.Description := 'Share Capital';
//                             GenJournalLine.Amount := (GenSetup."share Capital") * -1;
//                             GenJournalLine.Validate(GenJournalLine.Amount);
//                             GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Shares Capital";
//                             GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                             GenJournalLine."Shortcut Dimension 2 Code" := Memb."Global Dimension 2 Code";
//                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                             if GenJournalLine.Amount <> 0 then
//                                 GenJournalLine.Insert;

//                             //................Post New.......................................

//                             GenJournalLine.Reset;
//                             GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
//                             GenJournalLine.SetRange("Journal Batch Name", 'ACC OPEN');
//                             if GenJournalLine.Find('-') then begin
//                                 Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
//                                 Message('Account Opening Charged Successfuly')
//                             end;

//                             //.......Post New........................................

//                             Vend.Reset;
//                             Vend.SetRange(Vend."No.", "No.");
//                             if Vend.Find('-') then begin
//                                 Vend."Paid RegFee" := true;
//                                 Vend.Modify;
//                             end;
//                             //FnGetLineNo(lineNo);
//                         end;
//                         //END;

//                         /////////////////////////////////////////...........................................

//                     end;
//                 }
//                 action("Account Signatories")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Account Signatories';
//                 }

//                 // action("Loan Recovery")
//                 // {
//                 //     ApplicationArea = Basic;
//                 //     Caption = 'Recover Loan From Account';
//                 //     Image = PostApplication;
//                 //     Promoted = true;
//                 //     PromotedCategory = Category6;
//                 //     RunObject = page "Loan Recovery List";

//                 // }
//                 action("Recover Loan From Account")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Recover Loan From Account';
//                     Image = PostApplication;
//                     Promoted = true;
//                     PromotedCategory = Category6;

//                     trigger OnAction()
//                     var
//                         Surestep: Codeunit "SURESTEP Factory";
//                     begin

//                         Loans.Reset;
//                         Loans.SetRange(Loans."Loan  No.", "Loan No");
//                         if Loans.Find('-') then begin

//                             if Confirm('Are you sure you want to recover Loan No. %1 Loan from account balance?', true, Loans."Loan  No.") = false then
//                                 exit;

//                             Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");

//                             OBal := "Principle Amount";//Loans."Oustanding Interest";
//                             OInterest := "Interest Amount";//Loans."Outstanding Balance";

//                             if OInterest < 0 then
//                                 OInterest := 0;

//                             if OBal < 0 then
//                                 OBal := 0;
//                             RunBal := OBal + OInterest;

//                             if (OBal + OInterest) > 0 then begin

//                                 GenJournalLine.Reset;
//                                 GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
//                                 GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'LOANS');
//                                 if GenJournalLine.Find('-') then
//                                     GenJournalLine.DeleteAll;

//                                 //IF Account.GET("Client Code") THEN BEGIN

//                                 CalcFields(Balance, "ATM Transactions");
//                                 AvailableBal := Balance - ("ATM Transactions" + 500);
//                                 if (OBal + OInterest) > AvailableBal then
//                                     RunBal := AvailableBal;

//                                 //END;

//                                 TotalRecovered := RunBal;

//                                 LineNo := LineNo + 10000;

//                                 GenJournalLine.Init;
//                                 GenJournalLine."Journal Template Name" := 'GENERAL';
//                                 GenJournalLine."Journal Batch Name" := 'LOANS';
//                                 GenJournalLine."Line No." := LineNo;
//                                 GenJournalLine."Document No." := Loans."Loan  No." + 'RC';
//                                 GenJournalLine."Posting Date" := Today;
//                                 GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//                                 GenJournalLine."Account No." := Loans."Client Code";
//                                 GenJournalLine.Validate(GenJournalLine."Account No.");
//                                 GenJournalLine.Description := Loans."Loan Product Type" + '-Loan Principle Recovery';
//                                 if RunBal < OBal then
//                                     GenJournalLine.Amount := -RunBal
//                                 else
//                                     GenJournalLine.Amount := -OBal;
//                                 GenJournalLine.Validate(GenJournalLine.Amount);
//                                 GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
//                                 GenJournalLine."Loan No" := Loans."Loan  No.";
//                                 IF LOANS.Source = LOANS.Source::BOSA THEN begin
//                                     GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                                     GenJournalLine."Shortcut Dimension 2 Code" := Surestep.FnGetUserBranch();
//                                 end ELSE
//                                     IF LOANS.Source = LOANS.Source::FOSA THEN begin
//                                         GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
//                                         GenJournalLine."Shortcut Dimension 2 Code" := Surestep.FnGetUserBranch();
//                                     end
//                                     ELSE
//                                         IF LOANS.Source = LOANS.Source::MICRO THEN begin
//                                             GenJournalLine."Shortcut Dimension 1 Code" := 'MICRO';
//                                             GenJournalLine."Shortcut Dimension 2 Code" := Surestep.FnGetUserBranch();
//                                         end;
//                                 GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                                 //GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                 //GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                 if GenJournalLine.Amount <> 0 then
//                                     GenJournalLine.Insert;

//                                 RunBal := RunBal - (GenJournalLine.Amount * -1);
//                                 if RunBal < 0 then
//                                     RunBal := 0;

//                                 LineNo := LineNo + 10000;

//                                 GenJournalLine.Init;
//                                 GenJournalLine."Journal Template Name" := 'GENERAL';
//                                 GenJournalLine."Journal Batch Name" := 'LOANS';
//                                 GenJournalLine."Line No." := LineNo;
//                                 GenJournalLine."Document No." := Loans."Loan  No." + 'RC';
//                                 GenJournalLine."Posting Date" := Today;
//                                 GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//                                 GenJournalLine."Account No." := Loans."Client Code";
//                                 GenJournalLine.Validate(GenJournalLine."Account No.");
//                                 GenJournalLine.Description := Loans."Loan Product Type" + '-Loan Interest Recovery';
//                                 if RunBal < OInterest then
//                                     GenJournalLine.Amount := -RunBal
//                                 else
//                                     GenJournalLine.Amount := -OInterest;
//                                 GenJournalLine.Validate(GenJournalLine.Amount);
//                                 GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
//                                 GenJournalLine."Loan No" := Loans."Loan  No.";
//                                 IF LOANS.Source = LOANS.Source::BOSA THEN begin
//                                     GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                                     GenJournalLine."Shortcut Dimension 2 Code" := Surestep.FnGetUserBranch();
//                                 end ELSE
//                                     IF LOANS.Source = LOANS.Source::FOSA THEN begin
//                                         GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
//                                         GenJournalLine."Shortcut Dimension 2 Code" := Surestep.FnGetUserBranch();
//                                     end
//                                     ELSE
//                                         IF LOANS.Source = LOANS.Source::MICRO THEN begin
//                                             GenJournalLine."Shortcut Dimension 1 Code" := 'MICRO';
//                                             GenJournalLine."Shortcut Dimension 2 Code" := Surestep.FnGetUserBranch();
//                                         end;
//                                 GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                                 //GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                 //GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                 if GenJournalLine.Amount <> 0 then
//                                     GenJournalLine.Insert;

//                                 LineNo := LineNo + 10000;

//                                 GenJournalLine.Init;
//                                 GenJournalLine."Line No." := LineNo;
//                                 GenJournalLine."Journal Template Name" := 'GENERAL';
//                                 GenJournalLine."Journal Batch Name" := 'LOANS';
//                                 GenJournalLine."Document No." := Loans."Loan  No." + 'RC';
//                                 GenJournalLine."Posting Date" := Today;
//                                 GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                                 GenJournalLine."Account No." := "No.";//Loans."Client Code";
//                                 GenJournalLine.Validate(GenJournalLine."Account No.");
//                                 GenJournalLine.Description := Loans."Loan Product Type" + '-Loan Principle Recovery from A/C';
//                                 GenJournalLine.Amount := OBal;
//                                 GenJournalLine.Validate(GenJournalLine.Amount);
//                                 GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                                 IF LOANS.Source = LOANS.Source::BOSA THEN begin
//                                     GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                                     GenJournalLine."Shortcut Dimension 2 Code" := Surestep.FnGetUserBranch();
//                                 end ELSE
//                                     IF LOANS.Source = LOANS.Source::FOSA THEN begin
//                                         GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
//                                         GenJournalLine."Shortcut Dimension 2 Code" := Surestep.FnGetUserBranch();
//                                     end
//                                     ELSE
//                                         IF LOANS.Source = LOANS.Source::MICRO THEN begin
//                                             GenJournalLine."Shortcut Dimension 1 Code" := 'MICRO';
//                                             GenJournalLine."Shortcut Dimension 2 Code" := Surestep.FnGetUserBranch();
//                                         end;
//                                 //GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                 //GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                 if GenJournalLine.Amount <> 0 then
//                                     GenJournalLine.Insert;

//                                 LineNo := LineNo + 10000;

//                                 GenJournalLine.Init;
//                                 GenJournalLine."Line No." := LineNo;
//                                 GenJournalLine."Journal Template Name" := 'GENERAL';
//                                 GenJournalLine."Journal Batch Name" := 'LOANS';
//                                 GenJournalLine."Document No." := Loans."Loan  No." + 'RC';
//                                 GenJournalLine."Posting Date" := Today;
//                                 GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                                 GenJournalLine."Account No." := "No.";//Loans."Client Code";
//                                 GenJournalLine.Validate(GenJournalLine."Account No.");
//                                 GenJournalLine.Description := Loans."Loan Product Type" + '-Loan Interest Recovery from A/C';
//                                 GenJournalLine.Amount := OInterest;
//                                 IF LOANS.Source = LOANS.Source::BOSA THEN begin
//                                     GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                                     GenJournalLine."Shortcut Dimension 2 Code" := Surestep.FnGetUserBranch();
//                                 end ELSE
//                                     IF LOANS.Source = LOANS.Source::FOSA THEN begin
//                                         GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
//                                         GenJournalLine."Shortcut Dimension 2 Code" := Surestep.FnGetUserBranch();
//                                     end
//                                     ELSE
//                                         IF LOANS.Source = LOANS.Source::MICRO THEN begin
//                                             GenJournalLine."Shortcut Dimension 1 Code" := 'MICRO';
//                                             GenJournalLine."Shortcut Dimension 2 Code" := Surestep.FnGetUserBranch();
//                                         end;
//                                 GenJournalLine.Validate(GenJournalLine.Amount);
//                                 GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                                 //GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                 //GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                 if GenJournalLine.Amount <> 0 then
//                                     GenJournalLine.Insert;

//                                 BATCH_TEMPLATE := 'GENERAL';
//                                 BATCH_NAME := 'LOANS';
//                                 DOCUMENT_NO := Loans."Loan  No." + 'RC';

//                                 GenSetup.Get();
//                                 //----------------------------------1.DEBIT TO VENDOR WITH PROCESSING FEE----------------------------------------------
//                                 LineNo := LineNo + 10000;
//                                 SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"0", GenJournalLine."account type"::Vendor,
//                                 "No.", Today, 50, 'FOSA', '', 'Charge on Loan Recovery', '', GenJournalLine."bal. account type"::"G/L Account", '5421');

//                                 //-------------------------------2.CHARGE EXCISE DUTY----------------------------------------------
//                                 LineNo := LineNo + 10000;
//                                 SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"0", GenJournalLine."account type"::Vendor,
//                                 "No.", Today, 10, 'FOSA', '', 'Excise Duty', '', GenJournalLine."bal. account type"::"G/L Account", GenSetup."Excise Duty Account");

//                                 //Post New
//                                 GenJournalLine.Reset;
//                                 GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
//                                 GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
//                                 if GenJournalLine.Find('-') then begin
//                                     Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
//                                 end;
//                                 //Post New

//                             end;
//                         end;

//                         Message('Loan recovered successfully');

//                         "Principle Amount" := 0;
//                         "Interest Amount" := 0;
//                         Modify;

//                     end;
//                 }
//                 action("Recover BOSA Entrance Fee")
//                 {
//                     ApplicationArea = Basic;
//                     Image = PostApplication;
//                     Promoted = true;
//                     PromotedCategory = Category6;

//                     trigger OnAction()
//                     var
//                         RegFee: Decimal;
//                         DBranch: Code[10];
//                     begin
//                         RegFee := 0;
//                         Cust.Reset;
//                         Cust.SetRange(Cust."No.", "BOSA Account No");
//                         //Cust.SetFilter(Cust.Status, '%1', Cust.Status::Active);
//                         if Cust.Find('-') then begin
//                             Cust.SetAutoCalcFields(Cust."Registration Fee Paid");
//                             RegFee := Cust."Registration Fee Paid";
//                             DBranch := Cust."Global Dimension 2 Code";
//                             if RegFee < 1000 then begin
//                                 if Confirm('Are You sure you want to recover BOSA Entrance Fee?', false) = false then begin
//                                     exit;
//                                 end else begin
//                                     GenJournalLine.Reset;
//                                     GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
//                                     GenJournalLine.SetRange("Journal Batch Name", 'ENTRANCE');
//                                     if GenJournalLine.Find('-') then begin
//                                         GenJournalLine.DeleteAll();
//                                     end;
//                                     LineNo := LineNo + 10000;
//                                     GenJournalLine.Init;
//                                     GenJournalLine."Line No." := LineNo;
//                                     GenJournalLine."Journal Template Name" := 'GENERAL';
//                                     GenJournalLine."Journal Batch Name" := 'ENTRANCE';
//                                     GenJournalLine."Document No." := "BOSA Account No";
//                                     GenJournalLine."Posting Date" := Today;
//                                     GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                                     GenJournalLine."Account No." := "No.";
//                                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                                     GenJournalLine.Description := 'BOSA Entrance Fee Recovery';
//                                     GenJournalLine.Amount := 1000 - RegFee;
//                                     GenJournalLine.Validate(GenJournalLine.Amount);
//                                     GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                     if GenJournalLine.Amount <> 0 then
//                                         GenJournalLine.Insert;

//                                     LineNo := LineNo + 10000;
//                                     GenJournalLine.Init;
//                                     GenJournalLine."Line No." := LineNo;
//                                     GenJournalLine."Journal Template Name" := 'GENERAL';
//                                     GenJournalLine."Journal Batch Name" := 'ENTRANCE';
//                                     GenJournalLine."Document No." := "BOSA Account No";
//                                     GenJournalLine."Posting Date" := Today;
//                                     GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
//                                     GenJournalLine."Account No." := "No.";
//                                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                                     GenJournalLine.Description := 'BOSA Entrance Fee-Excise Duty';
//                                     GenJournalLine.Amount := 200;
//                                     GenJournalLine.Validate(GenJournalLine.Amount);
//                                     GenJournalLine."Bal. Account No." := '3326';
//                                     GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                     if GenJournalLine.Amount <> 0 then
//                                         GenJournalLine.Insert;

//                                     LineNo := LineNo + 10000;
//                                     GenJournalLine.Init;
//                                     GenJournalLine."Line No." := LineNo;
//                                     GenJournalLine."Journal Template Name" := 'GENERAL';
//                                     GenJournalLine."Journal Batch Name" := 'ENTRANCE';
//                                     GenJournalLine."Document No." := "BOSA Account No";
//                                     GenJournalLine."Posting Date" := Today;
//                                     GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//                                     GenJournalLine."Account No." := "BOSA Account No";
//                                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                                     GenJournalLine.Description := 'Entrance Fee from A/C';
//                                     GenJournalLine.Amount := -(1000 - RegFee);
//                                     GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee";
//                                     GenJournalLine.Validate(GenJournalLine.Amount);
//                                     GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                                     GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                     GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
//                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                     if GenJournalLine.Amount <> 0 then
//                                         GenJournalLine.Insert;

//                                     //Post New
//                                     GenJournalLine.Reset;
//                                     GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
//                                     GenJournalLine.SetRange("Journal Batch Name", 'ENTRANCE');
//                                     if GenJournalLine.Find('-') then begin
//                                         Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
//                                     end;
//                                 end;
//                             end else begin
//                                 Error('Member has paid his registration fee fully');
//                             end;
//                         end;
//                         Message('Entrance Fee Successfully Recovered');
//                     end;
//                 }
//                 action("Fixed Deposit Certificate")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Fixed Deposit Certificate';
//                     Image = "Report";
//                     Promoted = true;
//                     PromotedCategory = Category7;
//                     visible = false;

//                     trigger OnAction()
//                     begin

//                         if AccountTypes.Get("Account Type") then begin
//                             if AccountTypes."Fixed Deposit" = false then begin
//                                 Error('Applicable only for Fixed Term Deposit accounts.');
//                             end;
//                         end;

//                         Vend.Reset;
//                         Vend.SetRange(Vend."No.", "No.");
//                         if Vend.Find('-') then
//                             Report.Run(51516432, true, true, Vend)
//                     end;
//                 }
//                 action("Recover Overdraft")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin

//         //Hide balances for hidden accounts
//         /*IF CurrForm.UnclearedCh.VISIBLE=FALSE THEN BEGIN
//         CurrForm.BookBal.VISIBLE:=TRUE;
//         CurrForm.UnclearedCh.VISIBLE:=TRUE;
//         CurrForm.AvalBal.VISIBLE:=TRUE;
//         CurrForm.Statement.VISIBLE:=TRUE;
//         CurrForm.Account.VISIBLE:=TRUE;
//         END;

//         IF Hide = TRUE THEN BEGIN
//         IF UsersID.GET(USERID) THEN BEGIN
//         IF UsersID."Show Hiden" = FALSE THEN BEGIN
//         CurrForm.BookBal.VISIBLE:=FALSE;
//         CurrForm.UnclearedCh.VISIBLE:=FALSE;
//         CurrForm.AvalBal.VISIBLE:=FALSE;
//         CurrForm.Statement.VISIBLE:=FALSE;
//         CurrForm.Account.VISIBLE:=FALSE;
//         END;
//         END;
//         END;
//         //Hide balances for hidden accounts
//           */
//         MinBalance := 0;
//         if AccountType.Get("Account Type") then
//             MinBalance := AccountType."Minimum Balance";
//         "Piggy Amount" := "Piggy Amount";
//         "Junior Trip" := "Junior Trip";
//         "Holiday Savings" := "Holiday Savings";
//         /*CurrForm.lblID.VISIBLE := TRUE;
//         CurrForm.lblDOB.VISIBLE := TRUE;
//         CurrForm.lblRegNo.VISIBLE := FALSE;
//         CurrForm.lblRegDate.VISIBLE := FALSE;
//         CurrForm.lblGender.VISIBLE := TRUE;
//         CurrForm.txtGender.VISIBLE := TRUE;
//         IF "Account Category" <> "Account Category"::Single THEN BEGIN
//         CurrForm.lblID.VISIBLE := FALSE;
//         CurrForm.lblDOB.VISIBLE := FALSE;
//         CurrForm.lblRegNo.VISIBLE := TRUE;
//         CurrForm.lblRegDate.VISIBLE := TRUE;
//         CurrForm.lblGender.VISIBLE := FALSE;
//         CurrForm.txtGender.VISIBLE := FALSE;
//         END;*/
//         OnAfterGetCurrRec;

//         Statuschange.Reset;
//         Statuschange.SetRange(Statuschange."User Id", UserId);
//         Statuschange.SetRange(Statuschange."Function", Statuschange."function"::"Account Status");
//         if not Statuschange.Find('-') then
//             CurrPage.Editable := false
//         else
//             CurrPage.Editable := true;

//         CalcFields(NetDis);
//         UnclearedLoan := NetDis;
//         //MESSAGE('Uncleared loan is %1',UnclearedLoan);

//     end;

//     trigger OnFindRecord(Which: Text): Boolean
//     var
//         RecordFound: Boolean;
//     begin
//         RecordFound := Find(Which);
//         CurrPage.Editable := RecordFound or (GetFilter("No.") = '');
//         exit(RecordFound);
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         "Creditor Type" := "creditor type"::Account;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         OnAfterGetCurrRec;
//     end;

//     trigger OnOpenPage()
//     begin
//         ActivateFields;
//         /*
//         IF NOT MapMgt.TestSetup THEN
//           CurrForm.MapPoint.VISIBLE(FALSE);
//         */

//         //Filter based on branch
//         /*IF UsersID.GET(USERID) THEN BEGIN
//         IF UsersID.Branch <> '' THEN
//         SETRANGE("Global Dimension 2 Code",UsersID.Branch);
//         END;*/
//         //Filter based on branch

//     end;

//     var
//         CalendarMgmt: Codeunit "Calendar Management";
//         PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
//         CustomizedCalEntry: Record "Customized Calendar Entry";
//         CustomizedCalendar: Record "Customized Calendar Change";
//         Text001: label 'Do you want to allow payment tolerance for entries that are currently open?';
//         Text002: label 'Do you want to remove payment tolerance from entries that are currently open?';
//         PictureExists: Boolean;
//         AccountTypes: Record "Account Types-Saving Products";
//         GenJournalLine: Record "Gen. Journal Line";
//         // GLPosting: Codeunit "Gen. Jnl.-Post Line";
//         StatusPermissions: Record "Status Change Permision";
//         Charges: Record Charges;
//         ForfeitInterest: Boolean;
//         InterestBuffer: Record "Interest Buffer";
//         FDType: Record "Fixed Deposit Type";
//         Vend: Record Vendor;
//         Cust: Record Customer;
//         LineNo: Integer;
//         UsersID: Record User;
//         DActivity: Code[20];
//         DBranch: Code[20];
//         MinBalance: Decimal;
//         OBalance: Decimal;
//         OInterest: Decimal;
//         Gnljnline: Record "Gen. Journal Line";
//         TotalRecovered: Decimal;
//         LoansR: Record "Loans Register";
//         LoanAllocation: Decimal;
//         LGurantors: Record "Loans Guarantee Details";
//         Loans: Record "Loans Register";
//         DefaulterType: Code[20];
//         LastWithdrawalDate: Date;
//         AccountType: Record "Account Types-Saving Products";
//         ReplCharge: Decimal;
//         Acc: Record Vendor;
//         SearchAcc: Code[10];
//         Searchfee: Decimal;
//         Statuschange: Record "Status Change Permision";
//         UnclearedLoan: Decimal;
//         LineN: Integer;
//         OBal: Decimal;
//         RunBal: Decimal;
//         AvailableBal: Decimal;
//         GenSetup: Record "Sacco General Set-Up";
//         SFactory: Codeunit "SURESTEP Factory";
//         BATCH_TEMPLATE: Code[100];
//         BATCH_NAME: Code[100];
//         DOCUMENT_NO: Code[100];
//         AccountOpening: Codeunit SureAccountCharges;
//         AccountNo: Code[30];
//         "Account No": Record Vendor;
//         Jtemplate: Code[30];
//         JBatch: Code[30];
//         Memb: Record Customer;
//         LineNum: Integer;

//     procedure ActivateFields()
//     begin
//         //CurrForm.Contact.EDITABLE("Primary Contact No." = '');
//     end;

//     local procedure OnAfterGetCurrRec()
//     begin
//         xRec := Rec;
//         ActivateFields;
//     end;
// }
