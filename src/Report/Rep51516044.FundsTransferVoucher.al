#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516044 "Funds Transfer Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Funds Transfer Voucher.rdlc';

    dataset
    {
        dataitem("Funds Transfer Header"; "Funds Transfer Header")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(No; "Funds Transfer Header"."No.")
            {
            }
            column(Dated; "Funds Transfer Header"."Paying Bank Account")
            {
            }
            column(ChequeNo; "Funds Transfer Header"."Cheque/Doc. No")
            {
            }
            column(PayingAcc; "Funds Transfer Header"."Paying Bank Account")
            {
            }
            column(AccName; "Funds Transfer Header"."Paying Bank Name")
            {
            }
            column(PostingDate_FundsTransferHeader; "Funds Transfer Header"."Posting Date")
            {
            }
            column(PostedBy_FundsTransferHeader; "Funds Transfer Header"."Posted By")
            {
            }
            column(CName; CompanyInfo.Name)
            {
            }
            column(CAddress; CompanyInfo.Address)
            {
            }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            dataitem("Funds Transfer Line"; "Funds Transfer Line")
            {
                DataItemLink = "Document No" = field("No.");
                column(ReportForNavId_6; 6)
                {
                }
                column(RecAcc; "Funds Transfer Line"."Receiving Bank Account")
                {
                }
                column(RecAccName; "Funds Transfer Line"."Bank Name")
                {
                }
                column(AmountReceived; "Funds Transfer Line"."Amount to Receive")
                {
                }
                column(ext; "Funds Transfer Line"."External Doc No.")
                {
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

    labels
    {
    }

    trigger OnPreReport()
    begin
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        CI: Record "Company Information";
}
