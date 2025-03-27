#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516037 "Loans Calculator"
{
    PageType = Card;
    SourceTable = "Loans Calculator";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Product Description"; "Product Description")
                {
                    ApplicationArea = Basic;
                }
                field("Interest rate"; "Interest rate")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Installments; Installments)
                {
                    ApplicationArea = Basic;
                }
                field("Instalment Period"; "Instalment Period")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Repayment Method"; "Repayment Method")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount"; "Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Principle Repayment"; "Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interest Repayment"; "Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Repayment Start Date"; "Repayment Start Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(ViewSchedule)
            {
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        InstallNo2 := 3;
                        QCounter := 0;
                        QCounter := 3;
                        Evaluate(InPeriod, '1Q');
                        GrPrinciple := "Grace Period - Principle (M)";
                        GrInterest := "Grace Period - Interest (M)";
                        InitialGraceInt := "Grace Period - Interest (M)";

                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan Product Type", "Loan Product Type");
                        if LoansR.Find('-') then begin

                            RSchedule.Reset;
                            RSchedule.DeleteAll;

                            LBalance := LoansR."Requested Amount";
                            LoanAmount := LoansR."Requested Amount";
                            InterestRate := "Interest rate";
                            RepayPeriod := Installments;
                            RunDate := "Repayment Start Date";
                            InstalNo := 0;
                            Evaluate(RepayInterval, '1M');
                            repeat
                                InstallNo2 := InstallNo2 - 1;
                                InstalNo := InstalNo + 1;

                                if "Repayment Method" = "repayment method"::Amortised then begin
                                    TestField("Interest rate");
                                    TestField(Installments);
                                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.05, '>');
                                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');
                                    LPrincipal := TotalMRepay - LInterest;
                                end;

                                if "Repayment Method" = "repayment method"::"Straight Line" then begin
                                    TestField("Interest rate");
                                    TestField(Installments);
                                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                                    LInterest := ROUND((InterestRate / 12 / 100) * LoanAmount, 0.05, '>');
                                    TotalMRepay := ROUND(LPrincipal + LInterest);
                                end;

                                if "Repayment Method" = "repayment method"::"Reducing Balance" then begin
                                    TestField("Interest rate");
                                    TestField(Installments);
                                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 0.05, '>');
                                end;

                                if "Repayment Method" = "repayment method"::Constants then begin
                                    TestField(Repayment);
                                    if LBalance < Repayment then
                                        LPrincipal := LBalance
                                    else
                                        LPrincipal := Repayment;
                                    LInterest := "Interest rate";
                                end;

                                //Grace Period
                                if GrPrinciple > 0 then
                                    LPrincipal := 0
                                else
                                    if "Instalment Period" <> InPeriod then
                                        LBalance := LBalance - LPrincipal;

                                if GrInterest > 0 then
                                    LInterest := 0;

                                GrPrinciple := GrPrinciple - 1;
                                GrInterest := GrInterest - 1;
                                //Grace Period

                                //Q Principle
                                if "Instalment Period" = InPeriod then begin
                                    //ADDED
                                    if GrPrinciple <> 0 then
                                        GrPrinciple := GrPrinciple - 1;
                                    if QCounter = 1 then begin
                                        QCounter := 3;
                                        LPrincipal := QPrinciple + LPrincipal;
                                        if LPrincipal > LBalance then
                                            LPrincipal := LBalance;
                                        LBalance := LBalance - LPrincipal;
                                        QPrinciple := 0;
                                    end else begin
                                        QCounter := QCounter - 1;
                                        QPrinciple := QPrinciple + LPrincipal;
                                        //IF QPrinciple > LBalance THEN
                                        //QPrinciple:=LBalance;
                                        LPrincipal := 0;
                                    end
                                end;
                                //Q Principle

                                Evaluate(RepayCode, Format(InstalNo));

                                RSchedule.Init;
                                RSchedule."Repayment Code" := RepayCode;
                                RSchedule."Loan Amount" := LoanAmount;
                                RSchedule."Instalment No" := InstalNo;
                                RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                                RSchedule."Loan Category" := "Loan Product Type";
                                RSchedule."Monthly Repayment" := LInterest + LPrincipal + "Administration Fee";
                                RSchedule."Monthly Interest" := LInterest;
                                RSchedule."Principal Repayment" := LPrincipal;
                                RSchedule.Insert;

                                RunDate := CalcDate('1M', RunDate);
                            until LBalance < 1;
                        end;

                        Commit;

                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan Product Type", "Loan Product Type");
                        if LoansR.Find('-') then
                            Report.Run(51516436, true, false, LoansR);
                    end;
                }
            }
        }
    }

    var
        i: Integer;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Calculator";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "Loan Repayment Calculator";
        RSchedule: Record "Loan Repayment Calculator";
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record "Loan Repayment Calculator";
        PeriodInterval: Code[10];
        CustomerRecord: Record Customer;
        Gnljnline: Record "Gen. Journal Line";
        //Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record Customer;
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record Customer;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sales & Receivables Setup";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        LoansR: Record "Loans Calculator";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        // GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        TotalTopupComm: Decimal;
        //Notification: Codeunit Mail;
        CustE: Record "Loans Register";
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        ApprovalUsers: Record "Approvals Users Set Up";
        MovementTracker: Record "Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loans Register";
        SMSMessage: Record "SMS Messages";
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record "Loan Disburesment-Batching";
        LoansCalc: Record "Loans Calculator";
}
