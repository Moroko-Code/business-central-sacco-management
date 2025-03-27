report 50010 "Payroll Payslip"
{

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Payroll Payslip.rdl';

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            RequestFilterFields = "No.";
            column(No; "No.") { }
            column(Surname; Surname) { }
            column(FirstName; "First Name") { }
            column(Lastname; "Middle Name") { }
            column(FullName; "Full Name") { }
            column(CName; CompanyInfo.Name) { }
            column(CAddress; CompanyInfo.Address) { }
            column(CPic; CompanyInfo.Picture) { }
            column(PeriodName; PeriodName) { }
            column(IncrementDate_PayrollEmployee; "Payroll Employee."."Next Increment Date") { }
            column(PINNo; "PIN No") { }
            column(JobGroup_PayrollEmployee; "Payroll Employee."."Job Group") { }
            column(JobDescription_PayrollEmployee; "Payroll Employee."."Job Description") { }
            column(GlobalDimension1_PayrollEmployee; "Payroll Employee."."Global Dimension 1") { }
            column(GlobalDimension2_PayrollEmployee; "Payroll Employee."."Global Dimension 2") { }
            column(NSSFNo; "NSSF No") { }
            column(BankCode_PayrollEmployee; "Payroll Employee."."Bank Code") { }
            column(NHIFNo; "NHIF No") { }
            column(BankName; "Bank Name") { }
            column(BranchName; "Branch Name") { }
            column(DateOfRetirement_PayrollEmployee; "Payroll Employee."."Date Of Retirement") { }
            column(Department; "Payroll Employee.".Department) { }
            column(UserId; UserId) { }
            column(BankAccNo; "Bank Account No") { }
            column(Departmentname; Departmentname) { }
            column(DepartmentCode_PayrollEmployee; "Payroll Employee."."Department Code") { }
            column(BANKN; BANKN) { }
            column(BranchN; BranchN) { }
            column(ACCn; ACCn) { }
            column(Designation; Designation) { }
            dataitem("prPeriod Transactions."; "prPeriod Transactions.")
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                RequestFilterFields = "Payroll Period";
                column(TCode; "Transaction Code") { }
                column(TName; "Transaction Name") { }
                column(coop_parameters; "coop parameters") { }
                column(Grouping; "Group Order") { }
                column(TBalances; "Original Amount") { }
                column(SubGroupOrder; "prPeriod Transactions."."Sub Group Order") { }
                column(Amount; Amount) { }
                column(PeriodMonth_prPeriodTransactions; "Period Month") { }
                column(PeriodYear_prPeriodTransactions; "Period Year") { }
                column(GPAY; GPAY) { }
                column(BPAY; BPAY) { }
                column(NPAY; NPAY) { }
                column(NSSF; NSSF) { }
                column(NHIF; NHIF) { }
                column(Pens; Pens) { }
                column(TaxablePay; TaxablePay) { }
                column(Taxcharged; Taxcharged) { }
                column(prelief; prelief) { }
                column(NHIFR; NHIFR) { }
                column(insrel; insrel) { }
                column(paye; paye) { }
                column(Housing_Levy; "Housing Levy") { }
                column(Housing_Levy_Relief; "Housing Levy Relief") { }
                column(BenevolentAmount; BenevolentAmount) { }
                column(SaccoLoans; SaccoLoans) { }
                column(SaccoDeposits; SaccoDeposits) { }
                column(SaccoFixedDeposits; SaccoFixedDeposits) { }
                column(TotalDeduction; TotalDeduction) { }
                column(ICEA; ICEA) { }
                trigger OnAfterGetRecord()
                begin
                    BANKN := '';
                    BranchN := '';
                    ACCn := '';
                    NSSF := 0;
                    Pens := 0;
                    TaxablePay := 0;
                    Taxcharged := 0;
                    prelief := 0;
                    insrel := 0;
                    paye := 0;
                    Loanamounnt := 0;
                    "Housing Levy" := 0;
                    "Housing Levy Relief" := 0;
                    ICEA := 0;
                    SaccoLoans := 0;
                    SaccoDeposits := 0;
                    BenevolentAmount := 0;
                    SaccoFixedDeposits := 0;
                    BPAY := 0;
                    NPAY := 0;
                    NPAY := 0;

                    PayrollCalender.Reset;
                    PayrollCalender.SetRange("Date Opened", PeriodFilter);
                    if PayrollCalender.FindFirst() then
                        PeriodName := PayrollCalender."Period Name";

                    // Basic pay
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    prPeriodTransactions2.SetRange("Transaction Code", 'BPAY');
                    if prPeriodTransactions2.FindFirst then
                        BPAY := prPeriodTransactions2.Amount;

                    // Gross pay
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    prPeriodTransactions2.SetRange("Transaction Code", 'GPAY');
                    if prPeriodTransactions2.FindFirst then
                        GPAY := prPeriodTransactions2.Amount;

                    // Net pay
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    prPeriodTransactions2.SetRange("Transaction Code", 'NPAY');
                    if prPeriodTransactions2.FindFirst then
                        NPAY := prPeriodTransactions2.Amount;


                    // NSSF Deductions
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    prPeriodTransactions2.SetRange("Transaction Code", 'NSSF');
                    if prPeriodTransactions2.FindFirst then
                        NSSF := prPeriodTransactions2.Amount;

                    //Pension Contribution
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    prPeriodTransactions2.SetRange("Transaction Code", 'PENSION');
                    if prPeriodTransactions2.FindFirst then
                        Pens := prPeriodTransactions2.Amount;

                    //Taxable pay
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    prPeriodTransactions2.SetRange("Transaction Code", 'TXBP');
                    if prPeriodTransactions2.FindFirst then
                        TaxablePay := prPeriodTransactions2.Amount;

                    // Housing Leavy
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    prPeriodTransactions2.SetRange("Transaction Code", 'HLEVY');
                    if prPeriodTransactions2.FindFirst then
                        "Housing Levy" := prPeriodTransactions2.Amount;

                    // Housing Leavy Relief
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    prPeriodTransactions2.SetRange("Transaction Code", 'HLEVYR');
                    if prPeriodTransactions2.FindFirst then
                        "Housing Levy Relief" := prPeriodTransactions2.Amount;

                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    prPeriodTransactions2.SetRange("Transaction Code", 'TXCHRG');
                    if prPeriodTransactions2.FindFirst then
                        Taxcharged := prPeriodTransactions2.Amount;

                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    prPeriodTransactions2.SetRange("Transaction Code", 'PSNR');
                    if prPeriodTransactions2.FindFirst then
                        prelief := prPeriodTransactions2.Amount;

                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    prPeriodTransactions2.SetRange("Transaction Code", 'INSRD');
                    if prPeriodTransactions2.FindFirst then
                        insrel := prPeriodTransactions2.Amount;

                    // Paye
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    prPeriodTransactions2.SetRange("Transaction Code", 'PAYE');
                    if prPeriodTransactions2.FindFirst then
                        paye := prPeriodTransactions2.Amount;

                    //NHIF
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    prPeriodTransactions2.SetRange("Transaction Code", 'NHIF');
                    if prPeriodTransactions2.FindFirst then
                        NHIF := prPeriodTransactions2.Amount;

                    //NHIF Relief
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    prPeriodTransactions2.SetRange("Transaction Code", 'NHIFR');
                    if prPeriodTransactions2.FindFirst then
                        NHIFR := prPeriodTransactions2.Amount;

                    //ICEA Relief
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    prPeriodTransactions2.SetRange("Transaction Code", 'ICEA');
                    if prPeriodTransactions2.FindFirst then
                        ICEA := prPeriodTransactions2.Amount;

                    //Loan Deductions
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    // prPeriodTransactions2.SetRange("coop parameters", "coop parameters"::loan);
                    prPeriodTransactions2.SetRange("Transaction Code", '02');
                    if prPeriodTransactions2.FindFirst() then
                        SaccoLoans := prPeriodTransactions2.Amount;

                    //Sacco Deposits
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    prPeriodTransactions2.SetRange("Transaction Code", '03');
                    if prPeriodTransactions2.FindFirst() then
                        SaccoDeposits := prPeriodTransactions2.Amount;

                    //Fixed Savings
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    prPeriodTransactions2.SetRange("Transaction Code", '05');
                    if prPeriodTransactions2.FindFirst() then
                        SaccoFixedDeposits := prPeriodTransactions2.Amount;

                    //Sacco Benevolent
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", PeriodFilter);
                    //prPeriodTransactions2.SetRange("coop parameters", "coop parameters"::Welfare);
                    prPeriodTransactions2.SetRange("Transaction Code", '04');
                    if prPeriodTransactions2.FindFirst then
                        BenevolentAmount := prPeriodTransactions2.Amount;

                    // Total Deductions
                    TotalDeduction := (NSSF + NHIF + paye + Pens + SaccoDeposits + SaccoLoans + "Housing Levy" + SaccoFixedDeposits + BenevolentAmount);

                    PayrollBankdeatails.Reset;
                    PayrollBankdeatails.SetRange("No.", "prPeriod Transactions."."Employee Code");
                    PayrollBankdeatails.SetRange("Payroll Period", PeriodFilter);
                    if PayrollBankdeatails.FindFirst then begin
                        BANKN := PayrollBankdeatails."Bank Name";
                        BranchN := PayrollBankdeatails."Branch Name";
                        ACCn := PayrollBankdeatails."Bank Account No";
                    end;

                end;
            }

            trigger OnAfterGetRecord()
            begin

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(PeriodFilter; PeriodFilter)
                {
                    Caption = 'Payroll Period:';
                    TableRelation = "Payroll Calender."."Date Opened";
                    ApplicationArea = all;
                }
            }
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        IF UserSetup.GET(USERID) THEN BEGIN
            IF NOT UserSetup."Payroll User" THEN
                ERROR(PemissionDenied);
        END ELSE
            ERROR(UserNotFound, USERID);
    end;

    trigger OnPreReport()
    begin
        if PeriodFilter = 0D then
            Error('Please specify the period');

        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);

        // PayrollEmp.RESET;
        // PayrollEmp.SETRANGE(PayrollEmp.Status, PayrollEmp.Status::Active);
        // IF PayrollEmp.FINDFIRST THEN BEGIN
        //     PayrollCalender.RESET;
        //     PayrollCalender.SETRANGE(PayrollCalender."Date Opened", "Payroll Period");//PeriodFilter);
        //     IF PayrollCalender.FINDLAST THEN BEGIN
        //         PeriodName := PayrollCalender."Period Name";
        //     END;
        // END;
    end;

    var
        BPAY: Decimal;
        GPAY: Decimal;
        NPAY: Decimal;
        TotalDeduction: Decimal;
        BenevolentAmount: Decimal;
        LoanInterestAmont: Decimal;
        Loanamounnt: Decimal;
        LoanBalance: Decimal;
        SaccoSharesAmunt: Decimal;
        LikizoContribution: Decimal;
        ShareCapital: Decimal;
        "Housing Levy": Decimal;
        PeriodFilter: Date;
        NHIF: Decimal;
        CompanyInfo: Record "Company Information";
        PayrollCalender: Record "Payroll Calender.";
        PeriodName: Text;
        UserNotFound: Label 'User Setup %1 not found.';
        PemissionDenied: Label 'User Account is not Setup for Payroll Use. Contact System Administrator.';
        UserSetup: Record "User Setup";
        Departmentname: Text;
        // HREmployees: Record "HR Employees";
        prPeriodTransactions2: Record "prPeriod Transactions.";
        NSSF: Decimal;
        Pens: Decimal;
        TaxablePay: Decimal;
        Taxcharged: Decimal;
        prelief: Decimal;
        insrel: Decimal;
        paye: Decimal;
        BANKN: Text;
        BranchN: Text;
        ACCn: Code[100];
        PayrollBankdeatails: Record "Payroll Bank deatails";
        NHIFR: Decimal;
        "Housing Levy Relief": Decimal;
        ICEA: Decimal;
        SaccoLoans: Decimal;
        SaccoDeposits: Decimal;
        SaccoFixedDeposits: Decimal;
}
