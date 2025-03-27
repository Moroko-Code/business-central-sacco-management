#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516014 "Liquidity"
{
    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Datefilter; Date)
        {
            FieldClass = FlowFilter;
        }
        field(3; "posting Date"; Date)
        {
        }
        field(4; Deposit; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Type = filter('CASH DEPOSIT'),
                                                                        "Posting Date" = field("posting Date")));
            FieldClass = FlowField;
        }
        field(5; Withdrawals; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Type = filter('WITHDRAWAL'),
                                                                        "Posting Date" = field("posting Date")));
            FieldClass = FlowField;
        }
        field(6; Ceep; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Type = filter('CEEP'),
                                                                        "Posting Date" = field("posting Date")));
            FieldClass = FlowField;
        }
        field(8; Advances; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Type = filter('ADVANCE'),
                                                                        "Posting Date" = field("posting Date")));
            FieldClass = FlowField;
        }
        field(9; "Share Deposit"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Type = filter('DEPOSIT CONTRIBUTION'),
                                                                        "Posting Date" = field("posting Date")));
            FieldClass = FlowField;
        }
        field(10; "Ceep Deposits"; Decimal)
        {
        }
        field(11; "Cheque Comm"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("Posting Date" = field("posting Date"),
                                                        "G/L Account No." = filter('5471')));
            FieldClass = FlowField;
        }
        field(12; Loan; Decimal)
        {
            CalcFormula = - sum("Bank Account Ledger Entry".Amount where(Type = filter('REPAYMENT'),
                                                                         "Posting Date" = field("posting Date")));
            FieldClass = FlowField;
        }
        field(13; "welfare Contribution"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Posting Date" = field("posting Date"),
                                                                           "Vendor No." = const('L25001000001')));
            FieldClass = FlowField;
        }
        field(14; "Xmass Contribution"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("Posting Date" = field("posting Date"),
                                                        "G/L Account No." = filter('3271'),
                                                        "Emp Code" = const('MMH')));
            FieldClass = FlowField;
        }
        field(15; "Loan Repayment"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Posting Date" = field("posting Date"),
                                                                   "Transaction Type" = filter(Repayment),
                                                                   "Employer Code" = const('MMH')));
            FieldClass = FlowField;
        }
        field(16; "Deposit Contributions"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Posting Date" = field("posting Date"),
                                                                   "Transaction Type" = filter("Deposit Contribution"),
                                                                   "Employer Code" = const('MMH')));
            FieldClass = FlowField;
        }
        field(17; "Deposit Contributions1"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Posting Date" = field("posting Date"),
                                                                   "Transaction Type" = filter("Deposit Contribution"),
                                                                   "Employer Code" = const('MMHSACCO')));
            FieldClass = FlowField;
        }
        field(18; "Deposit Contributions2"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Posting Date" = field("posting Date"),
                                                                   "Transaction Type" = filter("Deposit Contribution"),
                                     "Employer Code" = const('<>MMH|MMHSACCO')));
            FieldClass = FlowField;
        }
        field(19; "Loan Repayment1"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Posting Date" = field("posting Date"),
                                                                   "Transaction Type" = filter(Repayment)));
            FieldClass = FlowField;
        }
        field(20; "Loan Repayment2"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Posting Date" = field("posting Date"),
                                                                   "Transaction Type" = filter(Repayment)));
            FieldClass = FlowField;
        }
        field(21; DDeposit; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Posting Date" = field("posting Date"),
                                                                   "Transaction Type" = filter("Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(22; DDeposit1; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Posting Date" = field("posting Date"),
                                                                   "Transaction Type" = filter("Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(23; DDeposit2; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Posting Date" = field("posting Date"),
                                                                   "Transaction Type" = filter("Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(24; "welfare Contribution two"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Posting Date" = field("posting Date"),
                                                                           "Vendor No." = const('L25001000001')));
            FieldClass = FlowField;
        }
        field(25; "Xmass Contribution two"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("Posting Date" = field("posting Date"),
                                                        "G/L Account No." = filter('3271'),
                                                        "Emp Code" = const('MMHSACCO')));
            FieldClass = FlowField;
        }
        field(26; "welfare Contribution three"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Posting Date" = field("posting Date"),
                                                                           "Vendor No." = const('L25001000001')));
            FieldClass = FlowField;
        }
        field(27; "Xmass Contribution three"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("Posting Date" = field("posting Date"),
                                                        "G/L Account No." = filter('3271'),
                                                        "Emp Code" = const('<>MMH|MMHSACCO')));
            FieldClass = FlowField;
        }
        field(28; "Cheque Deposits"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Type = filter('CHEQUE DEPOSIT'),
                                                                        "Posting Date" = field("posting Date")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
