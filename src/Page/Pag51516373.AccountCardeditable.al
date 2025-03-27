// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Page 51516373 "Account Card-editable"
// {
//     Caption = 'Account Card';
//     DeleteAllowed = false;
//     Editable = true;
//     PageType = Card;
//     PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
//     RefreshOnActivate = true;
//     SourceTable = Vendor;

//     layout
//     {
//         area(content)
//         {
//             group(AccountTab)
//             {
//                 Caption = 'General Information';
//                 field("No.";"No.")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Account No';
//                     Editable = false;

//                     trigger OnAssistEdit()
//                     begin
//                         if AssistEdit(xRec) then
//                           CurrPage.Update;
//                     end;
//                 }
//                 field(Name;Name)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Account Name';
//                 }
//                 field("ID No.";"ID No.")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'ID No.';
//                 }
//                 field("Passport No.";"Passport No.")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Staff No";"Staff No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Force No.";"Force No.")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Company Code";"Company Code")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Global Dimension 1 Code";"Global Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Global Dimension 2 Code";"Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Station/Sections";"Station/Sections")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(txtGender;Gender)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Gender';
//                     Editable = true;
//                 }
//                 field("Marital Status";"Marital Status")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 field("Date of Birth";"Date of Birth")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Date of Birth';
//                     Editable = false;
//                 }
//                 field("Phone No.";"Phone No.")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 field("MPESA Mobile No";"MPESA Mobile No")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 field("Sms Notification";"Sms Notification")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Piggy Amount";"Piggy Amount")
//                 {
//                     ApplicationArea = Basic;
//                     Style = Attention;
//                     StyleExpr = true;
//                 }
//                 field("Junior Trip";"Junior Trip")
//                 {
//                     ApplicationArea = Basic;
//                     Style = Attention;
//                     StyleExpr = true;
//                 }
//                 field("Holiday Savings";"Holiday Savings")
//                 {
//                     ApplicationArea = Basic;
//                     Style = Attention;
//                     StyleExpr = true;
//                 }
//                 field("Monthly Contribution";"Monthly Contribution")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Pastrol Cont";"Pastrol Cont")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Signature;Signature)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 // field(Picture;Picture)
//                 // {
//                 //     ApplicationArea = Basic;
//                 //     Editable = true;
//                 // }
//             }
//             group(AccountTab1)
//             {
//                 Caption = 'Communication Details';
//                 field(Address;Address)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Post Code";"Post Code")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Post Code/City';
//                 }
//                 field("Address 2";"Address 2")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(City;City)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Mobile Phone No";"Mobile Phone No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("E-Mail";"E-Mail")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Home Page";"Home Page")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Contact;Contact)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("ContacPerson Phone";"ContacPerson Phone")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("ContactPerson Occupation";"ContactPerson Occupation")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("ContactPerson Relation";"ContactPerson Relation")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Home Address";"Home Address")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             group(AccountInfo)
//             {
//                 Caption = 'Account Information';
//                 field("Account Type";"Account Type")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Account Category";"Account Category")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("BOSA Account No";"BOSA Account No")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 field("Uncleared Cheques";"Uncleared Cheques")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Authorised Over Draft";"Authorised Over Draft")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Balance (LCY)";"Balance (LCY)")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(AvailableBal;("Balance (LCY)"+"Authorised Over Draft")-("Uncleared Cheques"+"ATM Transactions"+"EFT Transactions"+MinBalance))
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("ATM Transactions";"ATM Transactions")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Registration Date";"Registration Date")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 field(Status;Status)
//                 {
//                     ApplicationArea = Basic;
//                     Style = Standard;
//                     StyleExpr = true;

//                     trigger OnValidate()
//                     begin
//                         TestField("Resons for Status Change");

//                         StatusPermissions.Reset;
//                         StatusPermissions.SetRange(StatusPermissions."User Id",UserId);
//                         StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::"Account Status");
//                         if StatusPermissions.Find('-') = false then
//                         Error('You do not have permissions to change the account status.');

//                         if "Account Type" = 'FIXED' then begin
//                         if "Balance (LCY)" > 0 then begin
//                         CalcFields("Last Interest Date");

//                         if "Call Deposit" = true then begin
//                         if Status = Status::Closed then begin
//                         if "Last Interest Date" < Today then
//                         Error('Fixed deposit interest not UPDATED. Please update interest.');
//                         end else begin
//                         if "Last Interest Date" < "FD Maturity Date" then
//                         Error('Fixed deposit interest not UPDATED. Please update interest.');
//                         end;
//                         end;
//                         end;
//                         end;

//                         if Status = Status::Active then begin
//                         if Confirm('Are you sure you want to re-activate this account? This will recover re-activation fee.',false) = false then begin
//                         Error('Re-activation terminated.');
//                         end;

//                         Blocked:=Blocked::" ";
//                         Modify;

//                         end;

//                         //Account Closure
//                         if Status = Status::Closed then begin
//                         TestField("Closure Notice Date");
//                         if Confirm('Are you sure you want to close this account? This will recover closure fee and any '
//                         + 'interest earned before maturity will be forfeited.',false) = false then begin
//                         Error('Closure terminated.');
//                         end;

