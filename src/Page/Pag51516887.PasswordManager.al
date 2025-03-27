page 51516887 "Password Manager"
{
    ApplicationArea = All;
    Caption = 'Password Manager';
    PageType = List;
    SourceTable = "Password Manager";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(MemberNo; Rec.MemberNo)
                {
                    ToolTip = 'Specifies the value of the MemberNo field.', Comment = '%';
                }
                field(MemberName; Rec.MemberName)
                {
                    ToolTip = 'Specifies the value of the MemberName field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field(Activated; Rec.Activated)
                {
                    ToolTip = 'Specifies the value of the Activated field.', Comment = '%';
                }
                field(Username; Rec.Username)
                {
                    ToolTip = 'Specifies the value of the Username field.', Comment = '%';
                }
                field(OTP; Rec.OTP)
                {
                    ToolTip = 'Specifies the value of the OTP field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
            }
        }
    }
}
