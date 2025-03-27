#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516335 "Change MPESA Transactions"
{
    // DrillDownPageID = UnknownPage52018515;
    // LookupPageID = UnknownPage52018515;

    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; "Transaction Date"; Date)
        {
        }
        field(3; "Initiated By"; Code[50])
        {
        }
        field(4; "MPESA Receipt No"; Code[20])
        {
            TableRelation = "MPESA Transactions"."Document No." where(Posted = const(false));

            trigger OnValidate()
            begin
                MPESATrans.Reset;
                MPESATrans.SetRange(MPESATrans."Document No.", "MPESA Receipt No");
                if MPESATrans.Find('-') then
                    "Account No" := MPESATrans."Account No.";
            end;
        }
        field(5; "Account No"; Code[30])
        {
        }
        field(6; "New Account No"; Code[30])
        {
            TableRelation = if ("Destination Type" = const(FOSA)) Vendor."No."
            else if ("Destination Type" = const(BOSA)) Customer."ID No.";
        }
        field(7; Comments; Text[100])
        {
        }
        field(8; "Approved By"; Code[50])
        {
        }
        field(9; "Date Approved"; Date)
        {
        }
        field(10; "Time Approved"; Time)
        {
        }
        field(11; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(12; Changed; Boolean)
        {
        }
        field(13; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(14; "Send For Approval By"; Code[50])
        {
        }
        field(15; "Date Sent For Approval"; Date)
        {
        }
        field(16; "Time Sent For Approval"; Time)
        {
        }
        field(17; "Reasons for rejection"; Text[200])
        {
        }
        field(18; "BOSA Account No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                BOSAAcct.Reset;
                BOSAAcct.SetRange(BOSAAcct."No.", No);
                if BOSAAcct.Find('-') then
                    BOSAAcct.TestField(BOSAAcct."ID No.");
            end;
        }
        field(19; "Transaction Type"; Option)
        {
            OptionMembers = "Deposit Contribution","Share Capital","Loan Repayment","Benevolent Funds";
        }
        field(20; "Destination Type"; Option)
        {
            OptionCaption = 'FOSA,BOSA';
            OptionMembers = FOSA,BOSA;
        }
        field(21; "Loan Product Type"; Code[20])
        {
            TableRelation = "Paybill Keywords".Keyword where("Destination Type" = const("Loan Repayment"));
        }
        field(22; "App Status"; Option)
        {
            OptionCaption = 'Pending,First Approval,Changed,Rejected';
            OptionMembers = Pending,"First Approval",Changed,Rejected;
        }
        field(23; "Responsibility Centre"; Code[20])
        {
            TableRelation = "Responsibility Center";
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

    trigger OnDelete()
    begin
        if Status <> Status::Open then
            Error('You cannot delete the MPESA transaction because it has already been sent for first approval.');
    end;

    trigger OnInsert()
    begin
        if No = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."MPESA Change Nos");
            NoSeriesMgt.InitSeries(NoSetup."MPESA Change Nos", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Initiated By" := UserId;
        "Transaction Date" := Today;
    end;

    var
        NoSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MPESATrans: Record "MPESA Transactions";
        BOSAAcct: Record Customer;
}