//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange(GenJournalLine."Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",'FTRANS');
//                         if GenJournalLine.Find('-') then
//                         GenJournalLine.DeleteAll;

//                         AccountTypes.Reset;
//                         AccountTypes.SetRange(AccountTypes.Code,"Account Type");
//                         if AccountTypes.Find('-') then  begin
//                         "Date Closed":=Today;

//                         //Closure charges
//                         /*Charges.RESET;
//                         IF CALCDATE(AccountTypes."Closure Notice Period","Closure Notice Date") > TODAY THEN
//                         Charges.SETRANGE(Charges.Code,AccountTypes."Closing Prior Notice Charge") */

//                         Charges.Reset;
//                         if CalcDate(AccountTypes."Closure Notice Period","Closure Notice Date") > Today then
//                         Charges.SetRange(Charges.Code,AccountType."Closing Charge")

//                         else
//                         Charges.SetRange(Charges.Code,AccountTypes."Closing Charge");
//                         if Charges.Find('-') then begin
//                         LineNo:=LineNo+10000;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Document No.":="No."+'-CL';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         GenJournalLine."Account No.":="No.";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine.Description:=Charges.Description;
//                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                         GenJournalLine.Amount:=Charges."Charge Amount";
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
//                         GenJournalLine."Bal. Account No.":=Charges."GL Account";
//                         GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                         if GenJournalLine.Amount<>0 then
//                         GenJournalLine.Insert;

//                         end;
//                         //Closure charges

//                         //Interest forfeited/Earned on maturity
//                         CalcFields("Untranfered Interest");
//                         if "Untranfered Interest" > 0 then begin
//                         ForfeitInterest:=true;
//                         //If FD - Check if matured
//                         if AccountTypes."Fixed Deposit" = true then begin
//                         if "FD Maturity Date" <= Today then
//                         ForfeitInterest:=false;
//                         if "Call Deposit" = true then
//                         ForfeitInterest:=false;

//                         end;

//                         //PKK INGORE MATURITY
//                         ForfeitInterest:=false;
//                         //If FD - Check if matured

//                         if ForfeitInterest = true then begin
//                         LineNo:=LineNo+10000;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Document No.":="No."+'-CL';
//                         GenJournalLine."External Document No.":="No.";
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
//                         GenJournalLine."Account No.":=AccountTypes."Interest Forfeited Account";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine.Description:='Interest Forfeited';
//                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                         GenJournalLine.Amount:=-"Untranfered Interest";
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
//                         GenJournalLine."Bal. Account No.":=AccountTypes."Interest Payable Account";
//                         GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                         GenJournalLine."Shortcut Dimension 1 Code":="Global Dimension 1 Code";
//                         GenJournalLine."Shortcut Dimension 2 Code":="Global Dimension 2 Code";
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                         if GenJournalLine.Amount<>0 then
//                         GenJournalLine.Insert;

//                         InterestBuffer.Reset;
//                         InterestBuffer.SetRange(InterestBuffer."Account No","No.");
//                         if InterestBuffer.Find('-') then
//                         InterestBuffer.ModifyAll(InterestBuffer.Transferred,true);

//                         end else begin
//                         LineNo:=LineNo+10000;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Document No.":="No."+'-CL';
//                         GenJournalLine."External Document No.":="No.";
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         if AccountTypes."Fixed Deposit" = true then
//                         GenJournalLine."Account No.":="Savings Account No."
//                         else
//                         GenJournalLine."Account No.":="No.";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine.Description:='Interest Earned';
//                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                         GenJournalLine.Amount:=-"Untranfered Interest";
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
//                         GenJournalLine."Bal. Account No.":=AccountTypes."Interest Payable Account";
//                         GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                         if GenJournalLine.Amount<>0 then
//                         GenJournalLine.Insert;

//                         InterestBuffer.Reset;
//                         InterestBuffer.SetRange(InterestBuffer."Account No","No.");
//                         if InterestBuffer.Find('-') then
//                         InterestBuffer.ModifyAll(InterestBuffer.Transferred,true);

//                         end;

//                         //Transfer Balance if Fixed Deposit
//                         if AccountTypes."Fixed Deposit" = true then begin
//                         CalcFields("Balance (LCY)");

//                         TestField("Savings Account No.");

//                         LineNo:=LineNo+10000;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Document No.":="No."+'-CL';
//                         GenJournalLine."External Document No.":="No.";
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         GenJournalLine."Account No.":="Savings Account No.";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine.Description:='FD Balance Tranfers';
//                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                         if "Amount to Transfer" <> 0 then
//                         GenJournalLine.Amount:=-"Amount to Transfer"
//                         else
//                         GenJournalLine.Amount:=-"Balance (LCY)";
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         if GenJournalLine.Amount<>0 then
//                         GenJournalLine.Insert;

//                         LineNo:=LineNo+10000;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Document No.":="No."+'-CL';
//                         GenJournalLine."External Document No.":="No.";
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         GenJournalLine."Account No.":="No.";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine.Description:='FD Balance Tranfers';
//                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                         if "Amount to Transfer" <> 0 then
//                         GenJournalLine.Amount:="Amount to Transfer"
//                         else
//                         GenJournalLine.Amount:="Balance (LCY)";
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         if GenJournalLine.Amount<>0 then
//                         GenJournalLine.Insert;

