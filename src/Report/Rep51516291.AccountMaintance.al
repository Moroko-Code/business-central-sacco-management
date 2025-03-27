#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516291 "Account Maintance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Account Maintance.rdlc';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            CalcFields = Balance;
            DataItemTableView = where("Account Type" = const('ORDINARY'), "Debtor Type" = const("FOSA Account"), Status = filter(Active));
            RequestFilterFields = "No.";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Vendor.Balance > 60 then begin
                    //CurrReport.SKIP;
                    if PDate = 0D then
                        Error('Kindly specify the posting date');

                    if DocNo = '' then
                        Error('Kindly specify the document no');

                    //........... Deduct Account Maintainance Fee ....................................//
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Line No." := LineNo + 10000;
                    GenJournalLine."Journal Batch Name" := 'ACCM';
                    GenJournalLine."Document No." := DocNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := Vendor."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := PDate;
                    GenJournalLine.Description := 'Account Maintanance Fee';
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := 50;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := '5418';
                    GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //........................ End Of Account Maintainance Fee ........................//

                    //........................Excercise Duty on Account Maintainace ....................//

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Line No." := LineNo + 10000;
                    GenJournalLine."Journal Batch Name" := 'ACCM';
                    GenJournalLine."Document No." := DocNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := Vendor."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := PDate;
                    GenJournalLine.Description := 'Excise Duty';
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := 10;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := '3326';
                    GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    // CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",GenJournalLine);
                end
                //.............. End of Excercise Duty on Account Maintainance ........................//
            end;

            trigger OnPostDataItem()
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'ACCM');
                if GenJournalLine.Find('-') then;
                //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",GenJournalLine);
            end;

            trigger OnPreDataItem()
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'ACCM');
                GenJournalLine.DeleteAll;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(PDate; PDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                }
                field(DocNo; DocNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Document No';
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
        StatusPermissions.Reset;
        StatusPermissions.SetRange(StatusPermissions."User Id", UserId);
        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Account Status");
        if StatusPermissions.Find('-') = false then
            Error('You do not have permissions to charge maintenance fee. Please contact systems administrator');
    end;

    var
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        vend: Record Vendor;
        StatusPermissions: Record "Status Change Permision";
}
