#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516495 "CRM Member Statistics"
{
    Caption = 'CRM Member Statistics';
    Editable = false;
    PageType = CardPart;
    SaveValues = true;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            field(Image; Image)
            {
                ApplicationArea = Basic;
                Caption = 'Member No.';
            }
            group("Case Statistics;")
            {
                Caption = 'Case Statistics';
                visible = true;
                field("Enquiries Made"; "Enquiries Made")
                {
                    Editable = false;
                    Style = Ambiguous;
                }
                field("Request Made"; "Request Made")
                {
                    Editable = false;
                    Style = Ambiguous;
                }
                field("Appreciations Made"; "Appreciations Made")
                {
                    Editable = false;
                    Style = Ambiguous;
                }
                field("Complains Made"; "Complains Made")
                {
                    Editable = false;
                    Style = Attention;
                }
                field("Criticisms Made"; "Criticisms Made")
                {
                    Editable = false;
                    Style = Attention;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        "Loan Arrears" := FnGetLoanArrears(Rec."No.");
    end;

    trigger OnOpenPage()
    begin
    end;

    var
        LatestCustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry: array[4] of Record "Cust. Ledger Entry";
        AgingTitle: array[4] of Text[30];
        AgingPeriod: DateFormula;
        I: Integer;
        PeriodStart: Date;
        PeriodEnd: Date;
        Text002: label 'Not Yet Due';
        Text003: label 'Over %1 Days';
        Text004: label '%1-%2 Days';

    local procedure FnGetLoanArrears(No: Code[20]): Decimal
    var
        LoansReg: Record "Loans Register";
        Amount: Decimal;
    begin
        Amount := 0;
        LoansReg.reset;
        LoansReg.SetRange(LoansReg."Client Code", no);
        LoansReg.SetAutoCalcFields(LoansReg."Outstanding Balance");
        LoansReg.SetFilter(LoansReg."Outstanding Balance", '>%1', 0);
        LoansReg.SetRange(LoansReg.Posted, true);
        if LoansReg.Find('-') then begin
            repeat
                Amount += LoansReg."Amount in Arrears";
            until LoansReg.Next = 0;
            exit(Amount);
        end;
    end;
}
