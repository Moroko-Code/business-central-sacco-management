#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516360 "SMS Messages"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "SMS Messages";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; "Entry No")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                }
                field("Telephone No"; "Telephone No")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Message"; "SMS Message")
                {
                    ApplicationArea = Basic;
                }
                field("Date Entered"; "Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Time Entered"; "Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Entered By"; "Entered By")
                {
                    ApplicationArea = Basic;
                }
                field("Sent To Server"; "Sent To Server")
                {
                    ApplicationArea = Basic;
                }
                field("System Date"; "System Date")
                {
                    ApplicationArea = Basic;
                }
                field("System Time"; "System Time")
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
