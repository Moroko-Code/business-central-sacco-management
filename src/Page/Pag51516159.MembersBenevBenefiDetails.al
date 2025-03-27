#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516159 "Members Benev Benefi Details"
{
    PageType = List;
    Caption = 'Members Benevolent Beneficiary Details';
    Editable = false;
    SourceTable = "Members Next Kin Details";
    SourceTableView = where(Type = const("Benevolent Beneficiary"));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                }
                field(Relationship; Relationship)
                {
                    ApplicationArea = Basic;
                }
                field("%Allocation"; "%Allocation")
                {
                    ApplicationArea = Basic;
                }
                field(Beneficiary; Beneficiary)
                {
                    ApplicationArea = Basic;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone; Telephone)
                {
                    ApplicationArea = Basic;
                }
                field(Email; Email)
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
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
        StatusPermissions.Reset;
        StatusPermissions.SetRange(StatusPermissions."User Id", UserId);
        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::Nominee);
        if StatusPermissions.Find('-') = false then
            Error('You do not have permissions to View This information.');
    end;

    var
        StatusPermissions: Record "Status Change Permision";
}
