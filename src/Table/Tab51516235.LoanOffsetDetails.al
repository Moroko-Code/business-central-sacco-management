#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516235 "Loan Offset Details"
{
    // DrillDownPageID = "Payroll Employee List";
    // LookupPageID = "Payroll Employee List";

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(2; "Loan Top Up"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Client Code"),
                                                                Posted = const(true));
            // "Outstanding Balance" = filter(> 0));

            trigger OnValidate()

            var
                DateFilter: Date;

                Bloan: Record "Loans Register";
            begin
                if Confirm('Are you Sure you Want to Offset this loan?', true) = true then begin
                    Bloan.Get("Loan No.");
                    DateFilter := Bloan."Application Date";
                    "Loan Type" := '';
                    "Principle Top Up" := 0;
                    "Interest Top Up" := 0;
                    "Total Top Up" := 0;
                    Loantypes.Reset;
                    Loantypes.SetRange(Loantypes.Code, "Loan Type");

                    Loans.Reset;
                    Loans.SetRange(Loans."Loan  No.", "Loan Top Up");
                    Loans.SetRange("Date filter", 0D, DateFilter);
                    if Loans.Find('-') then begin
                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due");
                        "Loan Type" := Loans."Loan Product Type";
                        if Cust.Get(Loans."Account No") then begin
                            "ID. NO" := Cust."ID No.";
                            "Staff No" := Cust."Payroll/Staff No";
                        end;

                        "Principle Top Up" := Loans."Outstanding Balance";

                        "Total Top Up" := "Principle Top Up";// +"Interest Top Up";
                        "Monthly Repayment" := Loans.Repayment;
                        //GenSetUp.GET();

                        if Loantypes.Get("Loan Type") then
                            Commision := ("Principle Top Up") * (Loantypes."Top Up Commision" / 100);
                        "Total Top Up" := "Principle Top Up" + "Interest Top Up" + Commision;
                    end;

                    Loans.Bridged := true;
                    Loans.Modify
                end;
            end;
        }
        field(3; "Client Code"; Code[20])
        {
        }
        field(4; "Loan Type"; Code[20])
        {
        }
        field(5; "Principle Top Up"; Decimal)
        {
            trigger OnValidate()

            begin





                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.", "Loan Top Up");

                if Loans.Find('-') then
                    Loans.CalcFields(Loans."Outstanding Balance");
                GenSetUp.Get();
                Commision := ROUND(("Principle Top Up") * (Loantypes."Top Up Commision" / 100), 1, '>');
                "Total Top Up" := "Principle Top Up" + Commision;
            end;
        }
        field(6; "Interest Top Up"; Decimal)
        {
            trigger OnValidate()
            begin
                "Total Top Up" := "Principle Top Up" + "Interest Top Up" + Commision;
            end;
        }
        field(7; "Total Top Up"; Decimal)
        {
        }
        field(8; "Monthly Repayment"; Decimal)
        {
        }
        field(9; "Interest Paid"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Client Code"),
                                                                  "Loan No" = field("Loan Top Up"),
                                                                  "Transaction Type" = filter("Interest Paid")));
            FieldClass = FlowField;
        }
        field(10; "Outstanding Balance"; Decimal)
        {
            FieldClass = Normal;
        }
        field(11; "Interest Rate"; Decimal)
        {
            CalcFormula = sum("Loans Register".Interest where("Loan  No." = field("Loan Top Up"),
                                                               "Client Code" = field("Client Code")));
            FieldClass = FlowField;
        }
        field(12; "ID. NO"; Code[20])
        {
        }
        field(13; Commision; Decimal)
        {
            trigger OnValidate()
            begin
                "Total Top Up" := "Principle Top Up" + "Interest Top Up" + Commision;
            end;
        }
        field(14; "Partial Bridged"; Boolean)
        {
            trigger OnValidate()
            begin

                LoansTop.Reset;
                LoansTop.SetRange(LoansTop."Loan  No.", "Loan Top Up");
                if LoansTop.Find('-') then begin
                    if "Partial Bridged" = true then
                        LoansTop."partially Bridged" := true;
                    LoansTop.Modify;
                end;
            end;
        }
        field(15; "Remaining Installments"; Decimal)
        {
        }
        field(16; "Finale Instalment"; Decimal)
        {
        }
        field(17; "Penalty Charged"; Decimal)
        {
        }
        field(18; "Outstanding Interest"; Decimal)
        {
        }
        field(20; "Staff No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Client Code", "Loan Top Up")
        {
            Clustered = true;
            SumIndexFields = "Total Top Up", "Principle Top Up";
        }
        key(Key2; "Principle Top Up")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Client Code", "Loan Type", "Principle Top Up", "Interest Top Up", "Total Top Up", "Monthly Repayment", "Interest Paid", "Outstanding Balance", "Interest Rate", Commision)
        {
        }
    }

    var
        Loans: Record "Loans Register";
        Loantypes: Record "Loan Products Setup";
        Interest: Decimal;
        Cust: Record Customer;
        LoansTop: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
}
