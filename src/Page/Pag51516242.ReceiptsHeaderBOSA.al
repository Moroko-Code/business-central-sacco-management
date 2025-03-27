#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516242 "Receipts Header-BOSA"
{
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "Receipts & Payments";

    layout
    {
        area(content)
        {
            group(Transaction)
            {
                Caption = 'Transaction';
                field("Transaction No."; "Transaction No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Receipt Mode"; "Receipt Mode")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Allocated Amount"; "Allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Un allocated Amount"; "Un allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Employer No."; "Employer No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Teller Till / Bank  No.';
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque / Slip  No.';
                }
                field("Cheque Date"; "Cheque Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque / Slip  Date';
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Transaction Time"; "Transaction Time")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Insurance; Insuarance)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Suggest)
            {
                Caption = 'Suggest';
                action("Cash/Cheque Clearance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cash/Cheque Clearance';

                    trigger OnAction()
                    begin
                        Cheque := false;
                        //SuggestBOSAEntries();
                    end;
                }
                separator(Action1102760032)
                {
                }
                action("Suggest Payments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest Monthy Repayments';

                    trigger OnAction()
                    begin

                        TestField(Posted, false);
                        TestField("Account No.");
                        TestField(Amount);
                        //Cust.CALCFIELDS(Cust."Registration Fee Paid");

                        ReceiptAllocations.Reset;
                        ReceiptAllocations.SetRange(ReceiptAllocations."Document No", "Transaction No.");
                        ReceiptAllocations.DeleteAll;

                        if "Account Type" = "account type"::Customer then begin

                            BosaSetUp.Get();
                            RunBal := Amount;

                            if RunBal > 0 then begin

                                if Cust.Get("Account No.") then begin
                                    Cust.CalcFields(Cust."Registration Fee Paid");
                                    if Cust."Registration Fee Paid" = 0 then
                                        if Cust."Registration Date" > 20140103D then begin
                                            ReceiptAllocations.Init;
                                            ReceiptAllocations."Document No" := "Transaction No.";
                                            ReceiptAllocations."Member No" := "Account No.";
                                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Registration Fee";
                                            ReceiptAllocations."Loan No." := '';
                                            ReceiptAllocations.Amount := BosaSetUp."Registration Fee";
                                            //ReceiptAllocations."Interest Amount":=Loans."Interest Due";
                                            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount;
                                            ReceiptAllocations."Global Dimension 1 Code" := 'BOSA';
                                            ReceiptAllocations."Global Dimension 2 Code" := '01';
                                            ReceiptAllocations.Insert;
                                            RunBal := RunBal - ReceiptAllocations.Amount;
                                        end;
                                end;
                                //********** Mpesa Charges
                                if "Receipt Mode" = "receipt mode"::Mpesa then begin
                                    ReceiptAllocations.Init;
                                    ReceiptAllocations."Document No" := "Transaction No.";
                                    ReceiptAllocations."Member No" := "Account No.";
                                    ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::" ";
                                    ReceiptAllocations."Loan No." := '';

                                    // M Pesa Tarriff

                                    if Amount <= 2499 then
                                        ReceiptAllocations."Total Amount" := 55
                                    else
                                        if Amount <= 4999 then
                                            ReceiptAllocations."Total Amount" := 75
                                        else
                                            if Amount <= 9999 then
                                                ReceiptAllocations."Total Amount" := 105
                                            else
                                                if Amount <= 19999 then
                                                    ReceiptAllocations."Total Amount" := 130
                                                else
                                                    if Amount <= 34999 then
                                                        ReceiptAllocations."Total Amount" := 185
                                                    else
                                                        if Amount <= 49999 then
                                                            ReceiptAllocations."Total Amount" := 220
                                                        else
                                                            if Amount <= 70000 then
                                                                ReceiptAllocations."Total Amount" := 240
                                                            else
                                                                if Amount > 70000 then
                                                                    Error('Sorry the Maximum M - Pesa transaction Amount is Ksha. 70,000');

                                    ReceiptAllocations.Amount := ReceiptAllocations."Total Amount";
                                    ReceiptAllocations."Global Dimension 1 Code" := 'BOSA';
                                    ReceiptAllocations."Global Dimension 2 Code" := '01';
                                    ReceiptAllocations.Insert;
                                end;
                                //********** END Mpesa Charges

                               
                            end;
                            BosaSetUp.Get();


                            //Deposits Contribution
                            if Cust.Get("Account No.") then
                                if Cust."Monthly Contribution" > 0 then begin
                                    ReceiptAllocations.Init;
                                    ReceiptAllocations."Document No" := "Transaction No.";
                                    ReceiptAllocations."Member No" := "Account No.";
                                    ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::Loan;
                                    ReceiptAllocations."Loan No." := '';
                                    ReceiptAllocations.Amount := ROUND(Cust."Monthly Contribution", 0.01);
                                    ;
                                    ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount;
                                    ReceiptAllocations."Global Dimension 1 Code" := 'BOSA';
                                    ReceiptAllocations."Global Dimension 2 Code" := '01';
                                    ReceiptAllocations.Insert;
                                end;
                        end;

                        if "Account Type" = "account type"::Vendor then begin
                            if "Receipt Mode" = "receipt mode"::Mpesa then begin
                                ReceiptAllocations.Init;
                                ReceiptAllocations."Document No" := "Transaction No.";
                                ReceiptAllocations."Member No" := "Account No.";

                                ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::" ";
                                ReceiptAllocations."Total Amount" := Amount;
                                ReceiptAllocations."Loan No." := '';

                                // M Pesa Tarriff
                                MpesaCharge := 0;
                                if Amount <= 2499 then
                                    ReceiptAllocations."Total Amount" := 55
                                else
                                    if Amount <= 4999 then
                                        ReceiptAllocations."Total Amount" := 75
                                    else
                                        if Amount <= 9999 then
                                            ReceiptAllocations."Total Amount" := 105
                                        else
                                            if Amount <= 19999 then
                                                ReceiptAllocations."Total Amount" := 130
                                            else
                                                if Amount <= 34999 then
                                                    ReceiptAllocations."Total Amount" := 185
                                                else
                                                    if Amount <= 49999 then
                                                        ReceiptAllocations."Total Amount" := 220
                                                    else
                                                        if Amount <= 70000 then
                                                            ReceiptAllocations."Total Amount" := 240
                                                        else
                                                            if Amount > 70000 then
                                                                Error('Sorry the Maximum M - Pesa transaction Amount is Ksha. 70,000');
                                MpesaCharge := ReceiptAllocations."Total Amount";
                                ReceiptAllocations.Amount := ReceiptAllocations."Total Amount";

                                //ReceiptAllocations."Total Amount":=Amount;
                                ReceiptAllocations."Global Dimension 1 Code" := 'BOSA';
                                ReceiptAllocations."Global Dimension 2 Code" := '01';
                                ReceiptAllocations.Insert;
                            end;

                            //********** END Mpesa Charges

                            ReceiptAllocations.Init;
                            ReceiptAllocations."Document No" := "Transaction No.";
                            ReceiptAllocations."Member No" := "Account No.";
                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::" ";
                            //GenJournalLine.Description:= 'BT'+'-'+Remarks+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No.";
                            ReceiptAllocations."Loan No." := ' ';
                            ReceiptAllocations."Total Amount" := Amount;
                            ReceiptAllocations."Global Dimension 1 Code" := 'FOSA';
                            ReceiptAllocations."Global Dimension 2 Code" := '01';
                            ReceiptAllocations.Amount := ReceiptAllocations."Total Amount";
                            ReceiptAllocations.Insert;
                        end;
                        //VALIDATE("Allocated Amount");
                        CalcFields("Allocated Amount");
                        "Un allocated Amount" := (Amount - "Allocated Amount");
                        Modify;
                    end;
                }
            }
        }
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Post (F11)';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if FundsUser.Get(UserId) then begin
                        FundsUser.TestField(FundsUser."Receipt Journal Template");
                        FundsUser.TestField(FundsUser."Receipt Journal Batch");
                        JournalTemplate := FundsUser."Receipt Journal Template";
                        JournalBatch := FundsUser."Receipt Journal Batch";
                    end else
                        Error('User Account Not Setup for Posting');
                    if ("Receipt Mode" = "receipt mode"::Cash) and ("Transaction Date" <> Today) then
                        Error('You cannot post cash transactions with a date not today');

                    if Posted then
                        Error('This receipt is already posted');

                    TestField("Account No.");
                    TestField(Amount);
                    TestField("Employer No.");
                    //TESTFIELD("Cheque No.");
                    //TESTFIELD("Cheque Date");

                    if ("Account Type" = "account type"::"G/L Account") then
                        TransType := 'Withdrawal'
                    else
                        TransType := 'Deposit';

                    BOSABank := "Employer No.";
                    if ("Account Type" = "account type"::Customer) then
                        if Amount <> "Allocated Amount" then
                            Error('Receipt amount must be equal to the allocated amount.');

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                    GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                    GenJournalLine.DeleteAll;

                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := JournalTemplate;
                    GenJournalLine."Journal Batch Name" := JournalBatch;
                    GenJournalLine."Document No." := "Transaction No.";
                    GenJournalLine."External Document No." := "Cheque No.";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := "Employer No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    //GenJournalLine."Posting Date":="Cheque Date";
                    GenJournalLine."Posting Date" := "Transaction Date";
                    GenJournalLine.Description := 'BT-' + "Account No." + '-' + Remarks;
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := '01';
                    if TransType = 'Withdrawal' then
                        GenJournalLine.Amount := -Amount
                    else
                        GenJournalLine.Amount := Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    if ("Account Type" <> "account type"::Customer) then begin
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := JournalTemplate;
                        GenJournalLine."Journal Batch Name" := JournalBatch;
                        GenJournalLine."Document No." := "Transaction No.";
                        GenJournalLine."External Document No." := "Cheque No.";
                        GenJournalLine."Line No." := LineNo;
                        if "Account Type" = "account type"::"G/L Account" then
                            GenJournalLine."Account Type" := "Account Type"
                        else
                            // if "Account Type" = "account type"::Debtor then
                            //     GenJournalLine."Account Type" := "Account Type"
                            // else
                            if "Account Type" = "account type"::Vendor then
                                GenJournalLine."Account Type" := "Account Type"
                            else
                                if "Account Type" = "account type"::Customer then
                                    GenJournalLine."Account Type" := "Account Type";
                        GenJournalLine."Account No." := "Account No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        //GenJournalLine."Posting Date":="Cheque Date";
                        GenJournalLine."Posting Date" := "Transaction Date";
                        GenJournalLine.Description := 'BT-' + Name + '-' + "Account No." + '-' + Remarks;
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        if TransType = 'Withdrawal' then
                            GenJournalLine.Amount := Amount
                        else
                            GenJournalLine.Amount := -Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;

                    GenSetup.Get();

                    if ("Account Type" = "account type"::Customer) then begin

                        ReceiptAllocations.Reset;
                        ReceiptAllocations.SetRange(ReceiptAllocations."Document No", "Transaction No.");
                        if ReceiptAllocations.Find('-') then
                            repeat

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := JournalTemplate;
                                GenJournalLine."Journal Batch Name" := JournalBatch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := "Transaction No.";
                                GenJournalLine."External Document No." := "Cheque No.";
                                //GenJournalLine."Posting Date":="Cheque Date";
                                GenJournalLine."Posting Date" := "Transaction Date";
                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Repayment then begin
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := "Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine.Description := 'BT-' + Name + '-' + "Account No." + '-' + Remarks;
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := '01';
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");

                                end else begin
                                    if "Account Type" = "account type"::Vendor then begin
                                        GenJournalLine."Posting Date" := "Transaction Date";
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := '01';
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        //GenJournalLine.Description:=FORMAT(ReceiptAllocations."Transaction Type")+'-'+Remarks;
                                        //GenJournalLine.Description:='BT-'+Name+'-'+"Account No."+'-'+Remarks;
                                        //GenJournalLine.Description:='BT'+'-'+Remarks+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No.";

                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Account No." := ReceiptAllocations."Member No";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");

                                        if ("Receipt Mode" = "receipt mode"::Mpesa) then begin
                                            GenJournalLine.Amount := -Amount;
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                            GenJournalLine."Account No." := GenSetup."FOSA MPESA COmm A/C";
                                            GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type") + '-' + Remarks;
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                                            GenJournalLine."Bal. Account No." := "Account No.";
                                        end;
                                    end;

                                    if "Account Type" = "account type"::Customer then begin
                                        GenJournalLine."Posting Date" := "Transaction Date";
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := '01';
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                        GenJournalLine."Account No." := ReceiptAllocations."Member No";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        // if ("Receipt Mode" = "receipt mode"::Mpesa) and (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"FOSA Account") then begin
                                        //     GenJournalLine.Amount := -Amount;
                                        //     GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                        //     GenJournalLine."Account No." := GenSetup."FOSA MPESA COmm A/C";
                                        //     GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type") + '-' + Remarks;
                                        // end;
                                    end;
                                end;
                                //GenJournalLine."Prepayment date":=ReceiptAllocations."Prepayment Date";
                                //IF ("Mode of Payment"="Mode of Payment"::Mpesa) AND (ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::"Administration Fee") THEN
                                //GenJournalLine.Amount:=-ReceiptAllocations.Amount
                                //ELSE
                                GenJournalLine.Amount := -ReceiptAllocations.Amount;
                                GenJournalLine."Shortcut Dimension 1 Code" := ReceiptAllocations."Global Dimension 1 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine."Shortcut Dimension 2 Code" := ReceiptAllocations."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                GenJournalLine.Validate(GenJournalLine.Amount);

                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee" then
                                    GenJournalLine.Description := 'Registration' + '-' + Remarks + '-' + Format("Receipt Mode") + '-' + "Cheque No."
                                else
                                    // if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Interest Paid" then
                                    //     GenJournalLine.Description := 'Repayment' + '-' + Remarks + '-' + Format("Receipt Mode") + '-' + "Cheque No."
                                    // else

                                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Deposit Contribution" then
                                            GenJournalLine.Description := 'Deposit' + '-' + Remarks + '-' + Format("Receipt Mode") + '-' + "Cheque No."

                                        else
                                            GenJournalLine.Description := 'BT' + '-' + Remarks + '-' + Format("Receipt Mode") + '-' + "Cheque No.";

                                //description
                                GenJournalLine."Transaction Type" := ReceiptAllocations."Transaction Type";
                                GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            until ReceiptAllocations.Next = 0;
                    end;

                    //Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                    GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    //Post New

                    Posted := true;
                    Modify;
                    BOSARcpt.Reset;
                    BOSARcpt.SetRange(BOSARcpt."Transaction No.", "Transaction No.");
                    if BOSARcpt.Find('-') then
                        if/* ("Mode of Payment"<>"Mode of Payment"::"Standing order") AND */
                          //("Mode of Payment"<>"Mode of Payment"::"Direct Debit") AND
                           ("Receipt Mode" <> "receipt mode"::Mpesa) then begin

                            BOSARcpt.Reset;
                            BOSARcpt.SetRange(BOSARcpt."Transaction No.", "Transaction No.");
                            if BOSARcpt.Find('-') then
                                Report.run(50387, false, true, BOSARcpt);
                        end;
                end;
            }
            action("Reprint Frecipt")
            {
                ApplicationArea = Basic;
                Caption = 'Reprint Receipt';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    TestField(Posted);

                    BOSARcpt.Reset;
                    BOSARcpt.SetRange(BOSARcpt."Transaction No.", "Transaction No.");
                    if BOSARcpt.Find('-') then
                        Report.run(50387, true, true, BOSARcpt)
                end;
            }
        }
    }

    var
        GenJournalLine: Record "Gen. Journal Line";
        InterestPaid: Decimal;
        PaymentAmount: Decimal;
        RunBal: Decimal;
        Recover: Boolean;
        Cheque: Boolean;
        ReceiptAllocations: Record "Receipt Allocation";
        Loans: Record "Loans Register";
        Commision: Decimal;
        LOustanding: Decimal;
        TotalCommision: Decimal;
        TotalOustanding: Decimal;
        Cust: Record Customer;
        BOSABank: Code[20];
        LineNo: Integer;
        BOSARcpt: Record "Receipts & Payments";
        TellerTill: Record "Bank Account";
        CurrentTellerAmount: Decimal;
        TransType: Text[30];
        RCPintdue: Decimal;
        Text001: label 'This member has reached a maximum share contribution of Kshs. 5,000/=. Do you want to post this transaction as shares contribution?';
        BosaSetUp: Record "Sacco General Set-Up";
        MpesaCharge: Decimal;
        CustPostingGrp: Record "Customer Posting Group";
        MpesaAc: Code[30];
        GenSetup: Record "Sacco General Set-Up";
        JournalTemplate: Code[20];
        JournalBatch: Code[20];
        FundsUser: Record "Funds User Setup";

    local procedure AllocatedAmountOnDeactivate()
    begin
        CurrPage.Update := true;
    end;
}
