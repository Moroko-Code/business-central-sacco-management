#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516025 "Receipt Header Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Receipt Header";

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
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Date)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Balance"; "Bank Balance")
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
                field("Amount Received"; "Amount Received")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Received(LCY)"; "Amount Received(LCY)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Total Amount"; "Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("Received From"; "Received From")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount(LCY)"; "Total Amount(LCY)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
            part(Control23; "Receipt Line")
            {
                SubPageLink = "Document No" = field("No.");
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Post Receipt")
            {
                ApplicationArea = Basic;
                Caption = 'Post Receipt';
                Image = PostPrint;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory=Process;
                PromotedOnly=true;

                trigger OnAction()
                begin
                    TestField("Global Dimension 1 Code");
                    TestField("Global Dimension 2 Code");
                    TestField("Received From");
                    TestField(Description);

                    if Posted then
                        Error('This receipt is already posted');

                    //TESTFIELD(Status,Status::Approved);
                    CalcFields("Total Amount", "Total Amount(LCY)");

                    ok := Confirm('Post Receipt No:' + Format("No.") + '. The account will be credited with KES:' + Format("Total Amount(LCY)") + ' Continue?');
                    if ok then begin
                        DocNo := "No.";
                        if FundsUser.Get(UserId) then begin
                            FundsUser.TestField(FundsUser."Receipt Journal Template");
                            FundsUser.TestField(FundsUser."Receipt Journal Batch");
                            JTemplate := FundsUser."Receipt Journal Template";
                            JBatch := FundsUser."Receipt Journal Batch";
                            PostedEntry := FundsManager.PostPropertyReceipt(Rec, JTemplate, JBatch, "Property Code", "No.", '', "Received From", "Total Amount(LCY)");
                            if PostedEntry then begin
                                ReceiptHeader.Reset;
                                ReceiptHeader.SetRange(ReceiptHeader."No.", DocNo);
                                if ReceiptHeader.FindFirst then
                                    Report.RunModal(Report::"Receipt Header", true, false, ReceiptHeader);
                            end;
                        end else
                            Error('User Account Not Setup');
                    end;
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            action(Print)
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    ReceiptHeader.Reset;
                    ReceiptHeader.SetRange(ReceiptHeader."No.", "No.");
                    if ReceiptHeader.FindFirst then
                        Report.RunModal(Report::"Receipt Header", true, false, ReceiptHeader);
                end;
            }
        }
    }

    var
        FundsManager: Codeunit "Funds Management";
        JTemplate: Code[20];
        JBatch: Code[20];
        FundsUser: Record "Funds User Setup";
        ok: Boolean;
        ReceiptHeader: Record "Receipt Header";
        PostedEntry: Boolean;
        DocNo: Code[20];
}
