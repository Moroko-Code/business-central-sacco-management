#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516289 "Banking Shares Receipt"
{
    fields
    {
        field(1; "Transaction No."; Code[20])
        {
        }
        field(2; "Account No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                //TESTFIELD(Source);
                if Vend.Get("Account No.") then
                    Name := Vend.Name;
            end;
        }
        field(3; Name; Text[50])
        {
        }
        field(4; Amount; Decimal)
        {
            NotBlank = true;
        }
        field(5; "Cheque No."; Code[20])
        {
            trigger OnValidate()
            begin
                BOSARcpt.Reset;
                BOSARcpt.SetRange(BOSARcpt."Cheque No.", "Cheque No.");
                BOSARcpt.SetRange(BOSARcpt.Posted, true);
                if BOSARcpt.Find('-') then
                    Error('Cheque no already exist in a posted receipt.');
            end;
        }
        field(6; "Cheque Date"; Date)
        {
        }
        field(7; Posted; Boolean)
        {
            Editable = true;
        }
        field(8; "Bank No."; Code[20])
        {
            Editable = true;
            TableRelation = "Bank Account"."No.";
        }
        field(9; "User ID"; Code[50])
        {
            Editable = false;
        }
        field(10; "Allocated Amount"; Decimal)
        {
            CalcFormula = sum("Receipt Allocation".Amount where("Document No" = field("Transaction No."),
                                                                 "Member No" = field("Account No.")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                CalcFields("Un allocated Amount");
                Validate("Un allocated Amount");
            end;
        }
        field(11; "Transaction Date"; Date)
        {
            Editable = true;
        }
        field(12; "Transaction Time"; Time)
        {
            Editable = false;
        }
        field(13; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(14; "Account Type"; Option)
        {
            OptionCaption = 'Member,Debtor,G/L Account,FOSA Loan,Customer,Vendor';
            OptionMembers = Member,Debtor,"G/L Account","FOSA Loan",Customer,Vendor;
        }
        field(15; "Transaction Slip Type"; Option)
        {
            OptionCaption = ' ,Standing Order,Direct Debit,Direct Deposit,Cash,Cheque,M-Pesa';
            OptionMembers = " ","Standing Order","Direct Debit","Direct Deposit",Cash,Cheque,"M-Pesa";
        }
        field(16; "Bank Name"; Code[50])
        {
        }
        field(50000; Insuarance; Decimal)
        {
            FieldClass = Normal;
        }
        field(50001; "Un allocated Amount"; Decimal)
        {
        }
        field(50002; Source; Option)
        {
            OptionMembers = " ",Bosa,Fosa;
        }
        field(50003; "Mode of Payment"; Option)
        {
            OptionCaption = 'Cash,Cheque,Mpesa,Standing order,Deposit Slip,EFT';
            OptionMembers = Cash,Cheque,Mpesa,"Standing order","Deposit Slip",EFT;
        }
        field(50004; Remarks; Text[50])
        {
        }
        field(50005; "Code"; Code[20])
        {
        }
        field(50006; Type; Option)
        {
            NotBlank = true;
            OptionMembers = " ",Receipt,Payment,Imprest,Advance;
        }
        field(50007; Description; Text[50])
        {
        }
        field(50008; "Default Grouping"; Code[20])
        {
            Editable = false;
        }
        field(50009; "Transation Remarks"; Text[50])
        {
        }
        field(50010; "Customer Payment On Account"; Boolean)
        {
        }
        field(50011; "G/L Account"; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"."No.";

            trigger OnValidate()
            begin
                GLAcc.Reset;

                if GLAcc.Get("G/L Account") then

                    //IF Type=Type::Payment THEN
                    //  GLAcc.TESTFIELD(GLAcc."Budget Controlled",TRUE);
                    if GLAcc."Direct Posting" = false then
                        Error('Direct Posting must be True');

                /*PayLine.RESET;
                PayLine.SETRANGE(PayLine.Type,Code);
                IF PayLine.FIND('-') THEN
                   ERROR('This Transaction Code Is Already in Use You Cannot Delete');uncomment*/
            end;
        }
        field(50012; Blocked; Boolean)
        {
        }
        field(50013; "Branch Code"; Code[20])
        {
        }
        field(50014; "Transaction Type Fosa"; Option)
        {
            OptionCaption = ' ,Pepea Shares,School Fees Shares';
            OptionMembers = " ","Pepea Shares","School Fees Shares";
        }
    }

    keys
    {
        key(Key1; "Transaction No.")
        {
            Clustered = true;
        }
        key(Key2; "Account Type", Posted)
        {
            SumIndexFields = Amount;
        }
        key(Key3; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*
        IF Posted THEN
        ERROR('Cannot delete a posted transaction');
        */
    end;

    trigger OnInsert()
    begin
        if "Transaction No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Banking Shares Nos");
            NoSeriesMgt.InitSeries(NoSetup."Banking Shares Nos", xRec."No. Series", 0D, "Transaction No.", "No. Series");
        end;

        "User ID" := UserId;
        "Transaction Date" := Today;
        "Transaction Time" := Time;

        usersetup.Reset;
        usersetup.SetRange(usersetup."User ID", UserId);
        if usersetup.Find('-') then
            "Branch Code" := usersetup."Global Dimension 2 Code";
    end;

    trigger OnModify()
    begin
        /*IF Posted THEN
        ERROR('Cannot modify a posted transaction');
        */
    end;

    trigger OnRename()
    begin
        /*IF Posted THEN
        ERROR('Cannot rename a posted transaction');
        */
    end;

    var
        Cust: Record Customer;
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BOSARcpt: Record "Receipts & Payments";
        GLAcct: Record "G/L Account";
        Mem: Record Customer;
        Vend: Record Vendor;
        GLAcc: Record "G/L Account";
        PayLine: Record "Payment Line";
        usersetup: Record "User Setup";
}
