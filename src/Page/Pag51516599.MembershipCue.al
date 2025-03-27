#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516599 "Membership Cue"
{
    PageType = CardPart;
    SourceTable = "Membership Cue";

    layout
    {
        area(content)
        {
            cuegroup(Members)
            {
                field("Active Members"; "Active Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Junior Members"; "Junior Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field("Non-Active Members"; "Non-Active Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Dormant Members"; "Dormant Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field("Withdrawn Members"; "Withdrawn Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field("Deceased Members"; "Deceased Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
            }
            cuegroup("Members Per Branch")
            {
                field("Maua Members"; "Maua Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field("Mutuati Members"; "Mutuati Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field("Muriri Members"; "Muriri Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field("KK Members"; "KK Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field("Mikinduri Members"; "Mikinduri Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
            }
            cuegroup("BOSA Loans")
            {
                Caption = 'BOSA Loans';
                field(Development; Development)
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field(Executive; Executive)
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field(Mfadhili; Mfadhili)
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field("Devt Savings"; "Devt Savings")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field(Mkombozi; Mkombozi)
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field(Pepea; Pepea)
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field(College; College)
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field("School Fees"; "School Fees")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field(Digital; Digital)
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field(Housing; Housing)
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field(Asset; Asset)
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
            }
            cuegroup("FOSA Loans")
            {
                field("Normal Adv Loan"; "Normal Adv Loan")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field("Xmas Adv"; "Xmas Adv")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field(Crop; Crop)
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field(MILK; MILK)
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
            }
            cuegroup(CEEP)
            {
                field("Ceep Groups"; "Ceep Groups")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field("Ceep Members"; "Ceep Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field("Ceep New"; "Ceep New")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ceep Loan New';
                    Image = "None";
                }
            }
            cuegroup("Staff Loans")
            {
                field(StaffCar; StaffCar)
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field(StaffHousing; StaffHousing)
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if not Get(UserId) then begin
            Init;
            "User ID" := UserId;
            Insert;
        end;
    end;
}
