#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516009 "Surestep Workflow Responses"
{
    trigger OnRun()
    begin
    end;

    var
        WFEventHandler: Codeunit "Workflow Event Handling";
        WFResponseHandler: Codeunit "Workflow Response Handling";

    procedure AddResponsesToLib()
    begin
    end;

    procedure AddResponsePredecessors()
    begin
    end;

    procedure ReleaseClientApplication(var ClientApplication: Record "Membership Applications")
    var
        ClientApp: Record "Membership Applications";
    begin
        ClientApp.Reset;
        ClientApp.SetRange(ClientApp."No.", ClientApplication."No.");
        if ClientApp.FindFirst then begin
            ClientApp.Status := ClientApp.Status::Approved;
            ClientApp.Modify;
        end;
    end;

    procedure ReOpenClientApplication(var ClientApplication: Record "Membership Applications")
    var
        ClientApp: Record "Membership Applications";
    begin
        ClientApp.Reset;
        ClientApp.SetRange(ClientApp."No.", ClientApplication."No.");
        if ClientApp.FindFirst then begin
            ClientApp.Status := ClientApp.Status::Open;
            ClientApp.Modify;
        end;
    end;

    procedure ReleaseLoanBooking(var LoanBooking: Record "Loans Register")
    var
        LoanB: Record "Loans Register";
    begin
        LoanB.Reset;
        LoanB.SetRange(LoanB."Loan  No.", LoanBooking."Loan  No.");
        if LoanB.FindFirst then begin
            LoanB."Loan Status" := LoanB."loan status"::Approved;
            LoanB."Approval Status" := LoanB."approval status"::Approved;
            LoanB.Modify;
        end;
    end;

    procedure ReOpenLoanBooking(var LoanBooking: Record "Loans Register")
    var
        LoanB: Record "Loans Register";
    begin
        LoanB.Reset;
        LoanB.SetRange(LoanB."Loan  No.", LoanBooking."Loan  No.");
        if LoanB.FindFirst then begin
            LoanB."Loan Status" := LoanB."loan status"::Application;
            LoanB."Approval Status" := LoanB."approval status"::Open;
            LoanB.Modify;
        end;
    end;

    procedure ReleaseLoanDisbursement(var LoanDisbursement: Record "Loan Disburesment-Batching")
    var
        LoanD: Record "Loan Disburesment-Batching";
    begin
        LoanD.Reset;
        LoanD.SetRange(LoanD."Batch No.", LoanDisbursement."Batch No.");
        if LoanD.FindFirst then begin
            LoanD.Status := LoanDisbursement.Status::Approved;
            LoanD.Modify;
        end;
    end;

    procedure ReOpenLoanDisbursement(var LoanDisbursement: Record "Loan Disburesment-Batching")
    var
        LoanD: Record "Loan Disburesment-Batching";
    begin
        LoanD.Reset;
        LoanD.SetRange(LoanD."Batch No.", LoanDisbursement."Batch No.");
        if LoanD.FindFirst then begin
            LoanD.Status := LoanDisbursement.Status::Open;
            LoanD.Modify;
        end;
    end;

    // procedure ReleaseReceiptVoucher(var ReceiptHeader: Record "Receipt Header")
    // var
    //     RHeader: Record "Receipt Header";
    // begin
    //     RHeader.Reset;
    //     RHeader.SetRange(RHeader."No.", ReceiptHeader."No.");
    //     if RHeader.FindFirst then begin
    //         RHeader.Status := RHeader.Status::Approved;
    //         RHeader.Modify;
    //     end;
    // end;

    // procedure ReOpenReceiptVoucher(var ReceiptHeader: Record "Receipt Header")
    // var
    //     RHeader: Record "Receipt Header";
    // begin
    //     RHeader.Reset;
    //     RHeader.SetRange(RHeader."No.", ReceiptHeader."No.");
    //     if RHeader.FindFirst then begin
    //         RHeader.Status := RHeader.Status::Approved;
    //         RHeader.Modify;
    //     end;
    // end;

    procedure ReleaseFOSAOpening(var FOSAOpen: Record "Accounts Applications Details")
    var
        FOSA: Record "Accounts Applications Details";
    begin
        FOSA.Reset;
        FOSA.SetRange(FOSA."No.", FOSAOpen."No.");
        if FOSA.FindFirst then begin
            FOSA.Status := FOSA.Status::Approved;
            FOSA.Modify;
        end;
    end;

    procedure ReopenFOSAOpening(var FOSAOpen: Record "Accounts Applications Details")
    var
        FOSA: Record "Accounts Applications Details";
    begin
        FOSA.Reset;
        FOSA.SetRange(FOSA."No.", FOSAOpen."No.");
        if FOSA.FindFirst then begin
            FOSA.Status := FOSA.Status::Open;
            FOSA.Modify;
        end;
    end;

   
    procedure ReleasePaymentVoucher(var PVoucher: Record "Payment Header")
    var
        PV: Record "Payment Header";
    begin
        PV.Reset;
        PV.SetRange(PV."No.", PVoucher."No.");
        if PV.FindFirst then begin
            PV.Status := PV.Status::Approved;
            PV.Modify;
        end;
    end;

    procedure ReopenPaymentVoucher(var PVoucher: Record "Payment Header")
    var
        PV: Record "Payment Header";
    begin
        PV.Reset;
        PV.SetRange(PV."No.", PVoucher."No.");
        if PV.FindFirst then begin
            PV.Status := PV.Status::"Pending Approval";
            PV.Modify;
        end;
    end;

    procedure ReleasePettyCash(var PettyCash: Record "Payment Header")
    var
        PCash: Record "Payment Header";
    begin
        PCash.Reset;
        PCash.SetRange(PCash."No.", PettyCash."No.");
        if PCash.FindFirst then begin
            PCash.Status := PCash.Status::Approved;
            PCash.Modify;
        end;
    end;

    procedure ReopenPettyCash(var PettyCash: Record "Payment Header")
    var
        PCash: Record "Payment Header";
    begin
        PCash.Reset;
        PCash.SetRange(PCash."No.", PettyCash."No.");
        if PCash.FindFirst then begin
            PCash.Status := PCash.Status::New;
            PCash.Modify;
        end;
    end;

    procedure ReleaseImprestSur(var ImprestSur: Record "Imprest Accounting Header")
    var
        ImpSur: Record "Imprest Accounting Header";
    begin
        ImpSur.Reset;
        ImpSur.SetRange(ImpSur."No.", ImprestSur."No.");
        if ImpSur.FindFirst then begin
            ImpSur.Status := ImpSur.Status::Approved;
            ImpSur.Modify;
        end;
    end;

    procedure ReopenImprestSur(var ImprestSur: Record "Imprest Accounting Header")
    var
        ImpSur: Record "Imprest Accounting Header";
    begin
        ImpSur.Reset;
        ImpSur.SetRange(ImpSur."No.", ImprestSur."No.");
        if ImpSur.FindFirst then begin
            ImpSur.Status := ImpSur.Status::Pending;
            ImpSur.Modify;
        end;
    end;

    procedure ReleaseStoresReq(var StoresReq: Record "Store Requistion Header")
    var
        SReq: Record "Store Requistion Header";
    begin
        SReq.Reset;
        SReq.SetRange(SReq."No.", StoresReq."No.");
        if SReq.FindFirst then begin
            SReq.Status := SReq.Status::Released;
            SReq.Modify;
        end;
    end;

    procedure ReopenStoresReq(var StoresReq: Record "Store Requistion Header")
    var
        SReq: Record "Store Requistion Header";
    begin
        SReq.Reset;
        SReq.SetRange(SReq."No.", StoresReq."No.");
        if SReq.FindFirst then begin
            SReq.Status := SReq.Status::Open;
            SReq.Modify;
        end;
    end;

    procedure ReleaseFundsTrans(var FundsTrans: Record "Funds Transfer Header")
    var
        FTrans: Record "Funds Transfer Header";
    begin
        FTrans.Reset;
        FTrans.SetRange(FTrans."No.", FundsTrans."No.");
        if FTrans.FindFirst then begin
            FTrans.Status := FTrans.Status::Approved;
            FTrans.Modify;
        end;
    end;

    procedure ReopenFundsTrans(var FundsTrans: Record "Funds Transfer Header")
    var
        FTrans: Record "Funds Transfer Header";
    begin
        FTrans.Reset;
        FTrans.SetRange(FTrans."No.", FundsTrans."No.");
        if FTrans.FindFirst then begin
            FTrans.Status := FTrans.Status::Open;
            FTrans.Modify;
        end;
    end;

    procedure ReleaseChangeReq(var ChangeReq: Record "Loans Cue")
    var
        Change: Record "Loans Cue";
    begin
        /*Change.RESET;
        Change.SETRANGE(Change.No,ChangeReq.No);
        IF Change.FINDFIRST THEN BEGIN
          Change.Status:=Change.Status::Approved;
          Change.MODIFY;
        END;
        */
    end;

    procedure ReopenChangeReq(var ChangeReq: Record "Loans Cue")
    var
        Change: Record "Loans Cue";
    begin
        /*Change.RESET;
        Change.SETRANGE(Change.No,ChangeReq.No);
        IF Change.FINDFIRST THEN BEGIN
          Change.Status:=Change.Status::Open;
          Change.MODIFY;
        END;*/
    end;

    procedure ReleaseBOSATransfer(var BOSATrans: Record "BOSA Transfers")
    var
        BOSA: Record "BOSA Transfers";
    begin
        BOSA.Reset;
        BOSA.SetRange(BOSA.No, BOSATrans.No);
        if BOSA.FindFirst then begin
            BOSA.Status := BOSA.Status::Approved;
            BOSA.Modify;
        end;
    end;

    procedure ReopenBOSATransfer(var BOSATrans: Record "BOSA Transfers")
    var
        BOSA: Record "BOSA Transfers";
    begin
        BOSA.Reset;
        BOSA.SetRange(BOSA.No, BOSATrans.No);
        if BOSA.FindFirst then begin
            BOSA.Status := BOSA.Status::Open;
            BOSA.Modify;
        end;
    end;

    procedure ReleaseLoanTopUp(var LoanTopUp: Record "Loan Top Up.")
    var
        TOP: Record "Loan Top Up.";
    begin
        TOP.Reset;
        TOP.SetRange(TOP."Document No", LoanTopUp."Document No");
        if TOP.FindFirst then begin
            TOP.Status := TOP.Status::Approved;
            TOP.Modify;
        end;
    end;

    procedure ReopenLoanTopUp(var LoanTopUp: Record "Loan Top Up.")
    var
        TOP: Record "Loan Top Up.";
    begin
        TOP.Reset;
        TOP.SetRange(TOP."Document No", LoanTopUp."Document No");
        if TOP.FindFirst then begin
            TOP.Status := TOP.Status::Open;
            TOP.Modify;
        end;
    end;

    ///Member Re-Application
    procedure ReleaseMemberReapplication(var Reapplication: Record "Member Reapplication")
    var
        MembReaplication: Record "Member Reapplication";

    begin
        MembReaplication.Reset;
        MembReaplication.SetRange(MembReaplication."No.", Reapplication."No.");
        if MembReaplication.FindFirst then begin
            MembReaplication.Status := MembReaplication.Status::Approved;
            MembReaplication.Modify;
        end;
    end;

    procedure ReopenMeberReapplication(var Reapplication: Record "Member Reapplication")
    var
        MembReaplication: Record "Member Reapplication";
    begin
        MembReaplication.Reset;
        MembReaplication.SetRange(MembReaplication."No.", Reapplication."No.");
        if MembReaplication.FindFirst then begin
            MembReaplication.Status := MembReaplication.Status::Open;
            MembReaplication.Modify;
        end;
    end;
}
