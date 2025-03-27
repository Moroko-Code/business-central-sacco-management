#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50008 "Other Disclosures"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Other Disclosures.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
#pragma warning disable AL0275
        dataitem(Company; "Company Information")
#pragma warning restore AL0275
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(Date; Date)
            {
            }
            column(FinancialYear; FinancialYear)
            {
            }
            column(name; Company.Name)
            {
            }
            column(Grossnonperformingloan; Grossnonperformingloan)
            {
            }
            column(GrossnonperformingloanLast; GrossnonperformingloanLast)
            {
            }
            column(Interestinsuspense; Interestinsuspense)
            {
            }
            column(InterestinsuspenseLast; InterestinsuspenseLast)
            {
            }
            column(Totalnonperformingloan; Totalnonperformingloan)
            {
            }
            column(TotalnonperformingloanLast; TotalnonperformingloanLast)
            {
            }
            column(Directors; Directors)
            {
            }
            column(DirectorsLast; DirectorsLast)
            {
            }
            column(Employees; Employees)
            {
            }
            column(EmployeesLast; EmployeesLast)
            {
            }
            column(Totalinsiderloans; Totalinsiderloans)
            {
            }
            column(TotalinsiderloansLast; TotalinsiderloansLast)
            {
            }
            column(Allowanceforloanloss; Allowanceforloanloss)
            {
            }
            column(Netnonperformingloans; Netnonperformingloans)
            {
            }
            column(AllowanceforloanlossLast; AllowanceforloanlossLast)
            {
            }
            column(NetnonperformingloansLast; NetnonperformingloansLast)
            {
            }
            column(othercontigentliabilities; othercontigentliabilities)
            {
            }
            column(Guaranteesandcommitments; Guaranteesandcommitments)
            {
            }
            column(totalcontingentliabilities; totalcontingentliabilities)
            {
            }
            column(Corecapital; Corecapital)
            {
            }
            column(CorecapitaltoTotalassetratio; CorecapitaltoTotalassetratio)
            {
            }
            column(liquidityRatio; liquidityRatio)
            {
            }
            column(CorecapitalLast; CorecapitalLast)
            {
            }
            column(CorecapitaltoTotalassetratioNew; CorecapitaltoTotalassetratioNew)
            {
            }
            column(CorecapitaltoTotalassetratioNewLast; CorecapitaltoTotalassetratioNewLast)
            {
            }
            column(Excess1; Excess1)
            {
            }
            column(Excess11; Excess11)
            {
            }
            column(Depositsliabilitiesratio; Depositsliabilitiesratio)
            {
            }
            column(DepositsliabilitiesratioLast; DepositsliabilitiesratioLast)
            {
            }
            column(CorecapitalDepositsliabilities; CorecapitalDepositsliabilities)
            {
            }
            column(CorecapitalDepositsliabilitiesLast; CorecapitalDepositsliabilitiesLast)
            {
            }
            column(xcessdeficiency; xcessdeficiency)
            {
            }
            column(xcessdeficiencyLast; xcessdeficiencyLast)
            {
            }
            column(Ratio2; Ratio2)
            {
            }
            column(Ratio; Ratio)
            {
            }
            column(ExcessLiquidity; ExcessLiquidity)
            {
            }
            column(ExcessLiquidityLast; ExcessLiquidityLast)
            {
            }
            column(Minimumstatutoryratio; Minimumstatutoryratio)
            {
            }
            column(Minimumstatutoryratio2; Minimumstatutoryratio2)
            {
            }
            column(Minimumstatutoryratio3; Minimumstatutoryratio3)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //gross non performing loan
                Loans.Reset;
                Loans.SetRange(Loans."Loans Category-SASRA", Loans."Loans Category-SASRA"::Substandard);
                Loans.SetFilter(Loans."Issued Date", '..%1', AsAt);
                Loans.SetAutocalcFields(Loans."Outstanding Balance");
                Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
                if Loans.FindFirst then
                    repeat
                        SubstarndardProv += Loans."Outstanding Balance";
                    until Loans.Next = 0;

                Loans.Reset;
                Loans.SetRange(Loans."Loans Category-SASRA", Loans."Loans Category-SASRA"::Doubtful);
                Loans.SetFilter(Loans."Issued Date", '..%1', AsAt);
                Loans.SetAutocalcFields(Loans."Outstanding Balance");
                Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
                if Loans.FindFirst then
                    repeat
                        DoubtfulProv += Loans."Outstanding Balance";
                    until Loans.Next = 0;

                Loans.Reset;
                Loans.SetRange(Loans."Loans Category-SASRA", Loans."Loans Category-SASRA"::Loss);
                Loans.SetFilter(Loans."Issued Date", '..%1', AsAt);
                Loans.SetAutocalcFields(Loans."Outstanding Balance");
                Loans.SetFilter(Loans."Outstanding Balance", '<>%1', 0);
                if Loans.FindFirst then
                    repeat
                        LossProv += Loans."Outstanding Balance";
                    until Loans.Next = 0;
                //MESSAGE('Substandard%1Doubt%2Loss%3',SubstarndardProv,DoubtfulProv,LossProv);
                SubstarndardProv := ROUND((SubstarndardProv * 25 / 100), 0.01, '=');
                DoubtfulProv := ROUND((DoubtfulProv * 50 / 100), 0.01, '=');
                LossProv := ROUND((LossProv * 100 / 100), 0.01, '=');
                TotalProvision := SubstarndardProv + LossProv + DoubtfulProv;
                Allowanceforloanloss := TotalProvision;
                //***************Previous Year Provision
                //gross non performing loan
                Loanss.Reset;
                // Loanss.SetRange(Loanss."Utilizable Amount",Loanss."utilizable amount"::"2");
                Loanss.SetFilter(Loanss."Issued Date", '..%1', EndLastYear);
                //Loanss.SETFILTER(Loanss."Outstanding Balance",'<>%1',0);
                Loanss.SetAutocalcFields(Loanss."Outstanding Balance");
                if Loanss.FindFirst then
                    repeat
                        //SubstarndardProvPY+=Loanss."Outstanding Balance";13/07/23
                        MemberLedgerEntry.Reset;
                        MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", Loanss."Loan  No.");
                        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '%1|%2', MemberLedgerEntry."transaction type"::Loan, MemberLedgerEntry."transaction type"::Repayment);
                        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Posting Date", '..%1', EndLastYear);
                        if MemberLedgerEntry.FindSet then
                            //MemberLedgerEntry.CalcSums(MemberLedgerEntry."Amount Posted");
                            SubstarndardProvPY += MemberLedgerEntry."Amount Posted";
                    //Gro
                    until Loanss.Next = 0;

                Loanss.Reset;
                Loanss.SETRANGE(Loanss."Loans Category Previous Year", Loanss."Loans Category Previous Year"::Loss);
                Loanss.SetFilter(Loanss."Issued Date", '..%1', EndLastYear);
                //Loanss.SETFILTER(Loanss."Outstanding Balance",'<>%1',0);13/07/23
                Loanss.SetAutocalcFields(Loanss."Outstanding Balance");
                if Loanss.FindFirst then
                    repeat
                        //DoubtfulProvPY+=Loanss."Outstanding Balance";13/07/23
                        MemberLedgerEntry.Reset;
                        MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", Loanss."Loan  No.");
                        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '%1|%2', MemberLedgerEntry."transaction type"::Loan, MemberLedgerEntry."transaction type"::Repayment);
                        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Posting Date", '..%1', EndLastYear);
                        if MemberLedgerEntry.FindSet then
                            //MemberLedgerEntry.CalcSums(MemberLedgerEntry."Amount Posted");
                            DoubtfulProvPY += MemberLedgerEntry."Amount Posted";
                    //GrossnonperformingloanLast+=LoansRegister."Outstanding Balance";//(LoansRegister."Outstanding Balance"+LoansRegister."Oustanding Interest");
                    until Loanss.Next = 0;

                Loanss.Reset;
                Loanss.SETRANGE(Loanss."Loans Category Previous Year", Loanss."Loans Category Previous Year"::Loss);
                Loanss.SetFilter(Loanss."Issued Date", '..%1', EndLastYear);
                //Loanss.SETFILTER(Loanss."Outstanding Balance",'<>%1',0);
                Loanss.SetAutocalcFields(Loanss."Outstanding Balance");
                if Loans.FindFirst then
                    repeat
                        //LossProvPY+=Loanss."Outstanding Balance";
                        MemberLedgerEntry.Reset;
                        MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", Loanss."Loan  No.");
                        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '%1|%2', MemberLedgerEntry."transaction type"::Loan, MemberLedgerEntry."transaction type"::Repayment);
                        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Posting Date", '..%1', EndLastYear);
                        if MemberLedgerEntry.FindSet then
                            //MemberLedgerEntry.CalcSums(MemberLedgerEntry."Amount Posted");
                            LossProvPY += MemberLedgerEntry."Amount Posted";
                    //GrossnonperformingloanLast+=LoansRegister."Outstanding Balance";//(LoansRegister."Outstanding Balance"+LoansRegister."Oustanding Interest");
                    until Loans.Next = 0;
                SubstarndardProvPY := ROUND((SubstarndardProvPY * 25 / 100), 0.01, '=');
                DoubtfulProvPY := ROUND((DoubtfulProvPY * 50 / 100), 0.01, '=');
                LossProvPY := ROUND((LossProvPY * 100 / 100), 0.01, '=');
                TotalProvisionPY := SubstarndardProvPY + LossProvPY + DoubtfulProvPY;
                AllowanceforloanlossLast := TotalProvisionPY;
                //++++++++++++++++++++++++++++++++++

                //MESSAGE('Aste%1',AsAt);
                //MESSAGE('Substandard%1Doubt%2Loss%3',SubstarndardProv,DoubtfulProv,LossProv);
                LoansRegister.Reset;
                LoansRegister.SetFilter(LoansRegister."Loans Category-SASRA", '%1|%2|%3', LoansRegister."Loans Category-SASRA"::Substandard, LoansRegister."Loans Category-SASRA"::Doubtful, LoansRegister."Loans Category-SASRA"::Loss);
                //LoansRegister.SETFILTER(LoansRegister."Loans Category-SASRA",'%1|%2|%3',LoansRegister."Loans Category-SASRA"::"2",LoansRegister."Loans Category-SASRA"::"3",LoansRegister."Loans Category-SASRA"::"4");
                //LoansRegister.SETFILTER(LoansRegister."Date filter",DateFilterNew);
                LoansRegister.SetFilter(LoansRegister."Issued Date", '..%1', AsAt);
                LoansRegister.SetAutocalcFields("Outstanding Balance");
                LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '<>%1', 0);
                if LoansRegister.FindSet then
                    repeat
                        // MESSAGE('Here%1',LoansRegister."Loan  No.");
                        MemberLedgerEntry.Reset;
                        MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", LoansRegister."Loan  No.");
                        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '%1|%2', MemberLedgerEntry."transaction type"::Loan, MemberLedgerEntry."transaction type"::Repayment);
                        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Posting Date", '..%1', AsAt);
                        if MemberLedgerEntry.FindSet then
                            //MemberLedgerEntry.CalcSums(MemberLedgerEntry."Amount Posted");
                            Grossnonperformingloan += MemberLedgerEntry."Amount Posted";
                    // Grossnonperformingloan+=LoansRegister."Outstanding Balance";//(LoansRegister."Outstanding Balance"+LoansRegister."Oustanding Interest");
                    until LoansRegister.Next = 0;
                //MESSAGE('Gross%1',Grossnonperformingloan);

                LoansRegister.Reset;
                LoansRegister.SETFILTER(LoansRegister."Loans Category Previous Year", '%1|%2|%3', LoansRegister."Loans Category Previous Year"::Substandard, LoansRegister."Loans Category Previous Year"::Doubtful, LoansRegister."Loans Category Previous Year"::Loss);
                //LoansRegister.SETFILTER(LoansRegister."Loans CategoryNew",'%1|%2|%3',LoansRegister."Loans CategoryNew"::"2",LoansRegister."Loans CategoryNew"::"3",LoansRegister."Loans CategoryNew"::"4");
                //LoansRegister.SETFILTER(LoansRegister."Date filter",LastYearFilter);
                LoansRegister.SetFilter(LoansRegister."Issued Date", '..%1', EndLastYear);
                LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '<>%1', 0);
                LoansRegister.SetAutocalcFields("Outstanding Balance");
                if LoansRegister.FindSet then
                    repeat
                        MemberLedgerEntry.Reset;
                        MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", LoansRegister."Loan  No.");
                        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '%1|%2', MemberLedgerEntry."transaction type"::Loan, MemberLedgerEntry."transaction type"::Repayment);
                        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Posting Date", '..%1', EndLastYear);
                        if MemberLedgerEntry.FindSet then
                            //MemberLedgerEntry.CalcSums(MemberLedgerEntry."Amount Posted");
                            GrossnonperformingloanLast += MemberLedgerEntry."Amount Posted";
                    //GrossnonperformingloanLast+=LoansRegister."Outstanding Balance";//(LoansRegister."Outstanding Balance"+LoansRegister."Oustanding Interest");
                    until LoansRegister.Next = 0;
                //MESSAGE('%1|%2',Grossnonperformingloan,GrossnonperformingloanLast);
                //interest in suspense

                LoansRegister.Reset;
                LoansRegister.SetFilter(LoansRegister."Loans Category-SASRA", '%1|%2|%3', LoansRegister."Loans Category-SASRA"::Substandard, LoansRegister."Loans Category-SASRA"::Doubtful, LoansRegister."Loans Category-SASRA"::Loss);
                //LoansRegister.SETFILTER(LoansRegister."Loans Category-SASRA",'%1|%2|%3',LoansRegister."Loans Category-SASRA"::"2",LoansRegister."Loans Category-SASRA"::"3",LoansRegister."Loans Category-SASRA"::"4");
                //LoansRegister.SETFILTER(LoansRegister."Date filter",DateFilterNew);
                LoansRegister.SetFilter(LoansRegister."Issued Date", '..%1', AsAt);
  
              
                if LoansRegister.FindSet then
                    repeat
                        MemberLedgerEntry.Reset;
                        MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", LoansRegister."Loan  No.");
                        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '%1|%2', MemberLedgerEntry."transaction type"::"Interest Due", MemberLedgerEntry."transaction type"::"Interest Paid");
                        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Posting Date", '..%1', AsAt);
                        if MemberLedgerEntry.FindSet then
                            //MemberLedgerEntry.CalcSums(MemberLedgerEntry."Amount Posted");
                            Interestinsuspense += MemberLedgerEntry."Amount Posted";
                    //Interestinsuspense+=LoansRegister."Oustanding Interest";
                    until LoansRegister.Next = 0;

                LoansRegister.Reset;
                LoansRegister.SETFILTER(LoansRegister."Loans Category Previous Year", '%1|%2|%3', LoansRegister."Loans Category Previous Year"::Substandard, LoansRegister."Loans Category Previous Year"::Doubtful, LoansRegister."Loans Category Previous Year"::Loss);
                //LoansRegister.SETFILTER(LoansRegister."Loans CategoryNew",'%1|%2|%3',LoansRegister."Loans CategoryNew"::"2",LoansRegister."Loans CategoryNew"::"3",LoansRegister."Loans CategoryNew"::"4");
                LoansRegister.SetFilter(LoansRegister."Date filter", LastYearFilter);
                //LoansRegister.SETFILTER(LoansRegister."Issued Date",'<=%1',EndLastYear);
              
                LoansRegister.SetRange(LoansRegister.Posted, true);
                LoansRegister.SetAutocalcFields("Outstanding Balance");
                if LoansRegister.FindSet then
                    repeat
                        if LoansRegister."Outstanding Balance" <> 0 then
                            MemberLedgerEntry.Reset;
                        MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", LoansRegister."Loan  No.");
                        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '%1|%2', MemberLedgerEntry."transaction type"::"Interest Due", MemberLedgerEntry."transaction type"::"Interest Paid");
                        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Posting Date", '..%1', EndLastYear);
                        if MemberLedgerEntry.FindSet then
                            //MemberLedgerEntry.CalcSums(MemberLedgerEntry."Amount Posted");
                            InterestinsuspenseLast += MemberLedgerEntry."Amount Posted";
                    //InterestinsuspenseLast+=LoansRegister."Oustanding Interest";
                    until LoansRegister.Next = 0;
                // MESSAGE('Endlast%1',EndLastYear);
                //insider loans
                SaccoInsiders.Reset;
                SaccoInsiders.SetFilter(SaccoInsiders."Position in society", '%1', SaccoInsiders."position in society"::Staff);
                if SaccoInsiders.FindSet then
                    repeat
                        LoansRegister.Reset;
                        LoansRegister.SetFilter(LoansRegister."Date filter", DateFilterNew);
                        LoansRegister.SetFilter(LoansRegister."Issued Date", '..%1', AsAt);
                        LoansRegister.SetRange(LoansRegister."Client Code", SaccoInsiders.MemberNo);
                        //LoansRegister.SETFILTER(LoansRegister."Outstanding Balance",'>%1',0);13/07/2023
                        LoansRegister.SetAutocalcFields("Outstanding Balance");
                        if LoansRegister.FindSet then
                            repeat
                                //MESSAGE(FORMAT(LoansRegister."Client Code"));
                                MemberLedgerEntry.Reset;
                                MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", LoansRegister."Loan  No.");
                                MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '%1|%2', MemberLedgerEntry."transaction type"::Loan, MemberLedgerEntry."transaction type"::Repayment);
                                MemberLedgerEntry.SetFilter(MemberLedgerEntry."Posting Date", '..%1', AsAt);
                                if MemberLedgerEntry.FindSet then
                                    //MemberLedgerEntry.CalcSums(MemberLedgerEntry."Amount Posted");
                                    Employees += MemberLedgerEntry."Amount Posted";
                            //Employees+=LoansRegister."Outstanding Balance";
                            until LoansRegister.Next = 0;
                    until SaccoInsiders.Next = 0;

                SaccoInsiders.Reset;
                SaccoInsiders.SetFilter(SaccoInsiders."Position in society", '%1', SaccoInsiders."position in society"::Staff);
                if SaccoInsiders.FindSet then
                    repeat
                        LoansRegister.Reset;
                        //LoansRegister.SETFILTER(LoansRegister."Date filter",LastYearFilter);
                        //LoansRegister.SETFILTER(LoansRegister."Date filter",LoanFilterOk);
                        LoansRegister.SetFilter(LoansRegister."Issued Date", '..%1', EndLastYear);
                        LoansRegister.SetRange(LoansRegister."Client Code", SaccoInsiders.MemberNo);
                        //LoansRegister.SETFILTER(LoansRegister."Outstanding Balance",'>%1',0);
                        LoansRegister.SetAutocalcFields("Outstanding Balance");
                        if LoansRegister.FindSet then
                            repeat

                                MemberLedgerEntry.Reset;
                                MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", LoansRegister."Loan  No.");
                                MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '%1|%2', MemberLedgerEntry."transaction type"::Loan, MemberLedgerEntry."transaction type"::Repayment);
                                MemberLedgerEntry.SetFilter(MemberLedgerEntry."Posting Date", '..%1', EndLastYear);
                                if MemberLedgerEntry.FindSet then
                                    //MemberLedgerEntry.CalcSums(MemberLedgerEntry."Amount Posted");
                                    EmployeesLast += MemberLedgerEntry."Amount Posted";
                            //EmployeesLast+=LoansRegister."Outstanding Balance";
                            until LoansRegister.Next = 0;
                    //MESSAGE(FORMAT(EmployeesLast));
                    until SaccoInsiders.Next = 0;
                //directors
                SaccoInsiders.Reset;
                SaccoInsiders.SetFilter(SaccoInsiders."Position in society", '%1|%2', SaccoInsiders."position in society"::Board, SaccoInsiders."position in society"::Board);
                if SaccoInsiders.FindSet then
                    repeat
                        LoansRegister.Reset;
                        // LoansRegister.SETFILTER(LoansRegister."Date filter",DateFilterNew);
                        LoansRegister.SetFilter(LoansRegister."Issued Date", '..%1', AsAt);
                        LoansRegister.SetRange(LoansRegister."Client Code", SaccoInsiders.MemberNo);
                        LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>%1', 0);
                        LoansRegister.SetAutocalcFields("Outstanding Balance");
                        if LoansRegister.FindSet then
                            repeat
                                //MESSAGE(FORMAT(LoansRegister."Client Code"));
                                MemberLedgerEntry.Reset;
                                MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", LoansRegister."Loan  No.");
                                MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '%1|%2', MemberLedgerEntry."transaction type"::Loan, MemberLedgerEntry."transaction type"::Repayment);
                                MemberLedgerEntry.SetFilter(MemberLedgerEntry."Posting Date", '..%1', AsAt);
                                if MemberLedgerEntry.FindSet then
                                    //MemberLedgerEntry.CalcSums(MemberLedgerEntry."Amount Posted");
                                    Directors += MemberLedgerEntry."Amount Posted";
                            //Employees+=LoansRegister."Outstanding Balance";
                            //Directors+=LoansRegister."Outstanding Balance";
                            until LoansRegister.Next = 0;
                    until SaccoInsiders.Next = 0;

                SaccoInsiders.Reset;
                SaccoInsiders.SetFilter(SaccoInsiders."Position in society", '%1|%2', SaccoInsiders."position in society"::Board, SaccoInsiders."position in society"::Board);
                if SaccoInsiders.FindSet then
                    repeat
                        LoansRegister.Reset;
                        //LoansRegister.SETFILTER(LoansRegister."Date filter",LastYearFilter);
                        LoansRegister.SetFilter(LoansRegister."Issued Date", '..%1', EndLastYear);
                        LoansRegister.SetRange(LoansRegister."Client Code", SaccoInsiders.MemberNo);
                        // LoansRegister.SETFILTER(LoansRegister."Outstanding Balance",'>%1',0);13/07/2023
                        LoansRegister.SetAutocalcFields("Outstanding Balance");
                        if LoansRegister.FindSet then
                            repeat
                                MemberLedgerEntry.Reset;
                                MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", LoansRegister."Loan  No.");
                                MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '%1|%2', MemberLedgerEntry."transaction type"::Loan, MemberLedgerEntry."transaction type"::Repayment);
                                MemberLedgerEntry.SetFilter(MemberLedgerEntry."Posting Date", '..%1', EndLastYear);
                                if MemberLedgerEntry.FindSet then
                                    //MemberLedgerEntry.CalcSums(MemberLedgerEntry."Amount Posted");
                                    DirectorsLast += MemberLedgerEntry."Amount Posted";
                            //Employees+=LoansRegister."Outstanding Balance";
                            //DirectorsLast+=LoansRegister."Outstanding Balance";
                            until LoansRegister.Next = 0;
                    until SaccoInsiders.Next = 0;

                //allowance for loan loss//Kit
                /*Allowanceforloanloss:=0;
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."Form 2H other disc",'%1',GLAccount."Form 2H other disc"::AllowanceForLoanLoss);
                IF GLAccount.FINDSET THEN BEGIN
                  REPEAT
                    GLEntry.RESET;
                    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                    GLEntry.SETFILTER(GLEntry."Posting Date",DateFilterNew);
                    IF GLEntry.FINDSET THEN BEGIN
                      GLEntry.CALCSUMS(Amount);
                      Allowanceforloanloss+=GLEntry.Amount;
                      END;
                      UNTIL GLAccount.NEXT = 0 ;
                END;
                Allowanceforloanloss:=0;
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."Form 2H other disc",'%1',GLAccount."Form 2H other disc"::AllowanceForLoanLoss);
                IF GLAccount.FINDSET THEN BEGIN
                  REPEAT
                    GLEntry.RESET;
                    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                    IF GLEntry.FINDSET THEN BEGIN
                      GLEntry.CALCSUMS(Amount);
                      AllowanceforloanlossLast+=GLEntry.Amount;
                      END;
                      UNTIL GLAccount.NEXT = 0 ;
                END;*/
                Totalnonperformingloan := Grossnonperformingloan - Interestinsuspense;
                TotalnonperformingloanLast := GrossnonperformingloanLast - InterestinsuspenseLast;
                Totalinsiderloans := Employees + Directors;
                TotalinsiderloansLast := EmployeesLast + DirectorsLast;
                Netnonperformingloans := Totalnonperformingloan - Allowanceforloanloss;
                NetnonperformingloansLast := TotalnonperformingloanLast - AllowanceforloanlossLast;

                Minimumstatutoryratio := 0.08;
                Minimumstatutoryratio2 := 0.05;
                Minimumstatutoryratio3 := 0.1;
                /*
                //CORE CAPITAL
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."Form 2H other disc",'%1',GLAccount."Form 2H other disc"::Core_Capital);
                IF GLAccount.FINDSET THEN BEGIN
                  REPEAT
                    GLEntry.RESET;
                    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                    GLEntry.SETFILTER(GLEntry."Posting Date",DateFilter);
                    IF GLEntry.FINDSET THEN BEGIN
                      GLEntry.CALCSUMS(Amount);
                      Corecapital+=GLEntry.Amount*-1;
                      END;
                      UNTIL GLAccount.NEXT = 0 ;
                END;
                GLAccount.RESET;
                GLAccount.SETFILTER(GLAccount."Form 2H other disc",'%1',GLAccount."Form 2H other disc"::Core_Capital);
                IF GLAccount.FINDSET THEN BEGIN
                  REPEAT
                    GLEntry.RESET;
                    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                    IF GLEntry.FINDSET THEN BEGIN
                      GLEntry.CALCSUMS(Amount);
                      CorecapitalLast+=GLEntry.Amount*-1;
                      END;
                      UNTIL GLAccount.NEXT = 0 ;
                END;
                GLAccount.RESET;
                GLAccount.SETRANGE(GLAccount."No.",'101799');
                GLAccount.SETFILTER(GLAccount."Date Filter",DateFilter);
                IF GLAccount.FINDSET THEN BEGIN
                  REPEAT
                    GLAccount.CALCFIELDS("Balance at Date");
                    BalancesheetAssets+=GLAccount."Balance at Date";
                    //MESSAGE(FORMAT(BalancesheetAssets));
                UNTIL GLAccount.NEXT =0 ;
                END;
                GLAccount.RESET;
                GLAccount.SETRANGE(GLAccount."No.",'101799');
                GLAccount.SETFILTER(GLAccount."Date Filter",LastYearFilter);
                IF GLAccount.FINDSET THEN BEGIN
                  REPEAT
                    GLAccount.CALCFIELDS("Balance at Date");
                    BalancesheetAssetsLast+=GLAccount."Balance at Date";
                UNTIL GLAccount.NEXT =0 ;
                END;
                //deposit liabilites
                 GLAccount.RESET;
                 GLAccount.SETFILTER(GLAccount."Form 2H other disc",'%1',GLAccount."Form 2H other disc"::"Deposits liabilities");
                 IF GLAccount.FINDSET THEN BEGIN
                  REPEAT
                    GLEntry.RESET;
                    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                    GLEntry.SETFILTER(GLEntry."Posting Date",DateFilter);
                    IF GLEntry.FINDSET THEN BEGIN
                      GLEntry.CALCSUMS(Amount);
                      Depositsliabilitiesratio+=GLEntry.Amount*-1;
                      END;
                   UNTIL GLAccount.NEXT = 0;
                 END;
                  GLAccount.RESET;
                 GLAccount.SETFILTER(GLAccount."Form 2H other disc",'%1',GLAccount."Form 2H other disc"::"Deposits liabilities");
                 IF GLAccount.FINDSET THEN BEGIN
                  REPEAT
                    GLEntry.RESET;
                    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                    IF GLEntry.FINDSET THEN BEGIN
                      GLEntry.CALCSUMS(Amount);
                      DepositsliabilitiesratioLast+=GLEntry.Amount*-1;
                      END;
                   UNTIL GLAccount.NEXT = 0;
                 END;
                 CorecapitaltoTotalassetratioNew:=Corecapital/BalancesheetAssets;
                 CorecapitaltoTotalassetratioNewLast:=CorecapitalLast/BalancesheetAssetsLast;
                 Maximumstatutoryratio:=0.08;
                 Excess1:=(CorecapitaltoTotalassetratioNew-Maximumstatutoryratio);
                 Excess11:=(CorecapitaltoTotalassetratioNewLast-Maximumstatutoryratio);
                // MESSAGE(FORMAT(CorecapitaltoTotalassetratioNew));
                // MESSAGE(FORMAT(CorecapitaltoTotalassetratioNewLast));
                 CorecapitalDepositsliabilities:=Corecapital/Depositsliabilitiesratio;
                 CorecapitalDepositsliabilitiesLast:=CorecapitalLast/DepositsliabilitiesratioLast;
                 xcessdeficiency:=(CorecapitalDepositsliabilities-0.05);
                 xcessdeficiencyLast:=(CorecapitalDepositsliabilitiesLast-0.08);*/
                //new
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '14300');
                GLAccount.SetFilter(GLAccount."Date Filter", DateFilter);
                if GLAccount.FindSet then
                    repeat
                        GLAccount.CalcFields("Net Change");
                        BalancesheetAssets += GLAccount."Net Change";
                    until GLAccount.Next = 0;
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '14300');
                GLAccount.SetFilter(GLAccount."Date Filter", LastYearFilter);
                if GLAccount.FindSet then
                    repeat
                        GLAccount.CalcFields("Net Change");
                        BalancesheetAssetsLast += GLAccount."Net Change";
                    until GLAccount.Next = 0;
                //deposit liabilites
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::TotalDepositsLiabilities);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Depositsliabilitiesratio += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::TotalDepositsLiabilities);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            DepositsliabilitiesratioLast += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;
                //end new
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::ShareCapital);
                if GLAccount.FindSet then
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ShareCapital += GLEntry.Amount * -1;
                        end;
                    //ShareCapital:=ShareCapital+ShareCapitalValue;
                    until GLAccount.Next = 0;

                //statutory reserve
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::StatutoryReserve);
                if GLAccount.FindSet then
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            StatutoryReserve += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;
                //retained earnings
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::RetainedEarnings);
                if GLAccount.FindSet then
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            retainedEarnins += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;
                //curent year surplus
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::NetSurplusaftertax);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", CurrentYearFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            NetSurplusaftertax += (GLEntry.Amount * 50 / 100) * -1;
                        end;
                    until GLAccount.Next = 0;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::LoansandAdvances);
                if GLAccount.FindSet then
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LoansandAdvances += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //total assets as per the balance sheet

                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '14300');
                GLAccount.SetFilter(GLAccount."Date Filter", DateFilter);
                GLAccount.SetAutocalcFields(Balance);
                if GLAccount.FindSet then
                    repeat
                        totalassetsPBSheet += GLAccount."Balance at Date";
                    until GLAccount.Next = 0;
                //Cash (Local + Foreign Currency)
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Cash);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Cash += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //INVESTMENT IN SUBSIDIARY
                InvestmentsinSubsidiary := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::InvestmentsinSubsidiary);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            InvestmentsinSubsidiary += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //Other reserves
                Otherreserves := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Otherreserves);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Otherreserves += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;

                //gov securities
                GovernmentSecurities := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::GovernmentSecurities);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            GovernmentSecurities += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //balances at other institutions
                DepositsandBalancesatOtherInstitutions := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::DepositsandBalancesatOtherInstitutions);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            DepositsandBalancesatOtherInstitutions += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //other assets
                Otherassets := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Otherassets);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Otherassets += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //property and equipment
                PropertyandEquipment := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::"PropertyandEquipment ");
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            PropertyandEquipment += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //deposit liabilities
                //TotalDepositsLiabilities:=0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::TotalDepositsLiabilities);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TotalDepositsLiabilities += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;

                //investment
                //TotalDepositsLiabilities:=0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Investments);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            investment += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                // TOTALOnBalanceSheet:=Cash+GovernmentSecurities+DepositsandBalancesatOtherInstitutions+LoansandAdvances+InvestmentsinSubsidiary+Otherassets+PropertyandEquipment+investment;
                // Sub_Total:=ShareCapital+CapitalGrants+retainedEarnins+NetSurplusaftertax+StatutoryReserve+Otherreserves;
                // TotalDeductions:=InvestmentsinSubsidiary+OtherDeductions;
                // CORECAPITAL:=Sub_Total-TotalDeductions;
                TOTALOnBalanceSheet := Cash + GovernmentSecurities + DepositsandBalancesatOtherInstitutions + LoansandAdvances + InvestmentsinSubsidiary + Otherassets + PropertyandEquipment;
                Sub_Total := ShareCapital + CapitalGrants + retainedEarnins + NetSurplusaftertax + StatutoryReserve + Otherreserves;
                TotalDeductions := InvestmentsinSubsidiary + OtherDeductions;
                Corecapital := (Sub_Total - TotalDeductions);

                //corecapital last year
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::ShareCapital);
                if GLAccount.FindSet then
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ShareCapitalLast += GLEntry.Amount * -1;
                        end;
                    //ShareCapital:=ShareCapital+ShareCapitalValue;
                    until GLAccount.Next = 0;

                //statutory reserve
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::StatutoryReserve);
                if GLAccount.FindSet then
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            StatutoryReserveLast += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;
                //retained earnings
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::RetainedEarnings);
                if GLAccount.FindSet then
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            retainedEarninsLast += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;
                //curent year surplus
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::NetSurplusaftertax);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", NewFiterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            NetSurplusaftertaxLast += (GLEntry.Amount * 50 / 100) * -1;
                        end;
                    until GLAccount.Next = 0;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::LoansandAdvances);
                if GLAccount.FindSet then
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LoansandAdvanceslast += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //total assets as per the balance sheet

                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '14300');
                GLAccount.SetFilter(GLAccount."Date Filter", DateFilter);
                GLAccount.SetAutocalcFields(Balance);
                if GLAccount.FindSet then
                    repeat
                        totalassetsPBSheetLast += GLAccount.Balance;
                    until GLAccount.Next = 0;
                //Cash (Local + Foreign Currency)
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Cash);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            CashLast += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //INVESTMENT IN SUBSIDIARY
                InvestmentsinSubsidiary := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::InvestmentsinSubsidiary);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            InvestmentsinSubsidiaryLast += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //Other reserves
                Otherreserves := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Otherreserves);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            OtherreservesLast += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;

                //gov securities
                GovernmentSecurities := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::GovernmentSecurities);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            GovernmentSecuritiesLast += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //balances at other institutions
                DepositsandBalancesatOtherInstitutions := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::DepositsandBalancesatOtherInstitutions);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            DepositsandBalancesatOtherInstitutionsLast += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //other assets
                Otherassets := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Otherassets);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            OtherassetsLast += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                //property and equipment
                PropertyandEquipment := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::"PropertyandEquipment ");
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            PropertyandEquipmentLast += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //deposit liabilities

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::TotalDepositsLiabilities);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TotalDepositsLiabilitiesLast += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;

                //investment
                //TotalDepositsLiabilities:=0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Investments);
                if GLAccount.FindSet then
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            investmentlAT += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                TOTALOnBalanceSheet := Cash + GovernmentSecurities + DepositsandBalancesatOtherInstitutions + LoansandAdvances + InvestmentsinSubsidiary + Otherassets + PropertyandEquipment + investment;
                Sub_Total := ShareCapital + CapitalGrants + retainedEarnins + NetSurplusaftertax + StatutoryReserve + Otherreserves;
                TotalDeductions := InvestmentsinSubsidiary + OtherDeductions;
                CORECAPITAL := Sub_Total - TotalDeductions;

                TOTALOnBalanceSheetLast := CashLast + GovernmentSecuritiesLast + DepositsandBalancesatOtherInstitutionsLast + LoansandAdvanceslast + InvestmentsinSubsidiaryLast + OtherassetsLast + PropertyandEquipmentLast;
                Sub_TotalLast := ShareCapitalLast + CapitalGrantsLast + retainedEarninsLast + NetSurplusaftertaxLast + StatutoryReserveLast + OtherreservesLast;
                TotalDeductionsLast := InvestmentsinSubsidiaryLast + OtherDeductionsLast;
                CorecapitalLast := (Sub_TotalLast - TotalDeductionsLast);
                // if Corecapital
                if BalancesheetAssets > 0 then
                    CorecapitaltoTotalassetratioNew := Corecapital / BalancesheetAssets;
                if BalancesheetAssetsLast > 0 then
                    CorecapitaltoTotalassetratioNewLast := CorecapitalLast / BalancesheetAssetsLast;
                Maximumstatutoryratio := 0.08;
                Excess1 := (CorecapitaltoTotalassetratioNew - Maximumstatutoryratio);
                Excess11 := (CorecapitaltoTotalassetratioNewLast - Maximumstatutoryratio);
                if Depositsliabilitiesratio > 0 then
                    CorecapitalDepositsliabilities := Corecapital / Depositsliabilitiesratio;
                if DepositsliabilitiesratioLast > 0 then
                    CorecapitalDepositsliabilitiesLast := CorecapitalLast / DepositsliabilitiesratioLast;
                xcessdeficiency := (CorecapitalDepositsliabilities - 0.05);
                xcessdeficiencyLast := (CorecapitalDepositsliabilitiesLast - 0.08);
                // //liquidity ratio
                LocalNotes := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::LocalNotes);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LocalNotes += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::LocalNotes);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LocalNotesLast += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                BalanceswithCommercialBanks := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::BankBalances);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            BalanceswithCommercialBanks += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::BankBalances);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            BalanceswithCommercialBanksLast += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //gov securities
                TreasuryBills := 0;
                TreasuryBonds := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::GovSecurities);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TreasuryBills += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::GovSecurities);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TreasuryBillsLast += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //balances with other financial institution
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::balanceswithotherfinancialinsti);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            BalanceswithotherFinancialInstitutions += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //20199
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::balanceswithotherfinancialinsti);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            BalanceswithotherFinancialInstitutionsLast += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //20199

                //total liabilities
                // GLAccount.RESET;
                // GLAccount.SETRANGE(GLAccount."No.",'20199');
                // IF GLAccount.FINDFIRST THEN BEGIN
                //  GLAccount.CALCFIELDS(Balance);
                //  TotalOtherliabilitiesNew:=GLAccount.Balance;
                // // MESSAGE('%1',TotalOtherliabilities);
                //  END;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::TotalOtherliabilitiesNew);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TotalOtherliabilitiesNew += GLEntry.Amount * -1;
                            // MESSAGE('%1',TotalOtherliabilitiesNew);
                        end;
                    until GLAccount.Next = 0;
                //20199
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::TotalOtherliabilitiesNew);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TotalOtherliabilitiesNewLast += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;
                //20199
                //time deposits
                //time deposits
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::TimeDeposits);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TimeDeposits += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                //time deposits
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::TimeDeposits);
                if GLAccount.FindSet then
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LoanFilterOk);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TimeDepositsLast += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                NETLIQUIDASSETS :=
                LocalNotes + ForeignNotes + BalancesduetoFinanciaInstitutions + BalancesDuetootherSaccosocieties + BalanceswithCommercialBanks + BalanceswithotherFinancialInstitutions + BalanceswithotherSaccoSocieties + TreasuryBills + TreasuryBonds + TimeDeposits
                + OverdraftsandMatured;
                //MESSAGE('%1|%2|%3',NETLIQUIDASSETS,TotalOtherliabilitiesNew,BalanceswithCommercialBanks);
                NETLIQUIDASSETSLst :=
                LocalNotesLast + ForeignNotes + BalancesduetoFinanciaInstitutionsLast + BalancesDuetootherSaccosocieties + BalanceswithCommercialBanksLast + BalanceswithotherFinancialInstitutionsLast + BalanceswithotherSaccoSocieties + TreasuryBillsLast + TreasuryBonds
                + TimeDepositsLast + OverdraftsandMatured;
                // TotalOtherliabilities:=MaturedLiabilities+LiabilitiesMaturingwithin91Days;
                if TotalOtherliabilitiesNew > 0 then
                    Ratio := NETLIQUIDASSETS / TotalOtherliabilitiesNew;
                if TotalOtherliabilitiesNewLast > 0 then
                    Ratio2 := NETLIQUIDASSETSLst / TotalOtherliabilitiesNewLast;
                ExcessLiquidityLast := (Ratio2) - (10 / 100);
                ExcessLiquidity := Ratio - (10 / 100);
            end;

            trigger OnPreDataItem()
            begin
                //++++++++Provision+++++++++++++++++++++++
                DateFilterNew := '..' + Format(AsAt);
                Date := CalcDate('-CY', AsAt);
                LastYear := CalcDate('-CY-1Y', AsAt);
                //EndLastYear:=CALCDATE('-1Y',AsAt);
                EndLastYear := CalcDate('-1Y', AsAt);

                //MESSAGE('Date%1aS%2',EndLastYear,AsAt);

                LastYearFilter := '..' + Format(EndLastYear);
                LoanFilterOk := '..' + Format(CalcDate('-1Y', AsAt));
                //LastYearFilter:='..'+FORMAT(EndLastYear);
                suplusfilter := Format(LastYear) + '..' + Format(EndLastYear);
                DateFilter := '..' + Format(AsAt);
                FinancialYear := Date2dmy(Date, 3);
                CurrentYearFilter := Format(Date) + '..' + Format(AsAt);
                NewFiterOk := Format(CalcDate('-CY', EndLastYear)) + '..' + Format(CalcDate('-1Y', AsAt));
                //MESSAGE('%1',NewFiterOk);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(AsAt; AsAt)
                {
                    ApplicationArea = Basic;
                    Caption = 'AsAt';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        DateFilter: Text;
        DateFilterNew: Text;
        Date: Date;
        investment: Decimal;
        investmentlAT: Decimal;
        NewFiterOk: Text;
        LoanFilterOk: Text;
        DateFilterCurrent: Text;
        TimeDepositsLast: Decimal;
        FinancialYear: Integer;
        NETLIQUIDASSETS: Decimal;
        Maximumstatutoryratio: Decimal;
        TimeDeposits: Decimal;
        ExcessLiquidity: Decimal;
        BalanceswithotherFinancialInstitutionsLast: Decimal;
        NETLIQUIDASSETSLst: Decimal;
        Ratio: Decimal;
        ExcessLiquidityLast: Decimal;
        Ratio2: Decimal;
        BalanceswithotherSaccoSocieties: Decimal;
        BalancesduetoFinanciaInstitutions: Decimal;
        BalancesduetoFinanciaInstitutionsLast: Decimal;
        BalancesDuetootherSaccosocieties: Decimal;
        OverdraftsandMatured: Decimal;
        ForeignNotes: Decimal;
        TreasuryBillsLast: Decimal;
        BalanceswithCommercialBanksLast: Decimal;
        LocalNotesLast: Decimal;
        LocalNotes: Decimal;
        AsAt: Date;
        BalanceswithCommercialBanks: Decimal;
        BalanceswithotherFinancialInstitutions: Decimal;
        TotalOtherliabilitiesNew: Decimal;
        TotalOtherliabilitiesNewLast: Decimal;
        TreasuryBonds: Decimal;
        TreasuryBills: Decimal;
        LastYear: Date;
        CorecapitaltoTotalassetratioNew: Decimal;
        CorecapitaltoTotalassetratioNewLast: Decimal;
        Excess1: Decimal;
        xcessdeficiency: Decimal;
        xcessdeficiencyLast: Decimal;
        Excess11: Decimal;
        CorecapitalDepositsliabilities: Decimal;
        CorecapitalDepositsliabilitiesLast: Decimal;
        Depositsliabilitiesratio: Decimal;
        DepositsliabilitiesratioLast: Decimal;
        EndLastYear: Date;
        LastYearFilter: Text;
        suplusfilter: Text;
        GovernmentSecuritiesLast: Decimal;
        Grossnonperformingloan: Decimal;
        DepositsandBalancesatOtherInstitutionsLast: Decimal;
        CorecapitalLast: Decimal;
        TOTALOnBalanceSheetLast: Decimal;
        Sub_TotalLast: Decimal;
        BalancesheetAssetsLast: Decimal;
        CapitalGrants: Decimal;
        PropertyandEquipmentLast: Decimal;
        OtherassetsLast: Decimal;
        TotalDeductionsLast: Decimal;
        BalancesheetAssets: Decimal;
        LoansRegister: Record "Loans Register";
        GrossnonperformingloanLast: Decimal;
        Interestinsuspense: Decimal;
        InterestinsuspenseLast: Decimal;
        CapitalGrantsLast: Decimal;
        InvestmentsinSubsidiaryLast: Decimal;
        TotalDepositsLiabilitiesLast: Decimal;
        OtherDeductionsLast: Decimal;
        Totalnonperformingloan: Decimal;
        OtherDeductions: Decimal;
        TotalnonperformingloanLast: Decimal;
        Directors: Decimal;
        DirectorsLast: Decimal;
        Employees: Decimal;
        ShareCapitalLast: Decimal;
        StatutoryReserveLast: Decimal;
        EmployeesLast: Decimal;
        Totalinsiderloans: Decimal;
        TotalinsiderloansLast: Decimal;
        Allowanceforloanloss: Decimal;
        AllowanceforloanlossLast: Decimal;
        NetSurplusaftertaxLast: Decimal;
        LoansandAdvanceslast: Decimal;
        totalassetsPBSheetLast: Decimal;
        Netnonperformingloans: Decimal;
        retainedEarninsLast: Decimal;
        OtherreservesLast: Decimal;
        NetnonperformingloansLast: Decimal;
#pragma warning disable AL0275
        GLAccount: Record "G/L Account";
#pragma warning restore AL0275
#pragma warning disable AL0275
        GLEntry: Record "G/L Entry";
#pragma warning restore AL0275
        othercontigentliabilities: Decimal;
        Guaranteesandcommitments: Decimal;
        totalcontingentliabilities: Decimal;
        CashLast: Decimal;
        Corecapital: Decimal;
        CorecapitaltoTotalassetratio: Decimal;
        liquidityRatio: Decimal;
        ShareCapitalValue: Decimal;
        ShareCapital: Decimal;
        StatutoryReserve: Decimal;
        retainedEarnins: Decimal;
        NetSurplusaftertax: Decimal;
        LoansandAdvances: Decimal;
        totalassetsPBSheet: Decimal;
        GovernmentSecurities: Decimal;
        Cash: Decimal;
        InvestmentsinSubsidiary: Decimal;
        Otherreserves: Decimal;
        DepositsandBalancesatOtherInstitutions: Decimal;
        Otherassets: Decimal;
        PropertyandEquipment: Decimal;
        TotalDepositsLiabilities: Decimal;
        Sub_Total: Decimal;
        TOTALOnBalanceSheet: Decimal;
        TotalDeductions: Decimal;
        CurrentYearFilter: Text;
        SaccoInsiders: Record "Sacco Insiders";
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        ScheduleRepayment: Decimal;
        ScheduleBalance: Decimal;
        LoanPrinciple: Decimal;
        LoanBalance: Decimal;
        ScheduleBalance1: Decimal;
        ExpectedAmount: Decimal;
        MonthsINArrears: Decimal;
        Minimumstatutoryratio: Decimal;
        Minimumstatutoryratio2: Decimal;
        Minimumstatutoryratio3: Decimal;
        Loans: Record "Loans Register";
        SubstarndardProv: Decimal;
        LossProv: Decimal;
        DoubtfulProv: Decimal;
        TotalProvision: Decimal;
        Loanss: Record "Loans Register";
        SubstarndardProvPY: Decimal;
        LossProvPY: Decimal;
        DoubtfulProvPY: Decimal;
        TotalProvisionPY: Decimal;
        MemberLedgerEntry: Record "Cust. Ledger Entry";
        EndYearMonth: Integer;
        EndYearDay: Integer;
        EndYearYear: Integer;
        AsAtFilter: Text;
}
