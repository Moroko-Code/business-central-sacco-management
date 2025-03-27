#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516050 "Regenerate Schedule for loans"
{
    trigger OnRun()
    begin
        //FnRegenerateNewSchedule();
    end;

    var
        LoansReg: Record "Loans Register";
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        LoanProductSetUp: Record "Loan Products Setup";
        SFactoryCode: Codeunit "SURESTEP Factory";

    procedure FnRegenerateNewSchedule()
    begin
        LoansReg.Reset;
        LoansReg.SetRange(LoansReg.Posted, true);
        LoansReg.SetAutocalcFields(LoansReg."Outstanding Balance");
        //LoansReg.SETRANGE(LoansReg."Loan  No.",'FLN02345');
        if LoansReg.Find('-') then
            repeat
                //..................................Check if Loan Has Expected date of loan Completion;
                if (LoansReg."Application Date" = 0D) then
                    if LoansReg."Issued Date" = 0D then begin
                        LoansReg."Application Date" := 20170101D;
                        LoansReg."Issued Date" := 20170101D;
                        LoansReg."Loan Disbursement Date" := 20170101D;
                        LoansReg."Repayment Start Date" := CalcDate('1M', 20170101D);
                        LoansReg.Modify;
                    end else if LoansReg."Issued Date" <> 0D then begin
                        LoansReg."Application Date" := LoansReg."Issued Date";
                        LoansReg."Loan Disbursement Date" := LoansReg."Issued Date";
                        LoansReg."Repayment Start Date" := CalcDate('1M', LoansReg."Issued Date");
                        LoansReg.Modify;
                    end;
                if LoansReg."Issued Date" = 0D then begin
                    LoansReg."Issued Date" := LoansReg."Application Date";
                    LoansReg.Modify;
                end;
                if LoansReg."Expected Date of Completion" = 0D then begin
                    LoansReg."Expected Date of Completion" := FncreateExpectedDateOfCompletion(LoansReg."Application Date", LoansReg."Loan Product Type");
                    LoansReg.Modify;
                end;
                if LoansReg."Approved Amount" = 0 then begin
                    LoansReg."Approved Amount" := LoansReg."Outstanding Balance";
                    LoansReg.Modify;
                end;
                if LoansReg.Installments = 0 then
                    if LoanProductSetUp.Get(LoansReg."Loan Product Type") then begin
                        LoansReg.Installments := LoanProductSetUp."No of Installment";
                        LoansReg.Modify;
                    end;
                if LoansReg.Interest = 0 then begin
                    LoansReg.Interest := 1;
                    LoansReg.Modify;
                end;
                //...................................Check if loan has loan repayment schedule
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.", LoansReg."Loan  No.");
                if LoanRepaymentSchedule.Find('-') = false then
                    SFactoryCode.FnGenerateRepaymentSchedule(LoansReg."Loan  No.");
            until LoansReg.Next = 0;
    end;

    local procedure FncreateExpectedDateOfCompletion(ApplicationDate: Date; LoanType: Code[50]): Date
    begin
        if LoanProductSetUp.Get(LoanType) then
            exit(CalcDate((Format(LoanProductSetUp."No of Installment") + 'M'), ApplicationDate));
    end;
}
