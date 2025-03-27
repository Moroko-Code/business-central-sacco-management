#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516898 "Account Activation"
{
    // DrillDownPageID = UnknownPage39004370;
    // LookupPageID = UnknownPage39004370;

    fields
    {
        field(1; "No."; Code[20])
        {
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Activation Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Client No."; Code[20])
        {
            TableRelation = if (Type = const(Member)) Customer where(Status = filter(<> Active | Deceased),
                                                                              "Global Dimension 2 Code" = filter('BOSA'))
            else
            if (Type = const(Account)) Vendor where(Status = filter(<> Active | Deceased));

            trigger OnValidate()
            begin

                GenSetUp.Get();

                if Cust.Get("Client No.") then

                    /*IF Cust.Status=Cust.Status::Deceased THEN
                    ERROR(Text001);*/

                    if Cust.Status = Cust.Status::Withdrawal then
                        if Cust."Withdrawal Date" <> 0D then;

                /*IF CALCDATE(GenSetUp."Minimum Re-admission period",Cust."Withdrawal Date") > TODAY THEN
                ERROR(Text002,GenSetUp."Minimum Re-admission period");*/

                IntTotal := 0;
                LoanTotal := 0;

                if Type = Type::Member then begin
                    if Cust.Get("Client No.") then
                        "Client Name" := Cust.Name;
                    "ID No." := Cust."ID No.";
                    "Staff/Payroll No." := Cust."Payroll/Staff No";
                    Cust.CalcFields(Cust."Current Savings");
                    "Member Deposits" := Cust."Current Savings";
                end
                else
                    if Type = Type::Account then begin

                        if Vend.Get("Client No.") then
                            "Client Name" := Vend.Name;
                        "ID No." := Vend."ID No.";
                    end;

                Loans.Reset;
                Loans.SetRange(Loans."Client Code", "Client No.");
                Loans.SetRange(Loans.Posted, true);
                Loans.SetFilter(Loans."Outstanding Balance", '>0');
                if Loans.Find('-') then
                    repeat
                        Loans.CalcFields(Loans."Outstanding Balance");
                        IntTotal := IntTotal ;
                        LoanTotal := LoanTotal + Loans."Outstanding Balance";
                    until Loans.Next = 0;

                "Total Loan" := LoanTotal;
                "Total Interest" := IntTotal;
            end;
        }
        field(3; "Client Name"; Text[50])
        {
        }
        field(4; "Activation Date"; Date)
        {
            Editable = true;
        }
        field(5; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "Total Loan"; Decimal)
        {
        }
        field(8; "Total Interest"; Decimal)
        {
        }
        field(9; "Member Deposits"; Decimal)
        {
        }
        field(10; "No. Series"; Code[20])
        {
        }
        field(11; "Closure Type"; Option)
        {
            OptionMembers = "Withdrawal - Normal","Withdrawal - Death","Withdrawal - Death(Defaulter)";
        }
        field(12; "Type"; Option)
        {
            OptionCaption = 'BOSA,FOSA,MICRO';
            OptionMembers = Member,Account,MICRO;
        }
        field(13; Activated; Boolean)
        {
        }
        field(14; "FOSA Account No."; Code[100])
        {
        }
        field(15; "Captured By"; Code[20])
        {
        }
        field(16; Date; Date)
        {
        }
        field(17; Time; Time)
        {
        }
        field(18; "Responsibility Center"; Code[10])
        {
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(19; Source; Option)
        {
            OptionCaption = 'BOSA,FOSA,Investment,MICRO';
            OptionMembers = BOSA,FOSA,Investment,MICRO;
        }
        field(20; "ID No."; Code[50])
        {
            Editable = false;
        }
        field(21; "Staff/Payroll No."; Code[20])
        {
        }
        field(22; "CRM Application"; Code[20])
        {
            trigger OnValidate()
            begin
                /*CRMApplication.RESET;
                CRMApplication.SETRANGE(CRMApplication."No.","CRM Application");
                IF CRMApplication.FIND('-') THEN BEGIN
                "Client No.":=CRMApplication."Member No.";
                "CRM User ID":=CRMApplication."Captured By";
                END;
                VALIDATE("Client No.");*/
            end;
        }
        field(23; "CRM User ID"; Code[50])
        {
        }
        field(24; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(26; "Posted By"; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup";
        }
        field(27; Remarks; Text[140])
        {
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

    trigger OnInsert()
    begin

        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Activation Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Activation Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        /*
        OfficeGroup.RESET;
        OfficeGroup.SETRANGE(OfficeGroup."User ID",USERID);
        IF OfficeGroup.FIND('-') THEN BEGIN
        OfficeGroup.TESTFIELD(OfficeGroup."Office/Group");

        OfficeGroup.TESTFIELD(OfficeGroup."Global Dimension 1 Code");
        OfficeGroup.TESTFIELD(OfficeGroup."Shortcut Dimension 2 Code");

        "Responsibility Center":=OfficeGroup."Office/Group";
        "Shortcut Dimension 1 Code":=OfficeGroup."Global Dimension 1 Code";
        "Shortcut Dimension 2 Code":=OfficeGroup."Shortcut Dimension 2 Code";
        END;
        */

        if "Shortcut Dimension 1 Code" = 'FOSA' then begin
            Source := Source::FOSA;
            Type := Type::Account;

        end else
            if "Shortcut Dimension 1 Code" = 'BOSA' then begin
                Source := Source::BOSA;
                Type := Type::Member;
            end else

                if "Shortcut Dimension 1 Code" = 'MICRO' then begin
                    Source := Source::MICRO;
                    Type := Type::MICRO;
                end;

        "Captured By" := UserId;
        Date := Today;
        Time := Time;
        "Activation Date" := Today;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Cust: Record Customer;
        Loans: Record "Loans Register";
        MemLed: Record "Cust. Ledger Entry";
        IntTotal: Decimal;
        LoanTotal: Decimal;
        Vend: Record Vendor;
        Text001: label 'Deceased status cannot be changed';
        GenSetUp: Record "Sacco General Set-Up";
        Text002: label 'Minimum Re-admission period must be %1.';
        OfficeGroup: Record "User Setup";
}
