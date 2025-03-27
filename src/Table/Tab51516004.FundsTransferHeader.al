#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516004 "Funds Transfer Header"
{
    LookupPageID = "Funds Transfer Card";

    fields
    {
        field(10; "No."; Code[10])
        {
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    GenFundsSetup.Get;
                    NoSeriesMgt.TestManual(GenFundsSetup."Funds Transfer Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(11; Date; Date)
        {
        }
        field(12; "Posting Date"; Date)
        {
        }
        field(13; "Paying Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                BankAcc.Reset;
                BankAcc.SetRange(BankAcc."No.");
                if BankAcc.FindFirst then
                    "Paying Bank Name" := BankAcc.Name;
            end;
        }
        field(14; "Paying Bank Name"; Text[50])
        {
        }
        field(15; "Bank Balance"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Paying Bank Account")));
            FieldClass = FlowField;
        }
        field(16; "Bank Balance(LCY)"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry"."Amount (LCY)" where("Bank Account No." = field("No."),
                                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter")));
            FieldClass = FlowField;
        }
        field(20; "Amount to Transfer"; Decimal)
        {
        }
        field(21; "Amount to Transfer(LCY)"; Decimal)
        {
        }
        field(22; "Total Line Amount"; Decimal)
        {
            CalcFormula = sum("Funds Transfer Line"."Amount to Receive" where("Document No" = field("No.")));
            FieldClass = FlowField;
        }
        field(23; "Total Line Amount(LCY)"; Decimal)
        {
        }
        field(24; "Pay Mode"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Cash,Cheque';
            OptionMembers = " ",Cash,Cheque,"Bank Slip";
        }
        field(25; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending Approval,Approved,Cancelled,Posted';
            OptionMembers = Open,"Pending Approval",Approved,Cancelled,Posted;
        }
        field(26; "Cheque/Doc. No"; Code[20])
        {
        }
        field(27; Description; Text[50])
        {
        }
        field(28; "No. Series"; Code[20])
        {
        }
        field(29; Posted; Boolean)
        {
            Editable = false;
        }
        field(30; "Posted By"; Code[20])
        {
            Editable = false;
        }
        field(31; "Date Posted"; Date)
        {
            Editable = false;
        }
        field(32; "Time Posted"; Time)
        {
        }
        field(33; "Created By"; Code[20])
        {
        }
        field(34; "Date Created"; Date)
        {
        }
        field(35; "Time Created"; Time)
        {
        }
        field(36; "Source Transfer Type"; Option)
        {
            OptionMembers = "Intra-Company","Inter-Company";
        }
        field(56; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(57; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error('You cannot delete a document');
        //MESSAGE('You cannot delete a document');
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            GenFundsSetup.Get;
            GenFundsSetup.TestField(GenFundsSetup."Funds Transfer Nos");
            NoSeriesMgt.InitSeries(GenFundsSetup."Funds Transfer Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Time Created" := Time;
        "Date Created" := Today;
    end;

    trigger OnModify()
    begin
        if Posted = true then
            Error('You cannot MODIFY a posted document');
    end;

    var
        GenFundsSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TempBatch: Record "Funds User Setup";
        BankAcc: Record "Bank Account";
        DimVal: Record "Dimension Value";
        ICPartner: Record "IC Partner";
        RespCenter: Record "Responsibility Center";
        // UserMgt: Codeunit "User Setup Management BR";
        Setup: Record "Funds General Setup";
}
