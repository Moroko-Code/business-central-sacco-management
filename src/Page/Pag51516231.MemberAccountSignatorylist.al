#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516231 "Member Account Signatory list"
{
    PageType = List;
    SourceTable = "Member Account Signatories";
    Editable = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Names; Names)
                {
                    ApplicationArea = Basic;
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
                            Modify;
                        end;
                    end;
                }
                field("Staff/Payroll"; "Staff/Payroll")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff/Payroll No';
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
                field("Expiry Date"; "Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA No."; "BOSA No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Email Address"; "Email Address")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            // group(Signatory)
            // {
            //     Caption = 'Signatory';
            //     action("Page Account Signatories Card")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Card';
            //         Image = EditLines;
            //         RunObject = Page "Member Account Signatory Card";
            //         RunPageLink = "Account No"=field("Account No"),
            //                       Names=field(Names);
            //     }
            // }
        }
    }

    trigger OnOpenPage()
    begin
        MemberApp.Reset;
        MemberApp.SetRange(MemberApp."No.", "Account No");
        if MemberApp.Find('-') = true then begin
            if MemberApp.Status = (MemberApp.Status::Approved) then
                CurrPage.Editable := false
            else
                if MemberApp.Status = (MemberApp.Status::Closed) then
                    CurrPage.Editable := false
                else
                    if MemberApp.Status = (MemberApp.Status::Open) then
                        CurrPage.Editable := true
                    else
                        if MemberApp.Status = (MemberApp.Status::Pending) then
                            CurrPage.Editable := false;
        end else
            CurrPage.Editable := true;
    end;

    var
        MemberApp: Record "Membership Applications";
        ReltnShipTypeEditable: Boolean;
        CUST: Record Customer;
}
