page 51516149 "Sacco Information"
{
    ApplicationArea = All;
    Caption = 'Sacco Information';
    PageType = Card;
    Editable = true;
    SourceTable = "Sacco Information";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    Visible = false;
                }
                field("Sacco Principal Activities"; "Sacco Principal Activities")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Sacco Principal activities';
                }
                field("Sacco CEO"; "Sacco CEO")
                {
                    ApplicationArea = all;
                }
                field("Sacco CEO Name"; "Sacco CEO Name")
                {
                    ApplicationArea = all;
                }
                field("Sacco CEO P.O Box"; "Sacco CEO P.O Box")
                {
                    ApplicationArea = all;
                }
                field("L.R.No."; "L.R.No.")
                {
                    ApplicationArea = all;
                }
                // field("Floor Number"; "Floor Number")
                // {
                //     ApplicationArea = all;

                // }
                field("P.O Box"; "P.O Box")
                {
                    ApplicationArea = all;
                }
                field("Building Name"; "Building Name")
                {
                    ApplicationArea = all;
                }
                field("Independent Auditor"; "Independent Auditor")
                {
                    ApplicationArea = all;
                }
                field(IndAuditorBOX; IndAuditorBOX)
                {
                    ApplicationArea = all;
                }
                field(PrincipalBankBox; PrincipalBankBox)
                {
                    ApplicationArea = all;
                }
                field(PrincipalBankers; PrincipalBankers)
                {
                    Caption = 'Principal Bankers';
                    ApplicationArea = all;
                }
                field("Principal Bank Branch"; "Principal Bank Branch")
                {
                    ApplicationArea = all;
                }
                field(auditorcerfication; auditorcerfication)
                {
                    ApplicationArea = all;
                    Caption = 'Auditor Certification Name';
                }
                field("Dividends Interest"; "Dividends Interest") { }
                field("Previous Dividends Interest"; "Previous Dividends Interest") { }
                field("Deposits Interest"; "Deposits Interest") { }
                field("Previous Deposits Interest"; "Previous Deposits Interest") { }
            }
            group("Board of Directors")
            {
                part("Board of Directors Lists"; "Board of Directors Lists")
                {
                    ApplicationArea = all;
                }
            }
            group("Supervisory Commite")
            {
                part("Supervisory Commitee Lists"; "Supervisory Commitee Lists")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Mkopo Account Setup")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Mkopo Account Setup";
            }
        }
    }
    trigger OnInit()
    begin
        if Rec.IsEmpty() then
            Rec.Insert();
    end;
}
