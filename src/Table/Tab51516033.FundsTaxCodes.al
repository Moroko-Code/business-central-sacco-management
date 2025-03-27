#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516033 "Funds Tax Codes"
{
    fields
    {
        field(10; "Tax Code"; Code[20])
        {
        }
        field(11; Description; Text[50])
        {
        }
        field(12; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,Investor';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor;
        }
        field(13; "Account No"; Code[50])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else if ("Account Type" = const(Customer)) Customer
            else if ("Account Type" = const(Vendor)) Vendor;
        }
        field(14; Percentage; Decimal)
        {
        }
        field(15; Type; Option)
        {
            OptionCaption = ' ,W/Tax,VAT,Excise,Legal,Others,Retention';
            OptionMembers = " ","W/Tax",VAT,Excise,Legal,Others,Retention;
        }
        field(16; "Account Name"; Text[50])
        {
        }
        field(17; Amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Tax Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
