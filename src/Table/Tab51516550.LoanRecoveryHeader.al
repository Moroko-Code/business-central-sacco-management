#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516550 "Loan Recovery Header"
{
    DrillDownPageID = "Loan Recovery List";
    LookupPageID = "Loan Recovery List";
    fields
    {
        field(1; "Document No"; Code[20])
        {
            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Loan Recovery Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(4; "Date Entered"; Date)
        {
        }
        field(5; "Time Entered"; time)
        {
        }
        field(7; "Entered By"; Code[40])
        {
        }
        field(8; "No. Series"; Code[20])
        {
        }
        field(12; Posted; Boolean)
        {
        }
        field(13; "Posting Date"; Date)
        {
        }
        field(14; "Posted By"; Code[40])
        {
        }
        field(16; "Recovery Type"; Enum "Loan Recovery Methods")
        {
            InitValue = "From Loanee Deposits";
            trigger OnValidate()
            var
            begin
            end;
        }
        field(17; Status; Enum "Record Status")
        {
            trigger OnValidate()
            var
            begin
            end;
        }
        field(18; "Notify Member(s)"; Boolean)
        {
            trigger OnValidate()
            var
            begin
            end;
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Loan Recovery Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Loan Recovery Nos", xRec."No. Series", 0D, "Document No", "No. Series");
            "Entered By" := UserId;
            "Date Entered" := Today;
            "Time Entered" := Time;
            "Recovery Type" := "Recovery Type"::"From Loanee Deposits";
        end;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Cust: Record Customer;
        LoanRec: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
        SFactory: Codeunit "SURESTEP Factory";
}