//                         end;

//                         //Transfer Balance if Fixed Deposit

//                         end;

//                         //Interest forfeited/Earned on maturity

//                         //Post New
//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
//                         if GenJournalLine.Find('-') then begin
//                         Codeunit.Run(Codeunit::"Gen. Jnl.-Post",GenJournalLine);
//                         end;
//                         //Post New

//                         Message('Funds transfered successfully to main account and account closed.');

//                         end;
//                         end;

//                         //Account Closure

//                     end;
//                 }
//                 field(Blocked;Blocked)
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         TestField("Resons for Status Change");
//                     end;
//                 }
//                 field("Closure Notice Date";"Closure Notice Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Resons for Status Change";"Resons for Status Change")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Bankers Cheque Amount";"Bankers Cheque Amount")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Signing Instructions";"Signing Instructions")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     MultiLine = true;
//                 }
//                 field("Salary Processing";"Salary Processing")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Net Salary";"Net Salary")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Do Not Include?";"Do Not Include?")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Grower No";"Grower No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             group("ATM Details")
//             {
//                 Caption = 'ATM Details';
//                 field("ATM No.";"ATM No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Card No.";"Card No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Disabled ATM Card No";"Disabled ATM Card No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Reason For Disabling ATM Card";"Reason For Disabling ATM Card")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Disabled By";"Disabled By")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Reason for Enabling ATM Card";"Reason for Enabling ATM Card")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Enabled By";"Enabled By")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Last Date Modified";"Last Date Modified")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Modified By";"Modified By")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             group("Fixed")
//             {
//                 Caption = 'Fixed Deposit';
//                 field(Regdate;"Registration Date")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Fixed Deposit Start Date';
//                     Editable = true;
//                 }
//                 field("Fixed Deposit Type";"Fixed Deposit Type")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("FD Duration";"FD Duration")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("FD Maturity Date";"FD Maturity Date")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Maturity Date';
//                 }
//                 field("Neg. Interest Rate";"Neg. Interest Rate")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Fixed Deposit Status";"Fixed Deposit Status")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Call Deposit";"Call Deposit")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Amount to Transfer";"Amount to Transfer")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Amount to Transfer';
//                 }
//                 field("Savings Account No.";"Savings Account No.")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Account to transfer to';
//                     Editable = true;
//                 }
//                 field("Interest Earned";"Interest Earned")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("FD Maturity Instructions";"FD Maturity Instructions")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Date Renewed";"Date Renewed")
//                 {
//                     ApplicationArea = Basic;
//                 }
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
//                     RunPageLink = "Vendor No."=field("No.");
//                     RunPageView = sorting("Vendor No.");
//                     ShortCutKey = 'Ctrl+F7';
//                 }
//                 action("Co&mments")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page "Comment Sheet";
//                     RunPageLink = "Table Name"=const(Vendor),
//                                   "No."=field("No.");
//                 }
//                 action(Dimensions)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     RunObject = Page "Default Dimensions";
//                     RunPageLink = "Table ID"=const(23),
//                                   "No."=field("No.");
//                     ShortCutKey = 'Shift+Ctrl+D';
//                 }
//                 separator(Action108)
//                 {
//                 }
//                 action("Re-new Fixed Deposit")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Re-new Fixed Deposit';
//                     Image = "Report";

//                     trigger OnAction()
//                     begin

//                         if AccountTypes.Get("Account Type") then begin
//                         if AccountTypes."Fixed Deposit" = true then begin
//                         if "Call Deposit" = false then begin
//                         TestField("Fixed Duration");
//                         TestField("FD Maturity Date");
//                         if "FD Maturity Date" > Today then
//                         Error('Fixed deposit has not matured.');

//                         end;

//                         if "Don't Transfer to Savings" = false then
//                         TestField("Savings Account No.");

//                         CalcFields("Last Interest Date");

//                         if "Call Deposit" = true then begin
//                         if "Last Interest Date" < Today then
//                         Error('Fixed deposit interest not UPDATED. Please update interest.');
//                         end else begin
//                         if "Last Interest Date" < "FD Maturity Date" then
//                         Error('Fixed deposit interest not UPDATED. Please update interest.');
//                         end;

//                         if Confirm('Are you sure you want to renew this Fixed deposit. Interest will be transfered accordingly?') = false then
//                         exit;

//                         CalcFields("Untranfered Interest");

//                         if "Call Deposit" = false then begin
//                         "Date Renewed":="FD Maturity Date";
//                         end else
//                         "Date Renewed":=Today;
//                         Validate("Date Renewed");
//                         Modify;

//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange(GenJournalLine."Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",'FTRANS');
//                         if GenJournalLine.Find('-') then
//                         GenJournalLine.DeleteAll;

//                         LineNo:=LineNo+10000;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Document No.":="No."+'-RN';
//                         GenJournalLine."External Document No.":="No.";
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         if "Don't Transfer to Savings" = false then
//                         GenJournalLine."Account No.":="Savings Account No."
//                         else
//                         GenJournalLine."Account No.":="No.";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine.Description:='Interest Earned';
//                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                         GenJournalLine.Amount:=-"Untranfered Interest";
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
//                         GenJournalLine."Bal. Account No.":=AccountTypes."Interest Payable Account";
//                         GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                         if GenJournalLine.Amount<>0 then
//                         GenJournalLine.Insert;

