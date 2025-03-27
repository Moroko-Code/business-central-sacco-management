#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 51516106 "Sasra Loan Classification Cue"
{
    PageType = CardPart;
    SourceTable = SasraLoanClassificationCues;
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            cuegroup(Group1)
            {
                Caption = 'BOSA LOANS ';
                field("Watchful Loans"; "Watchful Loans")
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    // DrillDownPageId = "Loan List";
                }
                field("Substandard Loans"; "Substandard Loans")
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    // DrillDownPageId = "Loans Posted List";
                }
                field("Doubtful Loans"; "Doubtful Loans")
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    // DrillDownPageId = "Loan List";
                }
            }

            cuegroup(Group2)
            {
                Caption = 'FOSA LOANS ';
                field("Watchful FOSA Loans"; "Watchful FOSA Loans")
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Substandard FOSA Loans"; "Substandard FOSA Loans")
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Doubtful FOSA Loans"; "Doubtful FOSA Loans")
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                }
            }

            cuegroup(Group3)
            {
                Caption = 'MICRO LOANS ';
                field("Watchful MICRO loans"; "Watchful MICRO Loans")
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Substandard MICRO Loans"; "Substandard MICRO Loans")
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Doubtful MICRO Loans"; "Doubtful MICRO Loans")
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    var
    begin
        if not Rec.Get("Primary Key") then begin
            Rec.Init;
            Rec."Primary Key" := "Primary Key";
            Rec.Insert;
        end;
    end;
}
