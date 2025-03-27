#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516442 "Investor Amounts Ledger"
{
    fields
    {
        field(10; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(11; "Investor No"; Code[20])
        {
        }
        field(12; "Principle Amount"; Decimal)
        {
        }
        field(13; "Principle Amount(LCY)"; Decimal)
        {
        }
        field(14; Date; Date)
        {
        }
        field(15; Day; Integer)
        {
        }
        field(16; Month; Integer)
        {
        }
        field(17; Year; Integer)
        {
        }
        field(18; "Receipt No"; Code[30])
        {
        }
        field(19; "Interest Rate"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Investor No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
