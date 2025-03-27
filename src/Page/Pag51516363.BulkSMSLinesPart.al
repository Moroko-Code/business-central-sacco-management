#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516363 "Bulk SMS Lines Part"
{
    PageType = ListPart;
    SourceTable = "Bulk SMS Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                }
                field("Phone No"; "Phone No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Telephone No';
                }
            }
        }
    }

    actions
    {
    }

    var
        BulkSMSHeader: Record "Bulk SMS Header";
        DimensionValue: Record "Dimension Value";
}
