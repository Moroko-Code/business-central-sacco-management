#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516215 "Guarantor Sub Card"

{
    //DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Guarantorship Substitution H";
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loanee Member No"; "Loanee Member No")
                {
                    ApplicationArea = Basic;
                    Editable = LoaneeNoEditable;
                }
                field("Loanee Name"; "Loanee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Guaranteed"; "Loan Guaranteed")
                {
                    ApplicationArea = Basic;
                    Editable = LoanGuaranteedEditable;
                }
                field("Substituting Member"; "Substituting Member")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member to be substuted';
                    Editable = SubMemberEditable;
                }
                field("Substituting Member Name"; "Substituting Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Commited Amount"; "Commited Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Substituted; Substituted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Substituted"; "Date Substituted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Substituted By"; "Substituted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1000000014; "Guarantor Sub Subform")
            {
                SubPageLink = "Document No" = field("Document No"),
                              "Member No" = field("Substituting Member"),
                              "Loan No." = field("Loan Guaranteed");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Approvals)
            {
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = SendApproval;
                    trigger OnAction()
                    var
                        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
                        text001: label 'This batch is already pending approval';
                        GuarantorshipSubstitutionL: Record "Guarantorship Substitution L";
                    begin
                        if Status <> Status::Open then
                            Error('Status must be open.');

                        TestField("Loanee Member No");
                        TestField("Loan Guaranteed");


                        LGuarantor.Reset;
                        LGuarantor.SetRange(LGuarantor."Loan No", "Loan Guaranteed");
                        LGuarantor.SetRange(LGuarantor."Member No", "Substituting Member");
                        if LGuarantor.FindSet then begin
                            //Add All Replaced Amounts
                            TotalReplaced := 0;
                            GSubLine.Reset;
                            GSubLine.SetRange(GSubLine."Document No", "Document No");
                            GSubLine.SetRange(GSubLine."Member No", "Substituting Member");
                            if GSubLine.FindSet then
                                repeat
                                    TotalReplaced := TotalReplaced + GSubLine."Sub Amount Guaranteed";
                                until GSubLine.Next = 0;
                            //End Add All Replaced Amounts
                            Commited := rec."Commited Amount";
                            if TotalReplaced < Commited then
                                Error('Guarantors replaced do not cover the whole amount');
                        end;

                        //Approval code  here
                        if Confirm('Send Approval Request?', false) = true then
                            SrestepApprovalsCodeUnit.SendGuarantorSubRequestForApproval(rec."Document No", Rec);
                        //...................
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = CancelApproval;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
                    begin
                        if Status <> Status::Pending then
                            Error(text001);
                        //Approval here
                        if Confirm('Cancel Approval Request?', false) = true then
                            SrestepApprovalsCodeUnit.CancelGuarantorSubRequestForApproval(Rec."Document No", Rec);
                    end;
                }
                action("Process Substitution")
                {
                    ApplicationArea = Basic;
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = AllowPosting;

                    trigger OnAction()
                    var
                        Gurantor: Record "Loans Guarantee Details";
                    begin

                        TestField(Status, Rec.Status::Approved);
                        if "Created By" <> UserId then
                            //Error('Restricted! you can only process a record you created!');
                        LGuarantor.Reset;
                        LGuarantor.SetRange(LGuarantor."Loan No", "Loan Guaranteed");
                        LGuarantor.SetRange(LGuarantor."Member No", "Substituting Member");
                        if LGuarantor.FindSet then begin
                            //Add All Replaced Amounts
                            if LGuarantor.Substituted = true then
                                Error('The Guarantor has already being Substituted');

                            TotalReplaced := 0;
                            GSubLine.Reset;
                            GSubLine.SetRange(GSubLine."Document No", "Document No");
                            GSubLine.SetRange(GSubLine."Member No", "Substituting Member");
                            if GSubLine.FindSet then
                                repeat
                                    TotalReplaced := TotalReplaced + GSubLine."Sub Amount Guaranteed";
                                until GSubLine.Next = 0;
                            //End Add All Replaced Amounts

                            //Compare with committed shares
                            Commited := LGuarantor."Amount Committed";
                            if TotalReplaced < Commited then
                                Message('Guarantors replaced do not cover the whole amount');
                            //End Compare with committed Shares

                            //Create Lines
                            GSubLine.Reset;
                            GSubLine.SetRange(GSubLine."Document No", "Document No");
                            GSubLine.SetRange(GSubLine."Member No", "Substituting Member");
                            if GSubLine.FindSet then
                                repeat
                                    Gurantor.Reset();
                                    Gurantor.SetRange(Gurantor."Loan No", "Loan Guaranteed");
                                    Gurantor.SetRange(Gurantor."Member No", GSubLine."Member No");
                                    if not Gurantor.FindSet() then begin
                                        Gurantor.Init;
                                        Gurantor."Loan No" := "Loan Guaranteed";
                                        Gurantor."Member No" := GSubLine."Substitute Member";
                                        Gurantor.Validate(Gurantor."Member No");
                                        Gurantor.Name := GSubLine."Substitute Member Name";
                                        Gurantor."Amont Guaranteed" := GSubLine."Sub Amount Guaranteed";
                                        Gurantor."Substituted Guarantor" := GSubLine."Member No";
                                        Gurantor.Shares := GSubLine."Substitute Member Deposits";
                                        Gurantor.Insert();
                                        commit;
                                    end
                                    else begin
                                        Gurantor."Loan No" := "Loan Guaranteed";
                                        Gurantor."Member No" := GSubLine."Substitute Member";
                                        Gurantor.Validate(Gurantor."Member No");
                                        Gurantor.Name := GSubLine."Substitute Member Name";
                                        Gurantor."Amont Guaranteed" := GSubLine."Sub Amount Guaranteed" + Gurantor."Amont Guaranteed";
                                        Gurantor."Substituted Guarantor" := GSubLine."Member No";
                                        Gurantor.Shares := GSubLine."Substitute Member Deposits";
                                        //Gurantor.Modify();
                                    end;
                                until GSubLine.Next = 0;
                            //End Create Lines
                            LGuarantor.Substituted := true;

                            Substituted := true;
                            "Date Substituted" := Today;
                            "Substituted By" := UserId;
                            Status := Status::Closed;
                            if Modify() = true then
                                Message('Guarantor Substituted Succesfully');

                            LGuarantor.Modify;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FNAddRecordRestriction();
        Controls();
    end;

    trigger OnAfterGetRecord()
    begin
        FNAddRecordRestriction();
        Controls();
    end;

    trigger OnOpenPage()
    begin
        "Application Date" := Today;
        Controls();
    end;

    var
        LGuarantor: Record "Loans Guarantee Details";
        GSubLine: Record "Guarantorship Substitution L";
        LoaneeNoEditable: Boolean;
        LoanGuaranteedEditable: Boolean;
        SubMemberEditable: Boolean;
        TotalReplaced: Decimal;
        Commited: Decimal;
        SendApproval: Boolean;
        AllowPosting: Boolean;
        CancelApproval: Boolean;
        NewLGuar: Record "Loans Guarantee Details";

    local procedure FNAddRecordRestriction()
    begin
        if Status = Status::Open then begin
            LoaneeNoEditable := true;
            LoanGuaranteedEditable := true;
            SubMemberEditable := true

        end else
            if Status = Status::Pending then begin
                LoaneeNoEditable := false;
                LoanGuaranteedEditable := false;
                SubMemberEditable := false
            end else
                if Status = Status::Approved then begin
                    LoaneeNoEditable := false;
                    LoanGuaranteedEditable := false;
                    SubMemberEditable := false;
                end;
    end;

    local procedure CalculateAmountGuaranteed(AmountReplaced: Decimal; TotalAmount: Decimal; AmountGuaranteed: Decimal) AmtGuar: Decimal
    begin
        AmtGuar := ((AmountReplaced / TotalAmount) * AmountGuaranteed);

        exit(AmtGuar);
    end;

    local procedure Controls()
    begin
        if Status = Status::Open THEN begin
            AllowPosting := false;
            CancelApproval := false;
            SendApproval := true;
        end ELSE
            if Status = Status::Pending THEN begin
                AllowPosting := false;
                CancelApproval := true;
                SendApproval := false;
            end ELSE
                if Status = Status::Approved THEN begin
                    AllowPosting := true;
                    CancelApproval := false;
                    SendApproval := false;
                end
                ELSE
                    if Status = Status::Closed THEN begin
                        AllowPosting := false;
                        CancelApproval := false;
                        SendApproval := false;
                    end;
    end;
}
