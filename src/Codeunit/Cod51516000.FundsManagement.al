#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516000 "Funds Management"
{
    procedure PostPayment("Payment Header": Record "Payment Header"; "Journal Template": Code[20]; "Journal Batch": Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        PaymentLine: Record "Payment Line";
        PaymentHeader: Record "Payment Header";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        PaymentLine2: Record "Payment Line";
        PaymentHeader2: Record "Payment Header";
    begin
        //Check if Document Already Posted
        BankLedgers.Reset;
        BankLedgers.SetRange("Document No.", "Payment Header"."No.");
        if BankLedgers.FindFirst then
            Error('Document No:' + Format("Payment Header"."No.") + ' already exists in Bank No:' + Format("Payment Header"."Bank Account"));
        //end check

        PaymentHeader.TransferFields("Payment Header", true);
        SourceCode := 'PAYMENTJNL';

        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then
            GenJnlLine.DeleteAll;
        //End Delete

        LineNo := 1000;
        //********************************************Add to Bank(Payment Header)*******************************************************//
        PaymentHeader.CalcFields(PaymentHeader."Net Amount");
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
        GenJnlLine."Document No." := PaymentHeader."No.";
        GenJnlLine."External Document No." := PaymentHeader."Cheque No";
        GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
        GenJnlLine."Account No." := PaymentHeader."Bank Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        // GenJnlLine."Transaction Type":=
        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
        GenJnlLine.Validate("Currency Factor");
        GenJnlLine.Amount := -(PaymentHeader."Net Amount");  //Credit Amount
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := CopyStr(PaymentHeader."Payment Description", 1, 50);
        GenJnlLine.Validate(GenJnlLine.Description);
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;

        PaymentLine.Reset;
        PaymentLine.SetRange("Document No", PaymentHeader."No.");
        PaymentLine.SetFilter(Amount, '<>%1', 0);
        if PaymentLine.FindSet then
            repeat
                //****************************************Add Line NetAmounts***********************************************************//
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                GenJnlLine."Document No." := PaymentLine."Document No";

                GenJnlLine."Posting Group" := PaymentLine."Default Grouping";
                GenJnlLine."Account Type" := PaymentLine."Account Type";
                GenJnlLine."Account No." := PaymentLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := PaymentHeader."Cheque No";
                GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                GenJnlLine.Validate("Currency Factor");
                GenJnlLine.Amount := PaymentLine."Net Amount";  //Debit Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Transaction Type" := PaymentLine."Transaction Type";
                GenJnlLine."Loan No" := PaymentLine."Loan No.";
                GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Gen. Bus. Posting Group" := PaymentLine."Gen. Bus. Posting Group";
                GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                GenJnlLine."Gen. Prod. Posting Group" := PaymentLine."Gen. Prod. Posting Group";
                GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                GenJnlLine."VAT Bus. Posting Group" := PaymentLine."VAT Bus. Posting Group";
                GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                GenJnlLine."VAT Prod. Posting Group" := PaymentLine."VAT Prod. Posting Group";
                GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                GenJnlLine."Shortcut Dimension 1 Code" := PaymentLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PaymentLine."Global Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                GenJnlLine.Description := PaymentLine."Payment Description";
                GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;

                if PaymentLine."VAT Code" <> '' then begin
                    TaxCodes.Reset;
                    TaxCodes.SetRange(TaxCodes."Tax Code", PaymentLine."VAT Code");
                    if TaxCodes.FindFirst then begin
                        TaxCodes.TestField(TaxCodes."Account No");
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document No." := PaymentLine."Document No";
                        //GenJnlLine."Posting Group":=PaymentLine."Default Grouping";    //Posting Group
                        GenJnlLine."External Document No." := PaymentHeader."Cheque No";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                        GenJnlLine.Validate("Currency Factor");
                        GenJnlLine."Loan No" := PaymentLine."Loan No.";
                        GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::" ";
                        GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                        GenJnlLine."Gen. Bus. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine.Amount := -(PaymentLine."VAT Amount");   //Credit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Transaction Type" := PaymentLine."Transaction Type";
                        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentLine."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentLine."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := CopyStr('VAT:' + Format(PaymentLine."Account Type") + '::' + Format(PaymentLine."Account Name"), 1, 50);
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;

                        //VAT Balancing goes to Vendor
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        // if CustomerLinesExist(PaymentHeader) then
                        //     GenJnlLine."Document Type" := GenJnlLine."document type"::" "
                        // else
                        //     GenJnlLine."Document Type" := GenJnlLine."document type"::Payment;
                        GenJnlLine."Document No." := PaymentLine."Document No";
                        GenJnlLine."Posting Group" := PaymentLine."Default Grouping";    //Posting Group
                        GenJnlLine."External Document No." := PaymentHeader."Cheque No";
                        GenJnlLine."Account Type" := PaymentLine."Account Type";
                        GenJnlLine."Account No." := PaymentLine."Account No.";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Transaction Type" := PaymentLine."Transaction Type";
                        GenJnlLine."Loan No" := PaymentLine."Loan No.";
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                        GenJnlLine.Validate("Currency Factor");
                        GenJnlLine.Amount := PaymentLine."VAT Amount";   //Debit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentLine."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentLine."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := CopyStr('VAT:' + Format(PaymentLine."Account Type") + '::' + Format(PaymentLine."Account Name"), 1, 50);
                        // GenJnlLine."Applies-to Doc. Type" := GenJnlLine."applies-to doc. type"::Invoice;
                        GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                        GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;
                    end;
                end;
                if PaymentLine."W/TAX Code" <> '' then begin
                    TaxCodes.Reset;
                    TaxCodes.SetRange(TaxCodes."Tax Code", PaymentLine."W/TAX Code");
                    if TaxCodes.FindFirst then begin
                        TaxCodes.TestField(TaxCodes."Account No");
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Document No." := PaymentLine."Document No";
                        //GenJnlLine."Posting Group":=PaymentLine."Default Grouping";    //Posting Group
                        GenJnlLine."External Document No." := PaymentHeader."Cheque No";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Loan No" := PaymentLine."Loan No.";
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                        GenJnlLine.Validate("Currency Factor");
                        GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::" ";
                        GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                        GenJnlLine."Gen. Bus. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine.Amount := -(PaymentLine."W/TAX Amount");   //Credit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentLine."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentLine."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := CopyStr('W/TAX:' + Format(PaymentLine."Account Type") + '::' + Format(PaymentLine."Account Name"), 1, 50);
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;

                        //W/TAX Balancing goes to Vendor
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        // if CustomerLinesExist(PaymentHeader) then
                        //     GenJnlLine."Document Type" := GenJnlLine."document type"::" "
                        // else
                        //     GenJnlLine."Document Type" := GenJnlLine."document type"::Payment;
                        GenJnlLine."Document No." := PaymentLine."Document No";
                        GenJnlLine."Posting Group" := PaymentLine."Default Grouping";    //Posting Group
                        GenJnlLine."External Document No." := PaymentHeader."Cheque No";
                        GenJnlLine."Account Type" := PaymentLine."Account Type";
                        GenJnlLine."Loan No" := PaymentLine."Loan No.";
                        GenJnlLine."Account No." := PaymentLine."Account No.";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                        GenJnlLine.Validate("Currency Factor");
                        GenJnlLine.Amount := PaymentLine."W/TAX Amount";   //Debit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Transaction Type" := PaymentLine."Transaction Type";
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentLine."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentLine."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := CopyStr('W/TAX:' + Format(PaymentLine."Account Type") + '::' + Format(PaymentLine."Account Name"), 1, 50);
                        // GenJnlLine."Applies-to Doc. Type" := GenJnlLine."applies-to doc. type"::Invoice;
                        // GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                        // GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                        // GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;
                    end;
                end;

            //*************************************End Add W/TAX Amounts************************************************************//

            //*************************************Add Retention Amounts************************************************************//
            //***********************************End Add Retention Amounts**********************************************************//
            until PaymentLine.Next = 0;

        //*********************************************End Add Payment Lines************************************************************//
        Commit;
        //********************************************Post the Journal Lines************************************************************//
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", "Journal Template");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
        AdjustGenJnl.Run(GenJnlLine);
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnlLine);
        //***************************************************End Posting****************************************************************//
        Commit;
        //*************************************************Update Document**************************************************************//
        BankLedgers.Reset;
        BankLedgers.SetRange("Document No.", PaymentHeader."No.");
        if BankLedgers.FindFirst then begin
            PaymentHeader2.Reset;
            PaymentHeader2.SetRange("No.", PaymentHeader."No.");
            if PaymentHeader2.FindFirst then begin
                PaymentHeader2.Status := PaymentHeader2.Status::Posted;
                PaymentHeader2.Posted := true;
                PaymentHeader2."Posted By" := UserId;
                PaymentHeader2."Date Posted" := Today;
                PaymentHeader2."Time Posted" := Time;
                PaymentHeader2.Modify;
                PaymentLine2.Reset;
                PaymentLine2.SetRange(PaymentLine2."Document No", PaymentHeader2."No.");
                if PaymentLine2.FindSet then
                    repeat
                        PaymentLine2.Status := PaymentLine2.Status::Posted;
                        PaymentLine2.Posted := true;
                        PaymentLine2."Posted By" := UserId;
                        PaymentLine2."Date Posted" := Today;
                        PaymentLine2."Time Posted" := Time;
                        PaymentLine2.Modify;
                    until PaymentLine2.Next = 0;
            end;
        end;
        //***********************************************End Update Document************************************************************//
    end;

    procedure PostReceipt("Receipt Header": Record "Receipt Header"; "Journal Template": Code[20]; "Journal Batch": Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        ReceiptLine: Record "Receipt Line";
        ReceiptHeader: Record "Receipt Header";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        ReceiptLine2: Record "Receipt Line";
        ReceiptHeader2: Record "Receipt Header";
    begin
        ReceiptHeader.TransferFields("Receipt Header", true);
        SourceCode := 'RECEIPTJNL';

        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then
            GenJnlLine.DeleteAll;
        //End Delete

        LineNo := 1000;
        //********************************************Add to Bank(Payment Header)*******************************************************//
        ReceiptHeader.CalcFields(ReceiptHeader."Total Amount");
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
        GenJnlLine."Document No." := ReceiptHeader."No.";
        GenJnlLine."Document Type" := GenJnlLine."document type"::" ";
        GenJnlLine."External Document No." := ReceiptHeader."Cheque No";
        GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
        GenJnlLine."Account No." := ReceiptHeader."Bank Code";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        GenJnlLine."Currency Factor" := ReceiptHeader."Currency Factor";
        GenJnlLine.Validate("Currency Factor");
        GenJnlLine.Amount := ReceiptHeader."Total Amount";  //Debit Amount
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
        GenJnlLine.ValidateShortcutDimCode(7, ReceiptHeader."Shortcut Dimension 7 Code");
        GenJnlLine.ValidateShortcutDimCode(8, ReceiptHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := CopyStr(ReceiptHeader.Description, 1, 50);
        GenJnlLine.Validate(GenJnlLine.Description);
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
        //************************************************End Add to Bank***************************************************************//

        //***********************************************Add Receipt Lines**************************************************************//
        ReceiptLine.Reset;
        ReceiptLine.SetRange(ReceiptLine."Document No", ReceiptHeader."No.");
        ReceiptLine.SetFilter(ReceiptLine.Amount, '<>%1', 0);
        if ReceiptLine.FindSet then
            repeat
                //****************************************Add Line NetAmounts***********************************************************//
                LineNo := LineNo + 1;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
                GenJnlLine."Document No." := ReceiptLine."Document No";
                GenJnlLine."Document Type" := GenJnlLine."document type"::" ";
                GenJnlLine."Account Type" := ReceiptLine."Account Type";
                GenJnlLine."Account No." := ReceiptLine."Account Code";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := ReceiptHeader."Cheque No";
                GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine."Currency Factor" := ReceiptHeader."Currency Factor";
                GenJnlLine.Validate("Currency Factor");
                GenJnlLine.Amount := -(ReceiptLine.Amount);  //Credit Amount
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Gen. Bus. Posting Group" := ReceiptLine."Gen. Bus. Posting Group";
                GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                GenJnlLine."Gen. Prod. Posting Group" := ReceiptLine."Gen. Prod. Posting Group";
                GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                GenJnlLine."VAT Bus. Posting Group" := ReceiptLine."VAT Bus. Posting Group";
                GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                GenJnlLine."VAT Prod. Posting Group" := ReceiptLine."VAT Prod. Posting Group";
                GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
                GenJnlLine.ValidateShortcutDimCode(7, ReceiptHeader."Shortcut Dimension 7 Code");
                GenJnlLine.ValidateShortcutDimCode(8, ReceiptHeader."Shortcut Dimension 8 Code");
                GenJnlLine.Description := ReceiptLine.Description;//COPYSTR(ReceiptHeader.Description,1,50);
                GenJnlLine.Validate(GenJnlLine.Description);
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;
                //*************************************End add Line NetAmounts**********************************************************//

                //****************************************Add VAT Amounts***************************************************************//
                if ReceiptLine."VAT Code" <> '' then begin
                    TaxCodes.Reset;
                    TaxCodes.SetRange(TaxCodes."Tax Code", ReceiptLine."VAT Code");
                    if TaxCodes.FindFirst then begin
                        TaxCodes.TestField(TaxCodes."Account No");
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
                        GenJnlLine."Document No." := ReceiptLine."Document No";
                        // GenJnlLine."Document Type":=GenJnlLine."document type"::"7";
                        GenJnlLine."External Document No." := ReceiptHeader."Cheque No";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine."Currency Factor" := ReceiptHeader."Currency Factor";
                        GenJnlLine.Validate("Currency Factor");
                        GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::" ";
                        GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                        GenJnlLine."Gen. Bus. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine.Amount := -(ReceiptLine."VAT Amount");   //Credit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, ReceiptHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, ReceiptHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := CopyStr('VAT:' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"), 1, 50);
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;

                        //VAT Balancing goes to Vendor
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
                        GenJnlLine."Document No." := ReceiptLine."Document No";
                        // GenJnlLine."Document Type":=GenJnlLine."document type"::"7";
                        GenJnlLine."External Document No." := ReceiptHeader."Cheque No";
                        GenJnlLine."Account Type" := ReceiptLine."Account Type";
                        GenJnlLine."Account No." := ReceiptLine."Account Code";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine."Currency Factor" := ReceiptHeader."Currency Factor";
                        GenJnlLine.Validate("Currency Factor");
                        GenJnlLine.Amount := ReceiptLine."VAT Amount";   //Debit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, ReceiptHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, ReceiptHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := CopyStr('VAT:' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"), 1, 50);
                        GenJnlLine."Interest Code" := ReceiptHeader."Interest Code";
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;
                    end;
                end;
                //*************************************End Add VAT Amounts**************************************************************//

                //****************************************Add W/TAX Amounts*************************************************************//
                if ReceiptLine."W/TAX Code" <> '' then begin
                    TaxCodes.Reset;
                    TaxCodes.SetRange(TaxCodes."Tax Code", ReceiptLine."W/TAX Code");
                    if TaxCodes.FindFirst then begin
                        TaxCodes.TestField(TaxCodes."Account No");
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
                        GenJnlLine."Document No." := ReceiptLine."Document No";
                        //GenJnlLine."Document Type":=GenJnlLine."document type"::"7";
                        GenJnlLine."External Document No." := ReceiptHeader."Cheque No";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine."Currency Factor" := ReceiptHeader."Currency Factor";
                        GenJnlLine.Validate("Currency Factor");
                        GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::" ";
                        GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                        GenJnlLine."Gen. Bus. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine.Amount := -(ReceiptLine."W/TAX Amount");   //Credit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, ReceiptHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, ReceiptHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := CopyStr('W/TAX:' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"), 1, 50);
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;

                        //W/TAX Balancing goes to Vendor
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
                        GenJnlLine."Document No." := ReceiptLine."Document No";
                        // GenJnlLine."Document Type":=GenJnlLine."document type"::"7";
                        GenJnlLine."External Document No." := ReceiptHeader."Cheque No";
                        GenJnlLine."Account Type" := ReceiptLine."Account Type";
                        GenJnlLine."Account No." := ReceiptLine."Account Code";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine."Currency Factor" := ReceiptHeader."Currency Factor";
                        GenJnlLine.Validate("Currency Factor");
                        GenJnlLine.Amount := ReceiptLine."W/TAX Amount";   //Debit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, ReceiptHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, ReceiptHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := CopyStr('W/TAX:' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"), 1, 50);
                        GenJnlLine."Interest Code" := ReceiptHeader."Interest Code";
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;
                    end;
                end;

                //*************************************End Add W/TAX Amounts************************************************************//

                //*************************************Add Retention Amounts************************************************************//
                //***********************************End Add Retention Amounts**********************************************************//

                //****************************************Add Legal Amounts***************************************************************//
                if ReceiptLine."Legal Fee Code" <> '' then begin
                    ReceiptLine.TestField(ReceiptLine."Account Type", ReceiptLine."account type"::Investor);//Applies to investor Accounts only
                    TaxCodes.Reset;
                    TaxCodes.SetRange("Tax Code", ReceiptLine."Legal Fee Code");
                    if TaxCodes.FindFirst then begin
                        TaxCodes.TestField("Account No");
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
                        GenJnlLine."Document No." := ReceiptLine."Document No";
                        GenJnlLine."External Document No." := ReceiptHeader."Cheque No";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine."Currency Factor" := ReceiptHeader."Currency Factor";
                        GenJnlLine.Validate("Currency Factor");
                        GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::" ";
                        GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                        GenJnlLine."Gen. Bus. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group" := '';
                        GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                        ReceiptLine.TestField(ReceiptLine."Legal Fee Amount");
                        GenJnlLine.Amount := -(ReceiptLine."Legal Fee Amount");   //Credit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, ReceiptHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, ReceiptHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := CopyStr('LEGAL FEE:' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"), 1, 50);
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;
                        //Legal Balancing goes to Investor
                        LineNo := LineNo + 1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
                        GenJnlLine."Document No." := ReceiptLine."Document No";
                        GenJnlLine."External Document No." := ReceiptHeader."Cheque No";
                        GenJnlLine."Account Type" := ReceiptLine."Account Type";
                        GenJnlLine."Account No." := ReceiptLine."Account Code";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine."Currency Factor" := ReceiptHeader."Currency Factor";
                        GenJnlLine.Validate("Currency Factor");
                        GenJnlLine.Amount := ReceiptLine."Legal Fee Amount";   //Debit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, ReceiptHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, ReceiptHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := CopyStr('LEGAL FEE:' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"), 1, 50);
                        GenJnlLine."Interest Code" := ReceiptHeader."Interest Code";
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;
                    end;
                end;
            //*************************************End Add Legal Amounts**************************************************************//
            until ReceiptLine.Next = 0;

        //*********************************************End Add Payment Lines************************************************************//
        Commit;
        //********************************************Post the Journal Lines************************************************************//
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", "Journal Template");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        AdjustGenJnl.Run(GenJnlLine);
        //Now Post the Journal Lines
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnlLine);
        //***************************************************End Posting****************************************************************//
        Commit;
        //*************************************************Update Document**************************************************************//
        BankLedgers.Reset;
        BankLedgers.SetRange("Document No.", ReceiptHeader."No.");
        if BankLedgers.FindFirst then begin
            ReceiptHeader2.Reset;
            ReceiptHeader2.SetRange("No.", ReceiptHeader."No.");
            if ReceiptHeader2.FindFirst then begin
                ReceiptHeader2.Status := ReceiptHeader2.Status::Posted;
                ReceiptHeader2.Posted := true;
                ReceiptHeader2."Posted By" := UserId;
                ReceiptHeader2."Date Posted" := Today;
                ReceiptHeader2."Time Posted" := Time;
                ReceiptHeader2.Modify;
                ReceiptLine2.Reset;
                ReceiptLine2.SetRange("Document No", ReceiptHeader2."No.");
                if ReceiptLine2.FindSet then
                    repeat
                        ReceiptLine2.Status := ReceiptLine2.Status::Posted;
                        ReceiptLine2.Posted := true;
                        ReceiptLine2."Posted By" := UserId;
                        ReceiptLine2."User ID" := UserId;
                        ReceiptLine2."Date Posted" := Today;
                        ReceiptLine2."Time Posted" := Time;
                        ReceiptLine2.Modify();
                    until ReceiptLine2.Next = 0;
            end;
        end;

        //***********************************************End Update Document************************************************************//
    end;

    procedure PostPropertyReceipt("Receipt Header": Record "Receipt Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; "Property No": Code[20]; Receipt: Code[20]; Cust: Code[20]; CustName: Text[50]; Amount: Decimal): Boolean
    var
        ReceiptLine: Record "Receipt Line";
        ReceiptHeader: Record "Receipt Header";
        ReceiptLine2: Record "Receipt Line";
        ReceiptHeader2: Record "Receipt Header";
    begin
        //Post the Receipt
        PostReceipt("Receipt Header", "Journal Template", "Journal Batch");
        Commit;
        //Update Property
        if UpdateProperty("Property No", Receipt, Cust, CustName, Amount) then
            exit(true)
        else
            exit(false);
    end;

    procedure PostFundsTransfer()
    begin
    end;

    procedure PostImprest()
    begin
    end;

    procedure PostImprestAccounting()
    begin
    end;

    procedure PostFundsClaim()
    begin
    end;

    local procedure CustomerLinesExist("Payment Header": Record "Payment Header"): Boolean
    var
        "Payment Line": Record "Payment Line";
        "Payment Line2": Record "Payment Line";
    begin
        "Payment Line".Reset;
        "Payment Line".SetRange("Document No", "Payment Header"."No.");
        if "Payment Line".FindFirst then
            if "Payment Line"."Account Type" = "Payment Line"."account type"::Customer then
                exit(true)
            else begin
                "Payment Line2".Reset;
                "Payment Line2".SetRange("Document No", "Payment Header"."No.");
                "Payment Line2".SetFilter("Net Amount", '<%1', 0);
                if "Payment Line2".FindFirst then
                    exit(true)
                else
                    exit(false)
            end;
    end;

    local procedure InsertInvestorLedger(InvestorNo: Code[20]; InterestCode: Code[20]; Amount: Decimal; "Amount(LCY)": Decimal; ReceiptNo: Code[20]; PostingDate: Date)
    var
        InvestorLedger: Record "Investor Amounts Ledger";
    begin
        InvestorLedger.Reset;
        InvestorLedger."Investor No" := InvestorNo;
        InvestorLedger."Principle Amount" := Amount;
        InvestorLedger."Principle Amount(LCY)" := "Amount(LCY)";
        InvestorLedger.Date := PostingDate;
        InvestorLedger.Day := Date2dmy(PostingDate, 1);
        InvestorLedger.Month := Date2dmy(PostingDate, 2);
        InvestorLedger.Year := Date2dmy(PostingDate, 3);
        InvestorLedger."Receipt No" := ReceiptNo;
        InvestorLedger."Interest Rate" := InterestCode;
        InvestorLedger.Insert;
    end;

    local procedure UpdateProperty(PropertyCode: Code[20]; "Receipt No": Code[20]; "Customer No": Code[20]; "Customer Name": Text[50]; Amount: Decimal): Boolean
    var
        FA: Record "Fixed Asset";
    begin
        FA.Reset;
        FA.SetRange("No.", PropertyCode);
        if FA.FindFirst then begin
            FA.Receipted := true;
            FA."Receipt No" := "Receipt No";
            FA."Customer No" := "Customer No";
            FA."Customer Name" := "Customer Name";
            FA."Customer Balance" := FA."Customer Balance" - Amount;
            if FA.Modify then begin
                Message('Property Payment Successfull. Customer:' + Format("Customer Name"));
                exit(true);
            end else
                exit(false);
        end;
    end;

    var
        TaxCodes: Record "Funds Tax Codes";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        DocPrint: Codeunit "Document-Print";
        DActivity: Code[10];
        DBranch: Code[50];
}
