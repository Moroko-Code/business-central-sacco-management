page 51901 "Basic Pay Changes"
{
    Editable = false;
    PageType = List;
    SourceTable = "Basic Pay Changes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payroll No"; "Payroll No")
                {
                }
                field("Old Pay"; "Old Pay")
                {
                }
                field("New Pay"; "New Pay")
                {
                }
                field("Date effected"; "Date effected")
                {
                }
                field("Effected By"; "Effected By")
                {
                }
            }
        }
    }

    actions
    {
    }
}
