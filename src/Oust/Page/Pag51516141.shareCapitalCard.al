page 51516141 "share Capital Card"
{
    ApplicationArea = All;
    Caption = 'share Capital Trading Card';
    PageType = Card;
    SourceTable = SharecapitalTrading;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Seller No"; "Seller No")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Name of Seller"; Rec."Name of Seller")
                {
                    ToolTip = 'Specifies the value of the Name of Seller field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Seller Share Balance"; "Seller Share Balance")
                {
                    ToolTip = 'Specifies the value of the Share Balance field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Partially Sell"; "Partially Sell")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        if "Partially Sell" = false then
                            partiallyVisible := false
                        else
                            partiallyVisible := true;
                    end;
                }
                field("Amount to Sell"; Rec."Amount to Sell")
                {
                    ToolTip = 'Specifies the value of the Amount to Sell field.';
                    ApplicationArea = all;
                    Editable = partiallyVisible;
                }
                field(Reason; Rec.Reason)
                {
                    ToolTip = 'Specifies the value of the Reason field.';
                    ApplicationArea = all;
                    Caption = 'Reason for Selling';
                    ShowMandatory = true;
                }
                field("Selling price"; Rec."Selling price")
                {
                    ToolTip = 'Specifies the value of the Selling price field.';
                    ApplicationArea = all;
                }
                field("Buyer No."; Rec."Buyer No.")
                {
                    ToolTip = 'Specifies the value of the Buyer No. field.';
                    ApplicationArea = all;
                }
                field("Buyer Name"; Rec."Buyer Name")
                {
                    ToolTip = 'Specifies the value of the Buyer Name field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buyer Shares Balance"; "Buyer Shares Balance")
                {
                    ToolTip = 'Specifies the value of the Buyer Shares Amount field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(cashier; Rec.cashier)
                {
                    ToolTip = 'Specifies the value of the cashier field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Trasaction Date"; Rec."Trasaction Date")
                {
                    ToolTip = 'Specifies the value of the Trasaction Date field.';
                    ApplicationArea = all;
                    Editable = false;
                }
            }
            part("Member Statistics Seller"; "Member Stats")
            {
                SubPageLink = "No." = field("Seller No");
                Visible = true;
                ApplicationArea = all;
                Caption = 'Member Statistics Seller';
            }
            part("Member Statistics Buyer"; "Member Stats")
            {
                SubPageLink = "No." = field("Buyer No.");
                Visible = true;
                ApplicationArea = all;
                Caption = 'Member Statistics Buyer';
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Sell shares';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction()
                begin
                    TestField("Buyer No.");
                    TestField("Seller No");
                    if "Buyer Shares Balance" > 0 then begin
                        TempBatch.Reset;
                        TempBatch.SetRange(TempBatch.UserID, UserId);
                        if TempBatch.Find('-') then begin
                            TemplateName := TempBatch."FundsTransfer Template Name";
                            BatchName := TempBatch."FundsTransfer Batch Name";
                        end;
                        //....................Reset General Journal Lines
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
                        GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
                        GenJournalLine.DELETEALL;
                        //.sharecapital Transfer Seller
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, "No.", LineNo, GenJournalLine."Transaction Type"::"Shares Capital", GenJournalLine."Account Type"::Customer, "Seller No", "Trasaction Date", "Amount to Sell", 'BOSA', Rec."No.", 'Share Capital Tranfer' + Format("Seller No"), '');
                        //.sharecapital Buyer
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, "No.", LineNo, GenJournalLine."Transaction Type"::"Shares Capital", GenJournalLine."Account Type"::Customer, "Buyer No.", "Trasaction Date", "Amount to Sell" * -1, 'BOSA', Rec."No.", 'Share Capital Tranfer' + Format("Buyer Name"), '');

                        GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
                        if GenJournalLine.Find('-') then begin
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
                            //Send Notifications
                            FnSendNotificationstoBuyer();
                            FnSendNotificationstoBuyer();
                        end;
                        Posted := true;
                    end;
                end;
            }
        }
    }
    var
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        TemplateName: Code[50];
        BatchName: Code[50];
        GenJournalLine: Record "Gen. Journal Line";
        Cust: Record Customer;
        partiallyVisible: Boolean;
        TempBatch: Record "Funds User Setup";
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;

    local procedure FnSendNotificationstoSeller()
    var
        msg: Text[250];
        PhoneNo: Text[250];
    begin
        Cust.Reset();
        Cust.SetRange(Cust."No.", "Seller No");
        if Cust.Find('-') then begin
            msg := '';
            msg := 'Dear Member, Your have transfered' + Format("Amount to Sell") + ' Share Capital to ' + Format("Buyer No.");
            PhoneNo := FnGetPhoneNo("Seller No");
            SendSMSMessage("Seller No", msg, PhoneNo);
        end;
    end;

    local procedure FnSendNotificationstoBuyer()
    var
        msg: Text[250];
        PhoneNo: Text[250];
    begin
        Cust.Reset();
        Cust.SetRange(Cust."No.", "Buyer No.");
        if Cust.Find('-') then begin
            msg := '';
            msg := 'Dear Member, Your have Received' + Format("Amount to Sell") + ' Share Capital from ' + Format("Seller No");
            PhoneNo := FnGetPhoneNo("Buyer No.");
            SendSMSMessage("Buyer No.", msg, PhoneNo);
        end;
    end;

    local procedure SendSMSMessage(BOSANo: Code[20]; msg: Text[250]; PhoneNo: Text[250])
    begin
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else
            iEntryNo := 1;
        //--------------------------------------------------
        SMSMessages.Reset;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Account No" := BOSANo;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'SHARECAPSELL';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := msg;
        SMSMessages."Telephone No" := PhoneNo;
        SMSMessages.Insert;
    end;

    local procedure FnGetPhoneNo(ClientCode: Code[50]): Text[250]
    var
        Member: Record Customer;
    begin
        Member.Reset();
        Member.SetRange(Member."No.", ClientCode);
        if Member.Find('-') = true then begin
            if (Member."Mobile Phone No." <> '') and (Member."Mobile Phone No." <> '0') then
                exit(Member."Mobile Phone No.");
            if (Member."Mobile Phone No" <> '') and (Member."Mobile Phone No" <> '0') then
                exit(Member."Mobile Phone No");
            if (Member."Phone No." <> '') and (Member."Phone No." <> '0') then
                exit(Member."Phone No.");
        end;
    end;
}
