report 51516033 "Member Shares Status"
{
    ApplicationArea = All;
    Caption = 'Member Shares Status';
    UsageCategory = Lists;
    RDLCLayout = './Layouts/MemberSharesStatus.rdlc';
    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPic; CompanyInfo.Picture)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(Name; Name)
            {
            }
            column(No; "No.")
            {
            }
            // column(FosaShares; "Fosa Shares")
            // {
            // }
            // column(ComputerShares; "Computer Shares")
            // {
            // }
            // column(BuildingShares; BuildingShares)
            // {
            // }
            // column(PepeaShares; "Pepea Shares")
            // {
            // }
            trigger OnAfterGetRecord()
            begin
                // MembersReg.Reset();
                // MembersReg.SetRange(MembersReg."No.", Customer."No.");
                // if MembersReg.Find('-') then begin
                //     Vendor.Reset();
                //     Vendor.SetRange(Vendor."No.", MembersReg."No.");
                //     if Vendor.Find('-') then begin

                //     end;
                // end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnInitReport()
    begin
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
    end;

    var
        CompanyInfo: Record "Company Information";
}
