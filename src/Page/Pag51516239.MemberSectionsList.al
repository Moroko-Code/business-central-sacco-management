#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516239 "Member Sections List"
{
    PageType = Card;
    SourceTable = "Member Section";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(Section; Section)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}
