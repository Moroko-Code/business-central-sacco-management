#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516557 "General Equiries."
{
    fields
    {
        field(1; No; Code[20])
        {
            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Crm logs Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
            end;
        }
        field(3; "Member Name"; Code[60])
        {
        }
        field(4; "Payroll No"; Code[20])
        {
        }
        field(8; Description; Text[250])
        {
        }
        field(9; Status; Option)
        {
            Description = ' ,New,Escalted,Resolved';
            OptionCaption = 'New,Escalted,Resolved';
            OptionMembers = New,Escalted,Resolved;
        }
        field(10; "ID No"; Code[20])
        {
        }
        field(11; "Phone No"; Code[30])
        {
        }
        field(12; "Passport No"; Code[30])
        {
        }
        field(13; Email; Text[60])
        {
        }
        field(14; Gender; Option)
        {
            Description = 'Male,Female';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(18; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(25; "Resolved by"; Code[50])
        {
        }
        field(26; "Resolved Date"; Date)
        {
        }
        field(27; "Resolved Time"; Time)
        {
        }
        field(40; "Resolution Details"; text[2048])
        {
        }
        field(28; "Caller Reffered To"; Code[50])
        {
            TableRelation = User."User Name";

            trigger OnLookup()
            var
                UserMgt: Codeunit "Devco User Management";
            begin
                UserMgt.LookupUserID("Caller Reffered To");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit "Devco User Management";
            begin
                UserMgt.ValidateUserID("Caller Reffered To");

                ObjUser.Reset;
                ObjUser.SetRange(ObjUser."User ID", UserId);
                if ObjUser.Find('-') then begin
                    ObjUser.TestField(ObjUser."E-Mail");
                    "Escalated User Email" := ObjUser."E-Mail";
                end;
            end;
        }
        field(29; "Received From"; Code[20])
        {
        }
        field(30; "Calling As"; Option)
        {
            OptionCaption = 'As Member,As Staff,As Non Member';
            OptionMembers = "As Member","As Staff","As Non Member";
        }
        field(31; "Contact Mode"; Option)
        {
            OptionCaption = ' ,Physical,Phone Call,E-Mail,Letter';
            OptionMembers = " ",Physical,"Phone Call","E-Mail",Letter;
        }
        field(32; "Calling For"; Option)
        {
            OptionCaption = ' ,Enquiry,Request,Appreciation,Complaint,Criticism';
            OptionMembers = " ",Enquiry,Request,Appreciation,Complaint,Criticism;
        }
        field(33; "Date Sent"; Date)
        {
        }
        field(34; "Time Sent"; Time)
        {
        }
        field(35; "Sent By"; Code[50])
        {
        }
        field(36; "Escalted By"; Code[50])
        {
        }
        field(37; "Escaltion Date"; Date)
        {
        }
        field(38; "Escaltion time"; time)
        {
        }
        field(68027; "ID No."; Code[50])
        {
            Description = '//surestep crm';

            trigger OnValidate()
            begin
            end;
        }
        field(68028; Address; Code[50])
        {
            Description = '//surestep crm';
        }
        field(68029; City; Code[50])
        {
            Description = '//surestep crm';
        }
        field(68038; "Fosa account"; Code[30])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No"));
        }
        field(69192; "Lead Status"; Option)
        {
            OptionCaption = 'Open,Closed';
            OptionMembers = Open,Closed;
        }
        field(69193; "Captured By"; Code[20])
        {
        }
        field(69194; "Captured On"; Date)
        {
        }
        field(69195; "Lead Region"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(2));
        }
        field(69196; "Physical Meeting Location"; Text[40])
        {
        }
        field(69198; "Date of Escalation"; Date)
        {
        }
        field(69199; "Time of Escalation"; Time)
        {
        }
        field(69200; "Date Resolved"; Date)
        {
        }
        field(69201; "Time Resolved"; Time)
        {
        }
        field(69202; "Escalated User Email"; Text[50])
        {
        }
        // field(69203; "Case Resolution Details"; Text[250])
        // {
        // }
        field(69204; "Case Details"; Text[250])
        {
        }
        field(69205; "Case Subject"; Text[50])
        {
        }
        field(69206; "Date Of Birth"; Date)
        {
        }
        field(69207; "Delegated"; Boolean)
        {
        }
        field(69208; "Delegated To"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(69209; "FOSA Loan Balance"; Decimal)
        {
            Editable = false;
        }
        field(69210; "BOSA Loan Balance"; Decimal)
        {
            Editable = false;
        }
        field(69211; "MICRO Loan Balance"; Decimal)
        {
            Editable = false;
        }
        field(69212; "Escalate Case"; Boolean)
        {
        }
        field(69213; "Class"; Option)
        {
            OptionCaption = ' ,Low Risk,Medium Risk,High Risk';
            OptionMembers = " ","Low Risk","Medium Risk","High Risk";
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

    trigger OnInsert()
    begin
        if No = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Crm logs Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Crm logs Nos", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Captured By" := UserId;
        "Captured On" := Today;

        ObjUser.Reset;
        ObjUser.SetRange(ObjUser."User ID", UserId);
        if ObjUser.FindSet then
            "Lead Region" := ObjUser.Branch;
    end;

    var
        SalesSetup: Record "Crm General Setup.";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Loans: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
        Cust: Record Customer;
        PVApp: Record "Cust. Ledger Entry";
        UserMgt: Codeunit "Devco User Management";
        PRD: Record Customer;
        ObjEmployers: Record "Sacco Employers";
        ObjUser: Record "User Setup";
        ObjCust: Record Customer;
}
