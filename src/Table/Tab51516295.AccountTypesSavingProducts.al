#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516295 "Account Types-Saving Products"
{
    DrillDownPageId = "Account Types List";
    LookupPageId = "Account Types List";
    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
        }
        field(4; "Minimum Balance"; Decimal)
        {
        }
        field(5; "Closure Fee"; Decimal)
        {
        }
        field(6; "Fee Below Minimum Balance"; Decimal)
        {
        }
        field(7; "Dormancy Period (M)"; DateFormula)
        {
        }
        field(8; "Interest Calc Min Balance"; Decimal)
        {
        }
        field(9; "Interest Calculation Method"; Code[30])
        {
        }
        field(13; "Earns Interest"; Boolean)
        {
        }
        field(14; "Interest Rate"; Decimal)
        {
        }
        field(15; "Withdrawal Interval"; DateFormula)
        {
        }
        field(17; "Service Charge"; Decimal)
        {
        }
        field(18; "Maintenence Fee"; Decimal)
        {
        }
        field(19; "Minimum Interest Period (M)"; DateFormula)
        {
        }
        field(20; "Requires Closure Notice"; Boolean)
        {
        }
        field(21; "Transfer Fee"; Decimal)
        {
        }
        field(22; "Pass Book Fee"; Decimal)
        {
        }
        field(23; "Withdrawal Penalty"; Decimal)
        {
            Description = 'Charged on withdrawing more than the interval period';
        }
        field(24; "Salary Processing Fee"; Decimal)
        {
        }
        field(25; "Loan Application Fee"; Decimal)
        {
        }
        field(26; "Maximum Withdrawal Amount"; Decimal)
        {
        }
        field(31; "Max Period For Acc Topup (M)"; DateFormula)
        {
        }
        field(32; "Non Staff Loan Security(%)"; Decimal)
        {
        }
        field(33; "Staff Loan Security(%)"; Decimal)
        {
        }
        field(34; "Maximum Allowable Deposit"; Decimal)
        {
        }
        field(35; "Entered By"; Code[30])
        {
        }
        field(36; "Date Entered"; Date)
        {
        }
        field(37; "Time Entered"; Time)
        {
        }
        field(39; "Fixed Deposit Type"; Code[30])
        {
            //  TableRelation = Table53026;
        }
        field(40; "Last Date Modified"; Date)
        {
        }
        field(41; "Modified By"; Text[30])
        {
        }
        field(43; "Reject App. Pending Period"; DateFormula)
        {
        }
        field(44; "Maintenence Duration"; DateFormula)
        {
        }
        field(45; "Fixed Deposit"; Boolean)
        {
        }
        field(46; "Overdraft Charge"; Code[20])
        {
            TableRelation = Charges;
        }
        field(47; "Charge Closure Before Maturity"; Decimal)
        {
        }
        field(48; "Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            TableRelation = "Vendor Posting Group";
        }
        field(49; "Account No Prefix"; Code[10])
        {
        }
        field(50; "Interest Expense Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(51; "Interest Payable Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(52; "Requires Opening Deposit"; Boolean)
        {
        }
        field(53; "Interest Forfeited Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(54; "Allow Loan Applications"; Boolean)
        {
        }
        field(55; "Closing Charge"; Code[20])
        {
            TableRelation = Charges;
        }
        field(56; "Min Bal. Calc Frequency"; DateFormula)
        {
        }
        field(57; "SMS Description"; Text[150])
        {
        }
        field(58; "Authorised Ovedraft Charge"; Code[20])
        {
            TableRelation = Charges;
        }
        field(59; "Fee bellow Min. Bal. Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(60; "Withdrawal Interval Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(61; "No. Series"; Code[10])
        {
        }
        field(62; "Ending Series"; Code[10])
        {
        }
        field(63; "Account Openning Fee"; Decimal)
        {
        }
        field(64; "Account Openning Fee Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(65; "Re-activation Fee"; Decimal)
        {
        }
        field(66; "Re-activation Fee Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(67; "Standing Orders Suspense"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(68; "Closing Prior Notice Charge"; Code[20])
        {
            TableRelation = Charges;
        }
        field(69; "Closure Notice Period"; DateFormula)
        {
        }
        field(70; "Bankers Cheque Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(71; "Tax On Interest"; Decimal)
        {
        }
        field(72; "Interest Tax Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(73; "External EFT Charges"; Decimal)
        {
        }
        field(74; "Internal EFT Charges"; Decimal)
        {
        }
        field(75; "EFT Charges Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(76; "EFT Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(77; Branch; Code[20])
        {
        }
        field(78; "Statement Charge"; Code[20])
        {
            TableRelation = Charges;
        }
        field(79; "Savings Duration"; DateFormula)
        {
        }
        field(80; "Savings Withdrawal penalty"; Decimal)
        {
        }
        field(81; "Savings Penalty Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(82; "Recovery Priority"; Integer)
        {
        }
        field(83; "Check Off Recovery"; Boolean)
        {
        }
        field(84; "RTGS Charges"; Decimal)
        {
        }
        field(85; "RTGS Charges Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(86; "Use Savings Account Number"; Boolean)
        {
        }
        field(87; "Search Fee"; Code[10])
        {
        }
        field(88; "Activity Code"; Option)
        {
            OptionCaption = 'BOSA,FOSA,MICRO';
            OptionMembers = BOSA,FOSA,MICRO;
        }
        field(89; "FOSA Shares"; Code[20])
        {
            TableRelation = Charges;
        }
        field(90; "Pass Book"; Code[20])
        {
            TableRelation = Charges;
        }
        field(91; "Registration Fee"; Code[20])
        {
            TableRelation = Charges;
        }
        field(92; "Allow Over Draft"; Boolean)
        {
        }
        field(93; "Over Draft Interest %"; Decimal)
        {
        }
        field(94; "Over Draft Interest Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(95; "Over Draft Issue Charge %"; Decimal)
        {
        }
        field(96; "Over Draft Issue Charge A/C"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(97; "Allow Multiple Over Draft"; Boolean)
        {
        }
        field(98; "ATM Placing Charge"; Decimal)
        {
        }
        field(99; "ATM Replacement Charge"; Decimal)
        {
        }
        field(100; "Commission on Placing"; Decimal)
        {
        }
        field(101; "Commission on Replacement"; Decimal)
        {
        }
        field(102; "Comission on ATM Cards A/C"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(103; "ATM Bank/GL Account"; Code[20])
        {
            TableRelation = if ("ATM Post to Stock" = const(false)) "Bank Account"
            else
            if ("ATM Post to Stock" = const(true)) "G/L Account";
        }
        field(104; "ATM Post to Stock"; Boolean)
        {
        }
        field(105; "Allow Multiple Accounts"; Boolean)
        {
        }
        field(106; "Default Account"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
            SumIndexFields = "Minimum Balance";
        }
        key(Key2; "Recovery Priority")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }

    trigger OnInsert()
    begin
        "Last Date Modified" := Today;
        "Modified By" := UserId;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
        "Modified By" := UserId;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
        "Modified By" := UserId;
    end;

    var
        GenBusPostingGrp: Record "Gen. Business Posting Group";
}
