#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 51516100 "Import Checkoff Block"
{
    Format = VariableText;
    schema
    {
        textelement(root)
        {
            //MinOccurs = Zero;
            tableelement("ReceiptsProcessing_L-Checkoff"; "ReceiptsProcessing_L-Checkoff")
            {
                XmlName = 'checkoff';
                fieldelement(Transaction_No; "ReceiptsProcessing_L-Checkoff"."Receipt Line No")
                {
                    MinOccurs = Zero;
                }
                fieldelement(No; "ReceiptsProcessing_L-Checkoff"."Receipt Header No")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Mobile_No; "ReceiptsProcessing_L-Checkoff"."Staff/Payroll No")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Amount; "ReceiptsProcessing_L-Checkoff".Amount)
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
