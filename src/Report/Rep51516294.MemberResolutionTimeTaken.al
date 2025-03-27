report 51516294 MemberResolutionTimeTaken
{
    ApplicationArea = All;
    Caption = ' Members’ resolution time taken report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/Member Resolution Report.rdlc';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(GeneralEquiries; "General Equiries.")
        {
            DataItemTableView = sorting(No) where("Lead Status" = filter(Closed));
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPic; CompanyInfo.Picture)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(No; No)
            {
            }
            column(Case_Subject; "Case Subject") { }
            column(Member_Name; "Member Name") { }
            column(Captured_On; "Captured On") { }
            column(Resolved_Date; "Resolved Date") { }
            column(ResolutionTimeTaken; ResolutionTimeTaken) { }
            column(Captured_By; "Captured By") { }
            column(Resolved_by; "Resolved by") { }
            trigger OnAfterGetRecord()
            begin
                If "Resolved Date" <> 0D then
                    ResolutionTimeTaken := Abs("Resolved Date" - "Captured On");
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.get;
    end;

    var
        ResolutionTimeTaken: Integer;
        CompanyInfo: Record "Company Information";
}