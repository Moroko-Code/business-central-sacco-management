#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516298 "Transaction Types"
{
    DrillDownPageID = "Transaction Type - List";
    LookupPageID = "Transaction Type - List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = 'Cash Deposit,Withdrawal,Cheque Deposit,ATM Cash Deposit,ATM Cheque Deposit,ATM Withdrawal,BOSA Receipt,BOSA Withdrawal,Bankers Cheque,Encashment';
            OptionMembers = "Cash Deposit",Withdrawal,"Cheque Deposit","ATM Cash Deposit","ATM Cheque Deposit","ATM Withdrawal","BOSA Receipt","BOSA Withdrawal","Bankers Cheque",Encashment;
        }
        field(5; "Account Type"; Code[20])
        {
            TableRelation = "Account Types-Saving Products";
        }
        field(6; "Has Schedule"; Boolean)
        {
        }
        field(7; "Transaction Category"; Option)
        {
            OptionMembers = General,"Account Opening","Normal Cheques","Bankers Cheque";
        }
        field(8; "Transaction Span"; Option)
        {
            OptionMembers = FOSA,BOSA;
        }
        field(9; "Lower Limit"; Decimal)
        {
        }
        field(10; "Upper Limit"; Decimal)
        {
        }
        field(11; "Default Mode"; Option)
        {
            OptionCaption = 'Cash,Cheque';
            OptionMembers = Cash,Cheque;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
