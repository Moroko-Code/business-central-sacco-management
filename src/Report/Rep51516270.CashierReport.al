#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516270 "Cashier Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Cashier Report.rdlc';
    Caption = 'Teller Report';

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Bank Acc. Posting Group", "Date Filter";
            column(ReportForNavId_4558; 4558)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(STRSUBSTNO_Text000_BankAccDateFilter_; StrSubstNo(Text000, BankAccDateFilter))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(USERID; UserId)
            {
            }
            column(STRSUBSTNO___1___2___Bank_Account__TABLECAPTION_BankAccFilter_; StrSubstNo('%1: %2', "Bank Account".TableCaption, BankAccFilter))
            {
            }
            column(Bank_Account__No__; "No.")
            {
            }
            column(Bank_Account_Name; Name)
            {
            }
            column(Bank_Account__Currency_Code_; "Currency Code")
            {
            }
            column(StartBalance; StartBalance)
            {
                AutoFormatExpression = "Bank Account Ledger Entry"."Currency Code";
                AutoFormatType = 1;
            }
            column(Cashier_ReportCaption; Cashier_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Bank_Account_Ledger_Entry__Posting_Date_Caption; "Bank Account Ledger Entry".FieldCaption("Posting Date"))
            {
            }
            column(Bank_Account_Ledger_Entry__Document_No__Caption; "Bank Account Ledger Entry".FieldCaption("Document No."))
            {
            }
            column(Bank_Account_Ledger_Entry_DescriptionCaption; "Bank Account Ledger Entry".FieldCaption(Description))
            {
            }
            column(BankAccBalance_StartBalance_tellerIssuesCaption; BankAccBalance_StartBalance_tellerIssuesCaptionLbl)
            {
            }
            column(Bank_Account_Ledger_Entry__Entry_No__Caption; "Bank Account Ledger Entry".FieldCaption("Entry No."))
            {
            }
            column(Account_NameCaption; Account_NameCaptionLbl)
            {
            }
            column(Bank_Account_Ledger_Entry__Debit_Amount_Caption; "Bank Account Ledger Entry".FieldCaption("Debit Amount"))
            {
            }
            column(Bank_Account_Ledger_Entry__Credit_Amount_Caption; "Bank Account Ledger Entry".FieldCaption("Credit Amount"))
            {
            }
            column(Account_No_Caption; Account_No_CaptionLbl)
            {
            }
            column(Bank_Account__Currency_Code_Caption; FieldCaption("Currency Code"))
            {
            }
            column(Teller__Sign_Date_Caption; Teller__Sign_Date_CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Accountant_Manager__Sign_Date_Caption; Accountant_Manager__Sign_Date_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102760026; EmptyStringCaption_Control1102760026Lbl)
            {
            }
            column(Bank_Account_Date_Filter; "Date Filter")
            {
            }
            column(Bank_Account_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Bank_Account_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Balance_At_date; "Bank Account"."Balance at Date (LCY)")
            {
            }
            column(Bank_Account_Cashier_ID; CashierID)
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Company_pic; CompanyInfo.Picture)
            {
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter");
                DataItemTableView = sorting("Bank Account No.", "Posting Date");
                column(ReportForNavId_4920; 4920)
                {
                }
                column(StartBalance____Bank_Account_Ledger_Entry__Amount; StartBalance + "Bank Account Ledger Entry".Amount)
                {
                    AutoFormatExpression = "Bank Account Ledger Entry"."Currency Code";
                    AutoFormatType = 1;
                }
                column(Bank_Account_Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Bank_Account_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Bank_Account_Ledger_Entry_Description; Description)
                {
                }
                column(BankAccBalance_StartBalance_tellerIssues; BankAccBalance)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(Bank_Account_Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Bank_Account_Ledger_Entry_Amount; Amount)
                {
                }
                column(Names_Control1102760001; Names)
                {
                }
                column(Bank_Account_Ledger_Entry__Debit_Amount_; "Debit Amount")
                {
                }
                column(Bank_Account_Ledger_Entry__Credit_Amount_; "Credit Amount")
                {
                }
                column(Bank_Account_Ledger_Entry__Bank_Account_Ledger_Entry___Bal__Account_No__; "Bank Account Ledger Entry"."Bal. Account No.")
                {
                }
                column(StartBalance____Bank_Account_Ledger_Entry__Amount_Control47; StartBalance + "Bank Account Ledger Entry".Amount)
                {
                    AutoFormatExpression = "Bank Account Ledger Entry"."Currency Code";
                    AutoFormatType = 1;
                }
                column(ContinuedCaption; ContinuedCaptionLbl)
                {
                }
                column(ContinuedCaption_Control46; ContinuedCaption_Control46Lbl)
                {
                }
                column(Bank_Account_Ledger_Entry_Bank_Account_No_; "Bank Account No.")
                {
                }
                column(Bank_Account_Ledger_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                {
                }
                column(Bank_Account_Ledger_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not PrintReversedEntries and Reversed then
                        CurrReport.Skip;
                    BankAccLedgEntryExists := true;
                    BankAccBalance := BankAccBalance + Amount;
                    BankAccBalanceLCY := BankAccBalanceLCY + "Amount (LCY)";

                    Names := '';
                    if "Bank Account Ledger Entry"."Bal. Account Type" = "Bank Account Ledger Entry"."bal. account type"::Customer then begin
                        if Cust.Get("Bank Account Ledger Entry"."Bal. Account No.") then
                            Names := Cust.Name;
                    end else
                        if "Bank Account Ledger Entry"."Bal. Account Type" = "Bank Account Ledger Entry"."bal. account type"::Vendor then begin
                            if Vend.Get("Bank Account Ledger Entry"."Bal. Account No.") then
                                Names := Vend.Name;
                        end
                        else
                            if "Bank Account Ledger Entry"."Bal. Account Type" = "Bank Account Ledger Entry"."bal. account type"::"Bank Account" then
                                if Bank.Get("Bank Account Ledger Entry"."Bal. Account No.") then
                                    Names := Bank.Name;
                    //ELSE
                    //IF "Bank Account Ledger Entry"."Bal. Account Type"="Bank Account Ledger Entry"."Bal. Account Type"::"G/L Account" THEN BEGIN
                    //IF Member.GET(ban)
                    TCredit := TCredit + "Bank Account Ledger Entry"."Credit Amount";
                    TDebit := TDebit + "Bank Account Ledger Entry"."Debit Amount";
                end;

                trigger OnPreDataItem()
                begin
                    BankAccLedgEntryExists := false;
                    CurrReport.CreateTotals(Amount, "Amount (LCY)");
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(ReportForNavId_5444; 5444)
                {
                }
                column(Bank_Account__Name; "Bank Account".Name)
                {
                }
                column(Bank_Account_Ledger_Entry__Amount; "Bank Account Ledger Entry".Amount)
                {
                }
                column(StartBalance____Bank_Account_Ledger_Entry__Amount_tellerIssues; StartBalance + "Bank Account Ledger Entry".Amount + tellerIssues)
                {
                    AutoFormatExpression = "Bank Account Ledger Entry"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TDebit; TDebit)
                {
                }
                column(TCredit; TCredit)
                {
                }
                column(Integer_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not BankAccLedgEntryExists and ((StartBalance = 0) or ExcludeBalanceOnly) then begin
                        StartBalanceLCY := 0;
                        CurrReport.Skip;
                    end;
                end;
            }
            dataitem(Transactions; Transactions)
            {
                DataItemLink = "Transaction Date" = field("Date Filter"), Cashier = field(CashierID);
                DataItemTableView = sorting(No) where(Type = filter('Cheque Deposit'), Posted = filter('Yes'));
                column(ReportForNavId_5806; 5806)
                {
                }
                column(Transactions_No; No)
                {
                }
                column(Transactions__Account_No_; "Account No")
                {
                }
                column(Transactions__Account_Name_; "Account Name")
                {
                }
                column(Transactions__Cheque_Type_; "Cheque Type")
                {
                }
                column(Transactions__Cheque_No_; "Cheque No")
                {
                }
                column(Transactions__Cheque_Date_; "Cheque Date")
                {
                }
                column(Transactions_Amount; Amount)
                {
                }
                column(Transactions__Expected_Maturity_Date_; "Expected Maturity Date")
                {
                }
                column(Transactions_Amount_Control1102755015; Amount)
                {
                }
                column(Transactions__Cheque_Date_Caption; FieldCaption("Cheque Date"))
                {
                }
                column(Transactions__Cheque_No_Caption; FieldCaption("Cheque No"))
                {
                }
                column(Transactions__Cheque_Type_Caption; FieldCaption("Cheque Type"))
                {
                }
                column(Transactions__Account_Name_Caption; FieldCaption("Account Name"))
                {
                }
                column(Transactions__Account_No_Caption; FieldCaption("Account No"))
                {
                }
                column(Transactions_NoCaption; FieldCaption(No))
                {
                }
                column(CHEQUE_DEPOSITSCaption; CHEQUE_DEPOSITSCaptionLbl)
                {
                }
                column(Transactions_AmountCaption; FieldCaption(Amount))
                {
                }
                column(Maturity_DateCaption; Maturity_DateCaptionLbl)
                {
                }
                column(Total_Cheque_DepositsCaption; Total_Cheque_DepositsCaptionLbl)
                {
                }
                column(Transactions_Transaction_Date; "Transaction Date")
                {
                }
                column(Transactions_Cashier; Cashier)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                StartBalance := 0;
                TCredit := 0;
                TDebit := 0;

                if BankAccDateFilter <> '' then
                    if GetRangeMin("Date Filter") <> 0D then begin
                        SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
                        CalcFields("Net Change", "Net Change (LCY)");
                        StartBalance := "Net Change";
                        StartBalanceLCY := "Net Change (LCY)";
                        SetFilter("Date Filter", BankAccDateFilter);
                    end;
                CurrReport.PrintonlyIfDetail := ExcludeBalanceOnly or (StartBalance = 0);
                BankAccBalance := StartBalance;
                BankAccBalanceLCY := StartBalanceLCY;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.NewPagePerRecord := PrintOnlyOnePerPage;
                CurrReport.CreateTotals("Bank Account Ledger Entry"."Amount (LCY)", StartBalanceLCY);

                if CompanyInfo.Get() then
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

    trigger OnPreReport()
    begin
        /*StatusPermissions.RESET;
        StatusPermissions.SETRANGE(StatusPermissions."User Id", USERID);
        StatusPermissions.SETRANGE(StatusPermissions."Function", StatusPermissions."Function"::"Cashier Report");
        IF StatusPermissions.FIND('-') = FALSE THEN
            ERROR('You do not have permissions to edit member information.');
        */

        if UserSetup.Get(UserId) then begin
            if not UserSetup."View Cashier Report" then
                Error(PemissionDenied);
        end else
            Error(UserNotFound, UserId);

        BankAccFilter := "Bank Account".GetFilters;
        BankAccDateFilter := "Bank Account".GetFilter("Date Filter");

        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        Text000: label 'Period: %1';
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        BankAccFilter: Text[250];
        BankAccDateFilter: Text[30];
        BankAccBalance: Decimal;
        BankAccBalanceLCY: Decimal;
        StartBalance: Decimal;
        StartBalanceLCY: Decimal;
        BankAccLedgEntryExists: Boolean;
        PrintReversedEntries: Boolean;
        Cust: Record Customer;
        Bank: Record "Bank Account";
        Vend: Record Vendor;
        Names: Text[80];
        TCredit: Decimal;
        TDebit: Decimal;
        CompanyInfo: Record "Company Information";
        tellerIssues: Decimal;
        IssueAmount: Decimal;
        Cashier_ReportCaptionLbl: label 'Cashier Report';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        BankAccBalance_StartBalance_tellerIssuesCaptionLbl: label 'Balance';
        Account_NameCaptionLbl: label 'Account Name';
        Account_No_CaptionLbl: label 'Account No.';
        Teller__Sign_Date_CaptionLbl: label 'Teller (Sign/Date)';
        EmptyStringCaptionLbl: label '.....................................................................';
        Accountant_Manager__Sign_Date_CaptionLbl: label 'Accountant/Manager (Sign/Date)';
        EmptyStringCaption_Control1102760026Lbl: label '.....................................................................';
        Teller_IssuesCaptionLbl: label 'Teller Issues';
        Total_Teller_IssuesCaptionLbl: label 'Total Teller Issues';
        ContinuedCaptionLbl: label 'Continued';
        ContinuedCaption_Control46Lbl: label 'Continued';
        CHEQUE_DEPOSITSCaptionLbl: label 'CHEQUE DEPOSITS';
        Maturity_DateCaptionLbl: label 'Maturity Date';
        Total_Cheque_DepositsCaptionLbl: label 'Total Cheque Deposits';
        Member: Record Customer;
        StatusPermissions: Record "Status Change Permision";
        UserSetup: Record "User Setup";
        PemissionDenied: label 'This user is not allowed to view this report,please contact system administrator';
        UserNotFound: label 'User Setup %1 not found.';
}
