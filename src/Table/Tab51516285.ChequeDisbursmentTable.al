#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516285 "Cheque Disbursment Table"
{
    fields
    {
        field(1; codes; Code[30])
        {
            trigger OnValidate()
            begin

                if codes <> xRec.codes then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Cheque Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Loan Number"; Code[30])
        {
            trigger OnValidate()
            begin

                "Account Type" := "account type"::"Bank Account";
            end;
        }
        field(3; "Cheque Number"; Code[10])
        {
            trigger OnValidate()
            begin
                if Posted then
                    Error('This Cheque was already disbursed. It Cannot be Modified');
            end;
        }
        field(4; "Cheque Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                if Posted then
                    Error('This Cheque was already disbursed. It Cannot be Modified');
            end;
        }
        field(5; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(6; "Bank Account"; Code[10])
        {
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                if Posted then
                    Error('This Cheque was already disbursed. It Cannot be Modified');
            end;
        }
        field(7; "Dedact From"; Boolean)
        {
            trigger OnValidate()
            begin
                if Posted then
                    Error('This Cheque was already disbursed. It Cannot be Modified');
            end;
        }
        field(8; "Posting Date"; Date)
        {
            trigger OnValidate()
            begin
                if Posted then
                    Error('This Cheque was already disbursed. It Cannot be Modified');
            end;
        }
        field(9; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,None,Staff';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,"None",Staff;

            trigger OnValidate()
            begin
                if Posted then
                    Error('This Cheque was already disbursed. It Cannot be Modified');
            end;
        }
        field(10; Appeal; Boolean)
        {
        }
        field(11; Posted; Boolean)
        {
        }
        field(12; Description; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; codes, "Loan Number", "Cheque Number")
        {
            Clustered = true;
            SumIndexFields = "Cheque Amount";
        }
        key(Key2; "Cheque Number")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if codes = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Cheque Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Cheque Nos.", xRec."No. Series", 0D, codes, "No. Series");
        end;

        if Loans.Get("Loan Number") then
            if Loans."Appeal Loan" then
                Appeal := true;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Loans: Record "Loans Register";
        AppealAmount: Decimal;
        ChequeDisb: Record "Cheque Disbursment Table";
}
