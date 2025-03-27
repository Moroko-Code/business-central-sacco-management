pageextension 51516877 "BankAccountCardExt" extends "Bank Account Card"
{
    layout
    {
        addafter("Bank Acc. Posting Group")
        {
            field("Account Type"; "Account Type")
            {
                ApplicationArea = Basic;
            }
            field(CashierID; CashierID)
            {
                ApplicationArea = Basic;
            }
        }
    }
    trigger OnDeleteRecord(): Boolean
    var
        bankacount: Record "Bank Account";
        BankLedgEntry: record "Bank Account Ledger Entry";
    begin
        bankacount.Reset();
        bankacount.SetRange(bankacount."No.", "No.");
        bankacount.SetAutoCalcFields(bankacount.Balance);
        if bankacount.Find('-') then
            if bankacount.Balance <> 0 then
                Error('Prohibited! cannot delete a bank with entries')
            else
                if bankacount.Balance = 0 then begin
                    BankLedgEntry.Reset();
                    BankLedgEntry.SetRange(BankLedgEntry."Bank Account No.", bankacount."No.");
                    if BankLedgEntry.Find('-') then
                        Error('Prohibited! cannot delete a bank with entries');
                end;
    end;

    trigger OnOpenPage()
    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Accessed and read the bank accounts page no-' + Format("No.") + ' Name-' + Format(Name));
    end;

    trigger OnClosePage()
    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Closed bank accounts page no-' + Format("No.") + ' Name-' + Format(Name));
    end;

    var
        AuditLog: Codeunit "Audit Log Codeunit";
}