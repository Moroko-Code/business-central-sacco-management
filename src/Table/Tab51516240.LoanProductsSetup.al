#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516240 "Loan Products Setup"
{
    DrillDownPageID = "Loan Products Setup List";
    LookupPageID = "Loan Products Setup List";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Product Description"; Text[30])
        {
        }
        field(3; "Source of Financing"; Code[10])
        {
        }
        field(4; "Interest rate"; Decimal)
        {
        }
        field(9; "Interest Calculation Method"; Option)
        {
            OptionMembers = ,"No Interest","Flat Rate","Reducing Balances";
        }
        field(11; "Insurance %"; Decimal)
        {
        }
        field(17; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(24; "Grace Period"; DateFormula)
        {
        }
        field(26; "Name of Source of Funding"; Text[30])
        {
            Editable = false;
        }
        field(27; Rounding; Option)
        {
            OptionMembers = Nearest,Down,Up;
        }
        field(28; "Rounding Precision"; Decimal)
        {
            InitValue = 1;
            MaxValue = 1;
            MinValue = 0.01;
        }
        field(29; "Loan Appraisal %"; Decimal)
        {
        }
        field(30; "No of Installment"; Integer)
        {
        }
        field(31; "Loan No Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(32; "New Numbers"; Code[10])
        {
        }
        field(33; "Instalment Period"; DateFormula)
        {
        }
        field(34; "Loan to Share Ratio"; Decimal)
        {
        }
        field(35; "Penalty Calculation Days"; DateFormula)
        {
        }
        field(36; "Penalty Percentage"; Decimal)
        {
        }
        field(37; "Penalty Calculation Method"; Option)
        {
            OptionMembers = "No Penalty","Principal in Arrears","Principal in Arrears+Interest in Arrears","Principal in Arrears+Penalty inArrears","Principal in Arrears+Interest in Arrears+Penalty in Arrears";
        }
        field(38; "Penalty Paid Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(39; "Use Cycles"; Boolean)
        {
        }
        field(40; "Max. Loan Amount"; Decimal)
        {
        }
        field(41; "Penalty Posted Reporting Date"; Date)
        {
        }
        field(42; "Penalty Posted Last Calc. Date"; Date)
        {
        }
        field(43; "Compulsary Savings"; Decimal)
        {
        }
        field(44; "Repayment Method"; Option)
        {
            OptionMembers = Amortised,"Reducing Balance","Straight Line",Constants;
        }
        field(45; "Grace Period - Principle (M)"; Integer)
        {
        }
        field(46; "Grace Period - Interest (M)"; Integer)
        {
        }
        field(47; "Min. Loan Amount"; Decimal)
        {
        }
        field(48; "Bank Account Details"; Text[250])
        {
        }
        field(50; "Loan Account"; Code[20])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
            end;
        }
        field(51; "Loan Interest Account"; Code[20])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
            end;
        }
        field(52; "Receivable Interest Account"; Code[20])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
            end;
        }
        field(53; "BOSA Account"; Code[20])
        {
            TableRelation = Vendor."No." where("Creditor Type" = const(Account));
        }
        field(54; "Action"; Option)
        {
            OptionCaption = ' ,Off Set Commitments,Discounting';
            OptionMembers = " ","Off Set Commitments",Discounting;
        }
        field(55; "BOSA Personal Loan Account"; Code[20])
        {
            TableRelation = Vendor."No." where("Creditor Type" = const(Account));
        }
        field(56; "Top Up Commision Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(57; "Top Up Commision"; Decimal)
        {
        }
        field(58; Source; Option)
        {
            OptionCaption = 'BOSA,FOSA,Investment,MICRO';
            OptionMembers = BOSA,FOSA,Investment,MICRO;
        }
        field(59; "Recovery Priority"; Integer)
        {
        }
        field(60; "Check Off Recovery"; Boolean)
        {
        }
        field(61; "SMS Description"; Text[50])
        {
        }
        field(62; "Default Installements"; Integer)
        {
        }
        field(63; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(64; Applications; Decimal)
        {
        }
        field(65; "Issued Amount"; Decimal)
        {
        }
        field(66; "Min No. Of Guarantors"; Integer)
        {
        }
        field(67; "Min Re-application Period"; DateFormula)
        {
        }
        field(68; "Check Off Loan No."; Integer)
        {
        }
        field(69; "Bridged/Topped"; Boolean)
        {
        }
        field(70; "Affect Deposits Qualification"; Boolean)
        {
        }
        field(71; "Shares Multiplier"; Decimal)
        {
        }
        field(72; "Mode of Qualification"; Option)
        {
            OptionCaption = 'Normal Sacco,Fosa,Security';
            OptionMembers = "Normal Sacco",Fosa,Security;
        }
        field(73; "Product Currency Code"; Code[10])
        {
            Editable = false;
            TableRelation = Currency.Code;
        }
        field(74; "Loan Product Expiry Date"; Date)
        {
        }
        field(75; "Appln. between Currencies"; Option)
        {
            Caption = 'Appln. between Currencies';
            OptionCaption = 'None,EMU,All';
            OptionMembers = "None",EMU,All;
        }
        field(76; "Repayment Frequency"; Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quaterly';
            OptionMembers = Daily,Weekly,Monthly,Quaterly;
        }
        field(77; "Appraise Deposits"; Boolean)
        {
        }
        field(78; "Appraise Shares"; Boolean)
        {
        }
        field(79; "Appraise Salary"; Boolean)
        {
        }
        field(80; "Appraise Guarantors"; Boolean)
        {
        }
        field(81; "Appraise Business"; Boolean)
        {
        }
        field(82; "Recovery Mode"; Option)
        {
            OptionCaption = 'Checkoff,Standing Order,Salary';
            OptionMembers = Checkoff,"Standing Order",Salary;
        }
        field(83; "Deposits Multiplier"; Decimal)
        {
        }
        field(84; "Appraise Collateral"; Boolean)
        {
        }
        field(85; "Appraise Dividend"; Boolean)
        {
        }
        field(86; "Penalty Charged Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(87; "Staff Sal Adv  Max %"; Decimal)
        {
        }
        field(88; "Jaza Loan Min Re-App  Period"; DateFormula)
        {
        }
        field(89; "Jaza Min Boosting Amount"; Decimal)
        {
        }
        field(90; "Jaza Max Boosting Amount"; Decimal)
        {
        }
        field(91; "Jaza Levy"; Decimal)
        {
        }
        field(92; "Interest Rate-Outstanding >1.5"; Decimal)
        {
        }
        field(93; "Instant loan Net Multiplier"; Decimal)
        {
        }
        field(94; "Maximum No. Of Runing Loans"; Decimal)
        {
        }
        field(95; "Mazao Qualification(%)"; Decimal)
        {
        }
        field(96; "Self guaranteed Multiplier"; Decimal)
        {
        }
        field(97; "Dont Recover Repayment"; Boolean)
        {
        }
        field(98; "Loan Insurance Accounts"; Code[20])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
            end;
        }
        field(99; "Receivable Insurance Accounts"; Code[20])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
            end;
        }
        field(100; "Loan Collateral Accounts"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(101; "Post to Deposits"; Boolean)
        {
        }
        field(102; "Discount G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(103; "Requires LPO"; Boolean)
        {
        }
        field(104; "Post to G/L Account"; Boolean)
        {
        }
        field(105; "G/L Account No"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(106; "Post to Vendor"; Boolean)
        {
        }
        field(107; "Vendor Account No"; Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                TestField("Post to Vendor");
            end;
        }
        field(108; "Share Cap %"; Decimal)
        {
        }
        field(109; "Max Share Cap"; Decimal)
        {
        }
        field(110; "Bank Comm %"; Decimal)
        {
        }
        field(111; "Loan Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(112; "Loan Tiers"; Option)
        {
            OptionCaption = ' ,Tier One,Tier Two,Tier Three';
            OptionMembers = " ","Tier One","Tier Two","Tier Three";
        }
        field(113; "Pepea Deposits"; Decimal)
        {
        }
        field(114; "Sacco Deposits"; Decimal)
        {
        }
        field(115; "Charge Interest Upfront"; Boolean)
        {
        }
        field(116; "Load All Loan Interest"; Boolean)
        {
        }
        field(117; "Max No. Of Guarantors"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Recovery Priority")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", "Product Description")
        {
        }
    }

    trigger OnDelete()
    begin
    end;

    trigger OnModify()
    begin
    end;

    trigger OnRename()
    begin
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
