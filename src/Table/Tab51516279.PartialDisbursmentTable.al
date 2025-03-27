#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516279 "Partial Disbursment Table"
{
    fields
    {
        field(1; "Loan No."; Code[20])
        {
        }
        field(2; "Application Date"; Date)
        {
        }
        field(3; "Loan Product Type"; Code[20])
        {
            Editable = true;
        }
        field(4; "Client Code"; Code[20])
        {
        }
        field(5; "Group Code"; Code[20])
        {
        }
        field(8; "Requested Amount"; Decimal)
        {
        }
        field(9; "Approved Amount"; Decimal)
        {
            Editable = true;
        }
        field(26; "Client Name"; Text[50])
        {
            Editable = false;
        }
        field(29; "Issued Date"; Date)
        {
        }
        field(30; Installments; Integer)
        {
        }
        field(34; "Loan Disbursement Date"; Date)
        {
        }
        field(35; "Mode of Disbursement"; Option)
        {
            OptionMembers = " ",Cheque,"Bank Transfer","FOSA Loans";
        }
        field(67; "Date Approved"; Date)
        {
        }
        field(53050; Repayment; Decimal)
        {
        }
        field(53055; "Disbursment Balance"; Decimal)
        {
            Caption = 'Disbursment Balance';
            Editable = false;
        }
        field(53056; "Partial Amount Disbursed"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Loan No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
