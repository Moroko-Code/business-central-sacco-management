tableextension 51516077 "sales&receivablesetupext" extends "Sales & Receivables Setup"
{
    fields
    {
        field(10000; "G/L Freight Account No."; Code[20])
        {
            Caption = 'G/L Freight Account No.';
            TableRelation = "G/L Account";
        }
        field(50000; "BOSA Transfer Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(5003; "Custodian No."; Code[50])
        {
            TableRelation = "No. Series";
        }
        field(50001; "Safe Custody Package Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50002; "Collateral Register No"; Code[20])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
    }

    fieldgroups
    {
    }

    procedure GetLegalStatement(): Text
    begin
        exit('');
    end;

    procedure JobQueueActive(): Boolean
    begin
        Get;
        exit("Post with Job Queue" or "Post & Print with Job Queue");
    end;
}
