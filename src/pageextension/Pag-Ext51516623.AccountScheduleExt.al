pageextension 51516623 "AccountScheduleExt" extends "Account Schedule Names"
{
    layout
    {
        addbefore(Description)
        {
            field("Default Column Layouts"; "Default Column Layout")
            {
                Caption = 'Default Column Layouts';
                ApplicationArea = Basic;
            }
        }

        modify("Analysis View Name")
        {
            Visible = false;
        }
        // modify()
        // {
        //     Visible = false;
        // }
    }
    actions
    {
        // modify(EditAccountSchedule)
        // {
        // }
    }
}
