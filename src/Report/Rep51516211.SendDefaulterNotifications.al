report 51516211 "Send Defaulter Notifications"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            column(Loan__No_; "Loan  No.")
            {
            }
            trigger OnAfterGetRecord()
            var
                SmsBody: Text[250];
                ClientCode: code[30];
                Arreas: Decimal;

            begin
                //Send Sms Messages
                Arreas := 0;
                LoanRecord.Reset;
                LoanRecord.SetRange(LoanRecord."Loan  No.", "Loan  No.");
                if LoanRecord.Find('-') then
                    repeat
                        If LoanRecord."Amount in Arrears" > 0 then begin
                            ClientCode := LoanRecord."Client Code";
                            SmsBody := 'Dear' + ' ' + LoanRecord."Client Name" + ' ' + 'Note that your ' + LoanRecord."Loan Product Type Name" + ' ' + ' is in arrears of ' + Format(LoanRecord."Amount in Arrears");
                            Saccogensetup.FnSendSMS('DEFAULTER', SmsBody, ClientCode, GetPhoneNumber(ClientCode));
                        end;
                    until LoanRecord.Next = 0;

                //Send Emails
            end;
        }
    }
    var
        LoanRecord: Record "Loans Register";
        CustRecord: Record Customer;
        Saccogensetup: Codeunit "SURESTEP Factory";

    local procedure GetPhoneNumber(ClientCode: Code[20]): Text
    begin
        CustRecord.Reset();
        CustRecord.SetRange(CustRecord."No.", ClientCode);
        if CustRecord.Find('-') then
            exit(CustRecord."Phone No.");
    end;

    local procedure GetEmail(clientCode: Code[20]): Text
    begin
        CustRecord.Reset();
        CustRecord.SetRange(CustRecord."No.", clientCode);
        if CustRecord.Find('-') then
            exit(CustRecord."E-Mail");
    end;
}