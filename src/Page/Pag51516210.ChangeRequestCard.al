#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516210 "Change Request Card"
{
    PageType = Card;
    SourceTable = "Change Request";
    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                    Editable = TypeEditable;
                    Style = StrongAccent;
                    trigger OnValidate()
                    begin
                        AccountVisible := false;
                        MobileVisible := false;
                        nxkinvisible := false;

                        // if Type = Type::"M-Banking Change" then begin
                        //     MobileVisible := true;

                        // end;

                        // if Type = Type::"ATM Change" then begin
                        //     AccountVisible := true;
                        //     nxkinvisible := true;
                        // end;

                        if Type = Type::"BOSA Change" then begin
                            AccountVisible := true;
                            nxkinvisible := true;
                        end;
                        // if Type = Type::"FOSA Change" then begin
                        //     AccountVisible := true;
                        //     nxkinvisible := true;
                        // end;
                    end;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                    Style = StrongAccent;
                }
                field("Captured by"; "Captured by")
                {
                    ApplicationArea = Basic;
                }
                field("Capture Date"; "Capture Date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved by"; "Approved by")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Approval Date"; "Approval Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Reason for change"; "Reason for change")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
            }
            group("Account Info")
            {
                Caption = 'Account Details';
                Visible = Accountvisible;
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Name(New Value)"; "Name(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name(New Value)';
                    Editable = NameEditable;
                }
                field("Phone No.(New)"; "Phone No.(New)")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field("E-mail"; "E-mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Email(New Value)"; "Email(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Email(New Value)';
                    Editable = true;
                }
                field("Personal No"; "Personal No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Personal No(New Value)"; "Personal No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Personal No(New Value)';
                    Editable = PersonalNoEditable;
                }
                field("ID No"; "ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No(New Value)"; "ID No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No(New Value)';
                    Editable = IDNoEditable;
                }
                field("Position In the Sacco"; "Position In the Sacco")
                {
                    ApplicationArea = basic;
                    Editable = false;
                }
                field("Position In the Sacco(New)"; "Position In the Sacco(New)")
                {
                    ApplicationArea = basic;
                }
                field("Receive SMS Notification (Old)"; "SMS Notification")
                {
                }
                field("Receive SMS Notification (New)"; "SMS Notification (New)")
                {
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Age; Age)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                }
                field("Marital Status(New Value)"; "Marital Status(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status(New Value)';
                    Editable = MaritalStatusEditable;
                    ToolTip = 'Please enter your marital status';
                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Category(New Value)"; "Account Category(New Value)")
                {
                    ApplicationArea = Basic;
                }
                field("Card No"; "Card No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Card No(New Value)"; "Card No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Card No(New Value)';
                    Editable = CardNoEditable;
                }
                field("Status."; "Status.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Status.(New)"; "Status.(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Occupation; Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("KRA Pin(Old)"; "KRA Pin(Old)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("KRA Pin(New)"; "KRA Pin(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Disabled; Disabled)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Blocked (New)"; "Blocked (New)")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code(New)"; "Employer Code(New)")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Reactivation Fee"; "Charge Reactivation Fee")
                {
                    ApplicationArea = Basic;
                    Editable = ReactivationFeeEditable;
                }
                field("Monthly Contributions"; "Monthly Contributions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Contributions(NewValu)"; "Monthly Contributions(NewValu)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Monthly Contributions(New Value)';
                    Editable = MonthlyContributionEditable;
                }
                field("Mobile No"; "Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mobile No(New Value)"; "Mobile No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No(New Value)';
                    Editable = MobileNoEditable;
                }
            }

            group("Bank Details")
            {
                field("Bank Code(Old)"; "Bank Code(Old)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank Code(New)"; "Bank Code(New)")
                {
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bank Name (New)"; "Bank Name (New)")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Branch Name"; "Bank Branch Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Branch(New Value)"; "Branch(New Value)")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No(Old)"; "Bank Account No(Old)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank Account No(New)"; "Bank Account No(New)")
                {
                    ApplicationArea = Basic;
                }
            }

            group("mobile Info")
            {
                Caption = 'Mobile/Agency Change Details';
                Visible = MobileVisible;

                field("ID No."; "ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("ID No.(New Value)"; "ID No(New Value)")
                {
                    ApplicationArea = Basic;
                    Editable = IDNoEditable;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Phone No..(New)"; "Phone No.(New)")
                {
                    ApplicationArea = Basic;
                    Editable = PersonalNoEditable;
                }
                field("Mpesa mobile No."; "Mpesa mobile No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Mpesa mobile No.(New)"; "Mpesa mobile No.(New)")
                {
                    ApplicationArea = Basic;
                    Editable = MobileNoEditable;
                }
                field("SMS Notification."; "SMS Notification")
                {
                    Editable = false;
                }
                field("SMS Notification (New)."; "SMS Notification (New)")
                {
                }
                field("E-mail."; "E-mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Email.(New Value)"; "Email(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Email (New)';
                    Editable = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control149; "Change Request Pic")
            {
                ApplicationArea = all;
                SubPageLink = No = FIELD("No");
                Visible = true;
            }
            part(Control150; "Change Request Sign")
            {
                ApplicationArea = all;
                SubPageLink = No = FIELD("No");
                Visible = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Changes")
            {
                ApplicationArea = Basic;
                Caption = 'Update Changes';
                Image = UserInterface;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    // if (Status <> Status::Approved) then
                    //     Error('Change Request Must be Approved First');

                    if Type = Type::"BOSA Change" then begin
                        Memb.Reset;
                        Memb.SetRange(Memb."No.", "Account No");
                        if Memb.Find('-') then begin
                            if "Name(New Value)" <> '' then
                                Memb.Name := "Name(New Value)";
                            Memb."Global Dimension 2 Code" := Branch;
                            if "Address(New Value)" <> '' then
                                Memb.Address := "Address(New Value)";
                            if "Post Code (New)" <> '' then
                                Memb."Post Code" := "Post Code (New)";
                            if "Email(New Value)" <> '' then
                                Memb."E-Mail" := "Email(New Value)";
                            if "Mobile No(New Value)" <> '' then begin
                                Memb."Mobile Phone No" := "Mobile No(New Value)";
                                Memb."Phone No." := "Mobile No(New Value)";
                            end;

                            if "ID No(New Value)" <> '' then
                                Memb."ID No." := "ID No(New Value)";
                            if "Personal No(New Value)" <> '' then begin
                                Memb."Payroll/Staff No" := "Personal No(New Value)";
                                Memb.Validate("Payroll/Staff No");
                                loans.Reset;
                                loans.SetRange(loans."Client Code", "Account No");
                                if loans.Find('-') then
                                    repeat
                                        loans."Staff No" := "Personal No(New Value)";
                                        loans.Modify;
                                    until loans.Next = 0;
                            end;
                            if "City(New Value)" <> '' then
                                Memb.City := "City(New Value)";
                            //Memb.Status := "Status(New Value)";
                            if "Section(New Value)" <> '' then
                                Memb.Section := "Section(New Value)";
                            Memb.Blocked := "Blocked (New)";
                            if "Marital Status(New Value)" <> "marital status(new value)"::" " then
                                Memb."Marital Status" := "Marital Status(New Value)";
                            if "Responsibility Centers" <> '' then
                                Memb."Responsibility Center" := "Responsibility Centers";
                            if "Occupation(New)" <> '' then
                                Memb.Occupation := "Occupation(New)";

                            //update position in the sacco
                            if "Position In the Sacco(New)" <> "Position In the Sacco(New)"::" " then
                                if "Position In the Sacco(New)" = "Position In the Sacco(New)"::Board then begin
                                    Memb.Board := true;
                                    Memb.staff := false;
                                    Memb."Sacco Insider" := true;

                                end else
                                    if "Position In the Sacco(New)" = "Position In the Sacco(New)"::Staff then begin
                                        Memb.Board := false;
                                        Memb.staff := true;

                                        Memb."Sacco Insider" := true;
                                    end else
                                        if "Position In the Sacco(New)" = "Position In the Sacco(New)"::Member then begin
                                            Memb.Board := false;
                                            Memb.staff := false;

                                            Memb."Sacco Insider" := false;
                                        end else
                                            if "Position In the Sacco(New)" = "Position In the Sacco(New)"::Supervisory then begin
                                                Memb.Board := false;
                                                Memb.staff := false;
                                                Memb."Sacco Insider" := true;

                                            end;
                            //Update Bank
                            if "Bank Code(New)" <> '' then
                                Memb."Bank Code" := "Bank Code(New)";
                            if "Bank Name (New)" <> '' then
                                // Memb."Benevolent Fund Historical":="Bank Name (New)";
                                if "Bank Account No(New)" <> '' then
                                    Memb."Bank Account No." := "Bank Account No(New)";
                            //Bank Branch
                            if "Bank Branch Code(New)" <> '' then
                                Memb."Bank Code" := "Bank Branch Code(New)";
                            if "Bank Branch Name(New)" <> '' then
                                Memb."Bank Branch" := "Bank Branch Name(New)";
                            if "KRA Pin(New)" <> '' then
                                Memb.Pin := "KRA Pin(New)";
                            Memb."Last Date Modified" := "Capture Date";
                            if "Group Account Name" <> '' then
                                Memb."Group Account Name" := "Group Account Name";
                            if "Employer Code(New)" <> '' then
                                Memb."Employer Code" := "Employer Code(New)";
                            IF "Picture(New Value)".HasValue THEN
                                MEMB.Image := "Picture(New Value)";
                            IF "signinature(New Value)".HasValue THEN
                                MEMB.Signature := "signinature(New Value)";
                            IF "Date Of Birth" <> 0D THEN
                                Memb."Date of Birth" := "Date Of Birth";
                            IF Gender <> Gender::" " then
                                Memb.Gender := Gender;
                            if "SMS Notification (New)" = true then
                                memb."Sms Notification" := true;
                            if "Status.(New)" <> "Status.(New)"::" " then
                                Memb.Status := "Status.(New)";
                            if "Monthly Contributions(NewValu)" <> 0 then
                                Memb."Monthly Contribution" := "Monthly Contributions(NewValu)";
                            Memb.Modify;
                            //.....................GENERAL UPDATE VENDOR ALSO
                            VEND.Reset();
                            VEND.SetRange(vend."BOSA Account No", "Account No");
                            IF vend.Find('-') then
                                repeat
                                    IF "Picture(New Value)".HasValue THEN
                                        vend.Image := "Picture(New Value)";
                                    if "SMS Notification (New)" = true then
                                        vend."Sms Notification" := true;
                                    IF "Date Of Birth" <> 0D THEN
                                        vend."Date of Birth" := "Date Of Birth";
                                    IF Gender <> Gender::" " then
                                        vend.Gender := Gender;
                                    IF "signinature(New Value)".HasValue THEN
                                        vend.Signature := "signinature(New Value)";
                                    if "Mobile No(New Value)" <> '' then begin
                                        vend."Mobile Phone No" := "Mobile No(New Value)";
                                        vend."Phone No." := "Mobile No(New Value)";
                                    end;
                                    if "ID No(New Value)" <> '' then
                                        vend."ID No." := "ID No(New Value)";
                                    if ("Status.(New)" <> "Status.(New)"::" ") and ("Status.(New)" = "Status.(New)"::Deceased) then
                                        vend.Status := vend.Status::Deceased;
                                    vend.Modify();
                                until vend.Next = 0;

                            if "Charge Reactivation Fee" = true then
                                if Confirm('The System Is going to Charge Reactivation Fee', false) = true then begin
                                    GenSetUp.Get();
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'ACTIVATE');
                                    if GenJournalLine.FindSet then
                                        GenJournalLine.DeleteAll;

                                    BATCH_TEMPLATE := 'GENERAL';
                                    BATCH_NAME := 'ACTIVATE';
                                    DOCUMENT_NO := "Account No";
                                    GenSetup.Get();
                                    LineNo := 0;

                                    //Post New
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                    if GenJournalLine.Find('-') then begin
                                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                                        GenJournalLine.DeleteAll;
                                    end;

                                    Message('Account re-activated successfully');
                                end;
                        end;

                        //...........................
                    end;

                    Changed := true;
                    // IF Picture.HasValue then
                    //     Clear(Picture);
                    // IF signinature.HasValue then
                    //     Clear(signinature);
                    Modify;
                    Message('Changes have been updated Successfully');
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    if Status <> Status::Open then
                        Error(text001);
                    TestField("Reason for change");
                    if Confirm('Send Approval Request?', false) = true then
                        SrestepApprovalsCodeUnit.SendMemberChangeRequestForApproval(rec.No, Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel A&pproval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    if Confirm('Cancel Approval Request?', false) = true then
                        SrestepApprovalsCodeUnit.CancelMemberChangeRequestRequestForApproval(rec.No, Rec);
                end;
            }

            separator(Action1000000047)
            {
            }
            separator(Action1000000055)
            {
            }
            action("Next of Kin")
            {
                ApplicationArea = Basic;
                Caption = 'Next of Kin';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Next of Kin-Change";
                RunPageLink = "Account No" = field("Account No");
                Visible = false;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        AccountVisible := false;
        MobileVisible := false;
        nxkinvisible := false;

        // if Type = Type::"M-Banking Change" then begin
        //     MobileVisible := true;
        // end;

        // if Type = Type::"ATM Change" then begin
        //     AccountVisible := true;
        //     nxkinvisible := true;
        // end;

        if Type = Type::"BOSA Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;

        UpdateControl();
    end;

    trigger OnOpenPage()
    begin
        AccountVisible := false;
        MobileVisible := false;
        nxkinvisible := false;

        // if Type = Type::"M-Banking Change" then begin
        //     MobileVisible := true;
        // end;

        // if Type = Type::"ATM Change" then begin
        //     AccountVisible := true;
        //     nxkinvisible := false;
        // end;

        if Type = Type::"BOSA Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;

        UpdateControl();
    end;

    var
        vend: Record Vendor;
        Memb: Record Customer;
        MobileVisible: Boolean;
        AtmVisible: Boolean;
        AccountVisible: Boolean;
        cloudRequest: Record "Change Request";
        nxkinvisible: Boolean;
        //Kinchangedetails: Record "Members Next of Kin";
        DocumentType: Option " ",Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Withdrawal","Membership Reg","Loan Batches","Payment Voucher","Petty Cash",Loan,Interbank,Checkoff,"Savings Product Opening","Standing Order",ChangeRequest;
        //MemberNxK: Record "Members Next of Kin";
        GenSetUp: Record "Sacco General Set-Up";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        NameEditable: Boolean;
        PictureEditable: Boolean;
        SignatureEditable: Boolean;
        AddressEditable: Boolean;
        CityEditable: Boolean;
        EmailEditable: Boolean;
        PersonalNoEditable: Boolean;
        IDNoEditable: Boolean;
        PosInSaccoEditable: Boolean;
        MembPayTypeEditable: Boolean;
        MaritalStatusEditable: Boolean;
        PassPortNoEditbale: Boolean;
        AccountTypeEditible: Boolean;
        SectionEditable: Boolean;
        CardNoEditable: Boolean;
        HomeAddressEditable: Boolean;
        LocationEditable: Boolean;
        SubLocationEditable: Boolean;
        DistrictEditable: Boolean;
        MemberStatusEditable: Boolean;
        ReasonForChangeEditable: Boolean;
        SigningInstructionEditable: Boolean;
        MonthlyContributionEditable: Boolean;
        MemberCellEditable: Boolean;
        ATMApproveEditable: Boolean;
        CardExpiryDateEditable: Boolean;
        CardValidFromEditable: Boolean;
        CardValidToEditable: Boolean;
        ATMNOEditable: Boolean;
        ATMIssuedEditable: Boolean;
        ATMSelfPickedEditable: Boolean;
        ATMCollectorNameEditable: Boolean;
        ATMCollectorIDEditable: Boolean;
        ATMCollectorMobileEditable: Boolean;
        ResponsibilityCentreEditable: Boolean;
        MobileNoEditable: Boolean;
        SMobileNoEditable: Boolean;
        TypeEditable: Boolean;
        AccountNoEditable: Boolean;
        AccountCategoryEditable: Boolean;
        ReactivationFeeEditable: Boolean;
        loans: Record "Loans Register";
        RetirementDateEditable: Boolean;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: code[50];
        SFactory: Codeunit "SURESTEP Factory";
        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;

    local procedure UpdateControl()
    begin
        if Status = Status::Open then begin
            NameEditable := true;
            PictureEditable := true;
            SignatureEditable := true;
            AddressEditable := true;
            CityEditable := true;
            EmailEditable := true;
            PersonalNoEditable := true;
            IDNoEditable := true;
            MembPayTypeEditable := true;
            PosInSaccoEditable := true;
            MaritalStatusEditable := true;
            PassPortNoEditbale := true;
            AccountTypeEditible := true;
            EmailEditable := true;
            SectionEditable := true;
            CardNoEditable := true;
            HomeAddressEditable := true;
            LocationEditable := true;
            SubLocationEditable := true;
            DistrictEditable := true;
            MemberStatusEditable := true;
            ReasonForChangeEditable := true;
            SigningInstructionEditable := true;
            MonthlyContributionEditable := true;
            MemberCellEditable := true;
            ATMApproveEditable := true;
            CardExpiryDateEditable := true;
            CardValidFromEditable := true;
            CardValidToEditable := true;
            ATMNOEditable := true;
            ATMIssuedEditable := true;
            ATMSelfPickedEditable := true;
            ATMCollectorNameEditable := true;
            ATMCollectorIDEditable := true;
            ATMCollectorMobileEditable := true;
            ResponsibilityCentreEditable := true;
            MobileNoEditable := true;
            SMobileNoEditable := true;
            AccountNoEditable := true;
            ReactivationFeeEditable := true;
            TypeEditable := true;
            AccountCategoryEditable := true
        end else
            if Status = Status::Pending then begin
                NameEditable := false;
                PictureEditable := false;
                SignatureEditable := false;
                AddressEditable := false;
                CityEditable := false;
                EmailEditable := false;
                PersonalNoEditable := false;
                IDNoEditable := false;
                PosInSaccoEditable := false;
                MembPayTypeEditable := false;
                MaritalStatusEditable := false;
                PassPortNoEditbale := false;
                AccountTypeEditible := false;
                EmailEditable := false;
                SectionEditable := false;
                CardNoEditable := false;
                HomeAddressEditable := false;
                LocationEditable := false;
                SubLocationEditable := false;
                DistrictEditable := false;
                MemberStatusEditable := false;
                ReasonForChangeEditable := false;
                SigningInstructionEditable := false;
                MonthlyContributionEditable := false;
                MemberCellEditable := false;
                ATMApproveEditable := false;
                CardExpiryDateEditable := false;
                CardValidFromEditable := false;
                CardValidToEditable := false;
                ATMNOEditable := false;
                ATMIssuedEditable := false;
                ATMSelfPickedEditable := false;
                ATMCollectorNameEditable := false;
                ATMCollectorIDEditable := false;
                ATMCollectorMobileEditable := false;
                ResponsibilityCentreEditable := false;
                MobileNoEditable := false;
                SMobileNoEditable := false;
                AccountNoEditable := false;
                TypeEditable := false;
                ReactivationFeeEditable := false;
                AccountCategoryEditable := false
            end else
                if Status = Status::Approved then begin
                    NameEditable := false;
                    PictureEditable := false;
                    SignatureEditable := false;
                    AddressEditable := false;
                    CityEditable := false;
                    EmailEditable := false;
                    PersonalNoEditable := false;
                    IDNoEditable := false;
                    PosInSaccoEditable := false;
                    MembPayTypeEditable := false;
                    MaritalStatusEditable := false;
                    PassPortNoEditbale := false;
                    AccountTypeEditible := false;
                    EmailEditable := false;
                    SectionEditable := false;
                    CardNoEditable := false;
                    HomeAddressEditable := false;
                    LocationEditable := false;
                    SubLocationEditable := false;
                    DistrictEditable := false;
                    MemberStatusEditable := false;
                    ReasonForChangeEditable := false;
                    SigningInstructionEditable := false;
                    MonthlyContributionEditable := false;
                    MemberCellEditable := false;
                    ATMApproveEditable := false;
                    CardExpiryDateEditable := false;
                    CardValidFromEditable := false;
                    CardValidToEditable := false;
                    ATMNOEditable := false;
                    ATMIssuedEditable := false;
                    ATMSelfPickedEditable := false;
                    ATMCollectorNameEditable := false;
                    ATMCollectorIDEditable := false;
                    ATMCollectorMobileEditable := false;
                    ResponsibilityCentreEditable := false;
                    MobileNoEditable := false;
                    SMobileNoEditable := false;
                    AccountNoEditable := false;
                    ReactivationFeeEditable := false;
                    TypeEditable := false;
                    AccountCategoryEditable := false
                end;
    end;

    local procedure FnGetFOSA(AccountNo: Code[50]): Code[50]
    var
        Vendor: Record Vendor;
    begin
        Vendor.reset;
        Vendor.SetRange(Vendor."BOSA Account No", AccountNo);
        if Vendor.Find('-') = true then
            exit(Vendor."No.")
        else
            if Vendor.Find('-') = false then
                exit(AccountNo);
    end;
}
