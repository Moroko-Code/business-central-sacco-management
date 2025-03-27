Page 51516487 "KCAU Main Role Center"
{
    Caption = 'KCAU SACCO';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control75; "Custom Headline")
            {
                ApplicationArea = All;
                Visible = false;
            }

            part(Control99; "Finance Performance")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }

            part(BOSACue; "BOSA Cue")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            part("LoansCue"; "Loan Cues")
            {
                ApplicationArea = Suite;
                Visible = true;
            }

            part("General Cue"; "Approvals Activities")
            {
                ApplicationArea = Suite;
                Visible = true;
            }

            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            part(Control123; "Team Member Activities")
            {
                ApplicationArea = Suite;
                Visible = false;
            }
            part(Control1907692008; "My Accounts")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control103; "Trailing Sales Orders Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }

            part(Control106; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control9; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control100; "Cash Flow Forecast Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control108; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control122; "Power BI Report Spinner Part")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }

            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
        }
    }

    actions
    {
        // area(processing)
        // {
        //     Description = 'Periodic Activities';
        //     action("Process Monthly Interest")
        //     {
        //         ApplicationArea = all;
        //         Caption = 'Process Monthly Interest';
        //         Image = Process;
        //         RunObject = report "Post Monthly Interest.";
        //     }
        //     action("Process Monthly Checkoff")
        //     {
        //         ApplicationArea = all;
        //         Caption = 'Process Monthly Checkoff';
        //         Image = Process;
        //         RunObject = page "Bosa Receipts H List-Checkoff";
        //     }
        // }
        area(reporting)
        {
        }
        area(embedding)
        {
            action("Chart of Account")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ToolTip = 'Open the chart of accounts.';
                Visible = true;
            }
            action("Bank Accounts List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                visible = false;
                RunObject = Page "Bank Account List";
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
            }
            action(Members)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Members';
                Image = Customer;
                visible = true;
                RunObject = Page "Member List";
                ToolTip = 'View or edit detailed information for the Members.';
            }
            action(Loans)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Credits';
                Image = Loaner;
                Visible = true;
                RunObject = Page "Loans Posted List";
                ToolTip = 'View or edit detailed information for the Credits Accounts.';
            }
            action("Bulk Sms")
            {
                ApplicationArea = Basic, suite;
                Caption = 'Send SMS';
                Image = Message;
                RunObject = Page "Bulk SMS Header";
                ToolTip = 'Send Bulk Sms to Members';
                Visible = false;
            }
            action("Posted Receipts List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'View Posted Receipts';
                Image = Documents;
                RunObject = Page "Posted BOSA Receipts List";
                ToolTip = 'View Posted BOSA Receipts';
                Visible = true;
            }
        }
        area(sections)
        {
            //......................... START OF FINANCIAL MANAGEMENT MENU ...........................
            group(FinancialManagement)
            {
                Caption = 'Financial Management';
                Image = Journals;
                ToolTip = 'Collect and make payments, prepare statements, and reconcile bank accounts.';
                group("Budgeted Management")
                {
                    action("Budgets")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Budgets';
                        Image = Journal;
                        RunObject = Page "G/L Budget Names";
                        ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                    }
                    action("Actuals Vs Budget")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Budget vs Actuals';
                        Image = Journal;
                        RunObject = report "Actual Vs Budget";
                    }
                }
                action("General Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page "General Journal";
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
                group("General Ledger")
                {
                    Caption = 'General Ledger and General Journals';
                    ToolTip = 'Process incoming and outgoing payments. Set up bank accounts and service connections for electronic banking.  ';
                    Visible = true;

                    action("G/L Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Register';
                        Image = Journal;
                        RunObject = Page "G/L Registers";
                    }
                    action("Chart of Accounts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Chart of Accounts';
                        RunObject = Page "Chart of Accounts";
                        ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
                    }
                    action("G/L Navigator")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Navigator';
                        Image = Journal;
                        RunObject = Page Navigate;
                    }
                    action("Account Categories")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = Journal;
                        RunObject = Page "G/L Account Categories";
                    }
                }
                //......................................................................................................................................
                group("Cash Management")
                {
                    Caption = 'Cash Management';
                    ToolTip = 'Process incoming and outgoing payments. Set up bank accounts and service connections for electronic banking.  ';
                    Visible = true;

                    action("Bank Accounts Management")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Bank Accounts List';
                        RunObject = page "Bank Account List";
                    }
                    action("Voucher Cash Payments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Voucher Cash Payment';
                        RunObject = Page "Payment List";
                        Visible = false;
                    }
                    action("Cash Payments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Payments';
                        RunObject = Page "Cash Payment List";
                        Visible = false;
                    }
                    action("Bank Account Reconciliation")

                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Bank Accounts Reconcilations';
                        RunObject = page "Bank Acc. Reconciliation List";
                    }
                    action("Posted Payment Reconcilations")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Reconcilations';
                        RunObject = page "Posted Payment Reconciliations";
                        Visible = false;
                    }
                    action("Bank Reconciliation Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Reconcilations Report';
                        RunObject = report "Bank Account - List";
                        Visible = false;
                    }
                    action("Bank Reconciliation Summaary Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Reconcilations Summary Report';
                        RunObject = report BankReconiliationsummary;
                        //Visible = false;
                    }
                    action("Payment Reconcilations JOURNALS")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Reconcilations Journals';
                        RunObject = page "Payment Reconciliation Journal";
                        Visible = false;
                    }
                }
                //........................................................................................................................................

                group("SASRA Reports")
                {
                    Caption = 'SASRA Reports';
                    ToolTip = 'which highlights the operations and performance of the SACCO industry during the year ended';
                    Visible = true;
                    action("Capital Adequacy Return")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Capital Adequacy Return';
                        RunObject = report "CAPITAL ADEQUACY RETURN";
                        ToolTip = 'View or Generate Deposit Return SASRA for a given period.';
                    }
                    action("Investiment Return")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Investiment Return';
                        RunObject = report "RETURN ON INVESTMENT";
                        ToolTip = 'View or Generate Deposit Return SASRA for a given period.';
                        // Visible = false;
                    }
                    action("Liquidity Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Liquidity Statement';
                        RunObject = report Liquidity;
                        ToolTip = 'View or Generate Deposit Return SASRA for a given period.';
                        // Visible = false;
                    }
                    action("Form2F Statement of CompIncome")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of comprehensive Income';
                        RunObject = report "Form2F Statement of CompIncome";
                        ToolTip = 'View or Generate Deposit Return SASRA for a given period.';
                        // Visible = false;
                    }
                    action("Deposits Return-SASRA")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Deposits Return';
                        Image = Report;
                        RunObject = report "Deposit returnN";
                    }
                    action("Statement of Financial Position")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Financial Position';
                        RunObject = report "STATEMENT OF FINANCIAL P";
                        ToolTip = 'View or Generate Deposit Return SASRA for a given period.';
                        // Visible = false;
                    }
                    action("Other Disclosures")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Other Disclosures';
                        RunObject = report "Other Disclosures";
                    }
                    action("Insider Lending Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insider Lending Report';
                        RunObject = report "Insider Lending & Perf Return";
                        ToolTip = 'View or Generate Agency Returns for a given period.';
                        // Visible = false;
                    }
                    action("Loans Defaulter Aging-SASRA")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Defaulter Aging';
                        RunObject = report "SASRA Loans Classification";
                    }

                    // action("Sectorial Lending Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Sectorial Lending Report';
                    //     RunObject = report "SECTORAL LENDING";
                    //     ToolTip = 'View or Generate Agency Returns for a given period.';
                    //     // Visible = false;
                    // }

                    action("Risk Class of Assets")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Risk Classification and Loan Provisioning';
                        RunObject = report "Risk Class Of Assets & Prov";
                    }

                    // action("Loans Provisioning Summary-SASRA")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Loans Provisioning Summary';
                    //     RunObject = report "Loans Provisioning Summarys";
                    // }
                    action("Loan Sectorial Lendng-SASRA")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Sectorial Lending';
                        RunObject = REPORT "Loan Sectoral Lending Report";
                    }
                }
                //..........................................................................................................................................
                group("Receipt Processing")
                {
                    action("Create Receipt")
                    {
                        ApplicationArea = all;
                        Image = Journal;
                        RunObject = page "Receipt Header List";
                    }
                    action("Posted Receipts")
                    {
                        ApplicationArea = all;
                        Image = Journal;
                        RunObject = page "Posted Receipt Header List";
                    }
                }
                group("Payments Processing")
                {
                    Caption = 'Payment Processing';
                    ToolTip = 'Process incoming and outgoing payments.';
                    Visible = true;

                    action("Payment Vouchers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Vouchers Posting';
                        Image = Journal;
                        RunObject = Page "Payment List";
                    }
                    action("Posted Payment Vouchers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Payment Vouchers';
                        Image = Journal;
                        RunObject = Page "Posted Payment List";
                    }
                    action("Petty Cash Payment")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Petty Cash Payment';
                        RunObject = page "PettyCash Payment List";
                    }
                    action("Posted Petty Cash")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Petty Cash';
                        RunObject = page "Posted PettyCash Payment List";
                    }
                }
                Group(FundsTranfer)
                {
                    Caption = 'Funds Tranfer';
                    action("FundTransList")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Funds Transfer';
                        RunObject = Page "Funds Transfer List";
                    }
                    action("PostedFundTrans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Funds Transfer';
                        RunObject = Page "Posted Funds Transfer List";
                    }
                }
                //............................................................................................

                group("Other Financials")
                {
                    action("Trade Creditors")
                    {
                        ApplicationArea = basic, Suite;
                        RunObject = page TradeCreditors;
                    }
                    action("Ex-Member Creditors")
                    {
                        ApplicationArea = basic, Suite;
                        RunObject = page Ex_MemberCreditors;

                    }
                    action(EmployerReceivables)
                    {
                        ApplicationArea = all;
                        Caption = 'Employer Receivables';
                        RunObject = page EmployerReceivables;
                    }
                }
                group("Assets Management")
                {
                    Caption = 'Assets Management';
                    ToolTip = 'Record and Manage Assets.';
                    Visible = true;
                    action("Asset Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Assets Register';
                        RunObject = Page "Fixed Asset List";
                        ToolTip = 'Assets Register.';
                    }
                    action("Fixed Asset G/L Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fixed Asset G/J Journal';
                        RunObject = Page "Fixed Asset G/L Journal";
                        ToolTip = 'Record Asset Movement.';
                        visible = false;
                    }
                    action("Fixed Asset Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fixed Asset Journal';
                        RunObject = Page "Fixed Asset Journal";
                        ToolTip = 'View all Sacco Assets.';
                        Visible = false;
                    }
                    action("Fixed Asset Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fixed Asset Setup';
                        RunObject = page "Fixed Asset Setup";
                    }
                    group("Fixed Asset Report")
                    {
                        action("Fixed Asset List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Fixed Asset List';
                            RunObject = report "Fixed Asset - List";
                        }
                        action("Fixed Asset Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Fixed Asset Register';
                            RunObject = report "Fixed Asset Register";
                        }
                        action("Fixed Assets Book Value")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Fixed Assets Book Value';
                            RunObject = report FixeAssetbookValueReport;
                        }
                    }
                }

                //.................................................................................................................................................
                group("Finance Statements")
                {
                    Caption = 'Financial Statements';
                    ToolTip = 'Display Financial Statements.';
                    Visible = true;

                    action("Devco Trial Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Summarised Trial Balance';
                        RunObject = report "Trial Balance";
                        ToolTip = 'Generate Trial Balance for a given period.';
                    }
                    action("Account Schedules")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Account Schedules';
                        RunObject = page "Financial Reports";
                    }
                    action("LiquidityReport")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Liquidity Report';
                        Image = Journal;
                        RunObject = report Liquidity;
                        ToolTip = 'Generate Liquidity Report for a given period.';
                        Visible = false;
                    }
                }

                //.......................................................................................................................................
                group("Mkopo Reports")
                {
                    Caption = 'Mkopo Reports';
                    Visible = false;
                    action(SaccoInformationReport)
                    {
                        ApplicationArea = All;
                        Caption = 'Sacco Information Report';
                        RunObject = report "Sacco Information";
                    }
                    action("Statement of Directors'RE")
                    {
                        ApplicationArea = All;
                        Caption = 'Statement of Directors Responsibilities';
                        RunObject = report "Statement of Directors'RE";
                    }
                    action(Reportofthedirectors)
                    {
                        ApplicationArea = All;
                        RunObject = report "REPORT OF THE DIRECTORS";
                        Caption = 'Report of the Directors';
                    }
                    action("Financial Statical Information")
                    {
                        ApplicationArea = All;
                        RunObject = report FinancialStaticalInformation;
                    }
                    action("Statement of Financial Position Mkopo")
                    {
                        ApplicationArea = All;
                        Caption = 'Satement of Financial Position';
                        RunObject = report "State of financial Position";
                    }
                    action("Statement of profit or loss and other comprehensive income")
                    {
                        ApplicationArea = All;
                        Caption = 'Statement of profit or loss and other comprehensive income';
                        RunObject = report StatementProfitorloss;
                    }
                    action("Statement of changes of Equity Current")
                    {
                        ApplicationArea = All;
                        Caption = 'Statement of Changes im Equity';
                        RunObject = report StatementOfChangesInEquity;
                    }
                    // action("Statement of changes of Equity Previous")
                    // {
                    //     ApplicationArea = All;
                    //     RunObject = report StatchangesinequityPrevious;
                    // }
                    action("Statement OF Cash Flows")
                    {
                        ApplicationArea = All;
                        Caption = 'Cash Flows';
                        RunObject = report cashFlows;
                    }
                }
                //.......................................................................................................................................

                //..................................................................................................................................
                group("Periodic Activities")
                {
                    Caption = 'Periodic Activities';
                    ToolTip = ' All Finance Module Setups ';
                    Visible = true;

                    action("Close Income Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Close Income Statement';
                        RunObject = report "Close Income Statement";
                    }
                    action("Sacco Information")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Sacco Information";
                    }
                    action("Create Accounting Period")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Create and Close Accounting Period';
                        RunObject = page "Accounting Periods";
                    }

                    // action("Update Liquidity")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     caption = 'Update Liquidity Report';

                    // }
                }

                // }
            }

            // group("Safe Custody management")
            // {
            //     action("Safe Custody Custodians")
            //     {
            //         ApplicationArea = All;

            //         RunObject = page "Safe Custodian List";
            //     }
            //     action("Safe Custody Custodian Register")
            //     {
            //         ApplicationArea = All;

            //         RunObject = page ApplyNewSafeCustody;
            //     }
            // }

            group("Cash Management New")
            {
                Caption = 'Cash Management';
                ToolTip = 'Process incoming and outgoing payments. Set up bank accounts and service connections for electronic banking.  ';
                Visible = false;
                group("Cheque Manangement")
                {
                    action(CollectedCheques)
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Collected Cheques';
                        // promoted = true;
                        // PromotedCategory = Process;
                        //RunObject = page CollectedCheques;
                    }
                    action(ProcessedCheques)
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Procesed Cheques';
                        // promoted = true;
                        // PromotedCategory = Process;
                        //RunObject = page ProccesedCheques;
                    }
                    action("OpenCheques")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Cheques';
                        // promoted = true;
                        // PromotedCategory = Process;
                        //RunObject = Page OpenCheques;
                    }
                    action("RejectedCheques")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Rejected Cheques';
                        // promoted = true;
                        // PromotedCategory = Process;
                        //RunObject = Page RejectedCheques;
                    }
                    action("ApprovedCheques")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Cheques';
                        // promoted = true;
                        // PromotedCategory = Process;
                        //RunObject = Page ApprovedCheques;
                    }
                    action("PendingCheques")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending Cheques';
                        // promoted = true;
                        // PromotedCategory = Process;
                        // RunObject = Page PendingCheques;
                    }
                }
                action(CashReceiptJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                        Recurring = CONST(false));
                    ToolTip = 'Register received payments by manually applying them to the related customer, vendor, or bank ledger entries. Then, post the payments to G/L accounts and thereby close the related ledger entries.';
                }
                action(PaymentJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments),
                                        Recurring = CONST(false));
                    ToolTip = 'Register payments to vendors. A payment journal is a type of general journal that is used to post outgoing payment transactions to G/L, bank, customer, vendor, employee, and fixed assets accounts. The Suggest Vendor Payments functions automatically fills the journal with payments that are due. When payments are posted, you can export the payments to a bank file for upload to your bank if your system is set up for electronic banking. You can also issue computer checks from the payment journal.';
                }
                action(Action164)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    RunObject = Page "Bank Account List";
                    ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
                }
                action("Payment Recon. Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Recon. Journals';
                    Image = ApplyEntries;
                    // Promoted = true;

                    // PromotedCategory = Process;
                    RunObject = Page "Pmt. Reconciliation Journals";
                    ToolTip = 'Reconcile unpaid documents automatically with their related bank transactions by importing a bank statement feed or file. In the payment reconciliation journal, incoming or outgoing payments on your bank are automatically, or semi-automatically, applied to their related open customer or vendor ledger entries. Any open bank account ledger entries related to the applied customer or vendor ledger entries will be closed when you choose the Post Payments and Reconcile Bank Account action. This means that the bank account is automatically reconciled for payments that you post with the journal.';
                }
                action("Bank Acc. Statements")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Acc. Statements';
                    Image = BankAccountStatement;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    RunObject = Page "Bank Account Statement List";
                    ToolTip = 'View statements for selected bank accounts. For each bank transaction, the report shows a description, an applied amount, a statement amount, and other information.';
                }
                action("Cash Flow Forecasts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Forecasts';
                    // Promoted = true;
                    // PromotedCategory = Process;
                    RunObject = Page "Cash Flow Forecast List";
                    ToolTip = 'Combine various financial data sources to find out when a cash surplus or deficit might happen or whether you should pay down debt, or borrow to meet upcoming expenses.';
                }
                action("Chart of Cash Flow Accounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Cash Flow Accounts';
                    // Promoted = true;
                    // PromotedCategory = Process;
                    RunObject = Page "Chart of Cash Flow Accounts";
                    ToolTip = 'View a chart contain a graphical representation of one or more cash flow accounts and one or more cash flow setups for the included general ledger, purchase, sales, services, or fixed assets accounts.';
                }
                action("Cash Flow Manual Revenues")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Manual Revenues';
                    // Promoted = true;
                    // PromotedCategory = Process;
                    RunObject = Page "Cash Flow Manual Revenues";
                    ToolTip = 'Record manual revenues, such as rental income, interest from financial assets, or new private capital to be used in cash flow forecasting.';
                }
                action("Cash Flow Manual Expenses")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Manual Expenses';
                    // Promoted = true;
                    // PromotedCategory = Process;
                    RunObject = Page "Cash Flow Manual Expenses";
                    ToolTip = 'Record manual expenses, such as salaries, interest on credit, or planned investments to be used in cash flow forecasting.';
                }
                action(BankAccountReconciliations)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Reconciliations';
                    Image = BankAccountRec;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    RunObject = Page "Bank Acc. Reconciliation List";
                    ToolTip = 'Reconcile bank accounts in your system with bank statements received from your bank.';
                }
            }
            //.................................START OF MEMBERSHIP MANAGEMENT..................................
            group(MembershipManagement)
            {
                Caption = 'Membership Management';

                action(MembersList)
                {
                    ApplicationArea = all;
                    Caption = 'Member Accounts';
                    RunObject = Page "Member List";
                    ToolTip = 'View Member Accounts';
                    Visible = false;
                }
                group("Account Opening")
                {
                    Caption = 'Membership Registration';
                    action(NewAccountOpening)
                    {
                        ApplicationArea = All;
                        Caption = 'New Account Opening';
                        RunObject = page "Membership Application List";
                        RunPageView = WHERE(status = CONST(open));
                        RunPageMode = Edit;
                    }
                    action(NewAccountPending)
                    {
                        ApplicationArea = All;
                        Caption = 'Applications Pending Approval';
                        RunObject = page "Membership Application-Pending";
                        RunPageView = WHERE(status = CONST(pending));
                        RunPageMode = View;
                    }
                    action(NewApprovedAccounts)
                    {
                        ApplicationArea = all;
                        Caption = 'Applications Pending Creation';
                        RunObject = Page "Member Applications -Approved";
                        RunPageMode = View;
                        RunPageView = WHERE(status = CONST(approved));
                    }
                    action("CreatedAccounts")
                    {
                        ApplicationArea = all;
                        Caption = 'Closed Membership Applications';
                        RunObject = Page "Member Applications -Closed";
                        RunPageMode = View;
                        RunPageView = WHERE(status = CONST(closed));
                    }
                }
                group("Membership Exit")
                {
                    action("Member Withdrawal List")
                    {
                        ApplicationArea = all;
                        RunObject = page "Membership Exit List";
                    }
                    action("Approved Membership Exit")
                    {
                        ApplicationArea = all;
                        RunObject = page "Membership Exit List-Posted";
                        RunPageView = where(status = const(Approved), posted = const(false));
                    }
                    action("Posted Membership Exit")
                    {
                        ApplicationArea = all;
                        RunObject = page "Membership Exit List-Posted";
                        RunPageView = where(Posted = const(true));
                    }
                }
                group("Membership Re-Application")
                {
                    action("Member Re-Application List")
                    {
                        RunObject = page "Member Re-Application List";
                        Enabled = true;
                        ApplicationArea = all;
                    }
                    action("Member Re-Application posted")
                    {
                        RunObject = page "MemberRe-ApplicationListPosted";
                        Enabled = true;
                        Caption = ' Member Re-Application Posted';
                        ApplicationArea = all;
                    }
                }
                group("Member Reports")
                {
                    Caption = 'Membership Reports';
                    action("Sacco Membership Reports")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member Accounts List";
                        ToolTip = 'Members Register';
                    }
                    action("Member Account Balances Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member Account  balances";
                        ToolTip = 'Member Account Summary Report.';
                    }
                    action(MembersavingReport)
                    {
                        ApplicationArea = all;
                        Caption = 'Member savings columnar report.';
                        RunObject = report "Member savings report";
                    }
                    action(memberwithoutsharecapitalReport)
                    {
                        ApplicationArea = all;
                        Caption = 'Members without minimum share capital report.';
                        RunObject = report MemberwithoutMinshapitalreport;
                    }
                    action(MemberwithoutPassportReport)
                    {
                        ApplicationArea = all;
                        Caption = 'Members without passports report.';
                        RunObject = report Memberswithoutpassportsreport;
                    }
                    action(MemberwithoutSignatureReport)
                    {
                        ApplicationArea = all;
                        Caption = ' Members without signature report.';
                        RunObject = report Memberwithoutsignaturereport;
                    }
                    action(MemberApplicationReport)
                    {
                        ApplicationArea = all;
                        Caption = 'Member application report';
                        RunObject = report MembershipApplicationReport;
                    }
                    action(MemberswithoutLoanReport)
                    {
                        ApplicationArea = all;
                        Caption = 'Members Without Loan report';
                        RunObject = report MemberwithoutLoanReport;
                    }
                    action(MembersReport)
                    {
                        ApplicationArea = all;
                        Caption = 'Members report';
                        RunObject = report MemberReport;
                        ToolTip = 'Members Report Contains all Members status';
                    }
                    action("Membership Closure Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Membership Exit Reports';
                        RunObject = report "Membership Closure Report";
                    }

                    //
                    action("Member Next Of Kin Details")
                    {
                        ApplicationArea = All;
                        Caption = 'Benificiary Report';
                        RunObject = report "Next of Kin Details Report";
                    }
                    action("Members Without Next of Kin")
                    {
                        ApplicationArea = All;
                        RunObject = report MemberWithoutNextOfKin;
                    }
                    action("Member shares Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member Share Capital Statement";
                    }
                    action("Member Deposits Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Members Deposits Statement";
                    }
                    action("Member Detailed Statement")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member Detailed Statement";
                    }
                    action("Member Accounts Statement")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member Account Statement";
                    }
                }
            }

            //'''''''''''''''''''''''''''''''''''''''''END OF MEMBERSHIP MANAGEMENT

            //.....................................START OF LOAN MANAGEMENT
            group(SaccoLoansManagement)
            {
                Caption = 'Credit Management';
                ToolTip = 'Manage BOSA Loans Module';
                group("BOSA Loans Management")
                {
                    Caption = 'New BOSA Loans Applications';
                    ToolTip = 'BOSA Loans'' Management Module';
                    action("BOSA Loan Application")
                    {
                        ApplicationArea = All;
                        Caption = 'BOSA Loan Application List';
                        Image = Loaners;
                        RunObject = Page "Loan List-New Application BOSA";
                        ToolTip = 'Open BOSA Loan Applications List';
                        RunPageView = where(Posted = const(false), "Loan Status" = const(Application));
                    }
                    action("Pending BOSA Loan Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'BOSA Loans Pending Approval';
                        Image = CreditCard;
                        RunObject = Page "LoanList-Pending Approval BOSA";
                        ToolTip = 'Open the list of BOSA Loans Pending Approval';
                    }
                    action("Approved Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'BOSA Loans Pending Disbursement.';
                        RunObject = Page "Loan Application BOSA-Approved";
                        ToolTip = 'Open the list of Approved Loans Pending Disbursement.';
                    }
                }
                group("Loan Batching")
                {
                    Visible = false;
                    action("Loan Batch List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Loans Disbursment Batch List";
                    }
                    action("Posted Loan Batch List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Posted Loan Batch - List";
                    }
                }
                group("Loans Appeals")
                {
                    // Visible = false;
                    Caption = 'Loan Restructure';
                    action("Loan Appeal List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Loan Appeal List";
                        Caption = 'Loans Restructure List';
                    }
                    action("Loans Appealed Posted")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Loan Appeal List Posted";
                        Caption = 'Loans Restructured List';
                    }
                }
                group("Loans' Reports")
                {
                    action("Loans Balances Report")
                    {
                        ApplicationArea = all;
                        RunObject = Report "Loan Balances Report";
                        Caption = 'Member Loans Book Report';
                        ToolTip = 'Member Loans Book Report';
                    }

                    action("Loans Guard Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Loan Guard Report";
                        ToolTip = 'Loans Guard Report';
                    }
                    action("Loan defaulter List")
                    {
                        ApplicationArea = all;
                        RunObject = report "Loan Defaulters List";
                    }
                    action("Loans Register")
                    {
                        ApplicationArea = all;
                        Caption = 'Member Loan Register';
                        RunObject = Report "Loans Register";
                        ToolTip = 'Loan Register Report';
                    }
                    action("Loans Arreas Report")
                    {
                        ApplicationArea = all;
                        RunObject = Report "Loan Arrears Report";
                        ToolTip = 'Loan Arreas Report';
                    }
                    action("Loans Guarantor Details Report")
                    {
                        ApplicationArea = all;
                        RunObject = Report "Loans Guarantor Details Report";
                        ToolTip = 'Loans Securities Report';
                    }
                }
                action("PostedLoans")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted BOSA Loans';
                    RunObject = Page "Loans Posted List";
                    ToolTip = 'Open the list of the Loans Posted.';
                }
                action("Loan Calculator")
                {
                    RunObject = page "Loans Calculator List";
                    ApplicationArea = all;
                }
            }

            group(BosaManagement)
            {
                Caption = 'Other Bosa Management Functions';
                //................................................START OF CHANGE REQUEST MENU.........................
                group(ChangeRequest)
                {
                    Caption = 'Change Request';
                    action("Change Request")
                    {
                        ApplicationArea = All;
                        Caption = 'Change Request List';
                        RunObject = Page "Change Request List";
                        ToolTip = 'Change Member Details';
                    }
                    action(updatedchangereqslist)
                    {
                        ApplicationArea = All;
                        Caption = 'Updated Change requests';
                        RunObject = page "Updated Change Request List";
                    }
                }

                //...........................START OF TRANSFERS MENU .........................................
                group(Transfers)
                {
                    Caption = 'BOSA Transfers';
                    action(TransfersList)
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Transfers List';
                        Image = Customer;
                        RunObject = page "BOSA Transfer List";
                        ToolTip = 'Make member receiptings for payments done by member';
                    }
                    action(PostedTransfers)
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Posted Transfer List';
                        Image = Customer;
                        RunObject = page "BOSA Transfer Posted";
                        ToolTip = 'BOSA Transfer Posted';
                        RunPageView = where(Posted = const(true));
                    }
                }
                //......................................................................................
                group("Bosa Receipts")
                {
                    Caption = 'Bosa Receipts';

                    action("Bosa Receipt")
                    {
                        ApplicationArea = All;
                        Caption = 'Bosa Receipts';
                        RunObject = page "BOSA Receipts List";
                    }
                    action(" Posted Bosa Receipt")
                    {
                        ApplicationArea = All;
                        caption = 'Posted Bosa Receipts';
                        RunObject = page "Posted BOSA Receipts List";
                    }
                }

                //.........................End of Collateral Management......................................

                //...................................Guarantor Management........................................
                group("Guarantor Management")
                {
                    Caption = 'Guarantor Management';
                    action("Guarantor Substitution List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Guarantorship Sub List";
                    }
                    action("Effected Guarantor Substitution")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Loans Guarantee Details";
                    }
                    action("Member Loans Guaranteed")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loans Guaranteed";
                    }
                    action("Members Loan  Guarantors")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loan Guarantors";
                    }
                }

                //...............................................Start of BOSA Reports.........................
                group("BOSA Reports")
                {
                    action("New Members Report")
                    {
                        Caption = 'New Members Report';
                        RunObject = report "New Member Accounts";
                    }
                    action("Sacco Loan Disbursements")
                    {
                        Caption = 'Loan Disbursements Report';
                        RunObject = report "Sacco Loan Disbursements";
                    }
                    action("Loan Totals Per Category")
                    {
                        Caption = 'Loan Totals Per Category';
                        RunObject = report "Loan Totals Per Employer";
                    }
                    action("Loans Portfolio Reports")
                    {
                        Caption = 'Loans Portfolio Reports';
                        RunObject = report "Loans Potfolio Analysis";
                    }
                    action("Loans Portfolio Concentration Reports")
                    {
                        Caption = 'Loans Portfolio Concentration Reports';
                        RunObject = report "Loan Portifolio Concentration";
                    }

                }
                //.....................................End Of BOSA

                //..............................................................................................

                group(BOSAPeriodicActivities)
                {
                    Caption = 'Periodic Activities';

                    action("Update Member Dormancy")
                    {
                        RunObject = report "Update Member Dormancy";
                        ApplicationArea = all;
                        Visible = false;
                    }
                    group(LoanDefaulter)
                    {
                        Caption = 'Loan Defaulter Notices';
                        action(LoanDefaulter1st)
                        {
                            Caption = 'Loan Defaulter 1st Notice';
                            Image = Setup;
                            RunObject = report "Loan Defaulter 1st Notice";
                        }
                        action(LoanDefaulter2nd)
                        {
                            Caption = 'loan Defaulter 2nd Notice';
                            Image = Setup;
                            RunObject = report "Loan Defaulter 2nd Notice";
                        }
                        action("Loan Defaulter Final Notice")
                        {
                            Image = Setup;
                            RunObject = report "Loan Defaulter Final Notice";
                        }
                    }
                    group(CheckOffDistributed)
                    {
                        Caption = 'Checkoff Processing-Distributed';
                        Visible = false;
                        action("Checkoff Processing List")
                        {
                            Caption = 'Checkoff Processing List';
                            Image = Setup;
                            RunObject = page "Checkoff Processing-D List";
                        }
                        action(CheckoffProcessingDistributed)
                        {
                            Caption = 'Checkoff Processing-Distributed';
                            Image = Setup;
                            RunObject = page "Transfer Schedule";
                        }
                    }
                    group(CheckOffBlocked)
                    {
                        Caption = 'Checkoff Processing-Blocked';
                        action("Checkoff Processing List Blocked")
                        {
                            Caption = 'Employer Checkoff Remittance';
                            Image = Setup;
                            RunObject = page "Bosa Receipts H List-Checkoff";
                        }
                        action("Posted Employer Checkoff Remittance")
                        {
                            Caption = 'Posted Employer Checkoff Remittance';
                            Image = Setup;
                            RunObject = page "Posted Bosa Rcpt List-Checkof";
                        }
                    }
                    // group(CheckOffAdvice)
                    // {
                    //     Caption = 'Check-Off Advice';
                    action("Check off Adivice-Breakdown")
                    {
                        Image = Setup;
                        Caption = 'Checkoff Advice';
                        RunObject = report "Check Off Advice";
                    }
                    //     action("Check off Adivice-Lumpsum")
                    //     {
                    //         Image = Setup;
                    //         RunObject = report "Check Off Advice-Lumpsum";
                    //         Visible = false;
                    //     }
                    // }
                    group(MonthlyInterestProcessing)
                    {
                        Caption = 'Monthly Interest Processing';
                        action("Post Monthly Interest")
                        {
                            Caption = 'Post Monthly Interest';
                            Image = Setup;
                            RunObject = report "Post Monthly Interest.";
                            ToolTip = 'Used to process Loans Monthly Interest';
                        }
                        action("Process Fixed Deposits")
                        {
                            Caption = 'Run Fixed deposits';
                            RunObject = report "Run Fixed Deposits";
                            ToolTip = 'Used to Process monthly fixed deosits';

                        }
                    }
                    group(Dividends)
                    {
                        Caption = 'Dividends';
                        group(Prorated)
                        {
                            Caption = 'Prorated';
                            action("Dividends Processing-Prorated")
                            {
                                Caption = 'Dividends Processing-Prorated';
                                Image = Setup;
                                RunObject = report "Dividend Processing-Prorated";
                            }
                            action("Dividends Register")
                            {
                                Caption = 'Dividends Register';
                                Image = Setup;
                                RunObject = report "Dividend Register";
                            }
                            action(DividendProgressionSlip)
                            {
                                Caption = 'Dividend Progression Slip';
                                Image = Setup;
                                RunObject = report "Dividends Progressionslip";
                                Visible = false;
                            }
                            action("Dividends Payments Report")
                            {
                                ApplicationArea = all;
                                RunObject = Report "Dividends Payments";
                            }
                        }
                        group("Share capital Manangement")
                        {
                            action("Share Capital Recovery")
                            {
                                Image = ReceiveLoaner;
                                ApplicationArea = all;
                                Caption = 'Recover Sharecapital from Deposits';
                                RunObject = report "Share Capital Recovery";
                            }
                            group(SharecapitalTrading)
                            {
                                action(SharecapitalTradingList)
                                {
                                    ApplicationArea = Basic, Suite;
                                    RunObject = page "Share Capital Trading List";
                                    Caption = 'Sharecapital Trading List';
                                }
                                action(SharecapitalTradingListPosted)
                                {
                                    ApplicationArea = Basic, Suite;
                                    RunObject = page "Share Capital Trading Posted";
                                    Caption = 'Sharecapital Trading List Posted';
                                }
                            }
                        }
                    }
                }
            }
            //....................... START OF ALTERNATIVE CHANNELS MAIN MENU ...................................

            group(CloudPesa)
            {
                Caption = 'Alternative Channels';

                group("SMS Messages")
                {
                    Caption = 'SMS Messages';
                    ToolTip = 'SMS Messages.';
                    action("SentSMS")
                    {
                        Caption = 'Sent SMS';
                        Image = PostedReceipt;
                        RunObject = page "SMS Messages";
                        ToolTip = 'Sent SMS.';
                    }
                    action("Send BULK SMS")
                    {
                        Caption = 'Send BULK SMS';
                        Image = PostedReceipt;
                        RunObject = page "Bulk SMS Header List";
                        ToolTip = 'Sent SMS.';
                    }
                }
                group("Login Management")
                {
                    Caption = 'Password Manager';
                    action("Password Manager")
                    {
                        Caption = 'Password Manager';
                        Image = LoginManagement;
                        RunObject = page "Password Manager";
                    }
                }
            }

            //......................... START OF CRM Main MENU ...............................................
            group(SaccoCRM)
            {
                Caption = 'CRM';
                Visible = false;

                action("CRM Member List")
                {
                    Caption = 'CRM Member List';
                    ApplicationArea = basic, suite;
                    Image = ProdBOMMatrixPerVersion;
                    RunObject = page "CRM Member List";
                }
                group("Case Management")
                {
                    action("Case Registration")
                    {
                        Caption = 'Lead Management';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        RunObject = page "Lead list";
                        RunPageView = WHERE(status = CONST(New));
                        ToolTip = 'Create a New Case enquiry';
                    }
                    action("Assigned Cases")
                    {
                        Caption = 'Assigned Cases';
                        ApplicationArea = basic, suite;
                        Image = Open;
                        RunObject = page "Lead list Escalated";
                        RunPageView = WHERE(status = CONST(Escalted));
                        ToolTip = 'Open List Of Cases open & Assigned To Me';
                    }
                    action("Resolved Case Enquiries")
                    {
                        Caption = 'Resolved Cases Enquiries';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        RunObject = page "Lead list Closed";
                        RunPageView = WHERE(status = CONST(Resolved));
                        ToolTip = 'Resolved Cases Enquiries';
                    }
                    action("Unreolved Case Enquiries")
                    {
                        Caption = 'Unresolved Case Enquiries';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        RunObject = page "Lead list Closed";
                        RunPageView = WHERE("Lead Status" = CONST(open));
                        ToolTip = 'Unresolved Cases Enquiries';
                    }
                    action("Member FeedBack")
                    {
                        Caption = 'Member FeedBacks';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        RunObject = page "Member FeedBack List";
                    }
                    group("CRM Reports")
                    {
                        action("Resolved Cases")
                        {
                            Caption = 'Resolved Cases';
                            ApplicationArea = basic, suite;
                            Image = Report;
                            RunObject = report "CRM Resolved Cases Report";
                            ToolTip = 'Resolved Cases';
                        }
                        action("UnResolved Cases")
                        {
                            Caption = 'UnResolved Cases';
                            ApplicationArea = basic, suite;
                            Image = Report;
                            RunObject = report "CRM UnResolved Cases Report";
                            ToolTip = 'UnResolved Cases';
                        }
                        action("customer Feed Back Report")
                        {
                            Caption = 'Customer Feed Back Report';
                            ApplicationArea = basic, suite;
                            Image = Report;
                            RunObject = report MemberFeedBackReport;
                        }
                        action("Complaints Report")
                        {
                            ApplicationArea = basic, suite;
                            Image = Report;
                            RunObject = report MemberComplaintsReport;
                        }
                        action("Member Feedback and Satisfaction Report")
                        {
                            Caption = 'Member Feedback and Satisfaction Report';
                            ApplicationArea = basic, suite;
                            Image = Report;
                            RunObject = report MemberFeedBackReport;
                        }
                        action(MemberSuggestionsReport)
                        {
                            Caption = 'Member Suggestions Report';
                            ApplicationArea = all;
                            Image = Report;
                            RunObject = report MemberSugestionReport;
                        }
                        action(MemberResolutionTimeTaken)
                        {
                            Caption = 'Members’ resolution time taken report';
                            ApplicationArea = all;
                            RunObject = report MemberResolutionTimeTaken;
                        }
                    }
                }
                group("CRM Gen Setup")
                {
                    action("CRM General setup")
                    {
                        Caption = 'CRM General Setup';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        RunObject = page "CRM General SetUp";
                        ToolTip = 'CRM Setup';
                    }
                    action("CRM CaseS types")
                    {
                        Caption = 'CRM Case types';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        RunObject = page "CRM Case Types";
                        ToolTip = 'CRM Case Types';
                        Visible = false;
                    }
                }
            }
            //........................... End of CRM MAIN MENU ...............................................

            group("Agile Payroll Management")
            {
                group("Payroll Employees")
                {
                    action("Payroll Employee List")
                    {
                        RunObject = page "Payroll Employee List.";
                        ApplicationArea = All;
                    }
                    action("Payroll Earnings List.")
                    {
                        RunObject = page "Payroll Earnings List.";
                        ApplicationArea = All;
                    }
                    action("Payroll Deductions List.")
                    {
                        RunObject = page "Payroll Deductions List.";
                        ApplicationArea = All;
                        Visible = false;
                    }
                    action("Payroll Employee Earnings.")
                    {
                        RunObject = page "Payroll Employee Earnings.";
                        ApplicationArea = All;
                        Visible = false;
                    }
                    action("Payroll Employee Deductions.")
                    {
                        RunObject = page "Payroll Employee Deductions.";
                        ApplicationArea = All;
                        Visible = false;
                    }
                }
                group("Payrolll Periodic Activities")
                {
                    action("Payroll Periods")
                    {
                        RunObject = page "Payroll Periods.";
                        ApplicationArea = All;
                    }
                    action("Transfer Payroll to journal")
                    {
                        RunObject = report "Payroll JournalTransfer.";
                        ApplicationArea = All;
                    }
                    action("General Journal")
                    {
                        RunObject = page "General Journal";
                        ApplicationArea = All;
                        Visible = false;
                    }
                }
                group(Reports1)
                {
                    Caption = 'Reports';
                    action("Payroll Employees Report")
                    {
                        RunObject = report "Payroll Employees Report.";
                        ApplicationArea = All;
                    }
                    action("NHIF Report")
                    {
                        RunObject = report "NHIF Schedule W..";
                        ApplicationArea = all;
                    }
                    action("NSSF Report")
                    {
                        RunObject = report "NSSF Schedule W..";
                        ApplicationArea = all;
                    }
                    action("Payroll Summary")
                    {
                        RunObject = report "Payroll Summary";
                        ApplicationArea = All;
                    }
                    action("Payroll Payee")
                    {
                        RunObject = report "PAYE Schedule";
                        ApplicationArea = All;
                    }
                    action("P9 Report")
                    {
                        RunObject = report "P9 Report";
                        ApplicationArea = All;
                    }
                    action("Staff Salaries Report")
                    {
                        RunObject = report "Staff Salaries Report";
                        Caption = 'Staff Loan Report';
                        ApplicationArea = all;
                    }
                }
                group(Setup1)
                {
                    Caption = 'Payroll Setup';
                    action("Payroll PAYE Setup")
                    {
                        RunObject = page "Payroll PAYE Setup.";
                        ApplicationArea = All;
                    }
                    action("Payroll NSSF Setup")
                    {
                        RunObject = page "Payroll NSSF Setup.";
                        ApplicationArea = All;
                    }
                    action("Payroll NHIF Setup")
                    {
                        RunObject = page "Payroll NHIF Setup.";
                        ApplicationArea = All;
                    }
                    action("Payroll Posting Group")
                    {
                        RunObject = page "Payroll Posting Group.";
                        ApplicationArea = All;
                    }
                    action("Payroll Transaction List")
                    {
                        RunObject = page "Payroll Transaction List.";
                        ApplicationArea = All;
                    }
                    action("Payroll Period Transactions")
                    {
                        RunObject = page "Payroll Period Transaction.";
                        ApplicationArea = All;
                    }
                    action("Payroll General Setup LIST")
                    {
                        RunObject = page "Payroll General Setup LIST.";
                        ApplicationArea = All;
                    }
                }
            }

