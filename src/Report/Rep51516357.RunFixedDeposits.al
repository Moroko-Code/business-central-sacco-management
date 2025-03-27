report 51516357 "Run Fixed Deposits"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No_; "No.")
            {

            }
            trigger OnAfterGetRecord()
            var

                DocumentNo: Code[30];
                FixedInterest: Decimal;
                Expr3: Text[20];


            begin
                SGenSetup.Get();
                if FundsUSer.Get(UserId) then begin
                    TemplateName := FundsUSer."Receipt Journal Template";
                    BatchName := FundsUSer."Receipt Journal Batch";

                end;
                if PDate = 0D then begin
                    PDate := Today;
                end;

                SDATE := '..' + Format(PDate);
                DocumentNo := 'FD-' + Format(PDate);
                Expr3 := '<CM+30D>';
                cust.Reset;
                Cust.SetRange(Cust."No.", Customer."No.");
                Cust.SetFilter(Cust."Date Filter", SDATE);
                if Cust.Find('-') then begin
                    repeat
                        Cust.CalcFields(cust."Fixed deposit");
                        if cust."Fixed deposit" > 0 then begin
                            FixedInterest := (Cust."Fixed deposit" * (SGenSetup."Fixed Deposit Int Percentage" / 1200));

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, DocumentNo, LineNo, GenJournalLine."Transaction Type"::"Fixed Deposits Savings",
                             GenJournalLine."Account Type"::Customer, Cust."No.", PDate, -FixedInterest, 'BOSA',
                            'FiXED DEPOSIT', 'Fixed Deposit Interest- ' + Cust."No.", '');

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, DocumentNo, LineNo, GenJournalLine."Transaction Type"::" ",
                           GenJournalLine."Account Type"::"G/L Account", SGenSetup."Fixed Deposit A/C", PDate, FixedInterest, 'BOSA',
                          'FiXED DEPOSIT', 'Fixed Deposit Interest- ' + Cust."No.", '');
                        end;

                    until cust.Next = 0;

                end;
            end;

            trigger OnPreDataItem()
            begin
                if FundsUSer.Get(UserId) then begin
                    TemplateName := FundsUSer."Receipt Journal Template";
                    BatchName := FundsUSer."Receipt Journal Batch";
                end;

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", TemplateName);
                GenJournalLine.SetRange("Journal Batch Name", BatchName);
                GenJournalLine.DeleteAll;
            end;

            trigger OnPostDataItem()
            begin
                //Post New
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", TemplateName);
                GenJournalLine.SetRange("Journal Batch Name", BatchName);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                end;

            end;

        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(PDate; PDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Run Date';

                    }
                }
            }
        }


    }
    var
        FundsUSer: Record "Funds User Setup";
        SGenSetup: Record "Sacco General Set-Up";
        Cust: Record Customer;
        CustLedger: Record "Cust. Ledger Entry";
        SFactory: Codeunit "SURESTEP Factory";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        TemplateName: Code[30];
        PDate: Date;
        SDATE: Text[30];
        BatchName: Code[30];
}