codeunit 51516159 "Sub Reports"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', true, true)]
    local procedure UpdateReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Trial Balance" then
            NewReportId := Report::TrialBalance
    end;
}