#if not CLEAN18

#if not CLEAN18
            group(SetupAndExtensions)
            {
            }

            group("System Administration")
            {
                group("Address setup")
                {
                    action("Postal codes")
                    {
                        RunObject = page "Post Codes";
                        ApplicationArea = all;
                    }
                    action("Sacco Employers")
                    {
                        RunObject = page "Employer list";
                        ApplicationArea = all;
                    }
                    action("Next of Kin Relations Types")
                    {
                        RunObject = page "Relationship list";
                        ApplicationArea = all;
                    }
                }
                action("Sacco General Setup")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Sacco General Set-Up";
                }
                action("Sacco No. Series")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Sacco No. Series";
                }
                action("Payment Types List")
                {
                    Caption = 'Payment Types Setup';
                    ApplicationArea = Basic, Suite;
                    Image = Setup;
                    RunObject = page "Payment Types List";
                    ToolTip = 'Payment Types Setup';
                }
                group("Sacco Workflow Mgmt")
                {
                    Visible = true;
                    action("Workflow Categories")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Workflow Categories";
                    }
                    action("Workflows Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page Workflows;
                    }
                    action("Workflow User Groups")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Workflow User Groups";
                    }
                }
                group(userssetup)
                {
                    caption = 'User Setups';
                    action(userAccountsSetups)
                    {
                        Caption = 'User Account Setups';
                        Image = Setup;
                        RunObject = page "User Setup";
                    }
                    action("Approval User Setup")
                    {
                        Caption = 'User Approval Setup';
                        Image = Setup;
                        RunObject = page "Approval User Setup";
                    }
                    action("User Permisions")
                    {
                        Caption = 'User Account Permissions';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Status Change Permisions";
                    }
                    action("User Branch Setup")
                    {
                        Caption = 'Users Branch Setups';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "User Branch Set Up";
                    }
                    action("Funds User Setup")
                    {
                        Caption = 'Funds User Setup ';
                        ApplicationArea = Basic, Suite;
                        Image = Check;
                        RunObject = page "Funds User Setup";
                        ToolTip = 'Funds User Setup';
                    }
                    action("User Workflow Setup")
                    {
                        Caption = 'User Workflow Setup';
                        ApplicationArea = Basic, Suite;
                        Image = Check;
                        RunObject = page "Workflows";
                    }
                }
                group(loanssetup)
                {
                    Caption = 'BOSA Setup';
                    action(LoansproductSetup)
                    {
                        Caption = 'Loans Product Setup';
                        Image = Setup;
                        RunObject = page "Loan Products Setup List";
                    }
                }
                group("Finance Setups")
                {
                    Caption = 'Finance Setups';
                    ToolTip = ' All Finance Module Setups ';
                    Visible = true;
                    action("General Ledger setup")
                    {
                        ApplicationArea = Basic;
                        RunObject = Page "General Ledger Setup";
                    }
                    action("Accounting Period Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Accounting Period Setup';
                        RunObject = page "Accounting Periods";
                    }
                    action("Funds Transaction Types")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Funds Transaction Types';
                        RunObject = page "Funds Transaction Types";
                    }
                }
                Group("FundsTransferSetup")
                {
                    Caption = 'Funds Tranfer Setups';

                    action("FundsGeneralSetup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Funds General Setup';
                        RunObject = Page "Funds General Setup";
                    }
                    action("RepaymentTypes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Funds Repayment Funds';
                        RunObject = Page "Funds General Setup";
                    }
                    action("ReceiptTypes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Funds Receipt Types';
                        RunObject = Page "Funds General Setup";
                    }
                }
                group("workflow")
                {
                    action("Posting groups")
                    {
                        Caption = 'Customer Posting Groups';
                        Image = CashFlow;
                        RunObject = page "Customer Posting Groups";
                    }
                }
            }
            group("Audit Trails")
            {
                action("Session Tracker")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Session Tracker";
                }
                action("Transaction Log")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "System Transaction Log";
                }
                action("Posting Audit Trail")
                {
                    ApplicationArea = all;
                    RunObject = report "Ledger enries audit Trail";
                }
                action("Read Log")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "System Change Entry Log";
                    Caption = 'System Change Entry Log';
                }
                action("User ID")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "User";
                    Caption = 'User ID';
                }
                action("Log Reg")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "LogReg";
                    Caption = 'Log Reg';
                }
                action("Log Reg Minutes")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "LogRegMinutes";
                    Caption = 'Log Reg Minutes';
                }
                action("Approval Details")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Approval Details";
                    Caption = 'Approval Details';
                }
                action("Approval Details Rec")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Approval Details rec";
                    Caption = 'Approval Details Rec';
                }
            }
        }

#endif
    }
}

#endif