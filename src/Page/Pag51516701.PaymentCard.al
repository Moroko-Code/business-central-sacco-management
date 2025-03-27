#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516701 PaymentCard
{
    DeleteAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Payment Header";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date';
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Mode"; "Payment Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bank Account"; "Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account Name"; "Bank Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account Balance"; "Bank Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Type"; "Cheque Type")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No"; "Cheque No")
                {
                    ApplicationArea = Basic;
                }
                field(Payee; Payee)
                {
                    ApplicationArea = Basic;
                }
                field("On Behalf Of"; "On Behalf Of")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Description"; "Payment Description")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                // field("Amount(LCY)"; "Amount(LCY)")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("VAT Amount"; "VAT Amount")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("VAT Amount(LCY)"; "VAT Amount(LCY)")
                // {
                //     ApplicationArea = Basic;
                //     Visible = false;
                // }
                // field("WithHolding Tax Amount"; "WithHolding Tax Amount")
                // {
                //     ApplicationArea = Basic;
                //     Visible = false;
                // }
                // field("WithHolding Tax Amount(LCY)"; "WithHolding Tax Amount(LCY)")
                // {
                //     ApplicationArea = Basic;
                //     Visible = false;
                // }
                // field("Net Amount"; "Net Amount")
                // {
                //     ApplicationArea = Basic;
                //     Visible = false;
                // }
                field("Net Amount(LCY)"; "Net Amount(LCY)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                // field(Posted; Posted)
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Posted By"; "Posted By")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Date Posted"; "Date Posted")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Time Posted"; "Time Posted")
                // {
                //     ApplicationArea = Basic;
                // }
                field(Cashier; Cashier)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control35; "Payment Line")
            {
                SubPageLink = "Document No" = field("No.");
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Post Payment")
            {
                ApplicationArea = Basic;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CheckRequiredItems;
                    if FundsUser.Get(UserId) then begin
                        FundsUser.TestField(FundsUser."Payment Journal Template");
                        FundsUser.TestField(FundsUser."Payment Journal Batch");
                        JTemplate := FundsUser."Payment Journal Template";
                        JBatch := FundsUser."Payment Journal Batch";
                        FundsManager.PostPayment(Rec, JTemplate, JBatch);
                    end else
                        Error('User Account Not Setup, Contact the System Administrator');
                end;
            }
            action("Post and Print")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PostPrint;

                trigger OnAction()
                begin
                    if FundsUser.Get(UserId) then begin
                        FundsUser.TestField(FundsUser."Payment Journal Template");
                        FundsUser.TestField(FundsUser."Payment Journal Batch");
                        JTemplate := FundsUser."Payment Journal Template";
                        JBatch := FundsUser."Payment Journal Batch";
                        FundsManager.PostPayment(Rec, JTemplate, JBatch);
                        Commit;
                        PHeader.Reset;
                        PHeader.SetRange(PHeader."No.", "No.");
                        if PHeader.FindFirst then
                            Report.RunModal(Report::"Payment Voucher", true, false, PHeader);
                    end else
                        Error('User Account Not Setup, Contact the System Administrator');
                end;
            }
            action(Refresh)
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Refresh;
                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
            action("Send Approval Request")
            {
                Image = SendApprovalRequest;
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    rec.CalcFields(Amount);
                    if Amount <> 0 then
                        if Confirm('Send  Approval request?', false) = true then
                            SrestepApprovalsCodeUnit.SendPaymentVoucherRequestForApproval(rec."No.", Rec)
                        else
                            Message('Amount can Not be 0');
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CancelApprovalRequest;

                trigger OnAction()
                begin

                    if Confirm('Cancel  Approval request?', false) = true then
                        SrestepApprovalsCodeUnit.CancelPaymentVoucherRequestForApproval(rec."No.", Rec);
                end;
            }

            action(Print)
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PHeader.Reset;
                    PHeader.SetRange(PHeader."No.", "No.");
                    if PHeader.FindFirst then
                        Report.RunModal(Report::"Payment Voucher", true, false, PHeader);
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Payment Mode" := "payment mode"::Cheque;
        "Payment Type" := "payment type"::Normal;
    end;

    var
        FundsUser: Record "Funds User Setup";
        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
        FundsManager: Codeunit "Funds Management";
        JTemplate: Code[20];
        JBatch: Code[20];
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        TableID: Integer;
        PHeader: Record "Payment Header";

    local procedure CheckRequiredItems()
    begin
        TestField(Status, Status::Approved);
        TestField("Posting Date");
        TestField(Payee);
        TestField("Bank Account");
        TestField("Payment Description");
        TestField("Global Dimension 1 Code");
        TestField("Global Dimension 2 Code");
    end;
}
