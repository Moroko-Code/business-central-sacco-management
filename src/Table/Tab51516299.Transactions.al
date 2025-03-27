#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516299 "Transactions"
{
    // DrillDownPageID = "Cashier Transactions - List";
    // LookupPageID = "Cashier Transactions - List";

    fields
    {
        field(1; No; Code[20])
        {
            Editable = true;

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Transaction Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = Vendor where(Status = filter(<> Closed),
                                          "Account Type" = filter(<> 'HOSPITAL'));

            trigger OnValidate()
            begin

                Cashier := UserId;
                "Transaction Date" := Today;
                "Transaction Time" := Time;
                Status := Status::Pending;
                "Needs Approval" := "needs approval"::Yes;
                "Frequency Needs Approval" := "frequency needs approval"::Yes;

                CustM.Reset;
                if CustM.Find('-') then begin
                    Picture := CustM.Image;
                    Signature := CustM.Signature;
                end;
                if (Account."FOSA Balance" <> 0) and (Account.Status = Account.Status::New) then begin
                    Account.Status := Account.Status::Active;
                    Account.Modify;
                end;

                //CHECK ACCOUNT ACTIVITY
                Account.Reset;
                if Account.Get("Account No") then begin
                    if Account.Status = Account.Status::Dormant then;
                    //Account.Status:=Account.Status::Active;
                    //Account.MODIFY;
                    if Account.Status = Account.Status::New then begin
                    end

                    else
                        if Account.Status <> Account.Status::Active then
                            Error('The account is not active and therefore cannot be transacted upon.');

                    Account.CalcFields(Account."FOSA Balance");
                    "Account Name" := Account.Name;
                    Payee := Account.Name;
                    "Account Type" := Account."Account Type";
                    "Currency Code" := Account."Currency Code";
                    "Staff/Payroll No" := Account."Staff No";
                    "ID No" := Account."ID No.";
                    "Member No." := Account."BOSA Account No";
                    "Atm Number" := Account."ATM No.";
                    // Picture := Account.Picture;
                    //Signature := Account.Signature;
                    if (Account."FOSA Balance" <> 0) and (Account.Status = Account.Status::New) then begin
                        Account.Status := Account.Status::Active;
                        Account.Modify;
                    end;

                    "Book Balance" := Account."FOSA Balance";

                    if Account."Account Category" = Account."account category"::Branch then
                        "Branch Transaction" := true;
                end;

                if AccountTypes.Get("Account Type") then begin
                    "Account Description" := AccountTypes.Description;
                    "Minimum Account Balance" := AccountTypes."Minimum Balance";
                    "Fee Below Minimum Balance" := AccountTypes."Fee Below Minimum Balance";
                    "Fee on Withdrawal Interval" := AccountTypes."Withdrawal Penalty";
                end;

                if Account."Atm card ready" = true then
                    Message('Atm card is ready for collection');
            end;
        }
        field(3; "Account Name"; Text[200])
        {
        }
        field(4; "Transaction Type"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Transaction Types" where("Account Type" = field("Account Type"));

            trigger OnValidate()
            begin
                VarAmtHolder := 0;
                if TransactionTypes.Get("Transaction Type") then begin
                    "Transaction Description" := TransactionTypes.Description;
                    "Transaction Mode" := TransactionTypes."Default Mode";
                    "Transaction Span" := TransactionTypes."Transaction Span";
                    Evaluate(Type, Format(TransactionTypes.Type));
                    /*
                    IF (TransactionTypes.Type = TransactionTypes.Type::Withdrawal) OR
                       (TransactionTypes.Type = TransactionTypes.Type::"Bankers Cheque") THEN BEGIN
                    IF Account.GET("Account No") THEN BEGIN
                    IF Account.Blocked <> Account.Blocked::" " THEN
                    ERROR('Account holder blocked from doing this transaction. %1',"Account No")
                    END;
                    END;
                    */
                end;

                if "Transaction Category" = 'BANKERS CHEQUE' then
                    if "Bankers Cheque Type" = "bankers cheque type"::Company then begin
                        TransactionCharges.Reset;
                        TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");
                        if TransactionCharges.Find('-') then
                            ////////
                            repeat
                                if TransactionCharges."Use Percentage" = true then begin
                                    if TransactionCharges."Percentage of Amount" = 0 then
                                        Error('Percentage of amount cannot be zero.');
                                    VarAmtHolder := VarAmtHolder + (TransactionCharges."Percentage of Amount" / 100) * "Suspended Amount";
                                end
                                else
                                    VarAmtHolder := VarAmtHolder + TransactionCharges."Charge Amount";
                            /////////
                            until TransactionCharges.Next = 0;

                        if "Suspended Amount" <> 0 then
                            Amount := "Suspended Amount" - VarAmtHolder
                        else
                            Amount := 0;
                    end;
            end;
        }
        field(5; Amount; Decimal)
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Transaction Category" = 'BANKERS CHEQUE' then
                    if "Bankers Cheque Type" = "bankers cheque type"::Company then;
                if "Transaction Type" = 'CWITHO' then
                    if Amount > ("Book Balance" - 1000) then
                        Message('You cannot withdraw amount Below Minimum Balance, Enter a Lower or Equal Amount');
            end;
        }
        field(6; Cashier; Code[60])
        {
            Editable = false;
        }
        field(7; "Transaction Date"; Date)
        {
            Editable = true;

            trigger OnValidate()
            begin
                if "Transaction Mode" = "transaction mode"::Cheque then
                    if ChequeTypes.Get("Cheque Type") then begin
                        CDays := ChequeTypes."Clearing  Days" + 1;

                        EMaturity := "Transaction Date";
                        if i < CDays then
                            repeat
                                EMaturity := CalcDate('1D', EMaturity);
                                if (Date2dwy(EMaturity, 1) <> 6) and (Date2dwy(EMaturity, 1) <> 7) then
                                    i := i + 1;
                            until i = CDays;

                        "Expected Maturity Date" := EMaturity;
                    end;
            end;
        }
        field(8; "Transaction Time"; Time)
        {
            Editable = false;
        }
        field(9; Posted; Boolean)
        {
            Editable = true;
        }
        field(10; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(11; "Account Type"; Code[20])
        {
            TableRelation = "Account Types-Saving Products".Code;
        }
        field(12; "Account Description"; Text[80])
        {
        }
        field(13; "Denomination Total"; Decimal)
        {
        }
        field(14; "Cheque Type"; Code[20])
        {
            TableRelation = "Cheque Types";

            trigger OnValidate()
            begin
                if ChequeTypes.Get("Cheque Type") then begin
                    Description := ChequeTypes.Description;
                    "Clearing Charges" := ChequeTypes."Clearing Charges";
                    "Clearing Days" := ChequeTypes."Clearing Days";

                    CDays := ChequeTypes."Clearing  Days"; //+1;

                    EMaturity := "Transaction Date";
                    if i < CDays then
                        repeat
                            EMaturity := CalcDate('1D', EMaturity);
                            if (Date2dwy(EMaturity, 1) <> 6) and (Date2dwy(EMaturity, 1) <> 7) then
                                i := i + 1;
                        until i = CDays;

                    "Expected Maturity Date" := EMaturity;
                end;
            end;
        }
        field(15; "Cheque No"; Code[20])
        {
            trigger OnValidate()
            begin
                if "Cheque No" <> '' then begin
                    Trans.Reset;
                    Trans.SetCurrentkey(Trans."Cheque No");
                    Trans.SetRange(Trans."Cheque No", "Cheque No");
                    Trans.SetRange(Trans.Posted, true);
                    //IF Trans.FIND('-') THEN
                    //ERROR('There is an existing posted cheque No. %1',Trans.No);
                end;
            end;
        }
        field(16; "Cheque Date"; Date)
        {
            trigger OnValidate()
            begin
                if "Cheque Date" > Today then
                    Error('Post dated cheques not allowed.');

                if CalcDate('6M', "Cheque Date") < Today then
                    Error('Cheque stale therefore cannot be accepted.');
            end;
        }
        field(17; Payee; Text[100])
        {
        }
        field(19; "Bank No"; Code[20])
        {
            TableRelation = "Bank Account";

            trigger OnLookup()
            begin
                //"Bank No":=BanksList.Code;
                /*
                BanksList.RESET;

                IF BanksList.GET("Bank No") THEN BEGIN
                "Bank Name":=BanksList."Bank Name";
                END;

                BanksList.RESET;
                */
            end;
        }
        field(20; "Branch No"; Code[20])
        {
            trigger OnValidate()
            begin
                /*BanksList.RESET;
                IF BanksList.GET("Branch No") THEN BEGIN
                "Branch Name":=BanksList."Bank Name";
                END;
                */
            end;
        }
        field(21; "Clearing Charges"; Decimal)
        {
        }
        field(22; "Clearing Days"; DateFormula)
        {
        }
        field(23; Description; Text[150])
        {
            trigger OnValidate()
            begin
                Description := UpperCase(Description);
            end;
        }
        field(24; "Bank Name"; Text[150])
        {
        }
        field(25; "Branch Name"; Text[150])
        {
        }
        field(26; "Transaction Mode"; Option)
        {
            Caption = 'Payment Mode';
            OptionCaption = 'Cash,Cheque';
            OptionMembers = Cash,Cheque;
            TableRelation = "Transaction Type";
        }
        field(27; Type; Text[50])
        {
        }
        field(31; "Transaction Description"; Text[100])
        {
        }
        field(32; "Minimum Account Balance"; Decimal)
        {
            FieldClass = Normal;
        }
        field(33; "Fee Below Minimum Balance"; Decimal)
        {
        }
        field(34; "Normal Withdrawal Charge"; Decimal)
        {
        }
        field(36; Authorised; Option)
        {
            Editable = true;
            OptionMembers = No,Yes,Rejected,"No Charges";

            trigger OnValidate()
            begin
                "Withdrawal FrequencyAuthorised" := Authorised;
            end;
        }
        field(39; "Checked By"; Text[50])
        {
        }
        field(40; "Fee on Withdrawal Interval"; Decimal)
        {
        }
        field(41; Remarks; Text[250])
        {
        }
        field(42; Status; Option)
        {
            OptionMembers = Pending,Honoured,Stopped,Bounced;
        }
        field(43; "Date Posted"; Date)
        {
        }
        field(44; "Time Posted"; Time)
        {
        }
        field(45; "Posted By"; Text[50])
        {
        }
        field(46; "Expected Maturity Date"; Date)
        {
        }
        field(47; Picture; Media)
        {
            Caption = 'Picture';
            // SubType = Bitmap;
        }
        field(48; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(49; "Transaction Category"; Code[20])
        {
        }
        field(50; Deposited; Boolean)
        {
        }
        field(51; "Date Deposited"; Date)
        {
        }
        field(52; "Time Deposited"; Time)
        {
        }
        field(53; "Deposited By"; Text[20])
        {
        }
        field(54; "Post Dated"; Boolean)
        {
        }
        field(55; Select; Boolean)
        {
        }
        field(56; "Status Date"; Date)
        {
        }
        field(57; "Status Time"; Time)
        {
        }
        field(58; "Supervisor Checked"; Boolean)
        {
        }
        field(59; "Book Balance"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(60; "Notice No"; Code[20])
        {
        }
        field(61; "Notice Cleared"; Option)
        {
            OptionMembers = Pending,No,Yes,"No Charges";
        }
        field(62; "Schedule Amount"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(63; "Has Schedule"; Boolean)
        {
        }
        field(64; Requested; Boolean)
        {
        }
        field(65; "Date Requested"; Date)
        {
        }
        field(66; "Time Requested"; Time)
        {
        }
        field(67; "Requested By"; Text[20])
        {
        }
        field(68; Overdraft; Boolean)
        {
        }
        field(69; "Cheque Processed"; Boolean)
        {
        }
        field(70; "Staff/Payroll No"; Text[20])
        {
            trigger OnValidate()
            begin
                /*Account.RESET;
                Account.SETRANGE(Account."Staff/Payroll No","Staff/Payroll No");

                IF Account.FIND('-')THEN BEGIN
                MESSAGE('its there');
                IF Account.Status=Account.Status::Dormant THEN BEGIN
                Account.Status:=Account.Status::Active;
                Account.MODIFY;
                END;
                IF Account.Status=Account.Status::New THEN BEGIN
                END
                ELSE BEGIN
                IF Account.Status<>Account.Status::Active THEN
                ERROR('The account is not active and therefore cannot be transacted upon.');
                END;
                END;

                IF Account.GET("Staff/Payroll No") THEN BEGIN
                "Account No":=Account."No.";
                "Account Name":=Account.Name;
                "Account Type":=Account."Account Type";
                "Currency Code":=Account."Currency Code";
                END;

                IF AccountTypes.GET("Account Type") THEN BEGIN
                "Account Description":=AccountTypes.Description;
                "Minimum Account Balance":=AccountTypes."Minimum Balance";
                "Fee Below Minimum Balance":=AccountTypes."Fee Below Minimum Balance";
                //"Normal Withdrawal Charge":=AccountTypes."Withdrawal Charge";
                "Fee on Withdrawal > Interval":=AccountTypes."Withdrawal Penalty";
                END;

                 */
            end;
        }
        field(71; "Cheque Transferred"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(72; "Expected Amount"; Decimal)
        {
        }
        field(73; "Line Totals"; Decimal)
        {
        }
        field(74; "Transfer Date"; Date)
        {
        }
        field(75; "BIH No"; Code[20])
        {
        }
        field(76; "Transfer No"; Code[20])
        {
        }
        field(77; Attached; Boolean)
        {
        }
        field(78; "BOSA Account No"; Code[20])
        {
            TableRelation = Customer."No." where("Customer Type" = filter(Member | MicroFinance),
                                                            Status = const(Active));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                /*Cust.RESET;
                Cust.SETRANGE(Cust."No.","BOSA Account No");
                IF Cust.FIND('-') THEN BEGIN
                Payee:=Cust.Name;
                "Reference No":=Cust."Payroll/Staff No";
                "Staff/Payroll No":=Cust."Payroll/Staff No";
                "ID No":=Cust."ID No.";
                END;
                  */
            end;
        }
        field(79; "Salary Processing"; Option)
        {
            OptionMembers = " ",No,Yes;
        }
        field(80; "Expense Account"; Code[30])
        {
        }
        field(81; "Expense Description"; Text[150])
        {
        }
        field(82; "Company Code"; Code[30])
        {
            TableRelation = "Sacco Employers".Code;
        }
        field(83; "Schedule Type"; Option)
        {
            OptionMembers = ,"Salary Processing",Contributions,"ATM EFT Transactions","Savings Loan Recoveries";
        }
        field(84; "Banked By"; Code[20])
        {
        }
        field(85; "Date Banked"; Date)
        {
        }
        field(86; "Time Banked"; Time)
        {
        }
        field(87; "Banking Posted"; Boolean)
        {
        }
        field(88; "Cleared By"; Code[50])
        {
        }
        field(89; "Date Cleared"; Date)
        {
        }
        field(90; "Time Cleared"; Time)
        {
        }
        field(91; "Clearing Posted"; Boolean)
        {
        }
        field(92; "Needs Approval"; Option)
        {
            OptionMembers = Yes,No;
        }
        field(93; "ID Type"; Code[20])
        {
        }
        field(94; "ID No"; Code[50])
        {
            trigger OnValidate()
            begin

                /*IF ("Account No"<>'00-0000003000') OR ("Account No"<>'00-0000000000')  THEN
                ERROR('THIS ID. NO CANNOT BE MODIFIED');*/
                "N.A.H Balance" := 0;
                VendLedg.Reset;
                VendLedg.SetCurrentkey(VendLedg."External Document No.");
                VendLedg.SetRange(VendLedg."External Document No.", "ID No");
                if VendLedg.Find('-') then begin
                    VendLedg.CalcFields(VendLedg.Amount);
                    repeat
                        "N.A.H Balance" := ("N.A.H Balance" + VendLedg.Amount) * -1;
                        Modify;
                    until VendLedg.Next = 0;
                end;
            end;
        }
        field(95; "Reference No"; Code[20])
        {
        }
        field(96; "Refund Cheque"; Boolean)
        {
        }
        field(97; Imported; Boolean)
        {
        }
        field(98; "External Account No"; Code[30])
        {
        }
        field(99; "BOSA Transactions"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(100; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(101; "Savers Total"; Decimal)
        {
            FieldClass = Normal;
        }
        field(102; "Mustaafu Total"; Decimal)
        {
            FieldClass = Normal;
        }
        field(103; "Junior Star Total"; Decimal)
        {
            FieldClass = Normal;
        }
        field(104; Printed; Boolean)
        {
        }
        field(105; "Account Type."; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(106; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type." = const("G/L Account")) "G/L Account"
            else
            if ("Account Type." = const(Customer)) Customer
            else
            if ("Account Type." = const(Vendor)) Vendor
            else
            if ("Account Type." = const("Bank Account")) "Bank Account"
            else
            if ("Account Type." = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type." = const("IC Partner")) "IC Partner";

            trigger OnValidate()
            begin

                if "Account Type." in ["account type."::Customer, "account type."::Vendor, "account type."::
                "IC Partner"] then
                    case "Account Type." of
                        "account type."::"G/L Account":

                            GLAcc.Get("Account No.");

                        "account type."::Customer:

                            Cust.Get("Account No.");
                        "account type."::Vendor:

                            Vend.Get("Account No.");
                        "account type."::"Bank Account":

                            BankAcc.Get("Account No.");
                        "account type."::"Fixed Asset":

                            FA.Get("Account No.");
                    end;
            end;
        }
        field(107; "Withdrawal FrequencyAuthorised"; Option)
        {
            OptionMembers = No,Yes,Rejected;
        }
        field(108; "Frequency Needs Approval"; Option)
        {
            OptionMembers = " ",No,Yes;
        }
        field(109; "Special Advance No"; Code[20])
        {
        }
        field(110; "Bankers Cheque Type"; Option)
        {
            OptionMembers = Normal,Company;

            trigger OnValidate()
            begin
                if "Bankers Cheque Type" = "bankers cheque type"::Company then begin
                    GenLedgerSetup.Get;
                    // GenLedgerSetup.TESTFIELD(GenLedgerSetup."Company Bankers Cheque Account");
                    "Account Type." := "account type."::"G/L Account";
                    //"Account No.":=GenLedgerSetup."Company Bankers Cheque Account";

                end else
                    "Account No." := '';
            end;
        }
        field(111; "Suspended Amount"; Decimal)
        {
        }
        field(112; "Transferred By EFT"; Boolean)
        {
        }
        field(113; "Banking User"; Code[20])
        {
        }
        field(114; "Company Text Name"; Code[20])
        {
        }
        field(115; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(116; "Total Salaries"; Integer)
        {
            FieldClass = Normal;
        }
        field(117; "EFT Transferred"; Boolean)
        {
        }
        field(118; "ATM Transactions Total"; Decimal)
        {
            FieldClass = Normal;
        }
        field(119; "Bank Code"; Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                /*IF BanksList.GET("Bank Code") THEN BEGIN
                "Bank Name":=BanksList."Bank Name";
                "Branch Name":=BanksList.Branch;
                END;

                "Bank No":=BanksList.Code;
                */
                BanksList.Reset;

                if BanksList.Get("Bank No") then
                    "Bank Name" := BanksList.Name;

                BanksList.Reset;
            end;
        }
        field(120; "External Account Name"; Text[50])
        {
        }
        field(121; "Overdraft Limit"; Decimal)
        {
        }
        field(122; "Overdraft Allowed"; Boolean)
        {
        }
        field(123; "Available Balance"; Decimal)
        {
        }
        field(124; "Authorisation Requirement"; Text[50])
        {
        }
        field(125; "Bankers Cheque No"; Code[20])
        {
            TableRelation = "Banker Cheque Register"."Banker Cheque No." where(Issued = const(false),
                                                                                Cancelled = const(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if BRegister.Get("Bankers Cheque No") then begin
                    BRegister.Issued := true;
                    BRegister.Modify;
                end;
            end;
        }
        field(126; "Transaction Span"; Option)
        {
            OptionCaption = 'FOSA,BOSA';
            OptionMembers = FOSA,BOSA;
        }
        field(127; "Uncleared Cheques"; Decimal)
        {
            CalcFormula = sum(Transactions.Amount where("Account No" = field("Account No"),
                                                         Posted = const(true),
                                                         "Cheque Processed" = const(false),
                                                         Type = const('Cheque Deposit')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(128; "Transaction Available Balance"; Decimal)
        {
        }
        field(129; "Branch Account"; Code[20])
        {
            TableRelation = Vendor."No." where("Creditor Type" = const(Account),
                                                "Account Category" = const(Branch));

            trigger OnValidate()
            begin
                if Acc.Get("Branch Account") then
                    "FOSA Branch Name" := Acc.Name;
            end;
        }
        field(130; "Branch Transaction"; Boolean)
        {
        }
        field(131; "FOSA Branch Name"; Text[30])
        {
        }
        field(133; "Branch Refference"; Text[30])
        {
        }
        field(134; "Branch Account No"; Code[20])
        {
        }
        field(135; "Branch Transaction Date"; Date)
        {
        }
        field(136; "Post Attempted"; Boolean)
        {
        }
        field(137; "Transacting Branch"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(138; Signature; Media)
        {
            // SubType = Bitmap;
        }
        field(139; "Allocated Amount"; Decimal)
        {
            CalcFormula = sum("Receipt Allocation"."Total Amount" where("Document No" = field(No),
                                                                         "Member No" = field("BOSA Account No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(140; "Amount Discounted"; Decimal)
        {
        }
        field(141; "Dont Clear"; Boolean)
        {
        }
        field(142; "Other Bankers No."; Code[100])
        {
        }
        field(62000; "N.A.H Balance"; Decimal)
        {
        }
        field(62001; "Cheque Deposit Remarks"; Text[50])
        {
        }
        field(62002; "Balancing Account"; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(62003; "Balancing Account Name"; Text[50])
        {
            trigger OnValidate()
            begin
                Vend.Reset;

                if Vend.Get(No) then
                    "Balancing Account Name" := Vend.Name;
            end;
        }
        field(62004; "Bankers Cheque Payee"; Text[80])
        {
        }
        field(62005; "Atm Number"; Text[30])
        {
        }
        field(62006; "Member Name"; Text[50])
        {
        }
        field(62007; "Savings Product"; Code[20])
        {
            TableRelation = "Account Types-Saving Products".Code;
        }
        field(62008; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Member No");
                if Cust.Find('-') then
                    "Member Name" := Cust.Name;
            end;
        }
        field(62009; Withdarawal; Boolean)
        {
        }
        field(62010; "Payee Bank No"; Code[15])
        {
        }
        field(62011; Payout; Boolean)
        {
        }
        field(62012; "Payment Voucher No"; Code[20])
        {
        }
        field(62013; "Withdrawable Balance"; Decimal)
        {
        }
        field(62014; "Member No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
        key(Key2; "Transfer No")
        {
            SumIndexFields = Amount;
        }
        key(Key3; Type, "Transaction Date", Posted, "Transaction Category")
        {
            SumIndexFields = Amount;
        }
        key(Key4; "Account No", "Cheque Processed", Deposited, "Transaction Category")
        {
            SumIndexFields = Amount;
        }
        key(Key5; Deposited, Posted, "Transaction Category", "Transaction Date", "Has Schedule")
        {
            SumIndexFields = Amount;
        }
        key(Key6; Requested, "Transaction Category", "Transaction Date")
        {
            SumIndexFields = Amount;
        }
        key(Key7; "Account No", "Cheque Processed", Posted, Type)
        {
            SumIndexFields = Amount;
        }
        key(Key8; "Cheque No")
        {
        }
        key(Key9; "Transaction Type", "Transaction Date", Posted)
        {
            SumIndexFields = Amount;
        }
        key(Key10; "Bankers Cheque No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        //ERROR('The transaction has been posted and therefore cannot be deleted.');

        /*IF Deposited THEN BEGIN
        ERROR('The cheque has already been deposited and therefore cannot be deleted.');
        END;*/
    end;

    trigger OnInsert()
    begin

        if No = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Transaction Nos.");
            NoSeriesMgt.InitSeries(NoSetup."Transaction Nos.", xRec."No. Series", 0D, No, "No. Series");

            Commit;
        end;

        //IF UsersID.GET(USERID) THEN
        //"Transacting Branch":=UsersID.Branch;
    end;

    trigger OnModify()
    begin

        //IF Posted=TRUE THEN
        //ERROR('You can not modify an already posted transaction');
    end;

    trigger OnRename()
    begin
        if Type <> 'Cheque Deposit' then
            if Posted then
                Error('The transaction has been posted and therefore cannot be modified.');

        if Deposited then
            Error('The cheque has already been deposited and therefore cannot be modified.');
        /*
     //Cyrus
     IF Cashier <> UPPERCASE(USERID) THEN
     ERROR('Cannot rename a Transaction being processed by %1',Cashier);
       */
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Account: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
        ChequeTypes: Record "Cheque Types";
        Banks: Record "Bank Account";
        BankBranches: Record "Bank Branch";
        PaymentMethod: Record "Payment Method";
        TransactionTypes: Record "Transaction Types";
        Cust: Record Customer;
        i: Integer;
        PublicHoliday: Integer;
        weekday: Integer;
        CDays: Integer;
        BanksList: Record "Bank Account";
        GLAcc: Record "G/L Account";
        Vend: Record Vendor;
        BankAcc: Record "Bank Account";
        FA: Record "Fixed Asset";
        GenLedgerSetup: Record "General Ledger Setup";
        TransactionCharges: Record "Transaction Charges";
        VarAmtHolder: Decimal;
        DimValue: Record "Dimension Value";
        EMaturity: Date;
        BRegister: Record "Banker Cheque Register";
        Acc: Record Vendor;
        UsersID: Record User;
        Trans: Record Transactions;
        VendLedg: Record "Vendor Ledger Entry";
        ATMApp: Record "ATM Card Applications";
        CustM: Record Vendor;
}
