#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516316 "Salary Processing Header"
{
    // DrillDownPageID = UnknownPage50222;
    // LookupPageID = UnknownPage50222;

    fields
    {
        field(1; No; Code[20])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(2; "No. Series"; Code[20])
        {
        }
        field(3; Posted; Boolean)
        {
            Editable = false;
        }
        field(6; "Posted By"; Code[20])
        {
            Editable = false;
        }
        field(7; "Date Entered"; Date)
        {
        }
        field(9; "Entered By"; Text[20])
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
            OptionCaption = 'G/L Account,Customer/Employer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(23; "Account No"; Code[30])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else if ("Account Type" = const(Customer)) Customer
            else if ("Account Type" = const(Vendor)) Vendor
            else if ("Account Type" = const("Bank Account")) "Bank Account"
            else if ("Account Type" = const("Fixed Asset")) "Fixed Asset";

            trigger OnValidate()
            begin
                // if "Account Type"="account type"::"1" then begin
                // cust.Reset;
                // cust.SetRange(cust."No.","Account No");
                // if cust.Find('-') then begin
                // "Account Name":=cust.Name;

                // end;
                // end;

                // if "Account Type"="account type"::"0" then begin
                // "GL Account".Reset;
                // "GL Account".SetRange("GL Account"."No.","Account No");
                // if "GL Account".Find('-') then begin
                // "Account Name":="GL Account".Name;
                // end;
                // end;

                // if "Account Type"="account type"::"3" then begin
                // BANKACC.Reset;
                // BANKACC.SetRange(BANKACC."No.","Account No");
                // if BANKACC.Find('-') then begin
                // "Account Name":=BANKACC.Name;

                // end;
                // end;
            end;
        }
        field(24; "Document No"; Code[20])
        {
        }
        field(25; Amount; Decimal)
        {
            trigger OnValidate()
            begin
                /*
              IF Amount<>"Scheduled Amount" THEN
              ERROR('The Amount must be equal to the Scheduled Amount');
                  */
            end;
        }
        field(26; "Scheduled Amount"; Decimal)
        {
            // CalcFormula = sum("Member Section".Field5 where (Field62003=field(No)));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(27; "Total Count"; Integer)
        {
            // CalcFormula = count("Member Section" where (Field62003=field(No)));
            // FieldClass = FlowField;
        }
        field(28; "Account Name"; Code[50])
        {
        }
        field(29; "Employer Code"; Code[30])
        {
            //TableRelation = Table51516191.Field1;
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
        /*
        IF No = '' THEN BEGIN
        NoSetup.GET();
        NoSetup.TESTFIELD(NoSetup."Salary Processing Nos");
        NoSeriesMgt.InitSeries(NoSetup."Salary Processing Nos",xRec."No. Series",0D,No,"No. Series");
        END;

        "Date Entered":=TODAY;
        "Time Entered":=TIME;
        "Entered By":=UPPERCASE(USERID);
        */
    end;

    trigger OnModify()
    begin
        if Posted = true then
            Error('You cannot modify a Posted Check Off');
    end;

    trigger OnRename()
    begin
        if Posted = true then
            Error('You cannot rename a Posted Check Off');
    end;

    var
        NoSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        // cust: Record UnknownRecord51516154;
        "GL Account": Record "G/L Account";
        BANKACC: Record "Bank Account";
}
