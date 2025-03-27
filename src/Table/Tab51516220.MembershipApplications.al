#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516220 "Membership Applications"
{
    Caption = 'Member Application';
    DataCaptionFields = "No.", Name;
    DrillDownPageId = "Membership Application List";
    LookupPageId = "Membership Application List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Member Application Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin

                Name := UpperCase(Name);
            end;
        }

        field(5; Address; Text[50])
        {
            Caption = 'Address';

            trigger OnValidate()
            begin
                Address := UpperCase(Address);
            end;
        }

        field(7; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            begin
                "Phone No." := UpperCase("Phone No.")
            end;
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

        }


        field(68000; "Customer Type"; Option)
        {
            OptionCaption = ',Member,FOSA,Investments,Property,MicroFinance';
            OptionMembers = " ",Member,FOSA,Investments,Property,MicroFinance;
        }
        field(68001; "Registration Date"; Date)
        {
        }
        field(68002; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected,Closed';
            OptionMembers = Open,Pending,Approved,Rejected,Closed;
        }
        field(68003; "Employer Code"; Code[20])
        {
            TableRelation = "Sacco Employers";

            trigger OnValidate()
            begin
                Employer.Get("Employer Code");
                "Employer Name" := Employer.Description;
            end;
        }
        field(68004; "Date of Birth"; Date)
        {
            trigger OnValidate()
            begin
                if "Date of Birth" > Today then
                    Error('Date of birth cannot be greater than today');

                // if "Account Category" <> "account category"::Junior then
                if "Date of Birth" <> 0D then
                    if GenSetUp.Get() then
                        if CalcDate(GenSetUp."Min. Member Age", "Date of Birth") > Today then
                            Error('Applicant below the mininmum membership age of %1', GenSetUp."Min. Member Age");
                Age := Dates.DetermineAge("Date of Birth", Today);
                // if "Date of Birth" <> 0D then
                //     Age := Round((Today - "Date of Birth") / 365, 1);
            end;
        }
        field(68005; "E-Mail"; Text[50])
        {
        }


        field(68008; "Sub-county"; Text[50])
        {
        }
        field(68009; "Location"; Text[50])
        {
        }

        field(68011; "Payroll/Staff No"; Code[20])
        {
        }
        field(68012; "ID No."; Code[50])
        {
            trigger OnValidate()
            begin


                if "ID No." <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."ID No.", "ID No.");
                    Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                    if Cust.Find('-') then
                        if Cust."No." <> "No." then
                            Error('ID No. already exists');
                end;
            end;
        }

        field(68014; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Divorced,Widower,Widow;
        }
        field(68015; Signature; Media)
        {
            ExtendedDatatype = Masked;
        }
        field(68016; "Passport No."; Code[50])
        {
        }
        field(68017; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(68018; "Monthly Contribution"; Decimal)
        {
        }

        field(68030; Department; Code[200])
        {
            TableRelation = "Member Departments"."No.";
            trigger OnValidate()
            var
                Dep: Record "Member Departments";
            begin
                Dep.Reset;
                Dep.SetRange(Dep."No.", Department);

                if Dep.FindSet then
                    if Dep.FindFirst then
                        Department := Dep.Department;
            end;
        }
        field(68031; Section; Code[20])
        {
            TableRelation = "Member Section"."No.";
        }
        field(68032; "No. Series"; Code[10])
        {
        }
        field(68033; Occupation; Text[30])
        {
        }
        field(68034; Designation; Text[30])
        {
        }
        field(68035; "Terms of Employment"; Option)
        {
            OptionMembers = " ",Permanent,Contract,Casual;
        }
        field(68036; Category; Code[20])
        {
        }


        field(68039; "Current Residence"; Text[30])
        {



        }
        field(68040; "Contact Person"; Code[20])
        {
        }
        field(68041; "Approved By"; Code[100])
        {
        }
        field(68042; "Sent for Approval By"; Code[20])
        {
        }
        field(68043; "Responsibility Centre"; Code[20])
        {
        }

        field(68045; "Home County"; Text[30])
        {

            TableRelation = Counties.No;
            trigger OnValidate()
            var
                Eneo: Record Counties;
            begin
                Eneo.Reset();
                Eneo.SetRange(Eneo.No, "Home County");
                if Eneo.FindFirst() then begin
                    "Home County" := Eneo.Name;
                end;
            end;
        }
        field(68046; "Bank Code"; Code[100])
        {
            TableRelation = Banks."Bank Code";
            trigger OnValidate()
            var
                Banks: Record Banks;
            begin
                Banks.Reset;
                Banks.SetRange(Banks."Bank Code", "Bank Code");

                if Banks.FindSet then
                    if Banks.FindFirst then
                        "Bank Code" := Banks."Bank Name";
                // "Bank Name" := BanksVer2."Bank Name";
                // "Bank Branch Code" := BanksVer2."Branch Code";
                // "Bank Branch Name" := BanksVer2."Branch Name";
            end;
        }
        field(68047; "Bank Name"; Code[120])
        {
        }
        field(68048; "Bank Account No"; Code[120])
        {
        }
        field(68049; "Contact Person Phone"; Code[130])
        {
        }
        field(68050; "ContactPerson Relation"; Code[20])
        {
            TableRelation = "Relationship Types";
        }
        field(68051; "Recruited By"; Code[120])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Recruited By");
                if Cust.Find('-') then
                    "Recruiter Name" := Cust.Name;
            end;
        }
        field(68052; "ContactPerson Occupation"; Code[20])
        {
        }
        field(68053; Dioces; Code[30])
        {
        }
        field(68054; "Mobile No. 2"; Code[20])
        {
        }
        field(68055; "Employer Name"; Code[50])
        {
        }



        field(68062; Created; Boolean)
        {
        }
        field(68063; "Incomplete Application"; Boolean)
        {
        }
        field(68064; "Created By"; Text[60])
        {
        }
        field(68065; "Assigned No."; Code[30])
        {
        }
        field(68066; "Home Town"; Text[60])
        {
        }
        field(68067; "Recruiter Name"; Text[50])
        {
        }
        field(68068; "Copy of Current Payslip"; Boolean)
        {
        }
        field(68069; "Member Registration Fee Receiv"; Boolean)
        {
        }
        field(68070; "Account Category"; Option)
        {
            InitValue = Individual;
            OptionMembers = Individual,"Group Account";

        }

        field(68073; "Second Member Name"; Text[30])
        {
        }
        field(68075; "Date Establish"; Date)
        {
        }
        field(68076; "Registration No"; Code[30])
        {
        }
        field(68077; "ID NO/Passport 2"; Code[30])
        {
        }
        field(68079; "Registration office"; Text[30])
        {
            TableRelation = Location.Code;
        }
        field(140; Image; Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
        }


        field(68105; "KRA Pin"; Code[30])
        {
        }

        field(69210; "First Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69211; "Second Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69212; "Last Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69213; "Bank Branch"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69214; "Official Designation"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69215; "Date Employed"; Date)
        {
        }
        field(69216; Nationality; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Kenyan,"Non-Kenyan";
        }
        field(69217; "Guardian No."; Code[50])
        {
            TableRelation = Customer."No.";
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Guardian No.");
                if Cust.Find('-') then
                    "Guardian Name" := Cust.Name;
            end;
        }
        field(69218; "Guardian Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69219; "Client Computer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(69220; Age; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(69221; "User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = User;
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Name, Address, "Phone No.")
        {
        }

    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, "Phone No.", "E-Mail")
        {
        }
    }

    trigger OnDelete()

    begin
        if (Status = Status::Approved) or (Status = Status::Rejected) then
            Message('You cannot DELETE an application');
    end;

    trigger OnInsert()
    var
        Activesesion: record "Active Session";
    begin

        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Member Application Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Member Application Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Global Dimension 1 Code" := 'BOSA';

        "Registration Date" := Today;
        "User ID" := UpperCase(UserId);
        Activesesion.Reset();
        Activesesion.SetRange(Activesesion."User ID", "User ID");
        if Activesesion.FindLast() then
            "Client Computer Name" := Activesesion."Client Computer Name";
    end;

    trigger OnModify()
    begin
    end;

    trigger OnRename()
    begin
    end;

    var
        Text000: label 'You cannot delete %1 %2 because there is at least one outstanding Sales %3 for this customer.';
        Text002: label 'Do you wish to create a contact for %1 %2?';
        SalesSetup: Record "Sacco No. Series";
        Text003: label 'Contact %1 %2 is not related to customer %3 %4.';
        Text004: label 'post';
        Text005: label 'create';
        Text006: label 'You cannot %1 this type of document when Customer %2 is blocked with type %3';
        Text007: label 'You cannot delete %1 %2 because there is at least one not cancelled Service Contract for this customer.';
        Text008: label 'Deleting the %1 %2 will cause the %3 to be deleted for the associated Service Items. Do you want to continue?';
        Text009: label 'Cannot delete customer.';
        Text010: label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3. Enter another code.';
        Text011: label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text012: label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        Text013: label 'You cannot delete %1 %2 because there is at least one outstanding Service %3 for this customer.';
        Text014: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text015: label 'You cannot delete %1 %2 because there is at least one %3 associated to this customer.';
        GenSetUp: Record "Sacco General Set-Up";
        MinShares: Decimal;
        MovementTracker: Record "Movement Tracker";
        Cust: Record Customer;
        Vend: Record Vendor;
        CustFosa: Code[20];
        Vend2: Record Vendor;
        FOSAAccount: Record Vendor;
        StatusPermissions: Record "Status Change Permision";
        RefundsR: Record Refunds;
        Text016: label 'You cannot change the contents of the %1 field because this %2 has one or more posted ledger entries.';
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PostCode: Record "Post Code";
        User: Record User;
        Employer: Record "Sacco Employers";
        Dates: Codeunit "Dates Calculation";
        DAge: DateFormula;
        // HREmp: Record "HR Employee";
        CustMember: Record Customer;
        Text0024: label 'This Member Status is %1, Therefore not eligible for enrollment';
        MemberAppl: Record Customer;
}