//                         InterestBuffer.Reset;
//                         InterestBuffer.SetRange(InterestBuffer."Account No","No.");
//                         if InterestBuffer.Find('-') then
//                         InterestBuffer.ModifyAll(InterestBuffer.Transferred,true);

//                         //Post
//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
//                         if GenJournalLine.Find('-') then begin
//                         Codeunit.Run(Codeunit::"Gen. Jnl.-Post",GenJournalLine);
//                         end;

//                         Message('Fixed deposit renewed successfully');
//                         end;
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
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = New;
//                     RunObject = Page "Member Account Card";
//                     RunPageLink = "No."=field("BOSA Account No");
//                 }
//                 action("<Action11027600800>")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Loans Statements';
//                     Image = "Report";
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = "Report";

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

//                     trigger OnAction()
//                     begin
//                         Cust.Reset;
//                         Cust.SetRange(Cust."No.","BOSA Account No");
//                         if Cust.Find('-') then
//                         Report.Run(51516223,true,false,Cust);
//                     end;
//                 }
//                 action("FOSA Loans")
//                 {
//                     ApplicationArea = Basic;
//                     Promoted = true;
//                     RunObject = Page "Loans Posted List";
//                     RunPageLink = "Account No"=field("No."),
//                                   Source=filter(FOSA);
//                 }
//                 action("Close Account")
//                 {
//                     ApplicationArea = Basic;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                          if Confirm('Are you sure you want to Close this Account?',false)=true then begin
//                          if "Balance (LCY)"-("Uncleared Cheques"+"ATM Transactions"+"EFT Transactions"+MinBalance+UnclearedLoan)<0 then
//                          Error('This Member does not enough Savings to recover Withdrawal Fee')
//                         else
//                             LineN:=LineN+10000;
//                             Gnljnline.Init;
//                             Gnljnline."Journal Template Name":='GENERAL';
//                             Gnljnline."Journal Batch Name":='ACC CLOSED';
//                             Gnljnline."Line No.":=LineN;
//                             Gnljnline."Account Type":=Gnljnline."account type"::Vendor;
//                             Gnljnline."Account No.":="No.";
//                             Gnljnline.Validate(Gnljnline."Account No.");
//                             Gnljnline."Document No.":='LR-'+"No.";
//                             Gnljnline."Posting Date":=Today;
//                             Gnljnline.Amount:=500;
//                             Gnljnline.Description:='Account Closure Fee';
//                             Gnljnline.Validate(Gnljnline.Amount);
//                             if Gnljnline.Amount<>0 then
//                             Gnljnline.Insert;

//                             LineN:=LineN+10000;
//                             Gnljnline.Init;
//                             Gnljnline."Journal Template Name":='GENERAL';
//                             Gnljnline."Journal Batch Name":='ACC CLOSED';
//                             Gnljnline."Line No.":=LineN;
//                             Gnljnline."Account Type":=Gnljnline."bal. account type"::"G/L Account";
//                             Gnljnline."Bal. Account No.":='105113';
//                             Gnljnline.Validate(Gnljnline."Bal. Account No.");
//                             Gnljnline."Document No.":='LR-'+"No.";
//                             Gnljnline."Posting Date":=Today;
//                             Gnljnline.Amount:=-500;
//                             Gnljnline.Description:='Account Closure Fee';
//                             Gnljnline.Validate(Gnljnline.Amount);
//                             if Gnljnline.Amount<>0 then
//                             Gnljnline.Insert;

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

//                     trigger OnAction()
//                     begin
//                         if "Account Type" <> 'FIXED' then
//                         Error('Only applicable for Fixed Deposit accounts.');

//                         CalcFields("Last Interest Date");

//                         if "Last Interest Date" >= Today then
//                         Error('Interest Up to date.');

//                         //IF CONFIRM('Are you sure you want to update the Fixed deposit interest.?') = FALSE THEN
//                         //EXIT;

//                         Vend.Reset;
//                         Vend.SetRange(Vend."No.","No.");
//                         if Vend.Find('-') then
//                         Report.Run(51516275,true,true,Vend)
//                     end;
//                 }
//             }
//             group(ActionGroup1102755009)
//             {
//                 action(Signatories)
//                 {
//                     ApplicationArea = Basic;
//                     Image = customer;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "Account Signatories List";
//                     RunPageLink = "Account No"=field("No.");
//                 }
//                 action("Next Of Kin")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Next Of Kin';
//                     Image = Relationship;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "Account Next of Kin Details";
//                     RunPageLink = "Account No"=field("No.");
//                 }
//                 separator(Action1102755005)
//                 {
//                 }
//                 action("Transfer FD Amnt from Savings")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnAction()
//                     begin

//                         //Transfer Balance if Fixed Deposit

//                         AccountTypes.Reset;
//                         AccountTypes.SetRange(AccountTypes.Code,"Account Type");
//                         if AccountTypes.Find('-') then  begin
//                         //IF AccountTypes."Fixed Deposit" <> TRUE THEN BEGIN
//                         if Vend.Get("Savings Account No.") then begin
//                         if Confirm('Are you sure you want to effect the transfer from the savings account',false) = false then
//                         exit else

