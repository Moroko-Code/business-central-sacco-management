#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 51516102 "Import Checkoff Distributed"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Checkoff Lines-Distributed"; "Checkoff Lines-Distributed")
            {
                XmlName = 'Paybill';
                fieldelement(Header_No; "Checkoff Lines-Distributed"."Receipt Header No")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Entry_No; "Checkoff Lines-Distributed"."Entry No")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Dept; "Checkoff Lines-Distributed".DEPT)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Personal_No; "Checkoff Lines-Distributed"."Staff/Payroll No")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Account_Type; "Checkoff Lines-Distributed"."Account type")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Reference; "Checkoff Lines-Distributed".Reference)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Amount; "Checkoff Lines-Distributed".Amount)
                {
                    MinOccurs = Zero;
                }
                fieldelement(EmployerCode; "Checkoff Lines-Distributed"."Employer Code")
                {
                    MinOccurs = Zero;
                }
            }
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }
}
