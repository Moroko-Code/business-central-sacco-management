#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516030 "Funds General Setup"
{
    fields
    {
        field(10; "Primary Key"; Integer)
        {
        }
        field(11; "Payment Voucher Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(12; "Cash Voucher Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(13; "PettyCash Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(14; "Mobile Payment Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(15; "Receipt Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(16; "Funds Transfer Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(17; "Imprest Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(18; "Imprest Surrender Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(19; "Claim Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(20; "Travel Advance Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(21; "Travel Surrender Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(22; "Salary Processing Nos"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
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
