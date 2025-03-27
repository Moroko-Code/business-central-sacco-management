report 51516029 "CRM Resolved Cases Report"
{
    ApplicationArea = All;
    Caption = 'CRM Resolved Cases Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/CRM Resolved Cases Report.rdlc';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(GeneralEquiries; "General Equiries.")
        {
            RequestFilterFields = "Captured On", "Captured By", "Resolved by";
            DataItemTableView = sorting(No) where("Lead Status" = const(closed));
            column(No; No)
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(CallingFor; "Calling For")
            {
            }
            column(CaseSubject; "Case Subject")
            {
            }
            column(CaseResolutionDetails; "Resolution Details")
            {
            }
            column(DateResolved; "Date Resolved")
            {
            }
            column(ResolvedDate; "Resolved Date")
            {
            }
            column(Resolvedby; "Resolved by")
            {
            }
            column(VarNo; VarNo)
            {
            }
            trigger OnPreDataItem()
            begin
                VarNo := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                VarNo := VarNo + 1;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        VarNo: Integer;
}
