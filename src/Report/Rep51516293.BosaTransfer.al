#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516293 "Bosa Transfer"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Bosa Transfer.rdlc';

    dataset
    {
        dataitem("BOSA Transfers"; "BOSA Transfers")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(No; "BOSA Transfers".No)
            {
            }
            column(Remarks; "BOSA Transfers".Remarks)
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(Total; "BOSA Transfers"."Schedule Total")
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            dataitem("BOSA Transfer Schedule"; "BOSA Transfer Schedule")
            {
                DataItemLink = "No." = field(No);
                column(ReportForNavId_1000000003; 1000000003)
                {
                }
                column(nO2; "BOSA Transfer Schedule"."No.")
                {
                }
                column(Source_Type; "Source Type")
                {
                }
                column(SourceAccount; "Source Account No.")
                {
                }
                column(Source_Name; "Source Account Name")
                {
                }
                column(Amount; "BOSA Transfer Schedule".Amount)
                {
                }
                column(Destination; "BOSA Transfer Schedule"."Destination Account Type")
                {
                }
                column(Name; "BOSA Transfer Schedule"."Destination Account Name")
                {
                }
                column(Loan; "BOSA Transfer Schedule"."Destination Loan")
                {
                }
                column(Destination_No; "BOSA Transfer Schedule"."Destination Account No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CheckReport.InitTextVariable();
                //CheckReport.FormatNoText(NumberText,("Schedule Total"),'');
            end;
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

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        CheckReport: Report Check;
        NumberText: Text[80];
}
