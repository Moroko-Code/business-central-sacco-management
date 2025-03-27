#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516281 "Transaction Slip - Deposits"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/TransactionSlipDeposits.rdlc';

    dataset
    {
        dataitem(Transactions; Transactions)
        {
            DataItemTableView = sorting(No);
            RequestFilterFields = No;
            column(ReportForNavId_5806; 5806)
            {
            }
            column(Transactions_Transactions__Branch_Refference_; Transactions."Branch Refference")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(Transactions_Transactions__Branch_Refference__Control1102755000; Transactions."Branch Refference")
            {
            }
            column(CompanyInfo_Name_Control1102755001; CompanyInfo.Name)
            {
            }
            column(Co_Address; CompanyInfo.Address)
            {
            }
            column(Co_Telephone; CompanyInfo."Phone No.")
            {
            }
            column(COmpanypic; CompanyInfo.Picture)
            {
            }
            column(Transactions__Cheque_No_; "Cheque No")
            {
            }
            column(Transactions_Amount; Amount)
            {
            }
            column(Transactions__Account_Name_; "Account Name")
            {
            }
            column(Transactions__Account_No_; "Account No")
            {
            }
            column(Account__BOSA_Account_No_; Account."BOSA Account No")
            {
            }
            column(Transactions_Transactions__Transaction_Time_; Transactions."Transaction Time")
            {
            }
            column(Transactions__Transaction_Date_; "Transaction Date")
            {
            }
            column(Transactions_No; No)
            {
            }
            column(Transactions_Type; Type)
            {
            }
            column(Transactions_Transactions_Cashier; Transactions.Cashier)
            {
            }
            column(Description_Transactions; Transactions.Description)
            {
            }
            column(DUPLICATECaption; DUPLICATECaptionLbl)
            {
            }
            column(Transactions__Cheque_No_Caption; FieldCaption("Cheque No"))
            {
            }
            column(Amount_received__Caption; Amount_received__CaptionLbl)
            {
            }
            column(Account_Name_Caption; Account_Name_CaptionLbl)
            {
            }
            column(Account_No_Caption; Account_No_CaptionLbl)
            {
            }
            column(Member_No_Caption; Member_No_CaptionLbl)
            {
            }
            column(Time_Caption; Time_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Transaction_No_Caption; Transaction_No_CaptionLbl)
            {
            }
            column(Deposited_By_______________________________________Caption; Deposited_By_______________________________________CaptionLbl)
            {
            }
            column(You_were_served_by__Caption; You_were_served_by__CaptionLbl)
            {
            }
            column(THANK_YOUCaption; THANK_YOUCaptionLbl)
            {
            }
            column(Better_life_for_our_members_globallyCaption; Better_life_for_our_members_globallyCaptionLbl)
            {
            }
            column(Transactions_Transaction_Type; "Transaction Type")
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            dataitem(UnknownTable51516300; "Transaction Charges")
            {
                DataItemLink = "Transaction Type" = field("Transaction Type");
                column(ReportForNavId_8541; 8541)
                {
                }
                column(Transaction_Charges_Description; Description)
                {
                }
                column(Transaction_Charges__Charge_Amount_; "Charge Amount")
                {
                }
                column(Transaction_Charges_Transaction_Type; "Transaction Type")
                {
                }
                column(Transaction_Charges_Charge_Code; "Charge Code")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                ATMBalance := 0;

                //"Transactions 1".CALCFIELDS("Transactions 1"."Book Balance");

                LoanGuaranteed := 0;
                UnClearedBalance := 0;
                TotalGuaranted := 0;

                TransactionCharges.Reset;
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");

                TCharges := 0;
                AvailableBalance := 0;
                MinAccBal := 0;

                //CALCFIELDS("Book Balance");

                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code, "Account Type");

                if AccountTypes.Find('-') then begin
                    MinAccBal := AccountTypes."Minimum Balance";
                    FeeBelowMinBal := AccountTypes."Fee Below Minimum Balance";
                end;

                if Posted = false then begin

                    if TransactionCharges.Find('-') then
                        repeat

                            ////////
                            if TransactionCharges."Use Percentage" = true then begin
                                if TransactionCharges."Percentage of Amount" = 0 then
                                    Error('Percentage of amount cannot be zero.');
                                //USE BOOK BALANCE FOR ESTIMATING PERCENTAGE OF AMOUNT
                                TCharges := TCharges + (TransactionCharges."Percentage of Amount" / 100) * "Book Balance";
                                //TCharges:=TCharges+(TransactionCharges."Percentage of Amount"/100)*Amount;
                            end
                            else
                                TCharges := TCharges + TransactionCharges."Charge Amount";
                        /////////

                        //TCharges:=TCharges+TransactionCharges."Charge Amount";
                        until TransactionCharges.Next = 0;

                    TransactionCharges.Reset;

                    ///// CHECK LAST WITHDRAWAL DATE AND FIND IF CHARGE IS APPLICABLE AND CHARGE
                    IntervalPenalty := 0;
                    Members.Reset;
                    if Members.Get("Account No") then
                        if Members.Status <> Members.Status::New then
                            if Type = 'Withdrawal' then begin

                                AccountTypes.Reset;
                                AccountTypes.SetRange(AccountTypes.Code, "Account Type");

                                if AccountTypes.Find('-') then
                                    if CalcDate(AccountTypes."Withdrawal Interval", Members."Last Withdrawal Date") > Today then
                                        IntervalPenalty := AccountTypes."Withdrawal Penalty";
                            end;

                    //////////////

                    /////////////
                    //FIXED DEPOSIT

                    ChargesOnFD := 0;

                    Members.Reset;
                    if Members.Get("Account No") then begin

                        AccountTypes.Reset;
                        if AccountTypes.Get(Members."Account Type") then
                            if AccountTypes."Fixed Deposit" = true then
                                if Members."Expected Maturity Date" > Today then
                                    ChargesOnFD := AccountTypes."Charge Closure Before Maturity";
                    end;

                    Members.Reset;

                    ///////////
                end;

                //UNCLEARED CHEQUES
                chqtransactions.Reset;
                chqtransactions.SetRange(chqtransactions."Account No", "Account No");
                chqtransactions.SetRange(chqtransactions.Deposited, true);
                chqtransactions.SetRange(chqtransactions."Cheque Processed", false);

                if chqtransactions.Find('-') then
                    repeat

                        TotalUnprocessed := TotalUnprocessed + chqtransactions.Amount;
                    until chqtransactions.Next = 0;

                //ATM BALANCE
                AccountHolders.Reset;
                AccountHolders.SetRange(AccountHolders."No.", "Account No");
                if AccountHolders.Find('-') then
                    //AccountHolders.CALCFIELDS(AccountHolders."ATM Transactions");
                    ATMBalance := AccountHolders."ATM Transactions";

                if LoanGuaranteed < 0 then
                    LoanGuaranteed := 0;

                if UnClearedBalance < 0 then
                    UnClearedBalance := 0;

                AccountTypes.Reset;
                if AccountTypes.Get("Account Type") then
                    if AccountTypes."Fixed Deposit" = false then begin
                        if "Book Balance" < MinAccBal then
                            AvailableBalance := "Book Balance" - FeeBelowMinBal - TCharges - IntervalPenalty - MinAccBal - TotalUnprocessed - ATMBalance
                        else
                            AvailableBalance := "Book Balance" - TCharges - IntervalPenalty - MinAccBal - TotalUnprocessed - ATMBalance;

                    end else
                        AvailableBalance := "Book Balance" - TCharges - ChargesOnFD;

                //AvailableBalance:=AvailableBalance-Transactions.Amount;

                if Account.Get(Transactions."Account No") then begin
                    Account.CalcFields(Account."Balance (LCY)");
                    AvailableBalance := Account."Balance (LCY)" - 1000;
                end;

                vatTotalHolder := Transactions.Amount;

                TillNo := '';
                TellerTill.Reset;
                TellerTill.SetRange(TellerTill."Cashier ID", Transactions.Cashier);
                if TellerTill.Find('-') then
                    TillNo := TellerTill."No.";

                //Amount into words
                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NumberText, Amount, '');
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Account: Record Vendor;
        LoanBalance: Decimal;
        AvailableBalance: Decimal;
        UnClearedBalance: Decimal;
        LoanSecurity: Decimal;
        LoanGuaranteed: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        window: Dialog;
        Members: Record Vendor;
        TransactionTypes: Record "Transaction Types";
        TransactionCharges: Record "Transaction Charges";
        TCharges: Decimal;
        LineNo: Integer;
        AccountTypes: Record "Account Types-Saving Products";
        GenLedgerSetup: Record "General Ledger Setup";
        MinAccBal: Decimal;
        FeeBelowMinBal: Decimal;
        AccountNo: Code[30];
        NewAccount: Boolean;
        CurrentTellerAmount: Decimal;
        TellerTill: Record "Bank Account";
        IntervalPenalty: Decimal;
        StandingOrders: Record "Standing Orders";
        AccountAmount: Decimal;
        STODeduction: Decimal;
        Charges: Record Charges;
        "Total Deductions": Decimal;
        STODeductedAmount: Decimal;
        NoticeAmount: Decimal;
        AccountNotices: Record "Account Notices";
        Cust: Record Customer;
        AccountHolders: Record Vendor;
        ChargesOnFD: Decimal;
        TotalGuaranted: Decimal;
        VarAmtHolder: Decimal;
        vatTotalHolder: Decimal;
        chqtransactions: Record Transactions;
        TotalUnprocessed: Decimal;
        ATMBalance: Decimal;
        TillNo: Code[20];
        CompanyInfo: Record "Company Information";
        DUPLICATECaptionLbl: label 'DUPLICATE';
        Amount_received__CaptionLbl: label 'Amount received :';
        Account_Name_CaptionLbl: label 'Account Name:';
        Account_No_CaptionLbl: label 'Account No:';
        Member_No_CaptionLbl: label 'Member No:';
        Time_CaptionLbl: label 'Time:';
        Date_CaptionLbl: label 'Date:';
        Transaction_No_CaptionLbl: label 'Transaction No.';
        Deposited_By_______________________________________CaptionLbl: label 'Deposited By :.....................................';
        You_were_served_by__CaptionLbl: label 'You were served by :';
        THANK_YOUCaptionLbl: label 'THANK YOU';
        Better_life_for_our_members_globallyCaptionLbl: label 'Better life for our members globally';
        CheckReport: Report Check;
        NumberText: array[2] of Text[120];

    procedure CalAvailableBal()
    begin
        ATMBalance := 0;

        TCharges := 0;
        AvailableBalance := 0;
        MinAccBal := 0;
        TotalUnprocessed := 0;
        IntervalPenalty := 0;

        if Account.Get(Transactions."Account No") then begin
            Account.CalcFields(Account.Balance);

            AccountTypes.Reset;
            AccountTypes.SetRange(AccountTypes.Code, Transactions."Account Type");
            if AccountTypes.Find('-') then begin
                MinAccBal := AccountTypes."Minimum Balance";
                FeeBelowMinBal := AccountTypes."Fee Below Minimum Balance";

                //Check Withdrawal Interval
                if Account.Status <> Account.Status::New then begin
                    if Transactions.Type = 'Withdrawal' then begin
                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, Transactions."Account Type");
                        if Account."Last Withdrawal Date" <> 0D then
                            if CalcDate(AccountTypes."Withdrawal Interval", Account."Last Withdrawal Date") > Today then
                                IntervalPenalty := AccountTypes."Withdrawal Penalty";
                    end;
                    //Check Withdrawal Interval

                    //Fixed Deposit
                    ChargesOnFD := 0;
                    if AccountTypes."Fixed Deposit" = true then
                        if Account."Expected Maturity Date" > Today then
                            ChargesOnFD := AccountTypes."Charge Closure Before Maturity";
                    //Fixed Deposit

                    //Current Charges
                    TransactionCharges.Reset;
                    TransactionCharges.SetRange(TransactionCharges."Transaction Type", Transactions."Transaction Type");
                    if TransactionCharges.Find('-') then
                        repeat
                            if TransactionCharges."Use Percentage" = true then begin
                                TransactionCharges.TestField("Percentage of Amount");
                                TCharges := TCharges + (TransactionCharges."Percentage of Amount" / 100) * Transactions."Book Balance";
                            end else
                                TCharges := TCharges + TransactionCharges."Charge Amount";
                        until TransactionCharges.Next = 0;

                    TotalUnprocessed := Account."Uncleared Cheques";
                    ATMBalance := Account."ATM Transactions";

                    //FD
                    if AccountTypes."Fixed Deposit" = false then begin
                        if Account.Balance < MinAccBal then
                            AvailableBalance := Account.Balance - FeeBelowMinBal - TCharges - IntervalPenalty - MinAccBal - TotalUnprocessed - ATMBalance
                        else
                            AvailableBalance := Account.Balance - TCharges - IntervalPenalty - MinAccBal - TotalUnprocessed - ATMBalance;
                    end else
                        AvailableBalance := Account.Balance - TCharges - ChargesOnFD;
                end;
                //FD
            end;
        end;
    end;
}
