page 51516101 "LoanList-Pending Approval BOSA"
{
    ApplicationArea = All;
    Caption = 'Loan List-Pending Approval BOSA';
    CardPageID = "Loans Pending Approval";
    PageType = List;
    SourceTable = "Loans Register";
    UsageCategory = Lists;
    DeleteAllowed = true;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = where(Posted = const(false),
                            Source = filter(BOSA), "Loan Status" = const(Appraisal), "Approval Status" = const(Pending));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan  No."; "Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name"; "Client Name")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                }
                field("Client Code"; "Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member  No';
                }
                field("Group Code"; "Group Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Requested Amount"; "Requested Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = Basic;
                    Style = Ambiguous;
                }
                field("Loan Status"; "Loan Status")
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date"; "Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Date of Completion"; "Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                }
                field(Installments; Installments)
                {
                    ApplicationArea = Basic;
                }
                field(Repayment; Repayment)
                {
                    ApplicationArea = Basic;
                }
                field("Rejection  Remark"; "Rejection  Remark")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Captured By"; "Captured By")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000000; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    begin
        SetRange("Captured By", UserId);
    end;
}