//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange(GenJournalLine."Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",'FTRANS');
//                         if GenJournalLine.Find('-') then
//                         GenJournalLine.DeleteAll;

//                         Vend.Reset;
//                         if Vend.Find('-') then
//                         Vend.CalcFields(Vend."Balance (LCY)");
//                         //IF (Vend."Balance (LCY)" - 500) < "Fixed Deposit Amount" THEN
//                         //ERROR('Savings account does not have enough money to facilate the requested trasfer.');
//                         //MESSAGE('Katabaka ene!');
//                         LineNo:=LineNo+10000;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Document No.":="No."+'-OP';
//                         GenJournalLine."External Document No.":="No.";
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         GenJournalLine."Account No.":="Savings Account No.";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine.Description:='FD Balance Tranfers';
//                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                         //GenJournalLine.Amount:="Fixed Deposit Amount";
//                         GenJournalLine.Amount:="Amount to Transfer";
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         if GenJournalLine.Amount<>0 then
//                         GenJournalLine.Insert;
//                          //MESSAGE('The FDR amount is %1 ',"Fixed Deposit Amount");
//                         LineNo:=LineNo+10000;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Document No.":="No."+'-OP';
//                         GenJournalLine."External Document No.":="No.";
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         GenJournalLine."Account No.":="No.";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine.Description:='FD Balance Tranfers';
//                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                         //GenJournalLine.Amount:=-"Fixed Deposit Amount";
//                         GenJournalLine.Amount:=-"Amount to Transfer";
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         if GenJournalLine.Amount<>0 then
//                         GenJournalLine.Insert;

//                         //END;
//                         end;
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

//                     trigger OnAction()
//                     begin

//                         //Transfer Balance if Fixed Deposit

//                         AccountTypes.Reset;
//                         AccountTypes.SetRange(AccountTypes.Code,"Account Type");
//                         if AccountTypes.Find('-') then  begin
//                         if AccountTypes."Fixed Deposit" = true then begin
//                         if Vend.Get("No.") then begin
//                         if Confirm('Are you sure you want to effect the transfer from the Fixed Deposit account',false) = false then
//                         exit;

//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange(GenJournalLine."Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",'FTRANS');
//                         if GenJournalLine.Find('-') then
//                         GenJournalLine.DeleteAll;

//                         Vend.CalcFields(Vend."Balance (LCY)");
//                         if (Vend."Balance (LCY)") < "Transfer Amount to Savings" then
//                         Error('Fixed Deposit account does not have enough money to facilate the requested trasfer.');

//                         LineNo:=LineNo+10000;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Document No.":="No."+'-OP';
//                         GenJournalLine."External Document No.":="No.";
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         GenJournalLine."Account No.":="No.";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine.Description:='FD Balance Tranfers';
//                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                         GenJournalLine.Amount:="Transfer Amount to Savings";
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         if GenJournalLine.Amount<>0 then
//                         GenJournalLine.Insert;

//                         LineNo:=LineNo+10000;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Document No.":="No."+'-OP';
//                         GenJournalLine."External Document No.":="No.";
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         GenJournalLine."Account No.":="Savings Account No.";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine.Description:='FD Balance Tranfers';
//                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                         GenJournalLine.Amount:=-"Transfer Amount to Savings";
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         if GenJournalLine.Amount<>0 then
//                         GenJournalLine.Insert;

//                         end;
//                         end;
//                         end;

//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
//                         if GenJournalLine.Find('-') then begin
//                         repeat
//                         //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
//                         until GenJournalLine.Next = 0;
//                         end;

//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
//                         GenJournalLine.DeleteAll;

//                         Message('Amount transfered successfully.');
//                     end;
//                 }
//                 action("Renew Fixed deposit")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnAction()
//                     begin

//                         if AccountTypes.Get("Account Type") then begin
//                         if AccountTypes."Fixed Deposit" = true then begin
//                         if Confirm('Are you sure you want to renew the fixed deposit.',false) = false then
//                         exit;

//                         TestField("FD Maturity Date");
//                         if FDType.Get("Fixed Deposit Type") then begin
//                         "FD Maturity Date":=CalcDate(FDType.Duration,"FD Maturity Date");
//                         "Date Renewed":=Today;
//                         "FDR Deposit Status Type":="fdr deposit status type"::Renewed;
//                         Modify;

//                         Message('Fixed deposit renewed successfully');
//                         end;
//                         end;
//                         end;
//                     end;
//                 }
//                 action("Terminate Fixed Deposit")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnAction()
//                     begin

//                         //Transfer Balance if Fixed Deposit

//                         AccountTypes.Reset;
//                         AccountTypes.SetRange(AccountTypes.Code,"Account Type");
//                         if AccountTypes.Find('-') then  begin
//                         if AccountTypes."Fixed Deposit" = true then begin
//                         if Vend.Get("No.") then begin
//                         if Confirm('Are you sure you want to Terminate this Fixed Deposit Contract?',false) = false then
//                         exit;

