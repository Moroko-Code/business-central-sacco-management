#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516498 "lead card closed"
{
    DeleteAllowed = false;
    ModifyAllowed = false;
    Editable = false;
    PageType = Card;
    InsertAllowed = false;
    SourceTable = "General Equiries.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Enquiring As"; "Calling As")
                {
                    ApplicationArea = Basic;
                    Caption = 'Enquiring As';
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        if "Calling As" = "calling as"::"As Member" then begin
                            Asmember := true;
                            AsEmployer := true;
                            Ascase := true;
                            IfMember := true;
                            CurrPage.Update();
                        end;
                        if "Calling As" = "calling as"::"As Non Member" then begin
                            AsNonmember := true;
                            IfMember := false;
                            Asother := true;
                            CurrPage.Update();
                        end;
                        if "Calling As" = "calling as"::"As Staff" then begin
                            AsEmployer := true;
                            Asother := true;
                            Ascase := true;
                            IfMember := false;
                            CurrPage.Update();
                        end;
                    end;
                }
                field("Enquiring For"; "Calling For")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Contact Mode"; "Contact Mode")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Case Subject"; "Case Subject")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Lead Status"; "Lead Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured On"; "Captured On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Lead Details")
            {
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Enabled = IfMember;
                    trigger OnValidate()
                    var
                        cust: Record customer;
                        LoansReg: Record "Loans Register";
                    begin
                        cust.Reset();
                        cust.SetRange(cust."No.", "Member No");
                        if cust.Find('-') then begin
                            "Member Name" := cust.Name;
                            "ID No" := cust."ID No.";
                            "ID No." := cust."ID No.";
                            "Phone No" := cust."Mobile Phone No";
                            Email := cust."E-Mail (Personal)";
                            "Date Of Birth" := cust."Date of Birth";
                            Gender := cust.Gender;
                        end;
                    end;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Full Name';
                    ShowMandatory = true;
                }
                field("Phone No"; "Phone No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No';
                    ShowMandatory = true;
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Of Birth';
                    ShowMandatory = true;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Email; Email)
                {
                    ApplicationArea = Basic;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No';
                    ShowMandatory = true;
                }
                field("Escalate Case;"; EscalateCase)
                {
                    ApplicationArea = Basic;
                    Caption = 'Escalate Case';
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        if EscalateCase = true then
                            IsEscalated := true
                        else
                            if EscalateCase = false then
                                IsEscalated := false;
                    end;
                }
            }
            group("Case Description;")
            {
                Caption = 'Case Description';
                Visible = IsEscalated;
                field("Case Details"; "Case Details")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                    end;
                }
                field("Caller Reffered To"; "Caller Reffered To")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
            }
            group("Case Resolution Details")
            {
                field("Resolution Details"; "Resolution Details")
                {
                    ShowMandatory = true;
                }
                field("Resolved by"; "Resolved by")
                {
                    Enabled = false;
                    Style = Favorable;
                }
                field("Resolved Time"; "Resolved Time")
                {
                    Enabled = false;
                    Style = Favorable;
                }
                field("Resolved Date"; "Resolved Date")
                {
                    Enabled = false;
                    Style = Favorable;
                }
            }
        }
        area(factboxes)
        {
            part("Member Statistics FactBox"; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Member No");
            }
        }
    }

    // actions
    // {
    //     area(creation)
    //     {
    //         action("Email Escalted")
    //         {
    //             ApplicationArea = Basic;
    //             Promoted = true;
    //             Image = Email;
    //             PromotedIsBig = true;
    //             PromotedOnly = true;
    //             Caption = 'Attach Email To Delegate';
    //             PromotedCategory = process;
    //             RunObject = page "Email Editor";
    //             Enabled = IsEscalated;
    //             trigger OnAction()
    //             begin

    //             end;
    //         }
    //         action("Create ")
    //         {
    //             ApplicationArea = Basic;
    //             Caption = 'Forward Case';
    //             Image = FixedAssetLedger;
    //             Promoted = true;
    //             PromotedIsBig = true;
    //             PromotedOnly = true;
    //             Enabled = IsEscalated;
    //             PromotedCategory = Process;

    //             trigger OnAction()
    //             begin

    //             end;
    //         }
    //         action("Close Case;")
    //         {
    //             ApplicationArea = Basic;
    //             Promoted = true;
    //             Image = Email;
    //             PromotedIsBig = true;
    //             PromotedOnly = true;
    //             Caption = 'Close Case';
    //             PromotedCategory = process;
    //             Enabled = false;
    //             trigger OnAction()
    //             begin
    //                 if (UserId = "Captured By") or (UserId = "Delegated To") then begin
    //                 end else begin
    //                     Error('Only the staff who opened the case or case delegated to can close this ticket');
    //                 end;
    //                 //--------------------------------------------------------------------
    //                 if Confirm('Are you sure to Mark this ticket as resolved?', false) = false then begin
    //                     Message('Action Cancelled !');
    //                     exit;
    //                 end else begin
    //                     Status := Status::Resolved;
    //                     "Lead Status" := "Lead Status"::Closed;
    //                     "Resolved by" := UserId;
    //                     "Resolved Date" := today;
    //                     "Resolved Time" := time;
    //                     "Date Resolved" := today;
    //                     "Time Resolved" := time;
    //                     Modify(true);
    //                     //....................................................
    //                     //Send sms of case resolution
    //                     FnSendSMS();
    //                 end;

    //             end;
    //         }
    //         action("Open Member Page")
    //         {
    //             ApplicationArea = Basic;
    //             Promoted = true;
    //             Image = Card;
    //             PromotedIsBig = true;
    //             PromotedOnly = true;
    //             Caption = 'Open Member Page';
    //             PromotedCategory = process;
    //             RunObject = page "Member Account Card";
    //             Enabled = IsEnabled;
    //             trigger OnAction()
    //             begin

    //             end;
    //         }
    //         action("FOSA Statement")
    //         {
    //             ApplicationArea = Basic;
    //             Promoted = true;
    //             Image = Report;
    //             PromotedIsBig = true;
    //             PromotedOnly = true;
    //             Caption = 'FOSA Statement';
    //             PromotedCategory = process;
    //             Enabled = IsEnabled;
    //             trigger OnAction()
    //             var
    //                 VendorTable: Record Vendor;
    //             begin
    //                 VendorTable.Reset();
    //                 VendorTable.SetRange(VendorTable."No.", "Fosa account");
    //                 if VendorTable.Find('-') = true then begin
    //                     Report.Run(51516248, true, false, VendorTable);
    //                 end else
    //                     if VendorTable.Find('-') = false then begin
    //                         Error('There is No FOSA Account associated with this client');
    //                     end
    //             end;
    //         }
    //     }
    // }

    trigger OnAfterGetRecord()
    begin
        if Status = Status::Resolved then begin
            CurrPage.Editable := false;
            IsEnabled := false;
        end else
            if Status <> Status::Resolved then
                IsEnabled := true;
        if "Calling As" = "calling as"::"As Member" then begin
            Asmember := true;
            AsEmployer := true;
            Ascase := true;
            IfMember := true;
        end;
        if "Calling As" = "calling as"::"As Non Member" then begin
            AsNonmember := true;
            IfMember := false;
            Asother := true;
        end;
        if "Calling As" = "calling as"::"As Staff" then begin
            AsEmployer := true;
            Asother := true;
            Ascase := true;
            IfMember := false;
        end;
        if EscalateCase = true then
            IsEscalated := true
        else
            if EscalateCase = false then
                IsEscalated := false;
    end;

    trigger OnOpenPage()
    begin
        AsEmployer := false;
        Asmember := false;
        AsNonmember := false;
        Asother := false;
        Ascase := false;

        if "Calling As" = "calling as"::"As Non Member" then begin
            AsNonmember := true;
            Asother := true;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if Status = Status::Resolved then
            CurrPage.Editable := false;
    end;

    procedure FnSendSMS()
    var
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
    begin
        SMSMessages.RESET;
        IF SMSMessages.FIND('+') THEN BEGIN
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        END
        ELSE
            iEntryNo := 1;

        SMSMessages.RESET;
        SMSMessages.INIT;
        SMSMessages."Entry No" := iEntryNo;
        IF "Member No" <> '' THEN
            SMSMessages."Account No" := "Member No"
        else
            IF "Member No" = '' THEN
                SMSMessages."Account No" := 'NON-MEMBER';
        SMSMessages."Date Entered" := TODAY;
        SMSMessages."Time Entered" := TIME;
        SMSMessages.Source := 'CRM';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
        SMSMessages."SMS Message" := 'Good news! Your query has been resolved. If you have any more concerns or require further assistance, please feel free to contact us.Thank you for being a valued member. Jamii Yetu Sacco.';
        SMSMessages."Telephone No" := "Phone No";
        SMSMessages.INSERT;
    end;

    var
        Cust: Record Customer;
        IfMember: Boolean;
        CustCare: Record "General Equiries.";
        CQuery: Record "General Equiries.";
        employer: Record "Sacco Employers";
        LeadM: Record "Lead Management";
        entry: Integer;
        IsEscalated: Boolean;
        vend: Record Vendor;
        AsEmployer: Boolean;
        Asmember: Boolean;
        AsNonmember: Boolean;
        Asother: Boolean;
        EscalateCase: Boolean;
        Ascase: Boolean;
        ok: Boolean;
        LeadSetup: Record "Crm General Setup.";
        LeadNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CaseNO: Code[20];
        CaseSetup: Record "Crm General Setup.";
        sure: Boolean;
        IsEnabled: Boolean;
        EmploymentInfoEditable: Boolean;
        EmployedEditable: Boolean;
        ContractingEditable: Boolean;
        NatureofBussEditable: Boolean;
        IndustryEditable: Boolean;
        BusinessNameEditable: Boolean;
        PhysicalBussLocationEditable: Boolean;
        YearOfCommenceEditable: Boolean;
        FromDisplayName: Text[100];
        ToRecipient: Text[100];
        EmailBody: Text;

        CcRecipient: Text[1000];
        PositionHeldEditable: Boolean;
        EmploymentDateEditable: Boolean;
        EmployerAddressEditable: Boolean;
        EmployerCodeEditable: Boolean;
        DepartmentEditable: Boolean;
        EmailSubject: text[1000];
        TermsofEmploymentEditable: Boolean;
        OccupationEditable: Boolean;
        OthersEditable: Boolean;
        MonthlyIncomeEditable: Boolean;
}
