#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 51516070 processedchequelist
{
    ApplicationArea = Basic;
    Editable = false;
    PageType = List;
    SourceTable = Transactions;
    SourceTableView = where(Type = filter('Cheque Deposit'),
                            Posted = const(true),
                            "Cheque Processed" = const(true));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                }
                field(Cashier; Cashier)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Type")
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
                    Style = StrongAccent;
                }
                field("Cheque Date"; "Cheque Date")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Maturity Date"; "Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Process Cheque")
            {
                ApplicationArea = Basic;
                Caption = 'Process Cheque';
                Image = process;
                Promoted = true;
                PromotedCategory = Process;
                visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to process the selected Cheque?', false) = true then begin
                        Transactions.Reset;
                        Transactions.SetRange(Transactions.No, No);
                        Transactions.SetRange(Transactions."Account No", "Account No");
                        if Transactions.Find('-') then
                            if (Transactions.Status = Transactions.Status::Pending) or (Transactions.Status = Transactions.Status::Honoured) then begin
                                Transactions."Cheque Processed" := true;
                                Transactions."Date Cleared" := Today;
                                Transactions.Modify;
                            end;
                    end;
                end;
            }
        }
    }

    var
        Transactions: Record Transactions;
}
