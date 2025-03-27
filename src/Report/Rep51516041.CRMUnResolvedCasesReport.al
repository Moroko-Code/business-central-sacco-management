report 51516041 "CRM UnResolved Cases Report"
{
    ApplicationArea = All;
    Caption = 'CRM UnResolved Cases Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/CRM Un-Resolved Cases Report.rdlc';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(GeneralEquiries; "General Equiries.")
        {
            RequestFilterFields = "Captured On", "Captured By", "Resolved by";
            DataItemTableView = sorting(No) where("Lead Status" = const(open));
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
