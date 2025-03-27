#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516492 "Cases Management"
{
    // LookupPageID = UnknownPage53954;

    fields
    {
        field(1; "Case Number"; Code[20])
        {
        }
        field(3; "Date of Complaint"; Date)
        {
        }
        field(4; "Type of cases"; Option)
        {
            NotBlank = true;
            OptionCaption = ',Fosa Account,Loan,Member savings,Membership Withdrawal,Atm card,Payment/Receipt/Advice';
            OptionMembers = ,"Fosa Account",Loan,"Member savings","Membership Withdrawal","Atm card","Payment/Receipt/Advice";
        }
        field(5; "Recommended Action"; Code[20])
        {
        }
        field(6; "Case Description"; Text[250])
        {
        }
        field(7; Accuser; Code[50])
        {
        }
        field(8; "Resource#1"; Code[50])
        {
            TableRelation = User."User Name";

            trigger OnValidate()
            begin
                if casem.Get("Resource#1") then begin
                    "Resource Assigned" := casem."Resource#1";
                    Message("Resource Assigned");
                end;
            end;
        }
        field(9; "Resource #2"; Code[50])
        {
            TableRelation = User."User Name";

            trigger OnValidate()
            begin
                if casen.Get("Resource #2") then begin
                    "Resource Assigned" := "Resource #2";
                    Message("Resource Assigned");
                end;
            end;
        }
        field(10; "Action Taken"; Code[100])
        {
        }
        field(11; "Date To Settle Case"; Date)
        {
        }
        field(12; "Document Link"; Text[200])
        {
        }
        field(13; "solution Remarks"; Code[50])
        {
        }
        field(14; Comments; Text[250])
        {
        }
        field(15; "Case Solved"; Boolean)
        {
        }
        field(16; "Body Handling The Complaint"; Code[10])
        {
        }
        field(17; Recomendations; Code[10])
        {
        }
        field(18; Implications; Integer)
        {
        }
        field(19; "Support Documents"; Option)
        {
            OptionMembers = Yes,No;
        }
        field(20; "Policy Guidlines In Effect"; Code[10])
        {
        }
        field(21; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Assigned,Resolved';
            OptionMembers = Open,Assigned,Resolved;
        }
        field(22; "Mode of Lodging the Complaint"; Text[30])
        {
        }
        field(23; "No. Series"; Code[20])
        {
        }
        field(24; "Resource Assigned"; Code[30])
        {
            TableRelation = User."User Name";
        }
        field(25; Selected; Boolean)
        {
        }
        field(26; "Closed By"; Code[20])
        {
        }
        field(28; "Caller Reffered To"; Code[50])
        {
            TableRelation = User."User Name";

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                // UserMgt.LookupUserID("Caller Reffered To");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
            begin
                //UserMgt.ValidateUserID("Caller Reffered To");
            end;
        }
        field(29; "Received From"; Code[50])
        {
        }
        field(33; "Date Sent"; Date)
        {
        }
        field(34; "Time Sent"; Time)
        {
        }
        field(35; "Sent By"; Code[50])
        {
            Description = '//surestep crm';
        }
        field(3963; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center";
        }
        field(3964; "Member No"; Code[10])
        {
            TableRelation = Customer."No.";
        }
        field(3965; "Fosa Account"; Code[50])
        {
            TableRelation = Vendor."No.";
        }
        field(3966; "Account Name"; Text[50])
        {
        }
        field(3967; "loan no"; Code[10])
        {
            TableRelation = "Loans Register";
        }
        field(3968; "Receive User"; Code[50])
        {
            TableRelation = User."User Name";
        }
        field(3969; "Receive date"; Date)
        {
        }
        field(3970; "Receive Time"; Time)
        {
        }
        field(3971; "Resolved User"; Code[20])
        {
            TableRelation = User."User Name";
        }
        field(3972; "Resolved Date"; Date)
        {
        }
        field(3973; "Resolved Time"; Time)
        {
        }
        field(68030; "company No"; Code[50])
        {
            Description = '//surestep crm';
        }
        field(68031; "Company Name"; Text[100])
        {
            Description = '//surestep crm';
        }
        field(68043; "Company Address"; Code[50])
        {
        }
        field(68044; "Company postal code"; Code[10])
        {
            TableRelation = "Post Code";
        }
        field(68045; "Company Telephone"; Code[15])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(68046; "Company Email"; Text[30])
        {
            ExtendedDatatype = EMail;
        }
        field(68047; "Company website"; Text[30])
        {
            ExtendedDatatype = URL;
        }
    }

    keys
    {
        key(Key1; "Resource Assigned", "Case Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Case Number" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Disciplinary Cases Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Disciplinary Cases Nos.", xRec."No. Series", 0D, "Case Number", "No. Series");
        end;
    end;

    trigger OnModify()
    begin
        /* IF Status=Status::Assigned THEN
         ERROR('You cannot modify a closed case');
         */
    end;

    var
        HRSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        casem: Record "Cases Management";
        casen: Record "Cases Management";
}
