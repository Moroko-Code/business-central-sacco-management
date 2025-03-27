tableextension 51516044 "GlAccountExt" extends "G/L Account"
{
    fields
    {
        field(1000; "Budget Controlled"; Boolean)
        {
            Caption = 'Budget Controlled';
            DataClassification = ToBeClassified;
        }
        field(1002; "Expense Code"; Code[100])
        {
            Caption = 'Expense Code';
            DataClassification = ToBeClassified;
        }
        field(1003; "GL Account Balance"; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(54252; StatementOfFP; Option)
        {
            OptionMembers = "  ",Cashinhand,InterestonMemberdeposits,Cashatbank,GrossLoanPortfolio,PropertyEquipment,AllowanceforLoanLoss,PrepaymentsSundryReceivables,Investmentincompanies,IntangibleAssets,"Other Assets";
        }
        field(54253; StatementOfFP2; Option)
        {
            OptionCaption = '  ,Nonwithdrawabledeposits,TaxPayable,DeferredTaxLiability,OtherLiabilities,ExternalBorrowings,ShareCapital,StatutoryReserve,OtherReserves,RevaluationReserves,PrioryarRetainedEarnings,CurrentYrSurplus';
            OptionMembers = "  ",Nonwithdrawabledeposits,TaxPayable,DeferredTaxLiability,OtherLiabilities,ExternalBorrowings,ShareCapital,StatutoryReserve,OtherReserves,RevaluationReserves,PrioryarRetainedEarnings,CurrentYrSurplus;
        }
        field(54254; "Form2F(Statement of C Income)"; Option)
        {
            OptionMembers = " ",OtherOperatingincome,NetFeeandcommission,InterestExpenses,OtherInterestIncome,InterestonLoanPortfolio,FeesCommissiononLoanPortfolio,GovernmentSecurities,InvestmentinCompaniesshares,nterestExpenseonDeposits,DividendExpenses,OtherFinancialExpense,FeesCommissionExpense,OtherExpense,ProvisionforLoanLosses;
        }
        field(54255; "Form2F1(Statement of C Income)"; Option)
        {
            OptionCaption = '  ,PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,Taxes,NonOperatingIncome,NonOperatingExpense,OtherFinancialExpense,ValueofLoansRecovered';
            OptionMembers = "  ",PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,Taxes,NonOperatingIncome,NonOperatingExpense,OtherFinancialExpense,ValueofLoansRecovered;
        }
        field(54256; "Capital adequecy"; Option)
        {
            OptionCaption = '  ,ShareCapital,StatutoryReserve,RetainedEarnings,LoansandAdvances,Cash,InvestmentsinSubsidiary,Otherreserves,GovernmentSecurities,DepositsandBalancesatOtherInstitutions,Otherassets,PropertyandEquipment,TotalDepositsLiabilities,Investments,NetSurplusaftertax';
            OptionMembers = "  ",ShareCapital,StatutoryReserve,RetainedEarnings,LoansandAdvances,Cash,InvestmentsinSubsidiary,Otherreserves,GovernmentSecurities,DepositsandBalancesatOtherInstitutions,Otherassets,"PropertyandEquipment ",TotalDepositsLiabilities,Investments,NetSurplusaftertax;
        }
        field(54257; Liquidity; Option)
        {
            OptionCaption = ' ,LocalNotes,BankBalances,GovSecurities,balanceswithotherfinancialinsti,TotalOtherliabilitiesNew,TimeDeposits';
            OptionMembers = " ",LocalNotes,BankBalances,GovSecurities,balanceswithotherfinancialinsti,TotalOtherliabilitiesNew,TimeDeposits;
        }
        field(54258; "Form2E(investment)"; Option)
        {
            OptionCaption = '  ,Core_Capital,Equityinvestment,Otherinvestments,subsidiaryandrelatedentities,otherassets,totaldeposits';
            OptionMembers = "  ",Core_Capital,Equityinvestment,Otherinvestments,subsidiaryandrelatedentities,otherassets,totaldeposits;
        }
        field(54259; "Form 2H other disc"; Option)
        {
            OptionCaption = '  ,AllowanceForLoanLoss,Core_Capital,Deposits liabilities';
            OptionMembers = "  ",AllowanceForLoanLoss,Core_Capital,"Deposits liabilities";
        }
        field(54260; "Form2E(investment)New"; Option)
        {
            OptionCaption = '  ,Nonearningassets,Landbuilding';
            OptionMembers = "  ",Nonearningassets,Landbuilding;
        }
        field(54261; "Form2E(investment)Land"; Option)
        {
            OptionCaption = ' ,LandBuilding';
            OptionMembers = " ",LandBuilding;
        }
        field(54262; ChangesInEquity; Option)
        {
            OptionCaption = ' ,ShareCapital,StatutoryReserve,GeneralReserve,RevaluationReserve,RetainedEarnings,honararia';
            OptionMembers = " ",ShareCapital,StatutoryReserve,GeneralReserve,RevaluationReserve,RetainedEarnings,honararia;
        }
        field(54263; Assets; Option)
        {
            OptionMembers = " ",CashAndEquivalents,ReceivablesAndPrepayements,LoansAndAdvances,FinancialAssets,propertyplantandEquipment,Intangiableassets;
            DataClassification = ToBeClassified;
        }
        field(54264; MkopoLiabilities; Option)
        {
            OptionMembers = " ",TradeandotherPayables,LoanLoss,MemberDeposits,dividendsandInterestPayable,Honoria,Taxpayable;
            DataClassification = ToBeClassified;
        }
        field(54265; FinancedBy; Option)
        {
            OptionMembers = " ",StatutoryReserves,RevenueReserves,Sharecapital;
        }
        field(54266; Financials; Option)
        {
            OptionMembers = " ",Revenue,InterestIncome,Expenses;
        }
        field(54267; PersonnelExRe; Option)
        {
            OptionMembers = " ","Personnel Expenses","Personnel Revenue";
        }

        //Income
        field(54268; Incomes; Option)
        {
            OptionMembers = " ",InterestOnLoans,InterestExpenses,OtherOperatingIncome,InvestmentIncome,GorvernanceExpenses,AdministrationExpenses,PersonelExpenses,OperatingExpenses,FinancialExpense,MarketingExpenses,DepreciationAmmortisation,IncomeTaxExpense;
            DataClassification = ToBeClassified;
        }
        field(54269; Others; option)
        {
            OptionMembers = " ",PriorYearAdjustments,ShortTermLiabilities;
        }
    }
}
