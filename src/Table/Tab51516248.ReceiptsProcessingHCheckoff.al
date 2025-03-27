#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516248 "ReceiptsProcessing_H-Checkoff"
{
    fields
    {
        field(1; No; Code[20])
        {
            trigger OnValidate()
            begin
                if No = '' then begin
                    NoSetup.Get();
                    NoSetup.TestField(NoSetup."Bosa Transaction Nos");
                    NoSeriesMgt.InitSeries(NoSetup."Bosa Transaction Nos", xRec."No. Series", 0D, No, "No. Series");
                end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
        }
        field(3; Posted; Boolean)
        {
            Editable = false;
        }
        field(6; "Posted By"; Code[60])
        {
            Editable = false;
        }
        field(7; "Date Entered"; Date)
        {
        }
        field(9; "Entered By"; Text[60])
        {
        }
        field(10; Remarks; Text[150])
        {
        }
        field(19; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(20; "Time Entered"; Time)
        {
        }
        field(21; "Posting date"; Date)
        {
        }
        field(22; "Account Type"; Option)
        {
            OptionMembers = customer;
            InitValue = customer;
        }
        field(23; "Account No"; Code[30])
        {
            TableRelation =

            if ("Account Type" = const(Customer)) Customer where("Customer Type" = filter(Checkoff));
        }
        field(24; "Document No"; Code[20])
        {
        }
        field(25; Amount; Decimal)
        {
    
        }
        field(26; "Scheduled Amount"; Decimal)
        {
            CalcFormula = sum("ReceiptsProcessing_L-Checkoff".Amount where("Receipt Header No" = field(No)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Total Count"; Integer)
        {
            CalcFormula = count("ReceiptsProcessing_L-Checkoff" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;
        }
        field(28; "Account Name"; Code[50])
        {
        }
        field(29; "Employer Code"; Code[30])
        {
            //TableRelation = "Sacco Employers".Code;
        }
        field(30; "Check-off Type"; Option)
        {
            OptionMembers = Deposits,"Fixed Deposits",Loans;
        }
        field(31; "Employer Name"; Text[100])
        {
        }
        field(32; "Loan CutOff Date"; Date)
        {
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
        if Posted = true then
            Error('You cannot delete a Posted Check Off');
    end;

    trigger OnInsert()
    begin

        if No = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Bosa Transaction Nos");
            NoSeriesMgt.InitSeries(NoSetup."Bosa Transaction Nos", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UpperCase(UserId);
    end;

    trigger OnModify()
    begin
        /* //
       IF Posted = TRUE THEN
       ERROR('You cannot modify a Posted Check Off');
        */
    end;

    trigger OnRename()
    begin
        if Posted = true then
            Error('You cannot rename a Posted Check Off');
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        cust: Record Customer;
        "GL Account": Record "G/L Account";
        BANKACC: Record "Bank Account";
}
