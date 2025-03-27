#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516326 "Cue Sacco Roles Fosa"
{
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Application Loans"; Integer)
        {
        }
        field(3; "Appraisal Loans"; Integer)
        {
        }
        field(4; "Approved Loans"; Integer)
        {
        }
        field(5; "Rejected Loans"; Integer)
        {
        }
        field(6; "Pending Account Opening"; Integer)
        {
        }
        field(7; "Approved Accounts Opening"; Integer)
        {
        }
        field(8; "Pending Loan Batches"; Integer)
        {
        }
        field(9; "Approved Loan Batches"; Integer)
        {
        }
        field(10; "Pending Payment Voucher"; Integer)
        {
            Enabled = false;
        }
        field(11; "Approved Payment Voucher"; Integer)
        {
            Enabled = false;
        }
        field(12; "Pending Petty Cash"; Integer)
        {
            Enabled = false;
        }
        field(13; "Approved  Petty Cash"; Integer)
        {
            Enabled = false;
        }
        field(14; "Open Account Opening"; Integer)
        {
        }
        field(20; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(21; "Date Filter2"; Date)
        {
            Caption = 'Date Filter2';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(22; "Pending Standing Orders"; Integer)
        {
        }
        field(23; "Approved Standing Orders"; Integer)
        {
        }
        field(24; "Unbanked Cheques"; Integer)
        {
        }
        field(25; "Uncreated Approved Accounts"; Integer)
        {
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
}
