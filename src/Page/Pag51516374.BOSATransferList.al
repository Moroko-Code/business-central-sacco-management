#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516374 "BOSA Transfer List"
{
    ApplicationArea = Basic;
    CardPageID = Transfers;
    PageType = List;
    Editable = false;
    DeleteAllowed = true;
    SourceTable = "BOSA Transfers";
    SourceTableView = where(Posted = const(false), Approved = const(false));
    UsageCategory = Tasks;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                }
                field("Schedule Total"; "Schedule Total")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                }
                field("No. Series"; "No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Posted; Posted)
                {
                }
                field("Captured By"; "Captured By")
                {
                    Style = StrongAccent;
                }
                field("Approved By"; "Approved By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        SetRange("Captured By", UserId);
    end;
}
