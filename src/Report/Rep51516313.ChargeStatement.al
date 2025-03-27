#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516313 "Charge Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Charge Statement.rdlc';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = where("Account Type" = const('ORDINARY'), "Debtor Type" = const("FOSA Account"));
            RequestFilterFields = "No.";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }

            trigger OnAfterGetRecord()
            begin

                if PDate = 0D then
                    Error('Kindly specify the posting date');

                if DocNo = '' then
                    Error('Kindly specify the document no');

                vend.Get(Vendor."No.");
                Cust.Get(Vendor."BOSA Account No");

                Vendor.CalcFields(Vendor."Balance (LCY)");
                Cust.CalcFields(Cust."Current Shares");
                //MESSAGE(FORMAT(Cust."Current Shares"));

                //(Vendor."Balance (LCY)" >= 33) AND
                if (Cust."Current Shares" > 0) then  //OR (Vendor."Balance (LCY)" < 0)  THEN BEGIN
                                                     //IF Vendor.Status=0 AND Vendor."Balance (LCY)">35 THEN BEGIN
                    if Vendor."Balance (LCY)" > 35 then begin

                        LineNo := LineNo + 100000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Line No." := LineNo + 10000;
                        GenJournalLine."Journal Batch Name" := 'STATEMENT';
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := Vendor."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := PDate;
                        GenJournalLine.Description := 'Quartely Statement Fee';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := 30;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := '5419';
                        GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //excise
                        LineNo := LineNo + 100000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Line No." := LineNo + 10000;
                        GenJournalLine."Journal Batch Name" := 'STATEMENT';
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := Vendor."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := PDate;
                        GenJournalLine.Description := 'Excise Duty';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := 6;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := '3326';
                        GenJournalLine."Shortcut Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;
                /*
                //Post New
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                GenJournalLine.SETRANGE("Journal Batch Name",'STATEMENT');
                IF GenJournalLine.FIND('-') THEN BEGIN
                //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",GenJournalLine);
                END;
                */
                //excise
            end;

            trigger OnPreDataItem()
            begin

                GenJournalLine.Reset;
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'STATEMENT');
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
        Cust: Record Customer;
}
