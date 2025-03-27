Table 51516231 "Loans Guarantee Details"
{
    LookupPageId = "Loans Guarantee Details";
    DrillDownPageId = "Loans Guarantee Details";
    fields
    {
        field(1; "Loan No"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No.";

            NotBlank = true;
        }
        field(2; "Member No"; Code[20])
        {
            TableRelation = Customer."No." where(Status = const(Active));
            NotBlank = true;
        }
        field(3; Name; Text[200])
        {
            Editable = false;
        }
        field(5; Shares; Decimal)
        {
            Editable = false;
        }
        field(6; "No Of Loans Guaranteed"; Integer)
        {
        }
        field(7; Substituted; Boolean)
        {
            trigger OnValidate()
            begin
                TestField("Substituted Guarantor");
            end;
        }
        field(8; Date; Date)
        {
        }
        field(9; "Shares Recovery"; Boolean)
        {
        }
        field(10; "New Upload"; Boolean)
        {
        }
        field(11; "Amont Guaranteed"; Decimal)
        {
            trigger OnValidate()
            begin

                // Reset;
                // LoanApp.Reset;
                // LoanApp.SetRange(LoanApp."Loan  No.", "Loan No");
                // if LoanApp.Find('-') then begin
                //     "Amount Committed" := "Amont Guaranteed";
                if Loans.Get("Loan No") then
                    "% Proportion" := ("Amont Guaranteed" / Loans."Requested Amount") * 100;
            end;

            // end;
        }
        field(12; "Staff/Payroll No."; Code[20])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(13; "Account No."; Code[20])
        {
        }
        field(14; "Self Guarantee"; Boolean)
        {
        }
        field(15; "ID No."; Code[50])
        {
        }
        field(16; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan No"),
                                                        "Transaction Type" = filter(Loan | Repayment),
                                                              "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(17; "Total Loans Guaranteed"; Decimal)
        {
            FieldClass = Normal;
        }
        field(18; "Loans Outstanding"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter(Loan | Repayment),
                                                                  "Customer No." = field("Member No")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                // "Total Loans Guaranteed" := "Outstanding Balance";
                // Modify;
            end;
        }
        field(19; "Guarantor Outstanding"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Member No"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(20; "Employer Code"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(21; "Employer Name"; Text[100])
        {
        }
        field(22; "Substituted Guarantor"; Code[80])
        {
            TableRelation = Customer."No.";
        }
        field(23; "Loanees  No"; Code[30])
        {

            TableRelation = "Loans Register"."Client Code";
        }
        field(24; "Loanees  Name"; Text[80])
        {
        }
        field(25; "Member Guaranteed"; Code[50])
        {
            Enabled = false;
        }
        field(26; "Telephone No"; Code[10])
        {
        }
        field(27; "Cummulative Shares"; Decimal)
        {
        }
        field(28; "Cummulative Shares2"; Decimal)
        {
        }
        field(29; "Loan amount"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan No"),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(30; "Amount Committed"; Decimal)
        {
        }
        field(31; "% Proportion"; Decimal)
        {
        }
        field(32; "Amount Released"; Decimal)
        {
        }
        field(33; Signed; Boolean)
        {
        }
        field(34; "Distribution %"; Decimal)
        {
        }
        field(35; "Distribution Amount"; Decimal)
        {
        }
        field(36; "Group Account No."; Code[50])
        {
        }
        field(38; "Acceptance Status"; Option)
        {
            OptionMembers = Pending,Accepted,Declined;
            OptionCaption = 'Pending, Accepted, Declined';
        }
        field(37; "Total Amount Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Loan No" = field("Loan No"),
                                                                                  Substituted = const(false)));
            FieldClass = FlowField;
        }
        field(39; "Free Shares"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; LoanCount; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Loan No" = field("Loan No")));
            FieldClass = FlowField;
        }
        field(41; "Transferable shares"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53099; "Date filter"; Date)
        {
            FieldClass = FlowFilter;
        }
      
    }

    keys
    {
        key(Key1; "Loan No", "Member No")
        {
            Clustered = true;
            SumIndexFields = Shares;
        }
        key(key2; "Member No")
        {
        }
    }

    fieldgroups
    {
    }
    var
        Loans: Record "Loans Register";
}
