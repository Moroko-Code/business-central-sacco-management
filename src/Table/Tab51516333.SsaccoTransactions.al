#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516333 "Ssacco Transactions"
{
    fields
    {
        field(1; "Document No."; Code[30])
        {
        }
        field(2; "Transaction Date"; Date)
        {
        }
        field(3; "Account No."; Code[50])
        {
        }
        field(4; Description; Text[200])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "Transaction Type"; Option)
        {
            OptionCaption = 'Withdrawal,Deposit,Balance,Ministatement,Transfer,Advance,Loan Repayment';
            OptionMembers = Withdrawal,Deposit,Balance,Ministatement,Transfer,Advance,"Loan Repayment";
        }
        field(8; "Transaction Time"; Time)
        {
        }
        field(11; "Date Posted"; Date)
        {
        }
        field(12; "Time Posted"; Time)
        {
        }
        field(25; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(26; Comments; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error('You cannot delete MPESA transactions.');
    end;

    trigger OnModify()
    begin
        if Posted = true then
            Error('You cannot modify posted MPESA transactions.');
    end;
}
