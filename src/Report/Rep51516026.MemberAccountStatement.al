report 51516026 "Member Account Statement"
{
    ApplicationArea = All;
    Caption = 'Member Account Statement';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/MemberAccountStatement.rdlc';
    dataset
    {
        dataitem(MembersRegister; Customer)
        {
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
}
