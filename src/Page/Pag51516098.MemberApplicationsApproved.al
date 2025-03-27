page 51516098 "Member Applications -Approved"
{
    ApplicationArea = Basic;
    CardPageID = "Membership Application Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";
    SourceTableView = where(Status = const(approved));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }

                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Centre"; "Responsibility Centre")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll/Staff No"; "Payroll/Staff No")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No.";"Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Category")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; "User ID")
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
            group("Function")
            {
                Caption = 'Function';
                action("Next of Kin")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next of Kin';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Membership App Kin Details";
                    RunPageLink = Name = const('name');
                }
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Membership App Signatories";
                    RunPageLink = "Account No" = field("No.");
                }
                separator(Action1102755012)
                {
                    Caption = '-';
                }
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::"Account Opening";
                        ApprovalEntries.SetRecordFilters(Database::"Membership Applications", DocumentType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
                separator(Action1102755004)
                {
                    Caption = '       -';
                }
                action("Create Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Account';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin

                        if Confirm('Are you sure you want to approve account application?', false) = true then begin

                            if "ID No." <> '' then begin
                                Cust.Reset;
                                Cust.SetRange(Cust."ID No.", "ID No.");
                                Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                                if Cust.Find('-') then
                                    if Cust."No." <> "No." then
                                        Error('Member has already been created');
                            end;

                            if Status <> Status::Approved then
                                Error('This application has not been approved');

                            //IF UPPERCASE("Sent for Approval By")=UPPERCASE(USERID) THEN
                            //.ERROR('Operation denied');

                            //Create BOSA account
                            Cust."No." := '';
                            Cust.Name := Name;
                            Cust.Address := Address;
                            Cust."Home Town":= "Home Town";
                            Cust."Current Residence" := "Current Residence";
                            Cust."Phone No." := "Phone No.";
                            Cust."Global Dimension 1 Code" := "Global Dimension 1 Code";
                            Cust."Global Dimension 2 Code" := "Global Dimension 2 Code";
                            Cust."Registration Date" := "Registration Date";
                            Cust.Status := Cust.Status::Active;
                            Cust."Employer Code" := "Employer Code";
                            Cust."Date of Birth" := "Date of Birth";
              
                            Cust.Location := Location;
                            Cust."Home county" := "Home County";
                            Cust."Sub-county" := "Sub-county";
                            Cust."Payroll/Staff No" := "Payroll/Staff No";
                            Cust."ID No." := "ID No.";
                            Cust."Marital Status" := "Marital Status";
                            Cust."Customer Type" := Cust."customer type"::Member;
                            Cust.Gender := Gender;
     
                            Cust.Signature := Signature;
                            Cust."Monthly Contribution" := "Monthly Contribution";
                            Cust."Contact Person" := "Contact Person";
                            Cust."Contact Person Phone" := "Contact Person Phone";
                            Cust."ContactPerson Relation" := "ContactPerson Relation";
                            Cust."Recruited By" := "Recruited By";
                            Cust."ContactPerson Occupation" := "ContactPerson Occupation";
                           
                            Cust.Insert(true);
                            BOSAACC := Cust."No.";

                            NextOfKinApp.Reset;
                            NextOfKinApp.SetRange(NextOfKinApp."Account No", "No.");
                            if NextOfKinApp.Find('-') then
                                repeat
                                    NextOfKin.Init;
                                    NextOfKin."Account No" := BOSAACC;
                                    NextOfKin.Name := NextOfKinApp.Name;
                                    NextOfKin.Relationship := NextOfKinApp.Relationship;
                                    NextOfKin.Beneficiary := NextOfKinApp.Beneficiary;
                                    NextOfKin."Date of Birth" := NextOfKinApp."Date of Birth";
                                    NextOfKin.Address := NextOfKinApp.Address;
                                    NextOfKin.Telephone := NextOfKinApp.Telephone;
                                    NextOfKin.Email := NextOfKinApp.Email;
                                    NextOfKin."ID No." := NextOfKinApp."ID No.";
                                    NextOfKin."%Allocation" := NextOfKinApp."%Allocation";
                                    NextOfKin.Insert;
                                until NextOfKinApp.Next = 0;

                            AccountSignApp.Reset;
                            AccountSignApp.SetRange(AccountSignApp."Account No", "No.");
                            if AccountSignApp.Find('-') then
                                repeat
                                    AccountSign.Init;
                                    AccountSign."Account No" := AcctNo;
                                    AccountSign.Names := AccountSignApp.Names;
                                    AccountSign."Date Of Birth" := AccountSignApp."Date Of Birth";
                                    AccountSign."Staff/Payroll" := AccountSignApp."Staff/Payroll";
                                    AccountSign."ID No." := AccountSignApp."ID No.";
                                    AccountSign.Signatory := AccountSignApp.Signatory;
                                    AccountSign."Must Sign" := AccountSignApp."Must Sign";
                                    AccountSign."Must be Present" := AccountSignApp."Must be Present";
                                    AccountSign.Picture := AccountSignApp.Picture;
                                    AccountSign.Signature := AccountSignApp.Signature;
                                    AccountSign."Expiry Date" := AccountSignApp."Expiry Date";
                                    AccountSign."Mobile Number" := AccountSignApp."Mobile No";
                                    AccountSign.Insert;
                                until AccountSignApp.Next = 0;

                            Cust.Reset;
                            if Cust.Get(BOSAACC) then begin
                                Cust.Validate(Cust.Name);
                                //Cust.VALIDATE(Accounts."Account Type");
                                Cust.Validate(Cust."Global Dimension 1 Code");
                                Cust.Validate(Cust."Global Dimension 2 Code");
                                Cust.Modify;
                            end;

                            /*
                            GenSetUp.GET();
                             Notification.CreateMessage('Dynamics NAV',GenSetUp."Sender Address","E-Mail (Personal)",'Member Acceptance Notification',
                                            'Member application '+ "No." + ' has been approved'
                                           + ' (Dynamics NAV ERP)',FALSE);
                             Notification.Send;
                            */

                            Message('Account created successfully.');
                            //END;
                            Status := Status::Approved;
                            "Approved By" := UserId;
                            Modify;
                        end else
                            Error('Not approved');
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if UserId <> 'MMHSACCO\ADMINISTRATOR' then
            SetRange("User ID", UserId);
    end;

    var
        Cust: Record Customer;
        AcctNo: Code[20];
        NextOfKinApp: Record "Member App Next Of kin";
        AccountSign: Record "Member Account Signatories";
        AccountSignApp: Record "Member App Signatories";
        BOSAACC: Code[20];
        NextOfKin: Record "Members Next Kin Details";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
        Table_id: Integer;
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening";
}
