#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516246 "Loan Appraisal Salary Details"
{
    PageType = List;
    SourceTable = "Loan Appraisal Salary Details";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Appraisal Type"; "Appraisal Type")
                {
                    ApplicationArea = Basic;
                }
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //**Prevent modification of approved entries
        LoanApps.Reset;
        LoanApps.SetRange(LoanApps."Loan  No.", "Loan No");
        if LoanApps.Find('-') then
            if LoanApps."Approval Status" = LoanApps."approval status"::Approved then
                CurrPage.Editable := false
            else
                CurrPage.Editable := true;
    end;

    var
        LoanApps: Record "Loans Register";
}
