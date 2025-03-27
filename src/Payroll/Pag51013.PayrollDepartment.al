page 51013 PayrollDepartment
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = PayrollDepartments;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(code; code)
                {
                    ApplicationArea = All;
                }
                field(Department; Department)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                end;
            }
        }
    }
}