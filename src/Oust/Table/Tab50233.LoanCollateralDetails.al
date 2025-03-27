#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50233 "Loan Collateral Details"
{
    DrillDownPageID = "Loan Collateral Security";
    LookupPageID = "Loan Collateral Security";
    fields
    {
        field(1; "Loan No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Loans Register"."Loan  No.";
            trigger OnValidate()
            begin
                if LoanApplications.Get("Loan No") then
                    "Loan Type" := LoanApplications."Loan Product Type";
                "Member No." := LoanApplications."Client Code";
            end;
        }
        field(2; Type; Option)
        {
            NotBlank = true;
            // OptionCaption = ' ,Shares,Deposits,Collateral,Fixed Deposit';
            OptionMembers = Collateral,"Fixed Deposit";
        }
        field(3; "Security Details"; Text[150])
        {
        }
        field(4; Remarks; Text[250])
        {
        }
        field(5; "Loan Type"; Code[20])
        {
            //TableRelation = Table50005.Field3;
        }
        field(6; Value; Decimal)
        {
            trigger OnValidate()
            begin
                // //"Guarantee Value":=Value*0.7;
                // if Type = Type::"Fixed Deposit" then
                //     Error('The cannot change the value for fixed deposit');
                // //IF SecSetup.GET(Code) THEN BEGIN
                // SecSetup.Reset;
                // SecSetup.SetRange(SecSetup.Code, Code);
                // if SecSetup.Find('-') then begin
                //     Type := SecSetup.Type;
                //     "Security Details" := SecSetup."Security Description";
                //     "Collateral Multiplier" := SecSetup."Collateral Multiplier";
                //     "Guarantee Value" := (Value * "Collateral Multiplier") / 100;
                //     Category := SecSetup.Category;
                // end;
                //END;
            end;
        }
        field(7; "Guarantee Value"; Decimal)
        {
            //Editable = false;
        }
        field(8; "Code"; Code[20])
        {
            TableRelation = "Loan Collateral Register"."Document No" where("Member No." = field("Member No."));
            trigger OnValidate()
            begin
                //IF SecSetup.GET(Code) THEN BEGIN
                CollateralRegister.Reset;
                CollateralRegister.SetRange(CollateralRegister."Document No", Code);
                if CollateralRegister.Find('-') then begin
                    Name := CollateralRegister."Collateral Description";
                    Value := CollateralRegister."Asset Value";
                    "Assesment Done By" := CollateralRegister."Received By";
                    // "Security Details" := SecSetup."Security Description";
                    // "Collateral Multiplier" := SecSetup."Collateral Multiplier";
                    // "Guarantee Value" := Value * "Collateral Multiplier";
                    // Category := SecSetup.Category;
                end;
                //END;
            end;
        }
        field(9; Category; Option)
        {
            // OptionCaption = ' ,Cash,Government Securities,Corporate Bonds,Equity,Morgage Securities,Assets';
            OptionMembers = " ",Assets,Cash,"Government Securities","Corporate Bonds",Equity,"Morgage Securities";//,Assets;
        }
        field(10; "Collateral Multiplier"; Decimal)
        {
            trigger OnValidate()
            begin
                "Guarantee Value" := (Value * "Collateral Multiplier") / 100;
            end;
        }
        field(12; "Assesment Done By"; Code[30])
        {
        }
        field(13; "Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Member No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No", "Security Details", "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var
        LoanApplications: Record "Loans Register";
        SecSetup: Record "Loan Collateral Set-up";
        CollateralRegister: Record "Loan Collateral Register";
}

