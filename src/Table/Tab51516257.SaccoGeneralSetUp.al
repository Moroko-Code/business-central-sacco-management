#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516257 "Sacco General Set-Up"
{
    fields
    {
        field(1; "Interest on Share Capital(%)"; Decimal)
        {
        }
        field(2; "Max. Non Contribution Periods"; Code[10])
        {
        }
        field(3; "Min. Contribution"; Decimal)
        {
        }
        field(4; "Min. Dividend Proc. Period"; Code[10])
        {
        }
        field(5; "Loan to Share Ratio"; Decimal)
        {
        }
        field(6; "Min. Loan Application Period"; Code[10])
        {
        }
        field(7; "Min. Guarantors"; Integer)
        {
        }
        field(8; "Max. Guarantors"; Integer)
        {
        }
        field(9; "Member Can Guarantee Own Loan"; Boolean)
        {
        }
        field(10; "Insurance Premium (%)"; Decimal)
        {
        }
        field(11; "Primary Key"; Code[10])
        {
        }
        field(12; "Commision (%)"; Decimal)
        {
        }
        field(13; "Contactual Shares (%)"; Decimal)
        {
        }
        field(14; "Registration Fee"; Decimal)
        {
        }
        field(15; "Welfare Contribution"; Decimal)
        {
        }
        field(16; "Administration Fee"; Decimal)
        {
        }
        field(17; "Dividend (%)"; Decimal)
        {
        }
        field(18; "Statement Message #1"; Text[250])
        {
        }
        field(19; "Statement Message #2"; Text[250])
        {
        }
        field(20; "Statement Message #3"; Text[250])
        {
        }
        field(21; "Statement Message #4"; Text[250])
        {
        }
        field(22; "Statement Message #5"; Text[250])
        {
        }
        field(23; "Statement Message #6"; Text[250])
        {
            Enabled = false;
        }
        field(24; "Defaut Batch"; Code[20])
        {
            // TableRelation = Table50019.Field1;
        }
        field(25; "Min. Member Age"; DateFormula)
        {
        }
        field(26; "Approved Loans Letter"; Code[10])
        {
            TableRelation = "Interaction Template".Code;
        }
        field(27; "Rejected Loans Letter"; Code[10])
        {
            TableRelation = "Interaction Template".Code;
        }
        field(28; "Max. Contactual Shares"; Decimal)
        {
        }
        field(29; "Shares Contribution"; Decimal)
        {
        }
        field(30; "Boosting Shares %"; Decimal)
        {
        }
        field(31; "Boosting Shares Maturity (M)"; DateFormula)
        {
        }
        field(32; "Min Loan Reaplication Period"; DateFormula)
        {
        }
        field(33; "Welfare Breakdown #1 (%)"; Decimal)
        {
        }
        field(34; "Loan to Share Ratio (4M)"; Decimal)
        {
        }
        field(35; "FOSA Loans Transfer Acct"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(36; "FOSA Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(37; "Guarantor Loan No Series"; Code[20])
        {
        }
        field(38; "Interest Due Document No."; Code[20])
        {
        }
        field(39; "Interest Due Posting Date"; Date)
        {
        }
        field(40; "Withholding Tax (%)"; Decimal)
        {
        }
        field(41; "Withdrawal Fee"; Decimal)
        {
        }
        field(42; "Retained Shares"; Decimal)
        {
        }
        field(43; "Multiple Disb. Acc."; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(44; "Receipt Document No."; Code[20])
        {
        }
        field(45; "Minimum Balance"; Decimal)
        {
        }
        field(46; "Use Bands"; Boolean)
        {
        }
        field(47; "Retirement Age"; DateFormula)
        {
        }
        field(48; "Insurance Retension Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(49; "Shares Retension Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50; "Batch File Path"; Text[250])
        {
        }
        field(51; "Incoming Mail Server"; Text[30])
        {
        }
        field(52; "Outgoing Mail Server"; Text[30])
        {
        }
        field(53; "Email Text"; Text[250])
        {
        }
        field(54; "Sender User ID"; Text[30])
        {
        }
        field(55; "Sender Address"; Text[100])
        {
        }
        field(56; "Email Subject"; Text[100])
        {
        }
        field(57; "Template Location"; Text[100])
        {
        }
        field(58; "Copy To"; Text[100])
        {
        }
        field(59; "Delay Time"; Integer)
        {
        }
        field(60; "Alert time"; Time)
        {
        }
        field(61; Shares; Decimal)
        {
        }
        field(62; "Qualifing Shares"; Decimal)
        {
        }
        field(63; "Gross Dividends"; Decimal)
        {
        }
        field(64; "Withholding Tax"; Decimal)
        {
        }
        field(65; "Net Dividends"; Decimal)
        {
        }
        field(66; "Actual Net Surplus"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = filter('1-11-00000' .. '2-99-29999'),
                                                        "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(67; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(68; "Loan Transfer Fees Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(69; "Rejoining Fees Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(70; "Boosting Fees Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(71; "Bridging Commision Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(72; "Funeral Expenses Amount"; Decimal)
        {
        }
        field(73; "Funeral Expenses Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(74; "Interest on Deposits (%)"; Decimal)
        {
        }
        field(75; "Days for Checkoff"; Integer)
        {
        }
        field(76; "Guarantors Multiplier"; Decimal)
        {
        }
        field(77; "Excise Duty(%)"; Decimal)
        {
        }
        field(78; "Excise Duty Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(79; "ATM Expiry Duration"; DateFormula)
        {
        }
        field(80; "Defaulter LN"; Integer)
        {
        }
        field(81; "Loan Trasfer Fee-EFT"; Decimal)
        {
        }
        field(82; "Loan Trasfer Fee-Cheque"; Decimal)
        {
        }
        field(83; "Loan Trasfer Fee-FOSA"; Decimal)
        {
        }
        field(84; "Loan Trasfer Fee A/C-FOSA"; Code[30])
        {
            FieldClass = Normal;
            TableRelation = "G/L Account"."No.";
        }
        field(85; "Loan Trasfer Fee A/C-EFT"; Code[30])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(86; "Loan Trasfer Fee A/C-Cheque"; Code[30])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(87; "Monthly Share Contributions"; Decimal)
        {
        }
        field(88; "Maximum No of Guarantees"; Integer)
        {
        }
        field(89; "Loan Trasfer Fee-RTGS"; Decimal)
        {
        }
        field(90; "Loan Trasfer Fee A/C-RTGS"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(91; "Top up Commission"; Decimal)
        {
        }
        field(92; "ATM Card Fee-New Coop"; Decimal)
        {
        }
        field(93; "ATM Card Fee-Replacement"; Decimal)
        {
        }
        field(94; "ATM Card Fee-Renewal"; Decimal)
        {
        }
        field(95; "ATM Card Fee-Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(96; "ATM Card Fee Co-op Bank"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(97; "ATM Card Fee-New Sacco"; Decimal)
        {
        }
        field(98; "ATM Card Co-op Bank Amount"; Decimal)
        {
        }
        field(99; "Deposits Multiplier"; Decimal)
        {
        }
        field(100; "FOSA MPESA COmm A/C"; Code[30])
        {
            TableRelation = "G/L Account";
        }
        field(101; "Withdrawal Period"; DateFormula)
        {
        }
        field(102; "Rejoining Fee"; Decimal)
        {
        }
        field(103; "Maximum No of Loans Guaranteed"; Integer)
        {
        }
        field(104; "Withdrawal Fee Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(105; "Overdraft App Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(106; "Send SMS Notifications"; Boolean)
        {
        }
        field(107; "ATM Applications"; Code[10])
        {
        }
        field(108; "Auto Open FOSA Savings Acc."; Boolean)
        {
        }
        field(109; "Max Loans To Guarantee"; Integer)
        {
        }
        field(110; "Min Deposits To Apply Loan"; Decimal)
        {
        }
        field(111; "Speed Charge (%)"; Decimal)
        {
        }
        field(112; "Charge Premature Interest"; Boolean)
        {
        }
        field(113; "Retirement Age - Management"; DateFormula)
        {
        }
        field(114; "Customer Care No"; Text[30])
        {
        }
        field(115; "Send Email Notifications"; Boolean)
        {
        }
        field(116; "HQ Branch"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(117; "FOSA Account Type"; Code[20])
        {
            TableRelation = "Account Types-Saving Products".Code;
        }
        field(118; "Auto Fill Msacco Application"; Boolean)
        {
        }
        field(119; "Auto Fill ATM Application"; Boolean)
        {
        }
        field(121; "Allow Multiple Receipts"; Boolean)
        {
        }
        field(122; "Withdrawal fee G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(123; "Boosting Commission Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(124; "Tracker no"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(125; "Withdrawal Commision"; Decimal)
        {
        }
        field(126; "Max. No. of Signatories"; Integer)
        {
        }
        field(127; "Max Loan Guarantors BLoans"; Integer)
        {
        }
        field(128; "Business Loans A/c Format"; Code[10])
        {
            Editable = true;
        }
        field(129; "Min. Contribution Bus Loan"; Decimal)
        {
        }
        field(130; "Speed Charge"; Decimal)
        {
        }
        field(131; "Group Account No"; Code[10])
        {
        }
        field(132; "Form Fee"; Decimal)
        {
        }
        field(133; "Passcard Fee"; Decimal)
        {
        }
        // field(134; "share Capital"; Decimal)
        // {
        // }
        field(135; "Form Fee Account"; Code[30])
        {
            TableRelation = "G/L Account";
        }
        field(136; "Membership Form Acct"; Code[30])
        {
            TableRelation = "G/L Account";
        }
        field(137; "Ceep Reg Fee"; Decimal)
        {
        }
        field(138; "Ceep Reg Acct"; Code[30])
        {
            TableRelation = "G/L Account";
        }
        field(139; "Mpesa Withdrawal Fee"; Decimal)
        {
        }
        field(140; "Mpesa Cash Withdrawal fee ac"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(141; "Mpesa Withdrawal Fee Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(142; "Unpaid Cheques Fee"; Decimal)
        {
        }
        field(143; "Unpaid Cheques Fee Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(144; "Cheque Processing Fee"; Decimal)
        {
        }
        field(145; "Cheque Processing Fee Account"; Code[30])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(146; "Overdraft Limit"; Decimal)
        {
        }
        field(147; "Withholding Tax Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(148; "OKoa Limit"; Decimal)
        {
        }
        field(149; "FOSA Shares dividends(%)"; Decimal)
        {
        }
        field(150; "Dividend Payable Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(151; "SMS Fee Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(152; "Dividend SUspense Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(153; "Dividend Processing Fee"; Decimal)
        {
        }
        field(154; "Dividend Process Fee Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(155; "Interest On Current Shares"; Decimal)
        {
        }
        field(156; "Dividends Paying Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(157; "Interest On FOSA Shares"; Decimal)
        {
        }
        field(158; "GO Live Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(1588; "Interest On Computer Shares"; Decimal)
        {
        }
        field(1589; "Interest On Van Shares"; Decimal)
        {
        }
        field(1590; "Interest On PreferentialShares"; Decimal)
        {
        }
        field(1591; "Interest On LiftShares"; Decimal)
        {
        }
        field(1592; "Interest On TambaaShares"; Decimal)
        {
        }
        field(1593; "Interest On PepeaShares"; Decimal)
        {
        }
        field(1594; "Interest On HousingShares"; Decimal)
        {
        }
        field(1595; "Dividends Capitalization Rate"; Decimal)
        {
        }
        field(1596; "Share Capital Transfer Fee"; Decimal)
        {
        }
        field(1597; "Date For FOSA Interest Run"; Date)
        {
        }
        field(1598; "Date For FOSA Maintanance Run"; Date)
        {
        }
        field(1599; "Last Loan Interest Run Date"; Date)
        {
        }
        field(1600; "Top up Account"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(1601; "Asset Valuation Cost"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(1602; "Legal Fees"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(1603; "Benevolent Fund Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(1604; "Banks Charges"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(1605; "Fixed Deposit Int Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(1606; "Fixed Deposit A/C"; Code[20])
        {
            TableRelation = "G/L Account";
        }

    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        Error('Wacha Ujinga');
    end;
}