//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange(GenJournalLine."Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",'FTRANS');
//                         if GenJournalLine.Find('-') then
//                         GenJournalLine.DeleteAll;

//                         Vend.CalcFields(Vend."Balance (LCY)");
//                         if (Vend."Balance (LCY)") < "Transfer Amount to Savings" then
//                         Error('Fixed Deposit account does not have enough money to facilate the requested trasfer.');

//                         LineNo:=LineNo+10000;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Document No.":="No."+'-OP';
//                         GenJournalLine."External Document No.":="No.";
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         GenJournalLine."Account No.":="No.";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine.Description:='FD Termination Tranfer';
//                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                         GenJournalLine.Amount:="Balance (LCY)";
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         if GenJournalLine.Amount<>0 then
//                         GenJournalLine.Insert;

//                         LineNo:=LineNo+10000;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Document No.":="No."+'-OP';
//                         GenJournalLine."External Document No.":="No.";
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         GenJournalLine."Account No.":="Savings Account No.";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine.Description:='FD Termination Tranfer';
//                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                         GenJournalLine.Amount:=-"Balance (LCY)";
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         if GenJournalLine.Amount<>0 then
//                         GenJournalLine.Insert;

//                         end;
//                         end;
//                         end;

//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
//                         if GenJournalLine.Find('-') then begin
//                         repeat
//                         Codeunit.Run(Codeunit::"Gen. Jnl.-Post",GenJournalLine);
//                         until GenJournalLine.Next = 0;
//                         end;

//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
//                         GenJournalLine.DeleteAll;

//                         Message('Amount transfered successfully back to the savings Account.');
//                         "FDR Deposit Status Type":="fdr deposit status type"::Terminated;

//                          /*
//                         //Renew Fixed deposit - OnAction()

//                         IF AccountTypes.GET("Account Type") THEN BEGIN
//                         IF AccountTypes."Fixed Deposit" = TRUE THEN BEGIN
//                         IF CONFIRM('Are you sure you want to renew the fixed deposit.',FALSE) = FALSE THEN
//                         EXIT;

//                         TESTFIELD("FD Maturity Date");
//                         IF FDType.GET("Fixed Deposit Type") THEN BEGIN
//                         "FD Maturity Date":=CALCDATE(FDType.Duration,"FD Maturity Date");
//                         "Date Renewed":=TODAY;
//                         "FDR Deposit Status Type":="FDR Deposit Status Type"::Renewed;
//                         MODIFY;

//                         MESSAGE('Fixed deposit renewed successfully');
//                         END;
//                         END;
//                         END;
//                           */

//                     end;
//                 }
//                 action("Page Vendor Statement")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Statement';
//                     Image = "Report";
//                     Promoted = true;
//                     PromotedCategory = "Report";

//                     trigger OnAction()
//                     begin

//                         Vend.Reset;
//                         Vend.SetRange(Vend."No.","No.");
//                         if Vend.Find('-') then
//                         Report.Run(51516248,true,false,Vend)
//                     end;
//                 }
//                 action("Charge Fosa Statement")
//                 {
//                     ApplicationArea = Basic;
//                     Image = PostApplication;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin

//                         if Confirm('Are you sure you want to charge statement fee? This will recover statement fee.',false) = false then
//                         exit;

//                         CalcFields("Balance (LCY)","ATM Transactions");
//                         if ("Balance (LCY)"-"ATM Transactions")<=0 then
//                         Error('This Account does not have sufficient funds');

//                         AccountTypes.Reset;
//                         AccountTypes.SetRange(AccountTypes.Code,"Account Type");
//                         if AccountTypes.Find('-') then  begin

//                         //Closure charges
//                         Charges.Reset;
//                         Charges.SetRange(Charges.Code,AccountTypes."Statement Charge");
//                         if Charges.Find('-') then begin
//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange(GenJournalLine."Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",'FTRANS');
//                         if GenJournalLine.Find('-') then
//                         GenJournalLine.DeleteAll;

//                         LineNo:=LineNo+10000;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Document No.":="No."+'-STM';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         GenJournalLine."Account No.":="No.";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine.Description:=Charges.Description;
//                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                         GenJournalLine.Amount:=Charges."Charge Amount";
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
//                         GenJournalLine."Bal. Account No.":=Charges."GL Account";
//                         GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                         if GenJournalLine.Amount<>0 then
//                         GenJournalLine.Insert;

//                         //Post New
//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
//                         if GenJournalLine.Find('-') then begin
//                         //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
//                         end;

//                         //Post New

//                         end;
//                         //Closure charges

//                         end;
//                     end;
//                 }
//                 action("Charge ATM Card Placement")
//                 {
//                     ApplicationArea = Basic;
//                     Image = PostApplication;
//                     Promoted = false;
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         StatusPermissions.Reset;
//                         StatusPermissions.SetRange(StatusPermissions."User Id",UserId);
//                         StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::"ATM Approval");
//                         if StatusPermissions.Find('-') = false then
//                         Error('You do not have permissions to charge ATM placement,please contact systems administrator');

//                         if Confirm('Are you sure you want to post the ATM Charges fee?')=false then
//                         exit;

//                         CalcFields("Balance (LCY)","ATM Transactions");
//                         if ("Balance (LCY)"-"ATM Transactions")<=0 then
//                         Error('This Account does not have sufficient funds');

