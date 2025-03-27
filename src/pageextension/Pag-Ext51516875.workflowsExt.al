pageextension 51516875 "workflowsExt" extends Workflows
{
    trigger OnOpenPage()
    var
        CustomWorkFlowEvents: Codeunit "Custom Workflow Events";
        WorkflowRepsonse: Codeunit "Custom Workflow Responses";
    begin
        CustomWorkFlowEvents.AddEventsToLib();
        WorkflowRepsonse.AddResponsePredecessors();
        Message('done');
    end;
}
