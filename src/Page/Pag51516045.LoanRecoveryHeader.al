page 51516045 "Loan Recovery Header"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Loan Recovery Header";
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                }
                field("Recovery Type"; Rec."Recovery Type")
                {
                    Editable = FieldEditable;
                }
                field("Entered By"; Rec."Entered By")
                {
                    Editable = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    Editable = false;
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Notify Member(s)"; Rec."Notify Member(s)")
                {
                }
            }
            part("Loan Recovery Lines"; "Loan Recovery Lines")
            {
                Caption = 'Loan Recovery Lines';
                SubPageLink = "Document No" = field("Document No");
                Editable = FieldEditable;
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("Send Approval")
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Enabled = SendApprovalEnabled;

                trigger OnAction()
                var
                    RecoveryLines: Record "Loan Recovery List";
                begin
                    TestField(Posted, false);
                    TestField("Posted By", '');
                    TestField("Posting Date", 0D);
                    if Status <> Status::Open then
                        Error('The card MUST be Open');
                    RecoveryLines.Reset();
                    RecoveryLines.SetRange(RecoveryLines."Document No", "Document No");
                    if RecoveryLines.Find('-') then
                        repeat
                            if (RecoveryLines."Member No" = '') or (RecoveryLines."Loan No." = '') or (RecoveryLines."Total Amount To Recover" = 0) then
                                Error('You cannot send a card with incomplete recovery lines for Approvals ');
                        until RecoveryLines.Next = 0;
                    if Confirm('Are you sure you want to send Approval Request ?', false) = false then
                        exit
                    else begin
                        SrestepApprovalsCodeUnit.SendLoanRecoveryApplicationsRequestForApproval(rec."Document No", Rec);
                        CurrPage.Close();
                    end;
                end;
            }
            action("Cancel Approval")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Enabled = CancelApprovalEnabled;
                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Cancel Approval Request ?', false) = false then
                        exit
                    else
                        SrestepApprovalsCodeUnit.CancelLoanRecoveryApplicationsRequestForApproval(rec."Document No", Rec);
                end;
            }

            action("Post Recovery")
            {
                ApplicationArea = Basic;
                Caption = 'Post';
                Image = PostedReceipt;
                Promoted = true;
                Visible = false;
                Enabled = PostEnabled;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    TestField(Posted, false);
                    TestField("Posted By", '');
                    TestField("Posting Date", 0D);
                    if Status <> Status::Approved then
                        Error('The card MUST be Approved');
                end;
            }
        }
    }
    var
        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
        SendApprovalEnabled: Boolean;
        CancelApprovalEnabled: Boolean;
        PostEnabled: Boolean;
        FieldEditable: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        FnUpdateControls();
    end;

    trigger OnOpenPage()
    begin
        FnUpdateControls();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.Insert(true);
    end;

    local procedure FnUpdateControls()
    begin
        if Status = Status::Open then begin
            SendApprovalEnabled := true;
            CancelApprovalEnabled := false;
            PostEnabled := false;
            FieldEditable := true;
        end else
            if Status = Status::Pending then begin
                SendApprovalEnabled := false;
                CancelApprovalEnabled := true;
                PostEnabled := false;
                FieldEditable := false;
            end
            else
                if Status = Status::Approved then begin
                    SendApprovalEnabled := false;
                    CancelApprovalEnabled := false;
                    PostEnabled := true;
                    FieldEditable := false;
                end
                else
                    if Status = Status::Closed then begin
                        SendApprovalEnabled := false;
                        CancelApprovalEnabled := false;
                        PostEnabled := false;
                        FieldEditable := false;
                    end
                    else
                        if Status = Status::Rejected then begin
                            SendApprovalEnabled := true;
                            CancelApprovalEnabled := false;
                            PostEnabled := true;
                            FieldEditable := false;
                        end;
        CurrPage.Update();
    end;
}