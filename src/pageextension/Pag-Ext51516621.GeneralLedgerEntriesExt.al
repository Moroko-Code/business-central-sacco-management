pageextension 51516621 "General Ledger Entries Ext" extends "General Ledger Entries"
{
    layout
    {
        addbefore(Amount)
        {
            field("Debit Amounts"; "Debit Amount")
            {
                ApplicationArea = Basic;
            }
            field("Credit Amounts"; "Credit Amount")
            {
                ApplicationArea = Basic;
            }
            // field(RunningBalance; CalcRunningAccBalance.GetGLAccBalance(Rec))
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Running Balance';
            //     ToolTip = 'Specifies the running balance.';
            // }
            field("Reverse"; Reversed)
            {
                Caption = 'Reversed';
                ApplicationArea = Basic;
            }
            field("ExternalDocument No."; "External Document No.")
            {
                Caption = 'External Document No:';
                ApplicationArea = Basic;
            }
            field("UserID"; "User ID")
            {
                Caption = 'User ID';
                ApplicationArea = Basic;
            }
        }
        addafter("Posting Date")
        {
        }
        modify("External Document No.")
        {
            Visible = false;
        }
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        modify(IncomingDocAttachFactBox)
        {
            Visible = false;
        }
        modify(GLEntriesPart)
        {
            Visible = false;
        }
        modify(Control1900383207)
        {
            Visible = false;
        }
        modify(Control1905767507)
        {
            Visible = false;
        }
    }
    var
    // CalcRunningAccBalance: Codeunit "System General Setup";

    trigger OnAfterGetRecord()
    begin
        // RunningBal := 0;
        // GLEntryTable.Reset();
        // GLEntryTable.SetRange(GLEntryTable."G/L Account No.", "G/L Account No.");
        // if GLEntryTable.Find('-') then begin
        //     RunningBal := FnGetSumLessTheGLEntryNo(GLEntryTable."Entry No.", GLEntryTable."G/L Account No.")
        // end;
    end;

    local procedure FnGetSumLessTheGLEntryNo(EntryNo: Integer; GLAccountNo: Code[20]): Decimal
    var
        GLEntryTable: Record "G/L Entry";
        TotalSum: Decimal;
    begin
        TotalSum := 0;
        GLEntryTable.Reset();
        GLEntryTable.SetRange(GLEntryTable."G/L Account No.", GLAccountNo);
        GLEntryTable.SetFilter(GLEntryTable."Entry No.", '<%1', EntryNo);
        if GLEntryTable.Find('-') then
            repeat
                TotalSum += GLEntryTable.Amount;
            until GLEntryTable.Next = 0;
        exit(GLEntryTable.Amount);
    end;
}
