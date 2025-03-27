#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516344 "Paye Schedule W.."
{
    DefaultLayout = RDLC;
    Caption = 'Payee Report';
    RDLCLayout = './Layout/Paye Schedule W...rdlc';

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            RequestFilterFields = "Posting Group";
            column(ReportForNavId_6207; 6207)
            {
            }
            column(USERID; UserId)
            {
            }
            column(TODAY; Today)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(companyinfo_Picture; companyinfo.Picture)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "Payroll Employee."."No.")
            {
            }
            column(EmployeeName; "Payroll Employee."."Full Name")
            {
            }
            column(PinNumber; "Payroll Employee."."PIN No")
            {
            }
            column(PayeAmount; PayeAmount)
            {
            }
            column(TaxablePay; TaxablePay)
            {
            }
            column(TotTaxablePay; TotTaxablePay)
            {
            }
            column(CompName; CompName)
            {
            }
            column(IDS_NUMBER; "Payroll Employee."."National ID No")
            {
            }
            column(Addr1; Addr1)
            {
            }
            column(Addr2; Addr2)
            {
            }
            column(Email; Email)
            {
            }
            column(TotPayeAmount; TotPayeAmount)
            {
            }
            column(InsurancePremium_PayrollEmployee; "Payroll Employee."."Insurance Premium")
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(P_A_Y_E_ScheduleCaption; P_A_Y_E_ScheduleCaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(PIN_Number_Caption; PIN_Number_CaptionLbl)
            {
            }
            column(Paye_Amount_Caption; Paye_Amount_CaptionLbl)
            {
            }
            column(Taxable_Pay_Caption; Taxable_Pay_CaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Totals_Caption; Totals_CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            column(SN; SN)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PayeAmount := 0;
                TaxablePay := 0;

                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "No.");
                if objEmp.Find('-') then
                    EmployeeName := objEmp."Full Name";
                PinNumber := objEmp."PIN No";

                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Payroll Employee."."No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                if PeriodTrans.Find('-') then
                    repeat
                        //TXBP Taxable Pay -  BY DENNIS
                        if (PeriodTrans."Transaction Code" = 'TXBP') then
                            TaxablePay := PeriodTrans.Amount;

                        if (PeriodTrans."Transaction Code" = 'PAYE') then
                            PayeAmount := PeriodTrans.Amount;
                    until PeriodTrans.Next = 0;

                if PayeAmount = 0 then
                    CurrReport.Skip;

                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "No.");
                if objEmp.Find('-') then
                    repeat
                        TotPayeAmount := TotPayeAmount + PayeAmount;
                        TotTaxablePay := TotTaxablePay + TaxablePay;
                    until objEmp.Next = 0;
                SN := SN + 1;
            end;

            trigger OnPreDataItem()
            begin
                if companyinfo.Get() then
                    companyinfo.CalcFields(companyinfo.Picture);
                CompName := companyinfo.Name;
                Addr1 := companyinfo.Address;

                Addr2 := companyinfo.City;
                Email := companyinfo."E-Mail";
                TotPayeAmount := 0;
                TotTaxablePay := 0;
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
                    ApplicationArea = Basic;
                    Caption = 'Period:';
                    TableRelation = "Payroll Calender.";
                    Visible = true;
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

    trigger OnInitReport()
    begin
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then;
        PeriodFilter := objPeriod."Date Opened";
    end;

    trigger OnPreReport()
    begin
        if UserSetup.Get(UserId) then
            if UserSetup."Payroll User" = false then
                Error('You dont have permissions for payroll, Contact your system administrator! ');

        if PeriodFilter = 0D then Error('You must specify the period filter');

        SelectedPeriod := PeriodFilter;
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";

        if companyinfo.Get() then
            companyinfo.CalcFields(companyinfo.Picture);
    end;

    var
        UserSetup: Record "User Setup";
        PeriodTrans: Record "prPeriod Transactions.";
        PayeAmount: Decimal;
        TotPayeAmount: Decimal;
        TaxablePay: Decimal;
        TotTaxablePay: Decimal;
        EmployeeName: Text[150];
        PinNumber: Text[30];
        objPeriod: Record "Payroll Calender.";
        objEmp: Record "Payroll Employee.";
        HREmployees: Record "Payroll Employee.";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Date;
        companyinfo: Record "Company Information";
        User_Name_CaptionLbl: label 'User Name:';
        Print_Date_CaptionLbl: label 'Print Date:';
        P_A_Y_E_ScheduleCaptionLbl: label 'P.A.Y.E Schedule';
        Period_CaptionLbl: label 'Period:';
        Page_No_CaptionLbl: label 'Page No:';
        No_CaptionLbl: label 'No:';
        Employee_NameCaptionLbl: label 'Employee Name';
        PIN_Number_CaptionLbl: label 'PIN Number:';
        Paye_Amount_CaptionLbl: label 'Paye Amount:';
        Taxable_Pay_CaptionLbl: label 'Taxable Pay:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by…………………………………………………..                   Date……………………………………………';
        Totals_CaptionLbl: label 'Totals:';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by……………………………………………………..              Date……………………………………………';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by……………………………………………………..                Date……………………………………………';
        CompName: Text[50];
        Addr1: Text[50];
        Addr2: Text[50];
        Email: Text[50];
        SN: Integer;
}
