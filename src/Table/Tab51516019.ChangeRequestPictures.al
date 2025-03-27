Table 51516019 "Change Request Pictures"
{
    fields
    {
        // field(1; "Entry No"; Integer)
        // {
        //     AutoIncrement = true;
        // }
        field(11; "Document No"; Code[100])
        {
            TableRelation = "Change Request".No;
        }
        field(12; picture; Media)
        {
        }
        field(13; signature; Media)
        {
        }
    }
}
