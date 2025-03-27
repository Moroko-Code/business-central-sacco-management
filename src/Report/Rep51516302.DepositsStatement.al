#pragma warning disable AA0005,AL0579,AL0600,AL0589, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516302 "Deposits Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Deposits Statement.rdlc';

    dataset
    {
        dataitem("Members Register"; Customer)
        {
            RequestFilterFields = "No.", "Loan Product Filter", "Outstanding Balance", "Date Filter";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(USERID; UserId)
            {
            }
            column(PayrollStaffNo_Members; "Members Register"."Payroll/Staff No")
            {
            }
            column(No_Members; "Members Register"."No.")
            {
            }
            column(Name_Members; "Members Register".Name)
            {
            }
            column(EmployerCode_Members; "Members Register"."Employer Code")
            {
            }
            column(PageNo_Members; CurrReport.PageNo)
            {
            }
            column(Shares_Retained; "Members Register"."Shares Retained")
            {
            }
            column(ShareCapBF; ShareCapBF)
            {
            }
            column(IDNo_Members; "Members Register"."ID No.")
            {
            }
            column(GlobalDimension2Code_Members; "Members Register"."Global Dimension 2 Code")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            // dataitem(Shares; "Cust. Ledger Entry")
            // {
            //     DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
            //     DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const(Investment), Reversed = filter(false));
            //     column(ReportForNavId_1102755022; 1102755022)
            //     {
            //     }
            //     column(openBalances; OpenBalance)
            //     {
            //     }
            //     column(CLosingBalances; CLosingBalance)
            //     {
            //     }
            //     column(Description_Shares; Shares.Description)
            //     {
            //     }
            //     column(DocumentNo_Shares; Shares."Document No.")
            //     {
            //     }
            //     column(PostingDate_Shares; Shares."Posting Date")
            //     {
            //     }
            //     column(CreditAmount_Shares; Shares."Credit Amount")
            //     {
            //     }
            //     column(DebitAmount_Shares; Shares."Debit Amount")
            //     {
            //     }
            //     column(Amount_Shares; Shares."Amount Posted")
            //     {
            //     }
            //     column(TransactionType_Shares; Shares."Transaction Type")
            //     {
            //     }
            //     column(Shares_Description; Shares.Description)
            //     {
            //     }

            //     trigger OnAfterGetRecord()
            //     begin
            //         CLosingBalance := CLosingBalance - Shares."Amount Posted";
            //         if Shares."Amount Posted" < 0 then
            //             Shares."Credit Amount" := (Shares."Amount Posted" * -1)
            //         else
            //             if Shares."Amount Posted" > 0 then
            //                 Shares."Debit Amount" := (Shares."Amount Posted");
            //     end;

            //     trigger OnPreDataItem()
            //     begin
            //         CLosingBalance := ShareCapBF;
            //         OpeningBal := ShareCapBF * -1;
            //     end;
            // }
            dataitem(Deposits; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("Deposit Contribution"), Reversed = filter(false));
                PrintOnlyIfDetail = false;
                column(ReportForNavId_1102755004; 1102755004)
                {
                }
                column(OpeningBal; OpeningBal)
                {
                }
                column(ClosingBal; ClosingBal)
                {
                }
                column(TransactionType_Deposits; Deposits."Transaction Type")
                {
                }
                column(Amount_Deposits; Deposits."Amount Posted")
                {
                }
                column(Description_Deposits; Deposits.Description)
                {
                }
                column(DocumentNo_Deposits; Deposits."Document No.")
                {
                }
                column(PostingDate_Deposits; Deposits."Posting Date")
                {
                }
                column(DebitAmount_Deposits; Deposits."Debit Amount")
                {
                }
                column(CreditAmount_Deposits; Deposits."Credit Amount")
                {
                }
                column(Deposits_Description; Deposits.Description)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    ClosingBal := ClosingBal + Deposits."Amount Posted";
                    if Deposits."Amount Posted" < 0 then
                        Deposits."Credit Amount" := (Deposits."Amount Posted" * -1)
                    else
                        if Deposits."Amount Posted" > 0 then
                            Deposits."Debit Amount" := (Deposits."Amount Posted");
                end;

                trigger OnPreDataItem()
                begin
                    ClosingBal := SharesBF;
                    OpeningBal := SharesBF * -1;
                end;
            }
            dataitem(Pepea; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                // DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("Normal shares"), Reversed = filter(false));
                column(ReportForNavId_1102755055; 1102755055)
                {
                }
                column(OpenBalancesPepea; OpenBalancePS)
                {
                }
                column(CLosingBalancesPepea; CLosingBalancePS)
                {
                }
                column(Description_Pepea; Pepea.Description)
                {
                }
                column(DocumentNo_Pepea; Pepea."Document No.")
                {
                }
                column(PostingDate_Pepea; Pepea."Posting Date")
                {
                }
                column(CreditAmount_Pepea; Pepea."Credit Amount")
                {
                }
                column(DebitAmount_Pepea; Pepea."Debit Amount")
                {
                }
                column(Amount_Pepea; Pepea."Amount Posted")
                {
                }
                column(TransactionType_Pepea; Pepea."Transaction Type")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLosingBalancePS := CLosingBalancePS - Pepea."Amount Posted";
                    if Pepea."Amount Posted" < 0 then
                        Pepea."Credit Amount" := (Pepea."Amount Posted" * -1)
                    else
                        if Pepea."Amount Posted" > 0 then
                            Pepea."Debit Amount" := (Pepea."Amount Posted");
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalancePS := PepeaSharesBF;
                    OpenBalancePS := PepeaSharesBF * -1;
                end;
            }
            // dataitem(Preferencial; "Cust. Ledger Entry")
            // {
            //     DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
            //     DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("Loan Penalty"), Reversed = filter(false));
            //     column(ReportForNavId_1000000061; 1000000061)
            //     {
            //     }
            //     column(OpenBalance_Pref; OpenBalancePref)
            //     {
            //     }
            //     column(ClosingBal_Pref; ClosingBalPref)
            //     {
            //     }
            //     column(Description_Pref; Preferencial.Description)
            //     {
            //     }
            //     column(DocumentNo_Pref; Preferencial."Document No.")
            //     {
            //     }
            //     column(PostingDate_Pref; Preferencial."Posting Date")
            //     {
            //     }
            //     column(CreditAmount_Pref; Preferencial."Credit Amount")
            //     {
            //     }
            //     column(DebitAmount_Pref; Preferencial."Debit Amount")
            //     {
            //     }
            //     column(Amount_Pref; Preferencial."Amount Posted")
            //     {
            //     }
            //     column(TransactionType_Pref; Preferencial."Transaction Type")
            //     {
            //         OptionCaption = ' ,Registration Fee,Loan,Repayment,Withdrawal,Interest Due,Interest Paid,Benevolent Fund,Deposit Contribution,Penalty Charged,Application Fee,Appraisal Fee,Executive,Unallocated Funds,Shares Capital,Loan Adjustment,Dividend,Withholding Tax,Administration Fee,Insurance Contribution,Prepayment,Ordinary Building Shares(2),Xmas Contribution,Penalty Paid,Dev Shares,Tax Shares,Welfare Contribution 2,Loan Penalty,Loan Guard,Preferencial Building Shares,Van Shares,Bus Shares,Computer Shares,Ordinary Building Shares,Housing Deposits Shares,M Pesa Charge ,Insurance Charge,Insurance Paid,FOSA Account,Partial Disbursement,Loan Due,FOSA Shares,Loan Form Fee,Kuscco Shares,CIC shares,COOP Shares,Pepea Shares';
            //     }

            //     trigger OnAfterGetRecord()
            //     begin
            //         ClosingBalPref := ClosingBalPref - Preferencial."Amount Posted";
            //         if Preferencial."Amount Posted" < 0 then
            //             Preferencial."Credit Amount" := (Preferencial."Amount Posted" * -1)
            //         else
            //             if Preferencial."Amount Posted" > 0 then
            //                 Preferencial."Debit Amount" := (Preferencial."Amount Posted");
            //     end;

            //     trigger OnPreDataItem()
            //     begin
            //         ClosingBalPref := PrefSharesBF;
            //         OpenBalancePref := PrefSharesBF * -1;
            //     end;
            // }
            // dataitem(FShares; "Cust. Ledger Entry")
            // {
            //     DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
            //     DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("Partial Disbursement"), Reversed = filter(false));
            //     column(ReportForNavId_1000000016; 1000000016)
            //     {
            //     }
            //     column(OpenBalancesFs; OpenBalanceHse)
            //     {
            //     }
            //     column(CLosingBalancesFs; CLosingBalanceHse)
            //     {
            //     }
            //     column(DescriptionFs; FShares.Description)
            //     {
            //     }
            //     column(DocumentNoFs; FShares."Document No.")
            //     {
            //     }
            //     column(PostingDateFs; FShares."Posting Date")
            //     {
            //     }
            //     column(CreditAmountFs; FShares."Credit Amount")
            //     {
            //     }
            //     column(DebitAmountFs; FShares."Debit Amount")
            //     {
            //     }
            //     column(AmountFs; FShares."Amount Posted")
            //     {
            //     }
            //     column(TransactionTypeFs; FShares."Transaction Type")
            //     {
            //     }

            //     trigger OnAfterGetRecord()
            //     begin
            //         CLosingBalanceFs := CLosingBalanceFs - FShares."Amount Posted";
            //         if FShares."Amount Posted" < 0 then begin
            //             FShares."Credit Amount" := (FShares."Amount Posted" * -1);
            //         end else
            //             if FShares."Amount Posted" > 0 then begin
            //                 FShares."Debit Amount" := (FShares."Amount Posted");
            //             end;
            //     end;

            //     trigger OnPreDataItem()
            //     begin
            //         CLosingBalanceFs := HseBF;
            //         OpenBalanceFs := HseBF * -1;
            //     end;
            // }
            dataitem(Cshares; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                // DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const(Konza), Reversed = filter(false));
                column(ReportForNavId_1102755066; 1102755066)
                {
                }
                column(OpenBalancesCshare; OpenBalanceCs)
                {
                }
                column(CLosingBalancesCshare; CLosingBalanceCs)
                {
                }
                column(DescriptionCshare; Cshares.Description)
                {
                }
                column(DocumentCshare; Cshares."Document No.")
                {
                }
                column(PostingDateCshare; Cshares."Posting Date")
                {
                }
                column(CreditAmountCshare; Cshares."Credit Amount")
                {
                }
                column(DebitAmountCshare; Cshares."Debit Amount")
                {
                }
                column(AmountCshare; Cshares."Amount Posted")
                {
                }
                column(TransactionTypeCshare; Cshares."Transaction Type")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    CLosingBalanceCs := CLosingBalanceCs - Cshares."Amount Posted";
                    if Cshares."Amount Posted" < 0 then
                        Cshares."Credit Amount" := (Cshares."Amount Posted" * -1)
                    else
                        if Cshares."Amount Posted" > 0 then
                            Cshares."Debit Amount" := (Cshares."Amount Posted");
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalanceCs := ComputerSharesBF;
                    OpenBalanceCs := ComputerSharesBF * -1;
                end;
            }
            // dataitem(Vshares; "Cust. Ledger Entry")
            // {
            //     DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
            //     DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("Loan Guard"), Reversed = filter(false));
            //     column(ReportForNavId_1102755076; 1102755076)
            //     {
            //     }
            //     column(OpenBalancesVs; OpenBalanceVs)
            //     {
            //     }
            //     column(CLosingBalancesVs; CLosingBalanceVs)
            //     {
            //     }
            //     column(DescriptionVs; Vshares.Description)
            //     {
            //     }
            //     column(DocumentNoVs; Vshares."Document No.")
            //     {
            //     }
            //     column(PostingDateVs; Vshares."Posting Date")
            //     {
            //     }
            //     column(CreditAmountVs; Vshares."Credit Amount")
            //     {
            //     }
            //     column(DebitAmountVs; Vshares."Debit Amount")
            //     {
            //     }
            //     column(AmountVs; Vshares."Amount Posted")
            //     {
            //     }
            //     column(TransactionTypeVs; Vshares."Transaction Type")
            //     {
            //         OptionCaption = ' ,Registration Fee,Loan,Repayment,Withdrawal,Interest Due,Interest Paid,Benevolent Fund,Deposit Contribution,Penalty Charged,Application Fee,Appraisal Fee,Executive,Unallocated Funds,Shares Capital,Loan Adjustment,Dividend,Withholding Tax,Administration Fee,Insurance Contribution,Prepayment,Ordinary Building Shares(2),Xmas Contribution,Penalty Paid,Dev Shares,Tax Shares,Welfare Contribution 2,Loan Penalty,Loan Guard,Preferencial Building Shares,Van Shares,Bus Shares,Computer Shares,Ordinary Building Shares,Housing Deposits Shares,M Pesa Charge ,Insurance Charge,Insurance Paid,FOSA Account,Partial Disbursement,Loan Due,FOSA Shares,Loan Form Fee,Kuscco Shares,CIC shares,COOP Shares,Pepea Shares';
            //     }

            //     trigger OnAfterGetRecord()
            //     begin

            //         //CLosingBalanceHse:=CLosingBalanceHse-Vshares."Amount Posted";
            //         CLosingBalanceVs := CLosingBalanceVs - Vshares."Amount Posted";
            //         if Vshares."Amount Posted" < 0 then begin
            //             Vshares."Credit Amount" := (Vshares."Amount Posted" * -1);
            //         end else
            //             if Vshares."Amount Posted" > 0 then begin
            //                 Vshares."Debit Amount" := (Vshares."Amount Posted");
            //             end;
            //     end;

            //     trigger OnPreDataItem()
            //     begin
            //         //CLosingBalanceHse:=HseBF;
            //         //OpenBalanceHse:=HseBF*-1;
            //         CLosingBalanceVs := VanSharesBF;
            //         OpenBalanceVs := VanSharesBF * -1;
            //     end;
            // }
            // dataitem(Holiday_Savers; "Cust. Ledger Entry")
            // {
            //     DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
            //     DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const(Prepayment), Reversed = filter(false));
            //     column(ReportForNavId_1000000026; 1000000026)
            //     {
            //     }
            //     column(OpenBalancesDep1; OpenBalanceDep1)
            //     {
            //     }
            //     column(CLosingBalancesDep1; CLosingBalanceDep1)
            //     {
            //     }
            //     column(DescriptionDep1; Holiday_Savers.Description)
            //     {
            //     }
            //     column(DocumentNoDep1; Holiday_Savers."Document No.")
            //     {
            //     }
            //     column(PostingDateDep1; Holiday_Savers."Posting Date")
            //     {
            //     }
            //     column(CreditAmountDep1; Holiday_Savers."Credit Amount")
            //     {
            //     }
            //     column(DebitAmountDep1; Holiday_Savers."Debit Amount")
            //     {
            //     }
            //     column(AmountDep1; Holiday_Savers."Amount Posted")
            //     {
            //     }
            //     column(TransactionTypeDep1; Holiday_Savers."Transaction Type")
            //     {
            //     }

            //     trigger OnAfterGetRecord()
            //     begin
            //         CLosingBalanceHse := CLosingBalanceHse - Holiday_Savers."Amount Posted";
            //         if Holiday_Savers."Amount Posted" < 0 then begin
            //             Holiday_Savers."Credit Amount" := (Holiday_Savers."Amount Posted" * -1);
            //         end else
            //             if Holiday_Savers."Amount Posted" > 0 then begin
            //                 Holiday_Savers."Debit Amount" := (Holiday_Savers."Amount Posted");
            //             end;
            //     end;

            //     trigger OnPreDataItem()
            //     begin
            //         CLosingBalanceHse := Dep1BF;
            //         OpenBalanceHse := Dep1BF * -1;
            //     end;
            // }
            // dataitem(HousingTitle; "Cust. Ledger Entry")
            // {
            //     DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
            //     DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = filter(Investment), Reversed = filter(false));
            //     column(ReportForNavId_1000000036; 1000000036)
            //     {
            //     }
            //     column(OpenBalancesDep2; OpenBalanceDep2)
            //     {
            //     }
            //     column(CLosingBalancesDep2; CLosingBalanceDep2)
            //     {
            //     }
            //     column(DescriptionDep2; HousingTitle.Description)
            //     {
            //     }
            //     column(DocumentNoDep2; HousingTitle."Document No.")
            //     {
            //     }
            //     column(PostingDateDep2; HousingTitle."Posting Date")
            //     {
            //     }
            //     column(CreditAmountDep2; HousingTitle."Credit Amount")
            //     {
            //     }
            //     column(DebitAmountDep2; HousingTitle."Debit Amount")
            //     {
            //     }
            //     column(AmountDep2; HousingTitle."Amount Posted")
            //     {
            //     }
            //     column(TransactionTypeDep2; HousingTitle."Transaction Type")
            //     {
            //     }

            //     trigger OnAfterGetRecord()
            //     begin
            //         CLosingBalanceDep2 := CLosingBalanceDep2 - HousingTitle."Amount Posted";
            //         if HousingTitle."Amount Posted" < 0 then
            //             HousingTitle."Credit Amount" := (HousingTitle."Amount Posted" * -1)
            //         else
            //             if HousingTitle."Amount Posted" > 0 then
            //                 HousingTitle."Debit Amount" := (HousingTitle."Amount Posted");
            //     end;

            //     trigger OnPreDataItem()
            //     begin
            //         CLosingBalanceDep2 := Dep2BF;
            //         OpenBalanceDep2 := Dep2BF * -1;
            //     end;
            // }
            // dataitem(SchoolFees; "Cust. Ledger Entry")
            // {
            //     DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
            //     DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("SchFee Shares"), Reversed = filter(false));
            //     PrintOnlyIfDetail = false;
            //     column(ReportForNavId_14; 14)
            //     {
            //     }
            //     column(OpeningBalSF; OpenBalanceSF)
            //     {
            //     }
            //     column(ClosingBalSF; CLosingBalanceSF)
            //     {
            //     }
            //     column(TransactionType_DepositsSF; SchoolFees."Transaction Type")
            //     {
            //     }
            //     column(Amount_DepositsSF; SchoolFees."Amount Posted")
            //     {
            //     }
            //     column(Description_DepositsSF; SchoolFees.Description)
            //     {
            //     }
            //     column(DocumentNo_DepositsSF; SchoolFees."Document No.")
            //     {
            //     }
            //     column(PostingDate_DepositsSF; SchoolFees."Posting Date")
            //     {
            //     }
            //     column(DebitAmount_DepositsSF; SchoolFees."Debit Amount")
            //     {
            //     }
            //     column(CreditAmount_DepositsSF; SchoolFees."Credit Amount")
            //     {
            //     }
            //     column(Deposits_DescriptionSF; SchoolFees.Description)
            //     {
            //     }

            //     trigger OnAfterGetRecord()
            //     begin
            //         CLosingBalanceSF := CLosingBalanceSF + SchoolFees."Amount Posted";
            //         if SchoolFees."Amount Posted" < 0 then begin
            //             SchoolFees."Credit Amount" := (SchoolFees."Amount Posted" * -1);
            //         end else
            //             if SchoolFees."Amount Posted" > 0 then begin
            //                 SchoolFees."Debit Amount" := (SchoolFees."Amount Posted");
            //             end;
            //     end;

            //     trigger OnPreDataItem()
            //     begin
            //         CLosingBalanceSF := SchoolfeesBF;
            //         OpenBalanceSF := SchoolfeesBF * -1;
            //     end;
            // }
            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Client Code" = field("No."), "Loan Product Type" = field("Loan Product Filter"), "Date filter" = field("Date Filter");
                DataItemTableView = sorting("Loan  No.") where(Posted = const(true), "Loan  No." = filter(<> ''));

                column(PrincipleBF; PrincipleBF)
                {
                }
                column(LoanNumber; Loans."Loan  No.")
                {
                }
                column(ProductType; Loans."Loan Product Type Name")
                {
                }
                column(RequestedAmount; Loans."Requested Amount")
                {
                }
                column(Interest; Loans.Interest)
                {
                }
                column(Installments; Loans.Installments)
                {
                }
                column(LoanPrincipleRepayment; Loans."Loan Principle Repayment")
                {
                }
                column(ApprovedAmount_Loans; Loans."Approved Amount")
                {
                }
                column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
                {
                }
                column(Repayment_Loans; Loans.Repayment)
                {
                }
                column(ModeofDisbursement_Loans; Loans."Mode of Disbursement")
                {
                }
                dataitem(loan; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("Client Code"), "Loan No" = field("Loan  No."), "Posting Date" = field("Date filter");
                    DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter(Loan | Repayment), Reversed = filter(false), "Loan No" = filter(<> ''), Description = filter(<> 'Interest on salary advance'));
                    column(ReportForNavId_1102755031; 1102755031)
                    {
                    }
                    column(PostingDate_loan; loan."Posting Date")
                    {
                    }
                    column(DocumentNo_loan; loan."Document No.")
                    {
                    }
                    column(Description_loan; loan.Description)
                    {
                    }
                    column(DebitAmount_Loan; loan."Debit Amount")
                    {
                    }
                    column(CreditAmount_Loan; loan."Credit Amount")
                    {
                    }
                    column(Amount_Loan; loan."Amount Posted")
                    {
                    }
                    column(openBalance_loan; OpenBalance)
                    {
                    }
                    column(CLosingBalance_loan; CLosingBalance)
                    {
                    }
                    column(TransactionType_loan; loan."Transaction Type")
                    {
                    }
                    column(LoanNo; loan."Loan No")
                    {
                    }
                    column(PrincipleBF_loans; PrincipleBF)
                    {
                    }
                    column(Loan_Description; loan.Description)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        /*CLosingBalance:=CLosingBalance+loan."Amount Posted";
                        ClosingBalInt:=ClosingBalInt+loan."Amount Posted";

                        //interest
                        ClosingBal:=ClosingBal+LoanInterest."Amount Posted";
                        OpeningBal:=ClosingBal-LoanInterest."Amount Posted";
                        */
                        CLosingBalance := CLosingBalance + loan."Amount Posted";
                        if Loans."Loan  No." = '' then;
                        if loan."Transaction Type" = loan."transaction type"::"Interest Paid" then begin
                            InterestPaid := loan."Credit Amount";
                            SumInterestPaid := InterestPaid + SumInterestPaid;
                        end;
                        if loan."Transaction Type" = loan."transaction type"::Repayment then
                            loan."Credit Amount" := loan."Credit Amount";//+InterestPaid;
                        if loan."Amount Posted" < 0 then
                            loan."Credit Amount" := (loan."Amount Posted" * -1)
                        else
                            if loan."Amount Posted" > 0 then
                                loan."Debit Amount" := (loan."Amount Posted");
                    end;

                    trigger OnPreDataItem()
                    begin
                        CLosingBalance := PrincipleBF;
                        OpeningBal := PrincipleBF;
                    end;
                }
                dataitem(Interest; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("Client Code"), "Loan No" = field("Loan  No."), "Posting Date" = field("Date filter");
                    DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter("Interest Due" | "Interest Paid"), Reversed = filter(false), "Loan No" = filter(<> '""'), Description = filter(<> 'Interest on salary advance'));
                    column(ReportForNavId_1000000059; 1000000059)
                    {
                    }
                    column(PostingDate_Interest; Interest."Posting Date")
                    {
                    }
                    column(DocumentNo_Interest; Interest."Document No.")
                    {
                    }
                    column(Description_Interest; Interest.Description)
                    {
                    }
                    column(DebitAmount_Interest; Interest."Debit Amount")
                    {
                    }
                    column(CreditAmount_Interest; Interest."Credit Amount")
                    {
                    }
                    column(Amount_Interest; Interest."Amount Posted")
                    {
                    }
                    column(OpeningBalInt; OpeningBalInt)
                    {
                    }
                    column(ClosingBalInt; ClosingBalInt)
                    {
                    }
                    column(TransactionType_Interest; Interest."Transaction Type")
                    {
                    }
                    column(LoanNo_Interest; Interest."Loan No")
                    {
                    }
                    column(InterestBF; InterestBF)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin

                    if DateFilterBF <> '' then begin
                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");
                        LoansR.SetFilter(LoansR."Date filter", DateFilterBF);
                        if LoansR.Find('-') then begin
                            LoansR.CalcFields(LoansR."Outstanding Balance");
                            PrincipleBF := LoansR."Outstanding Balance";
                            //InterestBF:=LoansR."Interest Paid";
                        end;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    Loans.SetFilter(Loans."Date filter", "Members Register".GetFilter("Members Register"."Date Filter"));
                end;
            }
            dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
            {
                DataItemLink = "Member No" = field("No.");
                column(ReportForNavId_1000000042; 1000000042)
                {
                }
                column(LoanNumb; "Loans Guarantee Details"."Loan No")
                {
                }
                column(MembersNo; "Loans Guarantee Details"."Member No")
                {
                }
                column(Name; "Loans Guarantee Details".Name)
                {
                }
                column(LBalance; "Loans Guarantee Details"."Loans Outstanding")
                {
                }
                column(Shares; "Loans Guarantee Details".Shares)
                {
                }
                column(LoansGuaranteed; "Loans Guarantee Details"."No Of Loans Guaranteed")
                {
                }
                column(Substituted; "Loans Guarantee Details".Substituted)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                SharesBF := 0;
                InsuranceBF := 0;
                ShareCapBF := 0;
                XmasBF := 0;
                HseBF := 0;
                Dep1BF := 0;
                Dep2BF := 0;
                SchoolfeesBF := 0;
                PepeaShares := 0;
                vanshares := 0;
                computershares := 0;
                FosaShares := 0;
                PrefShares := 0;
                FosaSharesBF := 0;
                ComputerSharesBF := 0;
                VanSharesBF := 0;
                PrefSharesBF := 0;
                if DateFilterBF <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", "No.");
                    Cust.SetFilter(Cust."Date Filter", DateFilterBF);
                    if Cust.Find('-') then begin
                        Cust.CalcFields(Cust."Shares Retained", Cust."Current Shares", Cust."Fosa Shares", Cust."van Shares");
                        SharesBF := Cust."Current Shares";
                        ShareCapBF := Cust."Shares Retained";
                        SchoolfeesBF := Cust."School Fees Shares";
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin

                if "Members Register".GetFilter("Members Register"."Date Filter") <> '' then
                    DateFilterBF := '..' + Format(CalcDate('-1D', "Members Register".GetRangeMin("Members Register"."Date Filter")));
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
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    var
        OpenBalance: Decimal;
        CLosingBalance: Decimal;
        OpenBalanceXmas: Decimal;
        CLosingBalanceXmas: Decimal;
        Cust: Record Customer;
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        FirstRec: Boolean;
        PrevBal: Integer;
        BalBF: Decimal;
        LoansR: Record "Loans Register";
        DateFilterBF: Text[150];
        SharesBF: Decimal;
        InsuranceBF: Decimal;
        LoanBF: Decimal;
        PrincipleBF: Decimal;
        InterestBF: Decimal;
        ShowZeroBal: Boolean;
        ClosingBalSHCAP: Decimal;
        ShareCapBF: Decimal;
        XmasBF: Decimal;
        Company: Record "Company Information";
        OpenBalanceHse: Decimal;
        CLosingBalanceHse: Decimal;
        OpenBalanceDep1: Decimal;
        CLosingBalanceDep1: Decimal;
        OpenBalanceDep2: Decimal;
        CLosingBalanceDep2: Decimal;
        HseBF: Decimal;
        Dep1BF: Decimal;
        Dep2BF: Decimal;
        OpeningBalInt: Decimal;
        ClosingBalInt: Decimal;
        InterestPaid: Decimal;
        SumInterestPaid: Decimal;
        OpenBalanceJuja: Decimal;
        CLosingBalanceJuja: Decimal;
        OpenBalanceFani: Decimal;
        CLosingBalanceFani: Decimal;
        OpenBalancejpange: Decimal;
        CLosingBalancejpange: Decimal;
        OpenBalancejunior: Decimal;
        CLosingBalancejunior: Decimal;
        OpenBalanceholiday: Decimal;
        CLosingBalanceholiday: Decimal;
        PrincipleBF1: Decimal;
        SchoolfeesBF: Integer;
        OpenBalanceSF: Decimal;
        CLosingBalanceSF: Decimal;
        PepeaShares: Decimal;
        vanshares: Decimal;
        computershares: Decimal;
        FosaShares: Decimal;
        PepeaSharesBF: Decimal;
        OpenBalancePS: Decimal;
        CLosingBalancePS: Decimal;
        OpenBalanceFs: Decimal;
        CLosingBalanceFs: Decimal;
        ComputerSharesBF: Decimal;
        OpenBalanceCs: Decimal;
        CLosingBalanceCs: Decimal;
        FosaSharesBF: Decimal;
        VanSharesBF: Decimal;
        OpenBalanceVs: Decimal;
        CLosingBalanceVs: Decimal;
        OpenBalancePref: Decimal;
        ClosingBalPref: Decimal;
        PrefSharesBF: Decimal;
        PrefShares: Decimal;
}
