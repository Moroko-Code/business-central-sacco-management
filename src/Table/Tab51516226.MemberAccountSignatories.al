#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516226 "Member Account Signatories"
{
    fields
    {
        field(1; "Account No"; Code[20])
        {
            NotBlank = true;
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
            trigger OnValidate()
            begin
                CUST.Reset;
                CUST.SetRange(CUST."ID No.", "ID No.");
                if CUST.Find('-') then begin
                    "BOSA No." := CUST."No.";
                    Names := CUST.Name;
                    "Date Of Birth" := CUST."Date of Birth";
                    "Email Address" := cust."E-Mail (Personal)";

                    Modify;
                end;
            end;
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
            //SubType = Bitmap;
        }
        field(10; Signature; Media)
        {
            Caption = 'Signature';
            //SubType = Bitmap;
        }
        field(11; "Expiry Date"; Date)
        {
        }
        field(12; "Sections Code"; Code[20])
        {
            //  TableRelation = Table51516159.Field1;
        }
        field(13; "Company Code"; Code[20])
        {
            TableRelation = "Sacco Employers".Code;
        }
        field(14; "BOSA No."; Code[30])
        {
            TableRelation = Customer."No.";
        }
        field(15; "Email Address"; Text[50])
        {
        }
        field(16; "Mobile Number"; Text[50])
        {
        }
        // field(17; "Entry No"; Integer)
        // {
        //     AutoIncrement = true;
        // }
    }

    keys
    {
        key(Key1; "ID No.", "Account No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        CUST: Record Customer;
}