//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
//                         GenJournalLine.DeleteAll;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Line No.":=GenJournalLine."Line No."+1000;
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         GenJournalLine."Account No.":="No.";
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine."Document No.":="Card No.";
//                         GenJournalLine.Description:='Sacco Link Card Charges: '+ "Card No.";
//                         GenJournalLine.Amount:=605;
//                         GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                         if GenJournalLine.Amount <>0 then
//                         GenJournalLine.Insert;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Line No.":=GenJournalLine."Line No."+1000;
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
//                         GenJournalLine."Account No.":='BNK00008';
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine."Document No.":="Card No.";
//                         GenJournalLine.Description:='Sacco Link Card Charges: No.'+ "Card No.";
//                         GenJournalLine.Amount:=-550;
//                         GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                         if GenJournalLine.Amount <>0 then
//                         GenJournalLine.Insert;

//                         //Comms to Commissions account
//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Line No.":=GenJournalLine."Line No."+1000;
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
//                         GenJournalLine."Account No.":='300-000-404';
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine."Document No.":="Card No.";
//                         GenJournalLine.Description:='Sacco Link Card Charges' + 'No.'+ "Card No.";
//                         GenJournalLine.Amount:=-50;
//                         GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                         if GenJournalLine.Amount <>0 then
//                         GenJournalLine.Insert;

//                         //******excise duty

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Line No.":=GenJournalLine."Line No."+1000;
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
//                         GenJournalLine."Account No.":='200-000-168';
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine."Document No.":="Card No.";
//                         GenJournalLine.Description:='Excise Duty' + 'No.'+ "Card No.";
//                         GenJournalLine.Amount:=-5;
//                         GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                         if GenJournalLine.Amount <>0 then
//                         GenJournalLine.Insert;

//                         //Post New
//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
//                         if GenJournalLine.Find('-') then begin
//                         //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
//                           Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch",GenJournalLine);

//                         end;
//                         //Post New
//                     end;
//                 }
//                 action("Charge ATM Card Replacement")
//                 {
//                     ApplicationArea = Basic;
//                     Image = PostApplication;
//                     Promoted = false;
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = Process;

//                     trigger OnAction()
//                     begin

//                         StatusPermissions.Reset;
//                         StatusPermissions.SetRange(StatusPermissions."User Id",UserId);
//                         StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::"ATM Approval");
//                         if StatusPermissions.Find('-') = false then
//                         Error('You do not have permissions to charge ATM Replacement,please contact systems administrator');

//                         if Confirm('Are you sure you want to post the ATM Charges fee?')=false then
//                         exit;

//                         CalcFields("Balance (LCY)","ATM Transactions");
//                         if ("Balance (LCY)"-"ATM Transactions")<=0 then
//                         Error('This Account does not have sufficient funds');

//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
//                         GenJournalLine.DeleteAll;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Line No.":=GenJournalLine."Line No."+1000;
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         GenJournalLine."Account No.":="No.";
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine."Document No.":="Card No.";
//                         GenJournalLine.Description:='Sacco Link Card Charges: '+ "Card No.";
//                         GenJournalLine.Amount:=600;
//                         GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                         if GenJournalLine.Amount <>0 then
//                         GenJournalLine.Insert;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Line No.":=GenJournalLine."Line No."+1000;
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
//                         GenJournalLine."Account No.":='BNK00010';
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine."Document No.":="Card No.";
//                         GenJournalLine.Description:='Sacco Link Card Charges: No.'+ "Card No.";
//                         GenJournalLine.Amount:=-500;
//                         GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                         if GenJournalLine.Amount <>0 then
//                         GenJournalLine.Insert;

//                         //Comms to Commissions account
//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Line No.":=GenJournalLine."Line No."+1000;
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
//                         GenJournalLine."Account No.":='300-000-3016';
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine."Document No.":="Card No.";
//                         GenJournalLine.Description:='Sacco Link Card Charges' + 'No.'+ "Card No.";
//                         GenJournalLine.Amount:=-100;
//                         GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                         if GenJournalLine.Amount <>0 then
//                         GenJournalLine.Insert;

//                         //Post New
//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
//                         if GenJournalLine.Find('-') then begin
//                         //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
//                           Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch",GenJournalLine);

//                         end;
//                         //Post New
//                     end;
//                 }
//                 action("Charge Pass Book")
//                 {
//                     ApplicationArea = Basic;
//                     Enabled = false;
//                     Image = PostApplication;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin

//                         if Confirm('Are you sure you want to charge Pass book fee? This will recover passbook fee.',false) = false then
//                         exit;

//                         CalcFields("Balance (LCY)","ATM Transactions");
//                         if ("Balance (LCY)"-"ATM Transactions")<=0 then
//                         Error('This Account does not have sufficient funds');

//                         AccountTypes.Reset;
//                         AccountTypes.SetRange(AccountTypes.Code,"Account Type");
//                         if AccountTypes.Find('-') then  begin

//                         //Closure charges
//                         Charges.Reset;
//                         Charges.SetRange(Charges.Code,AccountTypes."Statement Charge");
//                         if Charges.Find('-') then begin
//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange(GenJournalLine."Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",'FTRANS');
//                         if GenJournalLine.Find('-') then
//                         GenJournalLine.DeleteAll;

