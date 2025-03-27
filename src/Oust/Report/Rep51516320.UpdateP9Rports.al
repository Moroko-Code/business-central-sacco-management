#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516320 "Update P9Rports"
{
    DefaultLayout = RDLC;
    ProcessingOnly = true;

    dataset
    {
        dataitem("prPeriod Transactions."; "prPeriod Transactions.")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ObjP9Periods.Reset;
                ObjP9Periods.SetRange(ObjP9Periods."Employee Code", "Employee Code");
                ObjP9Periods.SetRange(ObjP9Periods."Payroll Period", "Payroll Period");
                //ObjP9Periods.SETRANGE(ObjP9Periods."Period Year","Period Year");
                if ObjP9Periods.Find('-') then begin
                    case "Transaction Code" of
                        'BPAY':
                            ObjP9Periods."Basic Pay" := Amount;
                        'GPAY':
                            ObjP9Periods."Gross Pay" := Amount;
                        'INSRLF':
                            ObjP9Periods."Insurance Relief" := Amount;
                        'TXCHRG':
                            ObjP9Periods."Tax Charged" := Amount;
                        'PAYE':
                            ObjP9Periods.PAYE := Amount;
                        'NPAY':
                            ObjP9Periods."Net Pay" := Amount;
                        'PSNR':
                            ObjP9Periods."Tax Relief" := Amount;
                    //ELSE
                    end;
                    ObjP9Periods.Modify;
                end
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
        ObjPayrollTransactions.Reset;
        if ObjPayrollTransactions.Find('-') then
            repeat
                ObjP9Periods.Reset;
                ObjP9Periods.SetRange(ObjP9Periods."Employee Code", ObjPayrollTransactions."Employee Code");
                ObjP9Periods.SetRange(ObjP9Periods."Payroll Period", ObjPayrollTransactions."Payroll Period");
                if not ObjP9Periods.Find('-') then begin
                    ObjP9Periods.Init;
                    ObjP9Periods."Employee Code" := ObjPayrollTransactions."Employee Code";
                    ObjP9Periods."Payroll Period" := ObjPayrollTransactions."Payroll Period";
                    ObjP9Periods."Period Month" := ObjPayrollTransactions."Period Month";
                    ObjP9Periods."Period Year" := ObjPayrollTransactions."Period Year";
                    ObjP9Periods.Insert;
                end;
            until ObjPayrollTransactions.Next = 0;
    end;

    var
        ObjP9Periods: Record "Payroll Employee P9.";
        ObjPayrollTransactions: Record "prPeriod Transactions.";
}
