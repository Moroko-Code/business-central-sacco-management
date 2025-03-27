#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516319 "Loan GuarantorsFOSA"
{
    fields
    {
        field(1; "Loan No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Absence Preferences"."Include Weekends";
        }
        field(2; "Account No."; Code[20])
        {
            NotBlank = true;
            //TableRelation = Table51516154.Field1;

            trigger OnValidate()
            begin
                /*TotalGuaranted := 0;

                Date:=TODAY;

                Members.RESET;
                Members.SETRANGE(Members."No.","Account No.");
                IF Members.FIND('-') THEN BEGIN
                Members.CALCFIELDS(Members."Current Shares");
                "Amount Guaranted":=Members."Current Shares";
                Names:=Members.Name;
                "Staff/Payroll No.":=Cust."Staff No";
                END;

                Cust.RESET;
                IF Cust.GET("Account No.") THEN BEGIN
                //IF Cust."Salary Processing" = FALSE THEN
                //ERROR('You can only select guarantors whose salary is processed throught the SACCO.');

                {IF LoanApp.GET("Loan No") THEN BEGIN
                IF (LoanApp."Loan Product Type" = 'FH LOAN') OR (LoanApp."Loan Product Type" = 'FH INST') THEN BEGIN
                GroupMember.RESET;
                GroupMember.SETRANGE(GroupMember."Account No.",LoanApp."BOSA No");
                GroupMember.SETRANGE(GroupMember."Member No.",Cust."BOSA Account No");
                IF GroupMember.FIND('-') = FALSE THEN BEGIN
                ERROR('Guarantors must be members of the group.');
                END;
                END;
                END;
                }
                END;

                //Check Max garantors
                LoansG:=0;
                LoanGuarantors.RESET;
                LoanGuarantors.SETRANGE(LoanGuarantors."Account No.","Account No.");
                IF LoanGuarantors.FIND('-') THEN BEGIN
                IF LoanGuarantors.COUNT > 4 THEN BEGIN
                REPEAT
                IF Loans.GET(LoanGuarantors."Loan No") THEN BEGIN
                Loans.CALCFIELDS(Loans."Outstanding Balance");
                IF Loans."Outstanding Balance" > 0 THEN
                LoansG:=LoansG+1;
                END;
                UNTIL LoanGuarantors.NEXT = 0;
                END;
                END;

                IF LoansG > 4 THEN BEGIN
                IF CONFIRM('Member has guaranteed more than 4 active loans. Do you wish to continue?',FALSE) = FALSE THEN BEGIN
                "Account No.":='';
                "Staff/Payroll No.":='';
                Names:='';
                EXIT;
                END;
                END;
                //Check Max garantors
                */
            end;
        }
        field(3; Names; Text[200])
        {
        }
        field(4; Signed; Boolean)
        {
        }
        field(5; "Amount Guaranted"; Decimal)
        {
        }
        field(6; "Distribution (%)"; Decimal)
        {
        }
        field(7; "Distribution (Amount)"; Decimal)
        {
        }
        field(8; "Staff/Payroll No."; Code[20])
        {
            trigger OnValidate()
            begin
                /*Cust.RESET;
                Cust.SETFILTER(Cust."Account Type",'PRIME|OMEGA|FAHARI');
                Cust.SETRANGE(Cust."Staff No","Staff/Payroll No.");
                IF Cust.FIND('-') THEN BEGIN
                "Account No.":=Cust."No.";
                VALIDATE("Account No.");
                END
                ELSE
                ERROR('Record not found.')
                 */
            end;
        }
        field(9; Substituted; Boolean)
        {
            trigger OnValidate()
            begin
                Date := Today;
            end;
        }
        field(10; "Line No"; Integer)
        {
        }
        field(11; Date; Date)
        {
        }
        field(12; "Self Guarantee"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Loan No", "Staff/Payroll No.", "Account No.", Signed, "Line No")
        {
            Clustered = true;
            SumIndexFields = "Amount Guaranted";
        }
        key(Key2; "Loan No", Signed)
        {
            SumIndexFields = "Amount Guaranted";
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Vendor;
        LoanGuarantor: Record "Loans Register";
        LoanApp: Record "Loans Register";
        TotalGuaranted: Decimal;
        LoansG: Integer;
        LoanGuarantors: Record "Loans Register";
        Loans: Record "Loans Register";
        Members: Record Customer;
}