//                         LineNo:=LineNo+10000;

//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='PURCHASES';
//                         GenJournalLine."Journal Batch Name":='FTRANS';
//                         GenJournalLine."Document No.":="No."+'-STM';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         GenJournalLine."Account No.":="No.";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Posting Date":=Today;
//                         GenJournalLine.Description:=Charges.Description;
//                         GenJournalLine.Validate(GenJournalLine."Currency Code");
//                         GenJournalLine.Amount:=Charges."Charge Amount";
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
//                         GenJournalLine."Bal. Account No.":=Charges."GL Account";
//                         GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                         if GenJournalLine.Amount<>0 then
//                         GenJournalLine.Insert;

//                         //Post New
//                         GenJournalLine.Reset;
//                         GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
//                         GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
//                         if GenJournalLine.Find('-') then begin
//                         //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
//                         end;

//                         //Post New

//                         end;
//                         //Closure charges

//                         end;
//                     end;
//                 }
//                 action("Disable ATM Card")
//                 {
//                     ApplicationArea = Basic;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin

//                         StatusPermissions.Reset;
//                         StatusPermissions.SetRange(StatusPermissions."User Id",UserId);
//                         StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::"Disable ATM");
//                         if StatusPermissions.Find('-') = false then
//                         Error('You do not have permissions to disable ATM cards');

//                         if Confirm('Are you sure you want to disable the ATM card?')=false then
//                         exit;

//                         if "Reason For Disabling ATM Card"='' then
//                         Error('You must specify reason for disabling this ATM Card');

//                         if "ATM No."=''then
//                         Error('You cannot disable a blank ATM Card');

//                         "Disable ATM Card":=true;
//                         "Disabled ATM Card No":="ATM No.";
//                         "ATM No.":='';
//                         "ATM Prov. No":='';
//                         "Atm card ready" := false;
//                         "Disabled By":=UserId;
//                         Modify;
//                     end;
//                 }
//                 action("Enable ATM Card")
//                 {
//                     ApplicationArea = Basic;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         StatusPermissions.Reset;
//                         StatusPermissions.SetRange(StatusPermissions."User Id",UserId);
//                         StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::"Disable ATM");
//                         if StatusPermissions.Find('-') = false then
//                         Error('You do not have permissions to Disable ATM cards');

//                         if Confirm('Are you sure you want to enable the ATM card?')=false then
//                         exit;

//                         if "ATM No."<>''then
//                         Error('You cannot Enable an active ATM Card');

//                         if "Reason for Enabling ATM Card"='' then
//                         Error('You must specify reason for Re-enabling this ATM');

//                         "Disable ATM Card":=false;
//                         "ATM No.":="Disabled ATM Card No";
//                         "Disabled ATM Card No":='';
//                         "Enabled By":=UserId;
//                         "Date Enabled":=Today;
//                         Modify;
//                     end;
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
//         currpage.BookBal.VISIBLE:=FALSE;
//         CurrForm.UnclearedCh.VISIBLE:=FALSE;
//         CurrForm.AvalBal.VISIBLE:=FALSE;
//         CurrForm.Statement.VISIBLE:=FALSE;
//         CurrForm.Account.VISIBLE:=FALSE;
//         END;
//         END;
//         END;
//         //Hide balances for hidden accounts
//           */
//         MinBalance:=0;
//         if AccountType.Get("Account Type") then
//         MinBalance:=AccountType."Minimum Balance";

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
//         /*
//         Statuschange.RESET;
//         Statuschange.SETRANGE(Statuschange."User ID",USERID);
//         Statuschange.SETRANGE(Statuschange."Function",Statuschange."Function"::"Account Status");
//         IF NOT Statuschange.FIND('-')THEN
//         CurrPage.EDITABLE:=FALSE
//         ELSE
//         CurrPage.EDITABLE:=TRUE;
//         */
//         CalcFields(NetDis);
//         UnclearedLoan:=NetDis;
//         //MESSAGE('Uncleared loan is %1',UnclearedLoan);

//     end;

//     trigger OnFindRecord(Which: Text): Boolean
//     var
//         RecordFound: Boolean;
//     begin

//         RecordFound := Find(Which);
//         CurrPage.Editable:=true;
//         CurrPage.Editable := RecordFound or (GetFilter("No.") = '');
//         exit(RecordFound);
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         "Creditor Type":="creditor type"::Account;
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

//         StatusPermissions.Reset;
//         StatusPermissions.SetRange(StatusPermissions."User Id",UserId);
//         StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::Edit);
//         if StatusPermissions.Find('-') = false then
//         Error('You do not have permissions to edit account information.');

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
//        // GLPosting: Codeunit "Gen. Jnl.-Post Line";
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
//         LGurantors: Record "Loan GuarantorsFOSA";
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

//     procedure ActivateFields()
//     begin
//         //CurrForm.Contact.EDITABLE("Primary Contact No." = '');
//     end;

//     local procedure OnAfterGetCurrRec()
//     begin
//         /*xRec := Rec;
//         ActivateFields;*/

//     end;
// }
