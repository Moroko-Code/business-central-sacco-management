#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50311 "Payroll Employee List."
{
    CardPageID = "Payroll Employee Card.";
    DeleteAllowed = true;
    InsertAllowed = true;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    RefreshOnActivate = true;
    SourceTable = "Payroll Employee.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff  No.';
                }
                field("Payroll No"; "Payroll No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sacco Membership No.';
                }
                field("Full Name"; "Full Name")
                {
                    ApplicationArea = Basic;
                }
                field("Exit Staff"; "Exit Staff")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        ExitReasonVisible := false;
                        if "Exit Staff" = true then
                            ExitReasonVisible := true;
                    end;
                }
                field("Basic Pay"; "Basic Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Pays PAYE"; "Pays PAYE")
                {
                    ApplicationArea = Basic;
                }
                field("Pays NSSF"; "Pays NSSF")
                {
                    ApplicationArea = Basic;
                }
                field("Pays NHIF"; "Pays NHIF")
                {
                    ApplicationArea = Basic;
                }
                field("Voluntary Deposit Contribution"; "Voluntary Deposit Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Pay Bonus"; "Pay Bonus")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        BonusAmountVisible := false;
                        if "Pay Bonus" = true then
                            BonusAmountVisible := true;
                    end;
                }
                field("Bonus Amount"; "Bonus Amount")
                {
                    ApplicationArea = Basic;
                    Enabled = BonusAmountVisible;
                }
                field("Joining Date"; "Joining Date")
                {
                    ApplicationArea = Basic;
                }
                field("Job Group"; "Job Group")
                {
                    ApplicationArea = Basic;
                }
                field(Category; Category)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Group"; "Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No"; "Bank Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Email"; "Employee Email")
                {
                    ApplicationArea = Basic;
                }
                field("Managerial Position"; "Is Management")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Outlook)
            {
            }
            systempart(Control10; Notes)
            {
            }
            systempart(Control11; MyNotes)
            {
            }
            systempart(Control12; Links)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(InsertSaccoDeductions)
            {
                ApplicationArea = Basic;
                Caption = 'Effect Sacco Deductions';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    VarMonthlyInstalments: Decimal;
                begin
                    ObjPayrollCalender.Reset;
                    ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
                    ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
                    if ObjPayrollCalender.FindLast then begin
                        VarOpenPeriod := ObjPayrollCalender."Date Opened";
                        varPeriodMonth := Date2dmy(VarOpenPeriod, 2);
                        VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
                    end;
                    // end;

                    ObjPayrollEmployees.Reset;
                    ObjPayrollEmployees.SetRange(ObjPayrollEmployees.Status, ObjPayrollEmployees.Status::Active);
                    ObjPayrollEmployees.SetRange(ObjPayrollEmployees."Suspend Pay", false);
                    if ObjPayrollEmployees.FindSet then
                        repeat
                            //Shares Contribution
                            ObjTransactionCodes.Reset;
                            ObjTransactionCodes.SetRange(ObjTransactionCodes."Co-Op Parameters", ObjTransactionCodes."co-op parameters"::Shares);
                            if ObjTransactionCodes.FindSet then
                                if ObjCust.Get(ObjPayrollEmployees."Payroll No") then begin
                                    ObjCust.CalcFields(ObjCust."Current Shares");
                                    //============================================Delete Entries For the Same Period
                                    ObjEmployeeTransactions.Reset;
                                    ObjEmployeeTransactions.SetRange(ObjEmployeeTransactions."Payroll Period", VarOpenPeriod);
                                    ObjEmployeeTransactions.SetRange(ObjEmployeeTransactions."No.", ObjPayrollEmployees."No.");
                                    ObjEmployeeTransactions.SetFilter(ObjEmployeeTransactions."Loan Number", '%1', '');
                                    ObjEmployeeTransactions.SetRange(ObjEmployeeTransactions."Transaction Code", ObjTransactionCodes."Transaction Code");
                                    if ObjEmployeeTransactions.FindSet then
                                        ObjEmployeeTransactions.DeleteAll;
                                    //============================================Delete Entries For the Same Period
                                    ObjCust.CalcFields(ObjCust."Current Shares");
                                    ObjPayrollEmployeeTrans.Init;
                                    ObjPayrollEmployeeTrans."Sacco Membership No." := ObjPayrollEmployees."Payroll No";
                                    ObjPayrollEmployeeTrans."No." := ObjPayrollEmployees."No.";
                                    ObjPayrollEmployeeTrans."Loan Number" := '';
                                    ObjPayrollEmployeeTrans."Transaction Code" := ObjTransactionCodes."Transaction Code";
                                    ObjPayrollEmployeeTrans."Transaction Name" := ObjTransactionCodes."Transaction Name";
                                    ObjPayrollEmployeeTrans."Transaction Type" := ObjTransactionCodes."Transaction Type";
                                    ObjPayrollEmployeeTrans."Payroll Period" := VarOpenPeriod;
                                    ObjPayrollEmployeeTrans."Period Month" := varPeriodMonth;
                                    ObjPayrollEmployeeTrans."Period Year" := VarPeriodYear;
                                    ObjPayrollEmployeeTrans.Amount := ObjCust."Monthly Contribution";
                                    ObjPayrollEmployeeTrans."Amount(LCY)" := ObjCust."Monthly Contribution";
                                    ObjPayrollEmployeeTrans.Balance := ObjCust."Current Shares";
                                    ObjPayrollEmployeeTrans."Balance(LCY)" := ObjCust."Current Shares";
                                    ObjPayrollEmployeeTrans."Amtzd Loan Repay Amt" := 0;
                                    ObjPayrollEmployeeTrans.Insert;
                                end;
                            //SharecapitalContribution
                            ObjTransactionCodes.Reset;
                            ObjTransactionCodes.SetRange(ObjTransactionCodes."Co-Op Parameters", ObjTransactionCodes."co-op parameters"::"Share Capital");
                            if ObjTransactionCodes.FindSet then
                                if ObjCust.Get(ObjPayrollEmployees."Payroll No") then begin
                                    ObjCust.CalcFields(ObjCust."Share Capital");

                                    //============================================Delete Entries For the Same Period
                                    ObjEmployeeTransactions.Reset;
                                    ObjEmployeeTransactions.SetRange(ObjEmployeeTransactions."Payroll Period", VarOpenPeriod);
                                    ObjEmployeeTransactions.SetRange(ObjEmployeeTransactions."No.", ObjPayrollEmployees."No.");
                                    ObjEmployeeTransactions.SetFilter(ObjEmployeeTransactions."Loan Number", '%1', '');
                                    ObjEmployeeTransactions.SetRange(ObjEmployeeTransactions."Transaction Code", ObjTransactionCodes."Transaction Code");
                                    if ObjEmployeeTransactions.FindSet then
                                        ObjEmployeeTransactions.DeleteAll;
                                    //============================================Delete Entries For the Same Period
                                    ObjCust.CalcFields(ObjCust."Share Capital");
                                    ObjPayrollEmployeeTrans.Init;
                                    ObjPayrollEmployeeTrans."Sacco Membership No." := ObjPayrollEmployees."Payroll No";
                                    ObjPayrollEmployeeTrans."No." := ObjPayrollEmployees."No.";
                                    ObjPayrollEmployeeTrans."Loan Number" := '';
                                    ObjPayrollEmployeeTrans."Transaction Code" := ObjTransactionCodes."Transaction Code";
                                    ObjPayrollEmployeeTrans."Transaction Name" := ObjTransactionCodes."Transaction Name";
                                    ObjPayrollEmployeeTrans."Transaction Type" := ObjTransactionCodes."Transaction Type";
                                    ObjPayrollEmployeeTrans."Payroll Period" := VarOpenPeriod;
                                    ObjPayrollEmployeeTrans."Period Month" := varPeriodMonth;
                                    ObjPayrollEmployeeTrans."Period Year" := VarPeriodYear;
                                    ObjPayrollEmployeeTrans.Amount := ObjCust."Monthly ShareCap Cont.";
                                    ObjPayrollEmployeeTrans."Amount(LCY)" := ObjCust."Monthly ShareCap Cont.";
                                    ObjPayrollEmployeeTrans.Balance := ObjCust."Share Capital";
                                    ObjPayrollEmployeeTrans."Balance(LCY)" := ObjCust."Share Capital";
                                    ObjPayrollEmployeeTrans."Amtzd Loan Repay Amt" := 0;
                                    ObjPayrollEmployeeTrans.Insert;
                                end;
                            //End of share capital

                            //Likizo contribution
                            ObjTransactionCodes.Reset;
                            ObjTransactionCodes.SetRange(ObjTransactionCodes."Co-Op Parameters", ObjTransactionCodes."co-op parameters"::Likizo);
                            if ObjTransactionCodes.FindSet then
                                if ObjCust.Get(ObjPayrollEmployees."Payroll No") then begin


                                    //============================================Delete Entries For the Same Period
                                    ObjEmployeeTransactions.Reset;
                                    ObjEmployeeTransactions.SetRange(ObjEmployeeTransactions."Payroll Period", VarOpenPeriod);
                                    ObjEmployeeTransactions.SetRange(ObjEmployeeTransactions."No.", ObjPayrollEmployees."No.");
                                    ObjEmployeeTransactions.SetFilter(ObjEmployeeTransactions."Loan Number", '%1', '');
                                    ObjEmployeeTransactions.SetRange(ObjEmployeeTransactions."Transaction Code", ObjTransactionCodes."Transaction Code");
                                    if ObjEmployeeTransactions.FindSet then
                                        ObjEmployeeTransactions.DeleteAll;
                                    //============================================Delete Entries For the Same Period
                                    ObjCust.CalcFields(ObjCust."Share Capital");
                                    ObjPayrollEmployeeTrans.Init;
                                    ObjPayrollEmployeeTrans."Sacco Membership No." := ObjPayrollEmployees."Payroll No";
                                    ObjPayrollEmployeeTrans."No." := ObjPayrollEmployees."No.";
                                    ObjPayrollEmployeeTrans."Loan Number" := '';
                                    ObjPayrollEmployeeTrans."Transaction Code" := ObjTransactionCodes."Transaction Code";
                                    ObjPayrollEmployeeTrans."Transaction Name" := ObjTransactionCodes."Transaction Name";
                                    ObjPayrollEmployeeTrans."Transaction Type" := ObjTransactionCodes."Transaction Type";
                                    ObjPayrollEmployeeTrans."Payroll Period" := VarOpenPeriod;
                                    ObjPayrollEmployeeTrans."Period Month" := varPeriodMonth;
                                    ObjPayrollEmployeeTrans."Period Year" := VarPeriodYear;
                        

                                    ObjPayrollEmployeeTrans."Amtzd Loan Repay Amt" := 0;
                                    ObjPayrollEmployeeTrans.Insert;
                                end;
                            //end of Likizo
                            //Loan Deduction
                            ObjEmployeeTransactions.Reset;
                            ObjEmployeeTransactions.SetRange(ObjEmployeeTransactions."Payroll Period", VarOpenPeriod);
                            ObjEmployeeTransactions.SetRange(ObjEmployeeTransactions."No.", ObjPayrollEmployees."No.");
                            ObjEmployeeTransactions.SetFilter(ObjEmployeeTransactions."Loan Number", '<>%1', '');
                            ObjEmployeeTransactions.SetRange(ObjEmployeeTransactions."Transaction Code", 'LOAN');
                            if ObjEmployeeTransactions.FindSet then
                                ObjEmployeeTransactions.DeleteAll;
                            ObjTransactionCodes.Reset;
                            ObjTransactionCodes.SetRange(ObjTransactionCodes."Co-Op Parameters", ObjTransactionCodes."co-op parameters"::Loan);
                            if ObjTransactionCodes.FindSet then begin
                                ObjLoans.Reset();
                                ObjLoans.SetRange(ObjLoans."Client Code", ObjPayrollEmployees."Payroll No");
                                if ObjLoans.Find('-') then
                                    repeat
                                        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                                        //============================================Delete Entries For the Same Period

                                        //============================================Delete Entries For the Same Period
                                        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                                        If ObjLoans."Outstanding Balance" > 0 then begin
                                            if ObjLoans."Outstanding Balance" < ObjLoans.repayment then
                                                VarMonthlyInstalments := ObjLoans."Outstanding Balance" else
                                                VarMonthlyInstalments := ObjLoans.Repayment;

                                            ObjPayrollEmployeeTrans.Init;
                                            ObjPayrollEmployeeTrans."Sacco Membership No." := ObjPayrollEmployees."Payroll No";
                                            ObjPayrollEmployeeTrans."No." := ObjPayrollEmployees."No.";
                                            ObjPayrollEmployeeTrans."Loan Number" := ObjLoans."Loan  No.";
                                            ObjPayrollEmployeeTrans."Transaction Code" := ObjTransactionCodes."Transaction Code";
                                            ObjPayrollEmployeeTrans."Transaction Name" := ObjTransactionCodes."Transaction Name";
                                            ObjPayrollEmployeeTrans."Transaction Type" := ObjTransactionCodes."Transaction Type";
                                            ObjPayrollEmployeeTrans."Payroll Period" := VarOpenPeriod;
                                            ObjPayrollEmployeeTrans."Period Month" := varPeriodMonth;
                                            ObjPayrollEmployeeTrans."Period Year" := VarPeriodYear;
                                            ObjPayrollEmployeeTrans.Amount := VarMonthlyInstalments;
                                            ObjPayrollEmployeeTrans."Amount(LCY)" := VarMonthlyInstalments;
                                            ObjPayrollEmployeeTrans.Balance := ObjLoans."Outstanding Balance";
                                            ObjPayrollEmployeeTrans."Balance(LCY)" := ObjLoans."Outstanding Balance";
                                            ObjPayrollEmployeeTrans."Amtzd Loan Repay Amt" := 0;
                                            ObjPayrollEmployeeTrans.Insert;
                                        end;
                                    until ObjLoans.Next = 0;
                            end;


                        until ObjPayrollEmployees.Next = 0;

                    Message('Entries Updated Succesfully');
                end;
            }

            action("View PaySlip")
            {
                ApplicationArea = Basic;
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    PayrollEmp.Reset;
                    PayrollEmp.SetRange(PayrollEmp."No.", "No.");
                    if PayrollEmp.FindFirst then
                        Report.Run(50010, true, false, PayrollEmp);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ExitReasonVisible := false;
        BonusAmountVisible := false;
        if "Exit Staff" = true then
            ExitReasonVisible := true;

        if "Pay Bonus" = true then
            BonusAmountVisible := true;
    end;

    trigger OnAfterGetRecord()
    begin
        ExitReasonVisible := false;
        BonusAmountVisible := false;
        if "Exit Staff" = true then
            ExitReasonVisible := true;

        if "Pay Bonus" = true then
            BonusAmountVisible := true;
    end;

    trigger OnInit()
    begin
        //TODO
        IF Usersetup.GET(USERID) THEN
            IF Usersetup."Payroll User" = FALSE THEN
                ERROR('You dont have permissions for payroll, Contact your system administrator! ');
    end;

    trigger OnOpenPage()
    begin
        ExitReasonVisible := false;
        BonusAmountVisible := false;
        if "Exit Staff" = true then
            ExitReasonVisible := true;

        if "Pay Bonus" = true then
            BonusAmountVisible := true;
    end;

    var
        Usersetup: Record "User Setup";
        ObjPayrollEmployeeTrans: Record "Payroll Employee Transactions.";
        SFactory: Codeunit "SURESTEP Factory";
        ObjPayrollCalender: Record "Payroll Calender.";
        VarOpenPeriod: Date;
        ObjLoans: Record "Loans Register";
        ObjPayrollEmployeeTransII: Record "Payroll Employee Transactions.";
        ObjTransactionCodes: Record "Payroll Transaction Code.";
        ObjPayrollEmployeeTransIII: Record "Payroll Employee Transactions.";
        ObjTransactionCodesII: Record "Payroll Transaction Code.";
        ObjLoanRepaymentSchedule: Record "Loan Repayment Schedule Buffer";
        VarAmortizationAmount: Decimal;
        ObjPayrollEmployees: Record "Payroll Employee.";
        ProgressWindow: Dialog;
        ObjEmployeeTransactions: Record "Payroll Employee Transactions.";
        ExitReasonVisible: Boolean;
        PayrollEmp: Record "Payroll Employee.";
        //PayrollManager: Codeunit "Payroll Management";
        "Payroll Period": Date;
        PayrollCalender: Record "Payroll Calender.";
        PayrollMonthlyTrans: Record "Payroll Monthly Transactions.";
        PayrollEmployeeDed: Record "Payroll Employee Deductions.";
        PayrollEmployerDed: Record "Payroll Employer Deductions.";
        objEmp: Record "Salary Processing Header";
        SalCard: Record "Payroll Employee.";
        objPeriod: Record "Payroll Calender.";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        ProcessPayroll: Codeunit "Payroll Processing";
        HrEmployee: Record "Payroll Employee.";
        prPeriodTransactions: Record "prPeriod Transactions..";
        prEmployerDeductions: Record "Payroll Employer Deductions.";
        PayrollType: Record "Payroll Type.";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "Company Information";
        ObjPayrollTransactions: Record "prPeriod Transactions.";
        ObjPayrollTransactionsII: Record "prPeriod Transactions.";
        varPeriodMonth: Integer;
        BonusAmountVisible: Boolean;
        VarLoanDueAmount: Decimal;
        ObjPayrollEmployeesIV: Record "Payroll Employee.";
        VarPeriodYear: Integer;
        VarMonthlyDepositsContribution: Decimal;
        ObjCust: Record Customer;
        ObjLoansII: Record "Loans Register";
        VarMonthlyInstalments: Decimal;
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarDateFilter: Text;
        VarEndMonthDate: Date;

    local procedure FnGetClientCodeEmail(ClientCode: Code[50]): Text[100]
    var
        PayrollEmp: Record "Payroll Employee.";
        receipt: Record "Payroll Employee.";
    begin
        PayrollEmp.Reset();
        PayrollEmp.SetRange(PayrollEmp."No.", ClientCode);
        if PayrollEmp.Find('-') then
            exit(PayrollEmp."Employee Email");
    end;

    local procedure FnRunUpdateNewMemberLoans(VarMemberNo: Code[30])
    var
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;

        ObjPayrollEmployeeTrans.Reset;
        ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Sacco Membership No.", VarMemberNo);
        ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Payroll Period", '%1', VarOpenPeriod);
        if ObjPayrollEmployeeTrans.Find('-') then
            ObjPayrollEmployeeTrans.DeleteAll();

        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
       
        if ObjLoans.FindSet then
            repeat
              
                if ObjLoans."Exempt From Payroll Deduction" = true then //***Delete Loans Exempted from Payroll****
                begin
                    ObjPayrollEmployeeTrans.Reset;
                    ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Sacco Membership No.", VarMemberNo);
                    ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Loan Number", ObjLoans."Loan  No.");
                    ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Payroll Period", '%1', VarOpenPeriod);
                    if ObjPayrollEmployeeTrans.FindSet = false then
                        ObjPayrollEmployeeTrans.Delete;
                end;
            until ObjLoans.Next = 0;

        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then
            repeat
            begin
                ObjPayrollEmployeeTrans.Reset;
                ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Sacco Membership No.", VarMemberNo);
                ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Loan Number", ObjLoans."Loan  No.");
                ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Payroll Period", '%1', VarOpenPeriod);
                ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Transaction Code", 'INT');
                if not ObjPayrollEmployeeTrans.FindSet then begin
                    ObjTransactionCodes.Reset;
                    ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Code", 'LOAN');
                    if ObjTransactionCodes.FindSet then begin
                        ObjPayrollEmployeeTrans.Init;
                        ObjPayrollEmployeeTrans."Sacco Membership No." := ObjLoans."Client Code";
                        ObjPayrollEmployeeTrans."No." := VarMemberNo;
                        ObjPayrollEmployeeTrans."Loan Number" := ObjLoans."Loan  No.";
                        ObjPayrollEmployeeTrans."Transaction Code" := 'Loan';
                        ObjPayrollEmployeeTrans."Transaction Name" := ObjTransactionCodes."Transaction Name";
                        ObjPayrollEmployeeTrans."Transaction Type" := ObjTransactionCodes."Transaction Type";
                        ObjPayrollEmployeeTrans."Payroll Period" := VarOpenPeriod;
                        if ObjLoans."Outstanding Balance" < ObjLoans."Loan Principle Repayment" then
                            ObjPayrollEmployeeTrans.Amount := ObjLoans."Outstanding Balance"
                        else
                            if ObjLoans."Outstanding Balance" > ObjLoans."Loan Principle Repayment" then
                                ObjPayrollEmployeeTrans.Amount := ObjLoans."Loan Principle Repayment";
                        ObjPayrollEmployeeTrans."Period Month" := VarPeriodMonth;
                        ObjPayrollEmployeeTrans."Period Year" := VarPeriodYear;
                        ObjPayrollEmployeeTrans.Balance := ObjLoans."Outstanding Balance";
                        ObjPayrollEmployeeTrans."Balance(LCY)" := ObjLoans."Outstanding Balance";
                        ObjPayrollEmployeeTrans."Amtzd Loan Repay Amt" := VarAmortizationAmount;

                        ObjPayrollEmployeeTrans.Insert;
                    end;
                end;
            end;
            if ObjLoans."Exempt From Payroll Deduction" = true then //***Delete Loans Exempted from Payroll****
            begin
                ObjPayrollEmployeeTrans.Reset;
                ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Sacco Membership No.", VarMemberNo);
                ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Loan Number", ObjLoans."Loan  No.");
                ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Payroll Period", '%1', VarOpenPeriod);
                if ObjPayrollEmployeeTrans.FindSet = false then
                    ObjPayrollEmployeeTrans.Delete;
            end;
            until ObjLoans.Next = 0;

        //=============================================================Delete Cleared Loans
        ObjPayrollEmployeeTrans.Reset;
        ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Sacco Membership No.", VarMemberNo);
        ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Payroll Period", '%1', VarOpenPeriod);
        ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Loan Number", '<>%1', '');
        ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans.Balance, '<%1', 1);
        if ObjPayrollEmployeeTrans.FindSet then
            ObjPayrollEmployeeTrans.DeleteAll;

        //=============================================================Delete Non Due Loans
        ObjPayrollEmployeeTrans.Reset;
        ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Sacco Membership No.", VarMemberNo);
        ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Payroll Period", '%1', VarOpenPeriod);
        ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Loan Number", '<>%1', '');
        ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans.Amount, '%1', 0);
        if ObjPayrollEmployeeTrans.FindSet then
            ObjPayrollEmployeeTrans.DeleteAll;
    end;

    local procedure FnRunCreateLoanProductinTransactionCodes(VarLoanType: Text[100]; VarInterestRate: Decimal; VarLoanProductName: Text[100])
    var
        VarTransactionCode: Code[30];
    begin
        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetCurrentkey(ObjTransactionCodes."Transaction Code");
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Type", ObjTransactionCodes."transaction type"::Deduction);
        if ObjTransactionCodes.FindLast then
            VarTransactionCode := IncStr(ObjTransactionCodes."Transaction Code");

        ObjTransactionCodes.Init;
        ObjTransactionCodes."Transaction Code" := VarTransactionCode;
        ObjTransactionCodes."Transaction Name" := VarLoanProductName;
        ObjTransactionCodes."Transaction Type" := ObjTransactionCodes."transaction type"::Deduction;
        ObjTransactionCodes."Balance Type" := ObjTransactionCodes."balance type"::Reducing;
        ObjTransactionCodes.Frequency := ObjTransactionCodes.Frequency::Fixed;
        ObjTransactionCodes."Special Transaction" := ObjTransactionCodes."special transaction"::"Staff Loan";
        ObjTransactionCodes."Interest Rate" := VarInterestRate;
        ObjTransactionCodes."Repayment Method" := ObjTransactionCodes."repayment method"::Amortized;
        ObjTransactionCodes."Customer Posting Group" := 'MEMBER';
        ObjTransactionCodes.SubLedger := ObjTransactionCodes.SubLedger;
        ObjTransactionCodes."Loan Product" := VarLoanType;
        ObjTransactionCodes."Loan Product Name" := VarLoanProductName;
        ObjTransactionCodes.Insert;
    end;

    local procedure FnRunInsertMonthlyDepositContribution(VarMemberNo: Code[30]; VarPayrollNo: Code[30])
    var
        ObjCust: Record Customer;
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        VarDepositBal: Decimal;
        VarMonthlyDepositsContribution: Decimal;
    begin
        VarMonthlyDepositsContribution := 0;

        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;

        VarMonthlyDepositsContribution := SFactory.FnGetMemberMonthlyContributionDepositstier(VarMemberNo);
        if ObjPayrollEmployeesIV."Voluntary Deposit Contribution" > VarMonthlyDepositsContribution then
            VarMonthlyDepositsContribution := ObjPayrollEmployeesIV."Voluntary Deposit Contribution";

        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Co-Op Parameters", ObjTransactionCodes."co-op parameters"::Shares);
        if ObjTransactionCodes.FindSet then
            if ObjCust.Get(ObjPayrollEmployeesIV."Payroll No") then begin
                ObjCust.CalcFields(ObjCust."Current Shares");

                //============================================Delete Entries For the Same Period
                ObjEmployeeTransactions.Reset;
                ObjEmployeeTransactions.SetRange(ObjEmployeeTransactions."Payroll Period", VarOpenPeriod);
                ObjEmployeeTransactions.SetRange(ObjEmployeeTransactions."Transaction Code", ObjTransactionCodes."Transaction Code");
                if ObjEmployeeTransactions.FindSet then
                    ObjEmployeeTransactions.DeleteAll;
                //============================================Delete Entries For the Same Period

                ObjPayrollEmployeeTransII.Init;
                ObjPayrollEmployeeTransII."Sacco Membership No." := ObjPayrollEmployeesIV."Payroll No";
                ObjPayrollEmployeeTransII."No." := ObjPayrollEmployeesIV."No.";
                ObjPayrollEmployeeTransII."Loan Number" := '';
                ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
                ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
                ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
                ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
                ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
                ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
                ObjPayrollEmployeeTransII.Amount := VarMonthlyDepositsContribution;
                ObjPayrollEmployeeTransII."Amount(LCY)" := VarMonthlyDepositsContribution;
                ObjPayrollEmployeeTransII.Balance := ObjCust."Current Shares";
                ObjPayrollEmployeeTransII."Balance(LCY)" := ObjCust."Current Shares";
                ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := 0;
                ObjPayrollEmployeeTransII.Insert;
            end;
    end;
}
