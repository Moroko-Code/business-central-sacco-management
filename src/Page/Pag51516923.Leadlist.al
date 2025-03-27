#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516923 "Lead list"
{
    CardPageID = "Lead card";
    Editable = false;
    PageType = List;
    SourceTable = "General Equiries.";
    SourceTableView = where(Status = const(New));

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
                field("Full Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("ID No"; "ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No"; "Phone No")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Lead Status"; "Lead Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                }
            }
        }
    }

    actions
    {
    }
}
