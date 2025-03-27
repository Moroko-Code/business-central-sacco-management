#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516232 "Loan Appraisal Salary Details"
{
    fields
    {
        field(1; "Client Code"; Code[20])
        {
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = if ("Appraisal Type" = const(Salary)) "Appraisal Salary Set-up" where(Type = filter(Earnings | Deductions ));

            trigger OnValidate()
            begin
                if "SalarySet-up".Get(Code) then begin
                    Description := "SalarySet-up".Description;
                    Type := "SalarySet-up".Type;
                    Statutory := "SalarySet-up"."Statutory Ded";
                    "Statutory Amount" := "SalarySet-up"."Statutory Amount";
                    Amount := "Statutory Amount";
                    "Long Term Deduction" := "SalarySet-up"."Long Term Deductions";
                end;

                if "SalarySet-up".Get(Code) then
                    if "SalarySet-up"."Statutory(%)" <> 0 then
                        if Code = '001' then
                            Amount := "SalarySet-up"."Statutory(%)" * Amount;
            end;
        }
        field(3; Description; Text[30])
        {
        }
        field(4; Type; Option)
        {
            OptionCaption = ' ,Earnings,Deductions,Basic,Asset,Liability,Rental,Farming';
            OptionMembers = " ",Earnings,Deductions,Basic,Asset,Liability,Rental,Farming;
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Loan No"; Code[20])
        {
            TableRelation = "Loans Register";
        }
        field(7; Statutory; Boolean)
        {
        }
        field(8; "Statutory Amount"; Decimal)
        {
        }
        field(9; "Long Term Deduction"; Boolean)
        {
        }
        field(10; Basic; Boolean)
        {
        }
        field(11; Basic1; Integer)
        {
        }
        field(12; "Appraisal Type"; Option)
        {

            OptionMembers = " ",Salary;
            InitValue = Salary;
        }
    }

    keys
    {
        key(Key1; "Loan No", "Client Code", "Code")
        {
            Clustered = true;
        }
        key(Key2; "Code", "Client Code", Type)
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    var
        "SalarySet-up": Record "Appraisal Salary Set-up";
}
