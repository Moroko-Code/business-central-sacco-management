#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516032 "Funds Transaction Types"
{
    fields
    {
        field(10; "Transaction Code"; Code[30])
        {
        }
        field(11; "Transaction Description"; Text[50])
        {
        }
        field(12; "Transaction Type"; Option)
        {
            //Editable = false;
            OptionCaption = 'Payment,Receipt,Imprest,Claim';
            OptionMembers = Payment,Receipt,Imprest,Claim;
        }
        field(13; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,Investor';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor;
        }
        field(14; "Account No"; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else if ("Account Type" = const(Customer)) Customer
            else if ("Account Type" = const(Vendor)) Vendor
            // else if ("Account Type"=const(Investor)) "Profitability Set up-Micro"
            else if ("Account Type" = const(Member)) Customer;

            trigger OnValidate()
            begin
                if "Account Type" = "account type"::"G/L Account" then begin
                    "G/L Account".Reset;
                    "G/L Account".SetRange("G/L Account"."No.", "Account No");
                    if "G/L Account".FindFirst then
                        "Account Name" := "G/L Account".Name;
                end;
                if "Account Type" = "account type"::Customer then begin
                    Customer.Reset;
                    Customer.SetRange(Customer."No.", "Account No");
                    if Customer.FindFirst then
                        "Account Name" := Customer.Name;
                end;
                if "Account Type" = "account type"::Vendor then begin
                    Vendor.Reset;
                    Vendor.SetRange(Vendor."No.", "Account No");
                    if Vendor.FindFirst then
                        "Account Name" := Vendor.Name;
                end;
                //    if "Account Type"="account type"::Investor then begin
                //       Investor.Reset;
                //       Investor.SetRange(Investor.Code,"Account No");
                //       if Investor.FindFirst then begin
                //         "Account Name":=Investor.Description;
                //       end;
                //    end;

                if "Account No" = '' then
                    "Account Name" := '';
            end;
        }
        field(15; "Account Name"; Text[50])
        {
            Editable = false;
        }
        field(16; "Default Grouping"; Code[20])
        {
            TableRelation = if ("Account Type" = const(Customer)) "Customer Posting Group"
            else if ("Account Type" = const(Vendor)) "Vendor Posting Group"
            else if ("Account Type" = const("Bank Account")) "Bank Account Posting Group"
            else if ("Account Type" = const("Fixed Asset")) "FA Posting Group"
            else if ("Account Type" = const(Member)) "Customer Posting Group";
        }
        field(17; "VAT Chargeable"; Boolean)
        {
        }
        field(18; "VAT Code"; Code[20])
        {
            TableRelation = "Funds Tax Codes"."Tax Code" where(Type = const(VAT));
        }
        field(19; "Withholding Tax Chargeable"; Boolean)
        {
        }
        field(20; "Withholding Tax Code"; Code[20])
        {
            TableRelation = "Funds Tax Codes"."Tax Code" where(Type = const("W/Tax"));
        }
        field(21; "Retention Chargeable"; Boolean)
        {
        }
        field(22; "Retention Code"; Code[20])
        {
        }
        field(23; "Legal Fee Chargeable"; Boolean)
        {
        }
        field(24; "Legal Fee Code"; Code[20])
        {
            TableRelation = "Funds Tax Codes"."Tax Code" where(Type = const(Legal));
        }
        field(25; "Legal Fee Amount"; Decimal)
        {
        }
        field(26; "Investor Principle/Topup"; Boolean)
        {
        }
        field(27; "Transaction Category"; Option)
        {
            OptionCaption = 'Normal,Investor,Property';
            OptionMembers = Normal,Investor,Property;
        }
    }

    keys
    {
        key(Key1; "Transaction Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        "G/L Account": Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
    // Investor: Record "Profitability Set up-Micro";
}
