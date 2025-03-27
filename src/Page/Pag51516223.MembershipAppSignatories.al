#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516223 "Membership App Signatories"
{
    CardPageID = "Membership App Signatories";
    PageType = List;
    SourceTable = "Member App Signatories";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CUST.Reset;
                        CUST.SetRange(CUST."ID No.", "ID No.");
                        if CUST.Find('-') then begin
                            "BOSA No." := CUST."No.";
                            "Staff/Payroll" := CUST."Payroll/Staff No";
                            "Date Of Birth" := CUST."Date of Birth";
                            "Mobile No" := CUST."Mobile Phone No";
                            Modify;
                        end;
                    end;
                }
                field(Names; Names)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = false;
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Control1102760009; Signatory)
                {
                    ApplicationArea = Basic;
                }
                field("Must Sign"; "Must Sign")
                {
                    ApplicationArea = Basic;
                }
                field("Must be Present"; "Must be Present")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA No."; "BOSA No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Email Address"; "Email Address")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile No"; "Mobile No")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
            }
        }
        area(factboxes)
        {
        }
    }

    actions
    {
        area(navigation)
        {
        }
    }

    trigger OnOpenPage()
    begin
        // MemberApp.Reset;
        // MemberApp.SetRange(MemberApp."No.", "Account No");
        // if MemberApp.Find('-') then begin
        //     if MemberApp.Status = MemberApp.Status::Approved then begin
        //         CurrPage.Editable := false;
        //     end else
        //         CurrPage.Editable := true;
        // end;
    end;

    trigger OnInit()
    begin
    end;

    var
        MemberApp: Record "Membership Applications";
        ReltnShipTypeEditable: Boolean;
        CUST: Record Customer;
}
