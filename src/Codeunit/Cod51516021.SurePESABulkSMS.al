#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516021 "SurePESABulkSMS"
{
    trigger OnRun()
    begin
        Message(PollPendingSMS());
        //ChargeSMS();
    end;

    var
        SMSMessages: Record "SMS Messages";
        SMSCharges: Record "SMS Messages";
        SMSCharge: Decimal;
        ExDuty: Decimal;
        Vendor: Record Vendor;
        GenJournalLine: Record "Gen. Journal Line";
        GenBatches: Record "Gen. Journal Batch";
        LineNo: Integer;

    procedure PollPendingSMS() MessageDetails: Text
    begin

        SMSMessages.Reset;
        SMSMessages.SetRange(SMSMessages."Sent To Server", SMSMessages."sent to server"::No);
        //SMSMessages.SetFilter(SMSMessages.Source, '%1|%2|%3|%4|%5|%6', 'MOBILETRAN', 'AGENCY', 'ATM TRANS', 'LOANS', 'MEMBAPP', 'OTP');
        SMSMessages.SetFilter(SMSMessages."Date Entered", '=%', TODAY);
        SMSMessages.SetRange(SMSMessages."Telephone No", '0715881357');
        if SMSMessages.Find('-') then
            if (SMSMessages."Telephone No" = '')
              or (SMSMessages."Telephone No" = '+')
              or (SMSMessages."SMS Message" = '')
              then begin

                SMSMessages."Sent To Server" := SMSMessages."sent to server"::Failed;
                SMSMessages."Entry No." := 'FAILED';
                SMSMessages.Modify;

            end else begin
                MessageDetails := '';

                MessageDetails += SMSMessages."Telephone No" + ':::' + SMSMessages."SMS Message" + ':::' + Format(SMSMessages."Entry No");
            end;
    end;

    procedure ConfirmSent(TelephoneNo: Text[20]; Status: Integer)
    begin

        SMSMessages.Reset;
        SMSMessages.SetRange(SMSMessages."Sent To Server", SMSMessages."sent to server"::No);
        SMSMessages.SetRange(SMSMessages."Entry No", Status);
        if SMSMessages.FindFirst then begin
            SMSMessages."Sent To Server" := SMSMessages."sent to server"::Yes;
            SMSMessages."Entry No." := 'SUCCESS';
            //SMSMessages."Entry No.":='SUCCESS';
            SMSMessages.Modify;
            //result:='TRUE';
        end
    end;

    procedure ChargeSMS()
    begin
        /*
          SMSMessages.RESET;
          SMSMessages.SETRANGE(SMSMessages."Sent To Server", SMSMessages."Sent To Server"::Yes);
          SMSMessages.SETRANGE(SMSMessages."Entry No.",'SUCCESS');
          SMSMessages.SETFILTER(SMSMessages."Telephone No",'<>%1','');
          SMSMessages.SETRANGE(SMSMessages.Charged,FALSE);
          IF SMSMessages.FIND('-') THEN
            REPEAT
                BEGIN

                 SMSCharges.RESET;
                 SMSCharges.SETFILTER(SMSCharges.Source,SMSMessages.Source);
                IF SMSCharges.FIND('-') THEN BEGIN
                  SMSCharges.TESTFIELD(SMSCharges."Charge Account");
                  SMSCharge:=SMSCharges.Amount;
                  ExDuty:=(10/100)*SMSCharge;
                 END;
                  Vendor.RESET;
                  Vendor.SETRANGE(Vendor."No.",SMSMessages."Account No");
                  IF Vendor.FIND('-') THEN BEGIN
                      GenJournalLine.RESET;
                      GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                      GenJournalLine.SETRANGE("Journal Batch Name",'SMSCHARGE');
                      GenJournalLine.DELETEALL;
                      //end of deletion

                      GenBatches.RESET;
                      GenBatches.SETRANGE(GenBatches."Journal Template Name",'GENERAL');
                      GenBatches.SETRANGE(GenBatches.Name,'SMSCHARGE');

                      IF GenBatches.FIND('-') = FALSE THEN BEGIN
                      GenBatches.INIT;
                      GenBatches."Journal Template Name":='GENERAL';
                      GenBatches.Name:='SMSCHARGE';
                      GenBatches.Description:='SMS Charges';
                      GenBatches.VALIDATE(GenBatches."Journal Template Name");
                      GenBatches.VALIDATE(GenBatches.Name);
                      GenBatches.INSERT;
                      END;

                      //DR Member Account
                              LineNo:=LineNo+10000;
                              GenJournalLine.INIT;
                              GenJournalLine."Journal Template Name":='GENERAL';
                              GenJournalLine."Journal Batch Name":='SMSCHARGE';
                              GenJournalLine."Line No.":=LineNo;
                              GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
                              GenJournalLine."Account No.":=Vendor."No.";
                              GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                              GenJournalLine."Document No.":=SMSMessages.Source+'-'+FORMAT(SMSMessages."Entry No");
                              GenJournalLine."External Document No.":=SMSMessages.Source+'-'+FORMAT(SMSMessages."Entry No");
                              GenJournalLine."Posting Date":=TODAY;
                              GenJournalLine.Description:='SMS Charges';
                              GenJournalLine.Amount:=SMSCharges.Amount;
                              GenJournalLine.VALIDATE(GenJournalLine.Amount);
                              IF GenJournalLine.Amount<>0 THEN
                              GenJournalLine.INSERT;

                              //Cr SMS Charges
                              LineNo:=LineNo+10000;
                              GenJournalLine.INIT;
                              GenJournalLine."Journal Template Name":='GENERAL';
                              GenJournalLine."Journal Batch Name":='SMSCHARGE';
                              GenJournalLine."Line No.":=LineNo;
                              GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                              GenJournalLine."Account No.":=SMSCharges."Charge Account";
                              GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                              GenJournalLine."Document No.":=SMSMessages.Source+'-'+FORMAT(SMSMessages."Entry No");
                              GenJournalLine."External Document No.":=SMSMessages.Source+'-'+FORMAT(SMSMessages."Entry No");
                              GenJournalLine."Posting Date":=TODAY;
                              GenJournalLine.Description:='SMS Charge';
                              GenJournalLine.Amount:=-SMSCharges.Amount;
                              GenJournalLine.VALIDATE(GenJournalLine.Amount);
                              IF GenJournalLine.Amount<>0 THEN
                              GenJournalLine.INSERT;

                              //DR Excise Duty
                              LineNo:=LineNo+10000;
                              GenJournalLine.INIT;
                              GenJournalLine."Journal Template Name":='GENERAL';
                              GenJournalLine."Journal Batch Name":='SMSCHARGE';
                              GenJournalLine."Line No.":=LineNo;
                              GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
                              GenJournalLine."Account No.":=Vendor."No.";
                              GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                              GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                              GenJournalLine."Bal. Account No.":='201160';
                              GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                              GenJournalLine."Document No.":=SMSMessages.Source+'-'+FORMAT(SMSMessages."Entry No");
                              GenJournalLine."External Document No.":=SMSMessages.Source+'-'+FORMAT(SMSMessages."Entry No");
                              GenJournalLine."Posting Date":=TODAY;
                              GenJournalLine.Description:='Excise duty-SMS Notification';
                              GenJournalLine.Amount:=ExDuty;
                              GenJournalLine.VALIDATE(GenJournalLine.Amount);
                              IF GenJournalLine.Amount<>0 THEN
                              GenJournalLine.INSERT;
                              //Post
                              GenJournalLine.RESET;
                              GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                              GenJournalLine.SETRANGE("Journal Batch Name",'SMSCHARGE');
                              IF GenJournalLine.FIND('-') THEN BEGIN
                              REPEAT
                              GLPosting.RUN(GenJournalLine);
                              UNTIL GenJournalLine.NEXT = 0;
                              END;
                            END;
                            END;

                        SMSMessages.Charged:=TRUE;
                        SMSMessages.MODIFY;
                      UNTIL SMSMessages.NEXT=0;*/
    end;
}
