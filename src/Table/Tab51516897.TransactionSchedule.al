#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516897 "Transaction Schedule"
{
    fields
    {
        field(1; No; Code[30])
        {
            TableRelation = Transactions.No;
        }
        field(2; "Account No"; Code[30])
        {
            NotBlank = true;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                AccountHolders.Reset;
                if AccountHolders.Get("Account No") then begin
                    "Account Name" := AccountHolders.Name;
                    "Account Type" := AccountHolders."Account Type";
                    //AccountHolders.CALCFIELDS("Bosa Account No");
                    "Bosa Account No" := AccountHolders."BOSA Account No";
                end;
                /*
                SDeductions.RESET;
                SDeductions.SETRANGE(SDeductions."Transaction No",No);
                SDeductions.SETRANGE(SDeductions."Vendor No","Account No");
                SDeductions.DELETEALL;

                   LApplications.RESET;
                   LApplications.SETRANGE(LApplications.Source,LApplications.Source::FOSO);
                   LApplications.SETRANGE(LApplications."Member Code","Account No");
                   LApplications.SETRANGE(LApplications.Posted,TRUE);
                   IF LApplications.FIND('-') THEN BEGIN
                   REPEAT

                   IF LTypes.GET(LApplications."Loan Product Type") THEN BEGIN
                   IF LTypes."Deductable From Salary Proc." = TRUE THEN BEGIN
                   LApplications.CALCFIELDS("Oustanding Balance");
                   IF LApplications."Oustanding Balance" > 0 THEN BEGIN

                   SDeductions.INIT;
                   SDeductions."Transaction No":=No;
                   SDeductions."Vendor No":="Account No";
                   SDeductions."Loan No":=LApplications."Loan  No.";
                   SDeductions."Loan Type":=LApplications."Loan Product Type Name";
                   IF LApplications.Installments=0 THEN BEGIN
                   SDeductions."Total Repayment":=ROUND(LApplications."Oustanding Balance"
                                                  +((LApplications."Oustanding Balance"/100)*LApplications.Interest),0.01);
                   SDeductions.Principal:=ROUND(LApplications."Oustanding Balance",0.01);
                   END
                   ELSE BEGIN
                   IF LApplications."Oustanding Balance"<LApplications.Repayment THEN BEGIN
                   SDeductions."Total Repayment":=ROUND((LApplications."Oustanding Balance")
                                                  + ((LApplications."Oustanding Balance"/100)*LApplications.Interest),0.01);
                   SDeductions.Principal:=LApplications."Oustanding Balance"
                   END
                   ELSE BEGIN
                   SDeductions."Total Repayment":=ROUND((LApplications.Repayment)
                                                  + ((LApplications."Oustanding Balance"/100)*LApplications.Interest),0.01);
                   SDeductions.Principal:=ROUND((LApplications.Repayment),0.01);
                   END;
                   END;
                   SDeductions.Interest:=ROUND((LApplications."Oustanding Balance"/100)*LApplications.Interest,0.01);
                   SDeductions.INSERT;
                   END;
                   END;
                   END;
                   UNTIL LApplications.NEXT = 0;
                   END;
                 */
            end;
        }
        field(3; "Account Name"; Text[150])
        {
        }
        field(4; Amount; Decimal)
        {
            trigger OnValidate()
            begin

                TotalDN := 0;
                AddVarDN := 0;

                Modify;

                TransactionSchedule.Reset;

                TransactionSchedule.SetRange(TransactionSchedule.No, No);

                if TransactionSchedule.Find('-') then
                    repeat

                        AddVarDN := 0;
                        AddVarDN := TransactionSchedule.Amount;
                        TotalDN := TotalDN + AddVarDN;
                    until TransactionSchedule.Next = 0;

                Transactions.Reset;
                if Transactions.Get(No) then begin
                    ;
                    Transactions."Schedule Amount" := TotalDN;
                    Transactions.Modify;
                end;
            end;
        }
        field(5; "Account Type"; Text[50])
        {
        }
        field(6; "Transfer By EFT"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(7; "External Account No"; Code[30])
        {
        }
        field(8; "Loan Deductions"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(9; "External Account Name"; Text[150])
        {
        }
        field(10; "Do Not Effect Deductions"; Boolean)
        {
        }
        field(11; Imported; Boolean)
        {
        }
        field(12; "Import Date"; Date)
        {
        }
        field(13; "EFT Amount"; Decimal)
        {
        }
        field(14; "Staff No"; Code[20])
        {
        }
        field(15; "Transferred TO EFT"; Boolean)
        {
        }
        field(16; "Date transferred"; Date)
        {
        }
        field(17; "Time Transferred"; Time)
        {
        }
        field(18; "Transferred By"; Code[20])
        {
        }
        field(19; "Bank Code"; Code[20])
        {
        }
        field(20; "New Import"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(21; "Staff / Payroll No"; Code[20])
        {
            trigger OnValidate()
            begin
                AccountHolders.Reset;
                AccountHolders.SetRange(AccountHolders."Staff No", "Staff / Payroll No");
                if AccountHolders.Find('-') then
                    "Account Name" := AccountHolders.Name;
            end;
        }
        field(22; "Savers Contribution"; Decimal)
        {
        }
        field(23; "Mustaafu Contribution"; Decimal)
        {
        }
        field(24; "Junior Star Contribution"; Decimal)
        {
        }
        field(25; "Contribution Total"; Decimal)
        {
        }
        field(26; "Savers Variance"; Decimal)
        {
        }
        field(27; "Mustaafu Variance"; Decimal)
        {
        }
        field(28; "Junior Star Variance"; Decimal)
        {
        }
        field(29; "Savers Base"; Decimal)
        {
        }
        field(30; "Mustaafu Base"; Decimal)
        {
        }
        field(31; "Junior Star Base"; Decimal)
        {
        }
        field(32; "Bosa Account No"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; No, "Account No")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    var
        AccountHolders: Record Vendor;
        TotalDN: Decimal;
        AddVarDN: Decimal;
        Transactions: Record Transactions;
        TransactionSchedule: Record "Transaction Schedule";
        LApplications: Record "Loans Register";
        LTypes: Record "Loan Products Setup";
}
