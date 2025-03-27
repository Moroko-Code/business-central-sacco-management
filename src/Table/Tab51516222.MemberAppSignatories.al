#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516222 "Member App Signatories"
{
    fields
    {
        field(1; "Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Membership Applications"."No.";
        }
        field(2; Names; Text[50])
        {
            NotBlank = true;
        }
        field(3; "Date Of Birth"; Date)
        {
        }
        field(4; "Staff/Payroll"; Code[20])
        {
        }
        field(5; "ID No."; Code[50])
        {
        }
        field(6; Signatory; Boolean)
        {
        }
        field(7; "Must Sign"; Boolean)
        {
        }
        field(8; "Must be Present"; Boolean)
        {
        }
        field(9; Picture; Media)
        {
            Caption = 'Picture';
        }
        field(10; Signature; Media)
        {
            Caption = 'Signature';
        }
        field(11; "Expiry Date"; Date)
        {
        }
        field(12; "BOSA No."; Code[30])
        {
            TableRelation = Customer;
        }
        field(13; "Email Address"; Text[50])
        {
        }
        field(14; "FOSA No."; Code[30])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                Memb.Reset;
                if Memb.Get("FOSA No.") then begin
                    Names := Memb.Name;
                    "BOSA No." := Memb."BOSA Account No";
                    "ID No." := Memb."ID No.";
                    "Staff/Payroll" := Memb."Staff No";
                    "Date Of Birth" := Memb."Date of Birth";
                    "Mobile No" := Memb."Mobile Phone No";
                end;
            end;
        }
        field(15; "Mobile No"; Text[30])
        {
        }
        field(16; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Entry No", "Account No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Memb: Record Vendor;

    local procedure getMember()
    begin
    end;
}
