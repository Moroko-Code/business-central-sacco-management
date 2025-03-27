#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516438 "Investor Group Members"
{
    fields
    {
        field(10; "Investor No."; Code[20])
        {
        }
        field(11; "ID/Passport No"; Code[20])
        {
        }
        field(12; Name; Text[100])
        {
        }
        field(13; Photo; Blob)
        {
            SubType = Bitmap;
        }
        field(14; Sgnature; Blob)
        {
            SubType = Bitmap;
        }
        field(15; "Postal Code"; Code[20])
        {
        }
        field(16; Address; Code[20])
        {
        }
        field(17; City; Code[20])
        {
        }
        field(18; County; Code[20])
        {
        }
        field(19; "Mobile No."; Code[20])
        {
        }
        field(20; "Home Phone No."; Code[20])
        {
        }
        field(21; "Email Address"; Text[50])
        {
        }
        field(22; "Pin Number"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Investor No.", "ID/Passport No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
