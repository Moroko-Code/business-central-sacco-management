#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516002 "Receipt Header"
{
    fields
    {
        field(10; "No."; Code[10])
        {
            Editable = false;
        }
        field(11; "Document Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt;
        }
        field(12; Date; Date)
        {
            Editable = false;
        }
        field(13; "Posting Date"; Date)
        {
        }
        field(14; "Bank Code"; Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                BankAccount.Reset;
                BankAccount.SetRange(BankAccount."No.", "Bank Code");
                if BankAccount.FindFirst then
                    "Bank Name" := BankAccount.Name;
            end;
        }
        field(15; "Bank Name"; Text[50])
        {
            Editable = false;
        }
        field(16; "Bank Balance"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Bank Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Currency Code"; Code[10])
        {
            TableRelation = Currency;

            trigger OnValidate()
            begin
                Validate("Responsibility Center");
            end;
        }
        field(18; "Currency Factor"; Decimal)
        {
        }
        field(19; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(20; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(21; "Shortcut Dimension 3 Code"; Code[20])
        {
        }
        field(22; "Shortcut Dimension 4 Code"; Code[20])
        {
        }
        field(23; "Shortcut Dimension 5 Code"; Code[20])
        {
        }
        field(24; "Shortcut Dimension 6 Code"; Code[20])
        {
        }
        field(25; "Shortcut Dimension 7 Code"; Code[20])
        {
        }
        field(26; "Shortcut Dimension 8 Code"; Code[20])
        {
        }
        field(27; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(28; "Amount Received"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                    "Amount Received(LCY)" := "Amount Received"
                else begin
                    "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                    "Amount Received(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Amount Received", "Currency Factor"));
                end;
            end;
        }
        field(29; "Amount Received(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(30; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Receipt Line".Amount where("Document No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Total Amount(LCY)"; Decimal)
        {
            CalcFormula = sum("Receipt Line"."Amount(LCY)" where("Document No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "User ID"; Code[50])
        {
            Editable = false;
        }
        field(33; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected,Posted';
            OptionMembers = New,"Pending Approval",Approved,Rejected,Posted;
        }
        field(34; Description; Text[50])
        {
        }
        field(35; "Received From"; Text[50])
        {
        }
        field(36; "On Behalf of"; Text[50])
        {
        }
        field(37; "No. Series"; Code[20])
        {
        }
        field(38; Posted; Boolean)
        {
            Editable = false;
        }
        field(39; "Date Posted"; Date)
        {
            Editable = false;
        }
        field(40; "Time Posted"; Time)
        {
            Editable = false;
        }
        field(41; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(42; "Cheque No"; Code[20])
        {
        }
        field(43; "Date Created"; Date)
        {
            Editable = false;
        }
        field(44; "Time Created"; Time)
        {
            Editable = false;
        }
        field(45; "Receipt Type"; Option)
        {
            OptionCaption = 'Bank,Cash';
            OptionMembers = Bank,Cash;
        }
        field(51516450; "Investor Transaction"; Option)
        {
            Description = 'Investment Management';
            OptionCaption = ' ,Principle,Topup';
            OptionMembers = " ",Principle,Topup;
        }
        field(51516451; "Interest Code"; Code[20])
        {
            Description = 'Investment Management';
            TableRelation = "Interest Rates".Code;
        }
        field(51516452; "Investor Net Amount"; Decimal)
        {
            CalcFormula = sum("Receipt Line"."Net Amount" where("Investor Principle/Topup" = const(true),
                                                                 "Document No" = field("No.")));
            Description = 'Investment Management';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51516453; "Investor Net Amount(LCY)"; Decimal)
        {
            CalcFormula = sum("Receipt Line"."Net Amount(LCY)" where("Investor Principle/Topup" = const(true),
                                                                      "Document No" = field("No.")));
            Description = 'Investment Management';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51516454; "Investor No."; Code[20])
        {
            Description = 'Investment Management';
            // TableRelation = "Profitability Set up-Micro".Code;

            trigger OnValidate()
            begin
                //   "Investor Account".Reset;
                //   "Investor Account".SetRange("Investor Account".Code,"Investor No.");
                //   if "Investor Account".FindFirst then begin
                //     "Investor Name":="Investor Account".Description;
                //   end;
            end;
        }
        field(51516455; "Investor Name"; Text[50])
        {
            Description = 'Investment Management';
            Editable = false;
        }
        field(51516830; "Project Code"; Code[20])
        {
            Description = 'Project Management Field';
            // TableRelation = "Fixed Asset"."No." where ("Project Asset"=const(true),
            //                                            Closed=const(false));

            trigger OnValidate()
            begin
                if "Project Code" <> '' then begin
                    FA.Reset;
                    FA.SetRange(FA."No.", "Project Code");
                    if FA.FindFirst then
                        "Project Name" := FA.Description;
                end;
            end;
        }
        field(51516831; "Property Code"; Code[20])
        {
            Description = 'Project Management Field';
            // TableRelation = "Fixed Asset"."No." where ("Project No."=field("Project Code"),
            //                                            "Property Asset"=const(true),
            //                                            Receipted=const(false));

            trigger OnValidate()
            begin
                if "Property Code" <> '' then begin
                    FA.Reset;
                    FA.SetRange(FA."No.", "Property Code");
                    if FA.FindFirst then
                        "Property Name" := FA.Description;
                end;
            end;
        }
        field(51516832; "Project Name"; Text[50])
        {
            Description = 'Project Management Field';
            Editable = false;
        }
        field(51516833; "Property Name"; Text[50])
        {
            Description = 'Project Management Field';
            Editable = false;
        }
        field(51516834; "Receipt Category"; Option)
        {
            OptionCaption = 'Normal,Investor,Property';
            OptionMembers = Normal,Investor,Property;
        }
        field(51516835; "Property Total Amount"; Decimal)
        {
            Description = 'Project Management Field';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error('You cannot delete');
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            Setup.Get;
            Setup.TestField(Setup."Receipt Nos");
            NoSeriesMgt.InitSeries(Setup."Receipt Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "User ID" := UserId;
        Date := Today;
        "Document Type" := "document type"::Receipt;
    end;

    trigger OnModify()
    begin
        if Status = Status::Posted then
            Error('You cannot modify a posted transaction');
    end;

    var
        Setup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BankAccount: Record "Bank Account";
        CurrExchRate: Record "Currency Exchange Rate";
        //"Investor Account": Record "Profitability Set up-Micro";
        FA: Record "Fixed Asset";
}
