page 51516938 "Loan Appeal Card"
{
    ApplicationArea = All;
    Caption = 'Loan Restructure Card';
    PageType = Card;
    SourceTable = "Loan Appeal";
    Editable = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Loan Number"; Rec."Loan Number")
                {
                    ToolTip = 'Specifies the value of the Loan Number field.';
                    ApplicationArea = all;
                }
                field("Member No."; "Member No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ToolTip = 'Specifies the value of the Loan Product Type field.';
                    Editable = false;
                }
                field("Amount Applied"; Rec."Amount Applied")
                {
                    ToolTip = 'Specifies the value of the Amount Applied field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Installments; Rec.Installments)
                {
                    ToolTip = 'Specifies the value of the Installments field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Interest; Rec.Interest)
                {
                    ToolTip = 'Specifies the value of the Interest field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Oustanding Balance"; Rec."Oustanding Balance")
                {
                    ToolTip = 'Specifies the value of the Oustanding Balance field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("New Principle Amount"; "New Principle Amount")
                {
                    ApplicationArea = all;
                }
                field("New Loan Product Type"; "New Loan Product Type")
                {
                    ApplicationArea = all;
                }
                field(NewInterest; NewInterest)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'New Interest';
                }
                field(NewInstalmentPeriod; NewInstalmentPeriod)
                {
                    ApplicationArea = all;
                    Caption = 'New Installment Period';
                }
                field(NewInstallment; NewInstallment)
                {
                    ApplicationArea = all;
                    Caption = 'New Installment';
                }
                field("New Amount"; Rec."New Amount")
                {
                    ToolTip = 'Specifies the value of the New Amount field.';
                    Caption = 'Amount to Alter with';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Type; Type)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Reason For change?"; "Reason For change?")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = all;
                    Editable = FALSE;
                }
            }
            part(Control1000000004; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                ApplicationArea = Basic;
                SubPageLink = "Loan No" = field("Loan Number");
            }
            // part(Control1000000005; "Loan Collateral Security")
            // {
            //     Caption = 'Other Securities';
            //     ApplicationArea = Basic;
            //     SubPageLink = "Loan No" = field("Loan Number");

            // }
        }
        area(factboxes)
        {
            part("Member Statistics FactBox"; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Member No.");
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ProcessLoanAppeal)
            {
                ApplicationArea = All;
                Caption = 'Process Loan Appeal';
                Promoted = true;
                PromotedCategory = Process;
                Image = AdjustEntries;
                trigger OnAction()
                begin
                    if "Reason For change?" = '' then
                        Error('Please type the reason for change') else
                        StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User Id", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Can Appeal Loans");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to Appeal this Loan.')
                    else begin
                        if LoanType.Get("Loan Product Type") then
                            BankNo := LoanType."Loan Bank Account";
                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'APPEAL';
                        DOCUMENT_NO := 'LOANAPPEAL';

                        ///Delete
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;
                        //end of Delete

                        rec.CalcFields(ClientCode);

                        if Type = type::Increase then begin
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
                            GenJournalLine."account type"::Customer, ClientCode, Today, "New Amount", 'BOSA', "Loan Number", "Loan Number" + ' Loan Appeal', "Loan Number");

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"Bank Account", BankNo, Today, "New Amount" * -1, 'BOSA', "Loan Number", "Loan Number" + ' Loan Appeal', ' ');

                        end else
                            if Type = type::Decrease then begin
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
                                GenJournalLine."account type"::Customer, ClientCode, Today, "New Amount", 'BOSA', "Loan Number", "Loan Number" + ' Loan Appeal', "Loan Number");

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::"Bank Account", BankNo, Today, "New Amount" * -1, 'BOSA', "Loan Number", "Loan Number" + ' Loan Appeal', ' ');
                            end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        if GenJournalLine.Find('-') then
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                        Message('%1 Loan for %2 has Succesfully been Appealed', "Loan Number", ClientCode);
                        LoanReg.Reset();
                        LoanReg.SetRange(LoanReg."Loan  No.", "Loan Number");
                        if LoanReg.Find('-') then begin
                            LoanReg."Approved Amount" := "New Principle Amount";
                            LoanReg."Requested Amount" := "New Principle Amount";
                            LoanReg."Loan Disbursed Amount" := "New Principle Amount";
                            LoanReg.Installments := NewInstallment;
                            LoanReg."Instalment Period" := NewInstalmentPeriod;
                            LoanReg."Loan Product Type" := "New Loan Product Type";
                            LoanReg.Modify();
                            SFactory.FnGenerateRepaymentSchedule("Loan Number");
                            Appealed := true;
                            Rec.Modify();
                        end;
                    end;
                end;
            }

            action("View Schedule")
            {
                ApplicationArea = Basic;
                Caption = 'View Schedule';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan  No.", "Loan Number");
                    if LoanApp.Find('-') then
                        Report.Run(51516477, true, false, LoanApp);
                end;
            }
        }
    }
    var
        SFactory: Codeunit "SURESTEP Factory";
        LoanApp: record "Loans Register";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        LoanType: Record "Loan Products Setup";
        LoanReg: Record "Loans Register";
        BankNo: Code[30];
        StatusPermissions: Record "Status Change Permision";
}
