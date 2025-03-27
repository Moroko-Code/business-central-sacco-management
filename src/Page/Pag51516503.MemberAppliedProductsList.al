page 51516503 "Member Applied Products List"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Member Applied Products List';
    Editable = true;
    PageType = List;
    QueryCategory = 'Member Applied Products List';
    SourceTable = "Membership Applied Products";
    UsageCategory = Lists;
    AboutTitle = 'About Member Applied Products List';
    AboutText = 'Here you overview all Member Applied Products List currently under application status';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Membership Applicaton No"; Rec."Membership Applicaton No")
                {
                    ApplicationArea = All;
                    ToolTip = '';
                    Editable = false;
                    //autofill the other related fields when one chooses "Membership Applicaton No" start
                    trigger OnValidate()
                    begin
                        if MembershipApplications.Get(Rec."Membership Applicaton No") then begin
                            Rec."Applicant ID" := MembershipApplications."ID No.";
                            Rec."Applicant Name" := MembershipApplications.Name;
                        end;
                    end;
                    //autofill the other related fields when one chooses "Membership Applicaton No" end
                }
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Code of the product applied';
                    //autofill the other related fields when one chooses product code start
                    trigger OnValidate()
                    begin
                        if RegisteredProducts.Get(Rec."Product Code") then
                            if RegisteredProducts."Default Account" = false then
                                Rec."Product Name" := RegisteredProducts.Description;
                        if MembershipApplications.Get(Rec."Membership Applicaton No") then begin
                            Rec."Applicant ID" := MembershipApplications."ID No.";
                            Rec."Applicant Name" := MembershipApplications.Name;
                        end;
                    end;
                    //autofill the other related fields when one chooses product code end
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the product applied';
                    Editable = true;
                }
                field("Applicant ID"; Rec."Applicant ID")
                {
                    ApplicationArea = All;
                    ToolTip = '';
                    Editable = false;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                    ToolTip = '';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        RegisteredProducts: Record "Account Types-Saving Products";
        MembershipApplications: Record "Membership Applications";
}