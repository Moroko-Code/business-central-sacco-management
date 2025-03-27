#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516289 "Appraisal Salary Set-up"
{
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Appraisal Salary Set-up";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                    OptionCaption = ' ,Earnings,Deductions,Basic,Asset,Liability,Rental,Farming';
                }
            }
        }
    }

    actions
    {
    }
}
