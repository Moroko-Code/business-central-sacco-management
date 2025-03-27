#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516003 "Receipt Line"
{
    fields
    {
        field(10; "Line No"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(11; "Document No"; Code[20])
        {
            Editable = false;
        }
        field(12; "Document Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt;
        }
        field(13; "Transaction Type"; Code[20])
        {
            TableRelation = "Funds Transaction Types"."Transaction Code" where("Transaction Type" = const(Receipt));

            trigger OnValidate()
            begin
                FundsTypes.Reset;
                FundsTypes.SetRange("Transaction Code", "Transaction Type");
                if FundsTypes.FindFirst then begin
                    "Default Grouping" := FundsTypes."Default Grouping";
                    "Account Type" := FundsTypes."Account Type";
                    "Account Code" := FundsTypes."Account No";
                    Description := FundsTypes."Transaction Description";
                    //"Legal Fee Code":=FundsTypes."Legal Fee Code";
                    //"Legal Fee Amount":=FundsTypes."Legal Fee Amount";
                    "Investor Principle/Topup" := FundsTypes."Investor Principle/Topup";
                end;
                RHeader.Reset;
                RHeader.SetRange(RHeader."No.", "Document No");
                if RHeader.FindFirst then begin
                    "Global Dimension 1 Code" := RHeader."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := RHeader."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := RHeader."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := RHeader."Shortcut Dimension 4 Code";
                    "Shortcut Dimension 5 Code" := RHeader."Shortcut Dimension 5 Code";
                    "Shortcut Dimension 6 Code" := RHeader."Shortcut Dimension 6 Code";
                    "Shortcut Dimension 7 Code" := RHeader."Shortcut Dimension 7 Code";
                    "Shortcut Dimension 8 Code" := RHeader."Shortcut Dimension 8 Code";

                    "Responsibility Center" := RHeader."Responsibility Center";
                    //"Pay Mode":=
                    "Currency Code" := RHeader."Currency Code";
                    "Currency Factor" := RHeader."Currency Factor";
                    "Document Type" := "document type"::Receipt;
                end;
                Validate("Account Type");
            end;
        }
        field(14; "Default Grouping"; Code[20])
        {
            Editable = false;
        }
        field(15; "Account Type"; Option)
        {
            Editable = true;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Staff,Investor,Member;

            trigger OnValidate()
            begin
                if "Account Type" = "account type"::Investor then begin
                    RHeader.Reset;
                    RHeader.SetRange(RHeader."No.", "Document No");
                    if RHeader.FindFirst then begin
                        "Account Code" := RHeader."Investor No.";
                        "Account Name" := RHeader."Investor Name";
                    end;
                end;
                Validate("Account Code");
            end;
        }
        field(16; "Account Code"; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else if ("Account Type" = const(Customer)) Customer where("Customer Type" = const(Checkoff))
            else if ("Account Type" = const(Vendor)) Vendor;
            //   else if ("Account Type" = const(Investor)) "Profitability Set up-Micro";

            trigger OnValidate()
            begin
                if "Account Type" = "account type"::"G/L Account" then begin
                    "G/L Account".Reset;
                    "G/L Account".SetRange("G/L Account"."No.", "Account Code");
                    if "G/L Account".FindFirst then
                        "Account Name" := "G/L Account".Name;
                end;
                if "Account Type" = "account type"::Customer then begin
                    Customer.Reset;
                    Customer.SetRange(Customer."No.", "Account Code");
                    Customer.SetRange(Customer."Customer Type", Customer."Customer Type"::Checkoff);
                    if Customer.FindFirst then
                        "Account Name" := Customer.Name;
                end;
                if "Account Type" = "account type"::Vendor then begin
                    Vendor.Reset;
                    Vendor.SetRange(Vendor."No.", "Account Code");
                    if Vendor.FindFirst then
                        "Account Name" := Vendor.Name;
                end;
                // if "Account Type" = "account type"::Investor then begin
                //     Investor.Reset;
                //     Investor.SetRange(Investor.Code, "Account Code");
                //     if Investor.FindFirst then begin
                //         "Account Name" := Investor.Description;
                //     end;
                // end;

                if "Account Code" = '' then
                    "Account Name" := '';
            end;
        }
        field(17; "Account Name"; Text[50])
        {
            Editable = false;
        }
        field(18; Description; Text[50])
        {
            Editable = false;
        }
        field(19; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(20; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(21; "Shortcut Dimension 3 Code"; Code[20])
        {
            Editable = false;
        }
        field(22; "Shortcut Dimension 4 Code"; Code[20])
        {
            Editable = false;
        }
        field(23; "Shortcut Dimension 5 Code"; Code[20])
        {
            Editable = false;
        }
        field(24; "Shortcut Dimension 6 Code"; Code[20])
        {
            Editable = false;
        }
        field(25; "Shortcut Dimension 7 Code"; Code[20])
        {
            Editable = false;
        }
        field(26; "Shortcut Dimension 8 Code"; Code[20])
        {
            Editable = false;
        }
        field(27; "Responsibility Center"; Code[20])
        {
        }
        field(28; "Pay Mode"; Option)
        {
            OptionCaption = ' ,Cash,Cheque,Deposit Slip,EFT,Bankers Cheque,RTGS';
            OptionMembers = " ",Cash,Cheque,"Deposit Slip",EFT,"Bankers Cheque",RTGS;
        }
        field(29; "Currency Code"; Code[20])
        {
        }
        field(30; "Currency Factor"; Decimal)
        {
        }
        field(31; Amount; Decimal)
        {
            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                    "Amount(LCY)" := Amount
                else
                    "Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", Amount, "Currency Factor"));
                //VALIDATE("Legal Fee Code");

                "Net Amount" := Amount;
                "Net Amount(LCY)" := "Amount(LCY)";
            end;
        }
        field(32; "Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(33; "Cheque No"; Code[20])
        {
        }
        field(34; "Applies-To Doc No."; Code[20])
        {
        }
        field(35; "Applies-To ID"; Code[20])
        {
        }
        field(36; "VAT Code"; Code[20])
        {
            TableRelation = "Funds Tax Codes"."Tax Code" where(Type = const(VAT));
        }
        field(37; "VAT Percentage"; Decimal)
        {
        }
        field(38; "VAT Amount"; Decimal)
        {
        }
        field(39; "VAT Amount(LCY)"; Decimal)
        {
        }
        field(40; "W/TAX Code"; Code[20])
        {
            TableRelation = "Funds Tax Codes"."Tax Code" where(Type = const("W/Tax"));
        }
        field(41; "W/TAX Percentage"; Decimal)
        {
        }
        field(42; "W/TAX Amount"; Decimal)
        {
        }
        field(43; "W/TAX Amount(LCY)"; Decimal)
        {
        }
        field(44; "Net Amount"; Decimal)
        {
            Editable = false;
        }
        field(45; "Net Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(46; "Gen. Bus. Posting Group"; Code[20])
        {
        }
        field(47; "Gen. Prod. Posting Group"; Code[20])
        {
        }
        field(48; "VAT Bus. Posting Group"; Code[20])
        {
        }
        field(49; "VAT Prod. Posting Group"; Code[20])
        {
        }
        field(50; "User ID"; Code[50])
        {
            Editable = false;
        }
        field(51; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected,Posted';
            OptionMembers = New,"Pending Approval",Approved,Rejected,Posted;
        }
        field(52; Posted; Boolean)
        {
            Editable = false;
        }
        field(53; "Date Posted"; Date)
        {
            Editable = false;
        }
        field(54; "Time Posted"; Time)
        {
            Editable = false;
        }
        field(55; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(56; "Date Created"; Date)
        {
            Editable = false;
        }
        field(57; "Time Created"; Time)
        {
            Editable = false;
        }
        field(58; "Legal Fee Code"; Code[20])
        {
            Description = 'Investment Field';
            TableRelation = "Funds Tax Codes"."Tax Code" where(Type = const(Legal));

            trigger OnValidate()
            begin
                /* TESTFIELD(Amount);
                 "Net Amount":=Amount-"Legal Fee Amount";
                 IF "Currency Code"='' THEN BEGIN
                   "Legal Fee Amount(LCY)":="Legal Fee Amount";
                   "Net Amount(LCY)":=Amount-"Legal Fee Amount";
                 END ELSE BEGIN
                   "Legal Fee Amount(LCY)":=ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date","Currency Code","Legal Fee Amount","Currency Factor"));
                   "Net Amount(LCY)":=ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date","Currency Code","Net Amount","Currency Factor"));
                 END;*/
            end;
        }
        field(59; "Legal Fee Amount"; Decimal)
        {
            Description = 'Investment Field';
            Editable = false;
        }
        field(60; "Legal Fee Amount(LCY)"; Decimal)
        {
            Description = 'Investment Field';
        }
        field(61; Date; Date)
        {
        }
        field(62; "Posting Date"; Date)
        {
        }
        field(63; "Investor Principle/Topup"; Boolean)
        {
            Description = 'Investment Field';
        }
    }

    keys
    {
        key(Key1; "Line No", "Document No", "Transaction Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        FundsTypes: Record "Funds Transaction Types";
        "G/L Account": Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        //Investor: Record "Profitability Set up-Micro";
        RHeader: Record "Receipt Header";
        FundsTaxCodes: Record "Funds Tax Codes";
        CurrExchRate: Record "Currency Exchange Rate";
}
