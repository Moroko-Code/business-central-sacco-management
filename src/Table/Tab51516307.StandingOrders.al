#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516307 "Standing Orders"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Standing Orders Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Source Account No."; Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                if Account.Get("Source Account No.") then begin
                    "Staff/Payroll No." := Account."Staff No";
                    "Account Name" := Account.Name;
                    "BOSA Account No." := Account."BOSA Account No";
                end;
            end;
        }
        field(3; "Staff/Payroll No."; Code[20])
        {
        }
        field(4; "Account Name"; Text[100])
        {
        }
        field(5; "Destination Account Type"; Option)
        {
            OptionCaption = 'Internal,External,BOSA';
            OptionMembers = Internal,External,BOSA;

            trigger OnValidate()
            begin
                if "Destination Account Type" = "destination account type"::External then
                    "Don't Allow Partial Deduction" := true
                else
                    "Don't Allow Partial Deduction" := false;
            end;
        }
        field(6; "Destination Account No."; Code[50])
        {
            TableRelation = if ("Destination Account Type" = const(Internal)) Vendor."No.";

            trigger OnValidate()
            begin
                if "Destination Account Type" = "destination account type"::BOSA then
                    Error('Not applicable for BOSA Standing Orders.');

                if Account.Get("Destination Account No.") then
                    "Destination Account Name" := Account.Name;
            end;
        }
        field(7; "Destination Account Name"; Text[100])
        {
            trigger OnValidate()
            begin
                if "Destination Account Type" = "destination account type"::BOSA then
                    Error('Not applicable for BOSA Standing Orders.');
            end;
        }
        field(8; "BOSA Account No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(9; "Effective/Start Date"; Date)
        {
            trigger OnValidate()
            begin
                "Next Run Date" := "Effective/Start Date";
            end;
        }
        field(10; "End Date"; Date)
        {
        }
        field(11; Duration; DateFormula)
        {
            trigger OnValidate()
            begin
                TestField("Effective/Start Date");
                TestField(Duration);
                "End Date" := CalcDate(Duration, "Effective/Start Date");
            end;
        }
        field(12; Frequency; DateFormula)
        {
        }
        field(13; "Don't Allow Partial Deduction"; Boolean)
        {
        }
        field(14; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected,Stopped';
            OptionMembers = Open,Pending,Approved,Rejected,Stopped;
        }
        field(15; Remarks; Text[80])
        {
        }
        field(16; Amount; Decimal)
        {
        }
        field(17; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(18; "Bank Code"; Code[20])
        {
            TableRelation = "Member App Signatories"."Account No";

            trigger OnValidate()
            begin
                if BanksList.Get("Bank Code") then
                    "Bank Name" := BanksList."Bank Name";
                //"Branch Name":=BanksList.Branch;
            end;
        }
        field(19; "Transacting Branch"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(20; "Allocated Amount"; Decimal)
        {
            CalcFormula = sum("Receipt Allocation"."Total Amount" where("Document No" = field("No."),
                                                                         "Member No" = field("BOSA Account No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; Unsuccessfull; Boolean)
        {
        }
        field(22; Balance; Decimal)
        {
        }
        field(23; Effected; Boolean)
        {
        }
        field(24; "Next Run Date"; Date)
        {
        }
        field(25; "Old STO No."; Code[20])
        {
        }
        field(26; "Uneffected STO"; Boolean)
        {
        }
        field(27; "Auto Process"; Boolean)
        {
        }
        field(28; "Date Reset"; Date)
        {
        }
        field(29; "Reset Again"; Boolean)
        {
        }
        field(30; "None Salary"; Boolean)
        {
        }
        field(31; "ID. NO."; Code[20])
        {
        }
        field(32; Invalid; Boolean)
        {
        }
        field(50000; "Company Code"; Code[100])
        {
            CalcFormula = lookup(Vendor."Company Code" where("No." = field("Source Account No.")));
            FieldClass = FlowField;
        }
        field(50001; eewwe; Text[30])
        {
        }
        field(50002; "Income Type"; Option)
        {
            OptionCaption = ' ,Salary,Pension,Milk,Tea,Coffee';
            OptionMembers = " ",Salary,Pension,Milk,Tea,Coffee;
        }
        field(50003; "Account Balance"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Source Account No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.", "Source Account No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Standing Orders Nos.");
            NoSeriesMgt.InitSeries(NoSetup."Standing Orders Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        //IF UsersID.GET(USERID) THEN
        //"Transacting Branch":=UsersID.Branch;
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Account: Record Vendor;
        UsersID: Record User;
        BanksList: Record Banks;
        "Bank Name": Text[30];
}
