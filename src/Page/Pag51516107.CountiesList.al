page 51516107 "Counties List"
{
    ApplicationArea = All;
    Caption = 'Counties List';
    PageType = List;
    SourceTable = Counties;
    UsageCategory = None;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
            }
        }
    }
}
