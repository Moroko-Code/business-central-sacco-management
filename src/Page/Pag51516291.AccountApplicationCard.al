// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Page 51516291 "Account Application Card"
// {
//     Caption = 'Products Applications';
//     PageType = Card;
//     PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
//     SourceTable = "Accounts Applications Details";
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; "No.")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("BOSA Account No"; "BOSA Account No")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Member Account No';
//                     Editable = FieldEditable;
//                 }
//                 field("Account Type"; "Account Type")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = FieldEditable;

//                     trigger OnValidate()
//                     begin
//                         Controls;
//                     end;
//                 }
//                 group("Parent Account No")
//                 {
//                     Visible = parent;
//                     Caption = ' ';
//                     field("Parent Account No."; "Parent Account No.")
//                     {
//                         ApplicationArea = Basic;
//                         ShowMandatory = true;
//                     }
//                 }
//                 field(Name; Name)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Phone No."; "Phone No.")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("E-Mail"; "E-Mail")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("ID No."; "ID No.")
//                 {
//                     editable = false;
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         Acc.Reset;
//                         Acc.SetRange(Acc."ID No.", "ID No.");
//                         Acc.SetRange(Acc."Account Type", "Account Type");
//                         Acc.SetRange(Acc.Status, Acc.Status::Active);
//                         if Acc.Find('-') then
//                             Error('Account already created.');
//                     end;
//                 }
//                 field("Date of Birth"; "Date of Birth")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Employer Code"; "Employer Code")
//                 {
//                     ApplicationArea = Basic;
//                     editable = false;
//                 }
//                 field("Staff No"; "Staff No")
//                 {
//                     ApplicationArea = Basic;
//                     editable = false;
//                 }
//                 field("Global Dimension 2 Code"; "Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic;
//                     ShowMandatory = true;
//                     editable = false;

//                 }
//                 field(Status; Status)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Application Status"; "Application Status")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Account Category"; "Account Category")
//                 {
//                     ApplicationArea = Basic;
//                     editable = false;
//                 }
//                 field("Application Date"; "Application Date")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Savings Account No.";"Savings Account No.")
//                 {
//                 }
//             }
//         }

//         area(factboxes)
//         {
//             part(Control1000000004; "Member Statistics FactBox")
//             {
//                 SubPageLink = "No." = field("BOSA Account No");
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("Function")
//             {
//                 Caption = 'Function';
//                 action("Next of Kin")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Next of Kin';
//                     Image = Relationship;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "Account App Next Of Kin Detail";
//                     RunPageLink = "Account No" = field("No.");
//                     Enabled = FieldEditable;
//                 }
//                 // action("Account Signatories ")
//                 // {
//                 //     ApplicationArea = Basic;
//                 //     Caption = 'Signatories';
//                 //     Image = Group;
//                 //     Promoted = true;
//                 //     PromotedCategory = Process;
//                 //     RunObject = Page "Account App Signatories Detail";
//                 //     RunPageLink = "Account No" = field("No.");
//                 //     Enabled = FieldEditable;
//                 // }
//             }
//         }
//         area(processing)
//         {
//             group(Approvals)
//             {
//                 action("Send Approval Request")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Send Approval Request';
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     Enabled = SendApprovalEnabled;

//                     trigger OnAction()
//                     var
//                         Text001: label 'This request is already pending approval';
//                     begin

//                         if "Account Type" = 'JUNIOR' then
//                             TestField("Parent Account No.");
//                         if "Account Type" = 'CORPORATE' then begin
//                             if "Account Category" = "account category"::Single then begin
//                                 Error('Account category must not be single');
//                             end;
//                         end;

//                         //IF ("Account Type"<>'CHILDREN') AND ("Account Type"<>'CORPORATE') AND ("Account Type"<>'FIXED') THEN BEGIN
//                         if ("Fixed Deposit" <> true) and ("Allow Multiple Accounts" <> true) then begin
//                             if "ID No." <> '' then begin
//                                 Vend.Reset;
//                                 Vend.SetRange(Vend."ID No.", "ID No.");
//                                 Vend.SetRange(Vend."Account Type", "Account Type");
//                                 if Vend.Find('-') then begin
//                                     Error('Account type already exists');
//                                 end;
//                             end;
//                         end;
//                         //END;

//                         if "Account Type" <> 'JUNIOR' then begin
//                             if "Micro Group" <> true then begin
//                                 TestField("Account Type");
//                                 TestField("ID No.");
//                                 TestField("Global Dimension 2 Code");
//                                 TestField("BOSA Account No");
//                                 //  TESTFIELD(Signature);
//                                 //  TESTFIELD(Picture);
//                             end;
//                         end;
//                         if ("Micro Single" = true) then begin
//                             TestField("Group Code");
//                             TestField("Global Dimension 2 Code");
//                             TestField("Account Type");
//                             // TestField(Signature);
//                             // TestField(Picture);

//                         end;
//                         if "Account Type" <> 'JUNIOR' then begin
//                             if ("Micro Single" <> true) and ("Micro Group" <> true) then
//                                 if "Account Type" = 'SAVINGS' then begin
//                                     TestField("BOSA Account No");
//                                 end;
//                         end;

//                         if "Micro Group" = true then begin
//                             if "Account Type" = '' then
//                                 Error('Group accounts must have a Savings account kindly specify the account type ');
//                             TestField("Global Dimension 2 Code");
//                         end;

//                         if "Fixed Deposit" = true then begin
//                             TestField("Savings Account No.");

//                         end;

//                         if Status <> Status::Open then
//                             Error(Text001);
//                         if "Account Category" <> "account category"::Single then begin

//                             AccountSignApp.Reset;
//                             AccountSignApp.SetRange(AccountSignApp."Account No", "No.");
//                             if AccountSignApp.Find('-') = false then begin
//                                 Error(Text004);
//                             end;
//                         end;
//                         //-------------------Approval Workflow
//                         if Confirm('Send Approval Request for Product Applicant %1 ', false, Name) = false then begin
//                             exit;
//                         end else begin
//                             SrestepApprovalsCodeUnit.SendFOSAProductApplicationsRequestForApproval(rec."No.", Rec);
//                             CurrPage.Close();
//                         end;

//                     end;
//                 }
//                 action("Cancel Approval Request")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Cancel Approval Request';
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     Enabled = CancelApprovalEnabled;

//                     trigger OnAction()
//                     var
//                     begin
//                     end;
//                 }
//                 action(Create)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Create';
//                     Image = CreateBinContent;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     Enabled = PostApprovalEnabled;
//                     trigger OnAction()
//                     begin

//                         if Status <> Status::Approved then
//                             Error('Account application not approved');

//                         if ("Account Type" <> 'JUNIOR') then begin
//                             if "Micro Group" <> true then begin
//                                 TestField("Account Type");
//                                 TestField("ID No.");
//                                 TestField("BOSA Account No");
//                             end;
//                         end;

//                         if "Micro Single" = true then begin
//                             TestField("Group Code");
//                         end;
//                         if ("Account Type" <> 'JUNIOR') then begin
//                             if ("Micro Single" <> true) and ("Micro Group" <> true) then
//                                 if "Account Type" = 'SAVINGS' then begin
//                                     TestField("BOSA Account No");
//                                 end;
//                         end;
//                         if "Application Status" = "application status"::Converted then
//                             Error('Application has already been converted.');

//                         if ("Account Type" = 'ORDINARY') then begin
//                             Nok.Reset;
//                             Nok.SetRange(Nok."Account No", "No.");

//                         end;

//                         if Confirm('Are you sure you want to create ' + Format("Account Type") + '  Product Account for ' + Format(Name) + ' ?', false) = false then begin
//                             exit;
//                         end else begin
//                             if AccoutTypes.Get("Account Type") then begin
//                                 if "Micro Single" <> true then begin
//                                     if DimensionValue.Get('BRANCH', "Global Dimension 2 Code") then begin
//                                         AcctNo := AccoutTypes."Account No Prefix" + "Global Dimension 2 Code" + "BOSA Account No";
//                                     end;
//                                 end;

//                                 if "Micro Single" = true then begin
//                                     if DimensionValue.Get('BRANCH', "Global Dimension 2 Code") then begin
//                                         DimensionValue.TestField(DimensionValue."Account Code");
//                                         AcctNo := AccoutTypes."Account No Prefix" + '-' + DimensionValue."Account Code" + '-' + DimensionValue."No. Series"
//                                         + '-' + AccoutTypes."Ending Series";
//                                         AcctNo := "Group Code" + AccoutTypes."Ending Series";
//                                         AccoutTypes."Ending Series" := IncStr(AccoutTypes."Ending Series");
//                                         AccoutTypes.Modify;
//                                     end;
//                                 end;
//                                 if AccoutTypes.Get("Account Type") then begin
//                                     if "Parent Account No." = '' then begin
//                                         TestField("Savings Account No.");
//                                         AcctNo := AccoutTypes."Account No Prefix" + "Global Dimension 2 Code" + "BOSA Account No";
//                                     end else begin
//                                         AcctNo := AccoutTypes."Account No Prefix" + "Global Dimension 2 Code" + "BOSA Account No";
//                                         DimensionValue.Modify;
//                                     end;

//                                 end else begin
//                                     AcctNo := AccoutTypes."Account No Prefix" + "Kin No";
//                                     if Acc.Get(AcctNo) then begin
//                                         AcctNo := AccoutTypes."Account No Prefix" + "Global Dimension 2 Code" + "BOSA Account No";
//                                         AcctNo := AccoutTypes."Account No Prefix" + "Global Dimension 2 Code" + "BOSA Account No";
//                                     end;
//                                 end;
//                                 if AccoutTypes."Fixed Deposit" = true then begin
//                                     if "Kin No" <> '' then
//                                         AcctNo := AccoutTypes."Account No Prefix" + "Global Dimension 2 Code" + "BOSA Account No";
//                                 end;
//                                 ///////
//                             end;
//                             //END;

//                             if "Micro Group" = true then begin
//                                 SaccoSetup.Reset;
//                                 SaccoSetup.Get;
//                                 Accounts.Init;
//                                 Accounts."No." := SaccoSetup."Micro Group Nos.";
//                                 Message('The Group no is %1', Accounts."No.");
//                                 Accounts.Name := Name;
//                                 Accounts."Creditor Type" := Accounts."creditor type"::Account;
//                                 Accounts."Debtor Type" := Accounts."debtor type"::"FOSA Account";
//                                 Accounts."Global Dimension 1 Code" := 'MICRO';
//                                 Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
//                                 Accounts."Group Account" := true;
//                                 Accounts."Registration Date" := Today;
//                                 Accounts."Purchaser Code" := "Purchaser Code";
//                                 Accounts.Insert;
//                                 SaccoSetup."Micro Group Nos." := IncStr(SaccoSetup."Micro Group Nos.");
//                                 SaccoSetup.Modify;

//                                 //micro savin
//                                 Accounts."No." := AcctNo;//"No.";
//                                                          //AcctNo:="No.";
//                                 Accounts.Name := Name;
//                                 Accounts."Creditor Type" := Accounts."creditor type"::Account;
//                                 Accounts."Debtor Type" := Accounts."debtor type"::" ";
//                                 Accounts."Mobile Phone No" := "Mobile Phone No";
//                                 Accounts."Registration Date" := "Registration Date";
//                                 Accounts.Status := Accounts.Status::New;
//                                 Accounts."Account Type" := "Account Type";
//                                 Accounts."Purchaser Code" := "Purchaser Code";
//                                 Accounts."Account Category" := "Account Category";
//                                 Accounts."Date of Birth" := "Date of Birth";
//                                 Accounts."Global Dimension 1 Code" := "Global Dimension 1 Code";
//                                 Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
//                                 Accounts.Address := Address;
//                                 Accounts."Address 2" := "Address 2";
//                                 Accounts.City := City;
//                                 Accounts."Phone No." := "Phone No.";
//                                 Accounts."Telex No." := "Telex No.";
//                                 Accounts."Post Code" := "Post Code";
//                                 Accounts.County := County;
//                                 Accounts."E-Mail" := "E-Mail";
//                                 Accounts."Registration Date" := Today;
//                                 Accounts.Status := Status::Open;
//                                 Accounts.Section := Section;
//                                 Accounts."Home Address" := "Home Address";
//                                 Accounts.District := District;
//                                 Accounts.Location := Location;
//                                 Accounts."Sub-Location" := "Sub-Location";
//                                 Accounts."Savings Account No." := "Savings Account No.";
//                                 Accounts."Signing Instructions" := "Signing Instructions";
//                                 Accounts."Fixed Deposit Type" := "Fixed Deposit Type";
//                                 Accounts."FD Maturity Date" := "FD Maturity Date";
//                                 Accounts."Fixed Deposit Status" := Accounts."fixed deposit status"::Active;
//                                 Accounts."Registration Date" := Today;
//                                 Accounts."Monthly Contribution" := "Monthly Contribution";
//                                 Accounts."Formation/Province" := "Formation/Province";
//                                 Accounts."Division/Department" := "Division/Department";
//                                 Accounts."Station/Sections" := "Station/Sections";
//                                 Accounts."Force No." := "Force No.";
//                                 Accounts."Sms Notification" := "Sms Notification";
//                                 Accounts."Vendor Posting Group" := AccoutTypes."Posting Group";
//                                 Message('The Group Savings Account no is %1', AcctNo);

//                                 Accounts.Insert;
//                             end;
//                             //END;

//                             if "Micro Group" = false then begin
//                                 Accounts.Init;
//                                 Accounts."No." := AcctNo;
//                                 Accounts."Date of Birth" := "Date of Birth";
//                                 Accounts.Name := Name;
//                                 Accounts."Creditor Type" := Accounts."creditor type"::Account;
//                                 Accounts."Debtor Type" := "Debtor Type";
//                                 Accounts."Debtor Type" := Accounts."debtor type"::" ";
//                                 if "Micro Single" = true then begin
//                                     Accounts."Group Account" := false;
//                                     Accounts."Debtor Type" := Accounts."debtor type"::"FOSA Account";
//                                 end;
//                                 Accounts."Staff No" := "Staff No";
//                                 Accounts."Purchaser Code" := "Purchaser Code";
//                                 Accounts."ID No." := "ID No.";
//                                 Accounts."Mobile Phone No" := "Mobile Phone No";
//                                 Accounts."Registration Date" := "Registration Date";
//                                 Accounts."Marital Status" := "Marital Status";
//                                 Accounts."BOSA Account No" := "BOSA Account No";
//                                 // Accounts.Picture:=Picture;
//                                 Accounts.Signature := Signature;
//                                 Accounts."Passport No." := "Passport No.";
//                                 Accounts."Company Code" := "Employer Code";
//                                 Accounts.Status := Accounts.Status::New;
//                                 Accounts."Account Type" := "Account Type";
//                                 Accounts."Group Code" := "Group Code";
//                                 Accounts."Account Category" := "Account Category";
//                                 Accounts."Date of Birth" := "Date of Birth";
//                                 Accounts."Global Dimension 1 Code" := "Global Dimension 1 Code";
//                                 Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
//                                 Accounts.Address := Address;
//                                 Accounts."Address 2" := "Address 2";
//                                 Accounts.City := City;
//                                 Accounts."Phone No." := "Phone No.";
//                                 Accounts."Telex No." := "Telex No.";
//                                 Accounts."Post Code" := "Post Code";
//                                 Accounts.County := County;
//                                 Accounts."E-Mail" := "E-Mail";
//                                 Accounts."Registration Date" := Today;
//                                 Accounts.Status := Status::Open;
//                                 Accounts.Section := Section;
//                                 Accounts."Home Address" := "Home Address";
//                                 Accounts.District := District;
//                                 Accounts.Location := Location;

//                                 Accounts."Sub-Location" := "Sub-Location";
//                                 Accounts."Savings Account No." := "Savings Account No.";
//                                 Accounts."Signing Instructions" := "Signing Instructions";
//                                 Accounts."Fixed Deposit Type" := "Fixed Deposit Type";
//                                 Accounts."FD Maturity Date" := "FD Maturity Date";
//                                 Accounts."Neg. Interest Rate" := "Neg. Interest Rate";
//                                 Accounts."FD Duration" := "FD Duration";
//                                 Accounts."Registration Date" := Today;
//                                 Accounts."ContactPerson Relation" := "ContactPerson Relation";
//                                 Accounts."ContactPerson Occupation" := "ContacPerson Occupation";
//                                 Accounts."Recruited By" := "Recruited By";
//                                 Accounts."ContacPerson Phone" := "ContacPerson Phone";
//                                 Accounts."Monthly Contribution" := "Monthly Contribution";
//                                 Accounts."Formation/Province" := "Formation/Province";
//                                 Accounts."Division/Department" := "Division/Department";
//                                 Accounts."Station/Sections" := "Station/Sections";
//                                 Accounts."Force No." := "Force No.";
//                                 Accounts."Vendor Posting Group" := AccoutTypes."Posting Group";

//                                 Accounts."FD Maturity Instructions" := "FD Maturity Instructions";
//                                 if "Fixed Deposit" = true and "Allow Multiple Accounts" = true then
//                                     Accounts."Fixed Deposit Status" := Accounts."fixed deposit status"::Active;
//                                 Accounts.Insert;
//                             end;

//                             Accounts.Reset;
//                             if Accounts.Get(AcctNo) then begin
//                                 Accounts.Validate(Accounts.Name);
//                                 Accounts.Validate(Accounts."Account Type");
//                                 Accounts.Validate(Accounts."Global Dimension 1 Code");
//                                 Accounts.Validate(Accounts."Global Dimension 2 Code");
//                                 Accounts.Modify;

//                                 //Update BOSA with FOSA Account
//                                 if ("Account Type" = 'ORDINARY') then begin
//                                     if Cust.Get("BOSA Account No") then begin
//                                         Cust."FOSA Account" := AcctNo;
//                                         Cust.Modify;
//                                     end;
//                                 end;
//                             end;

//                             NextOfKinApp.Reset;
//                             NextOfKinApp.SetRange(NextOfKinApp."Account No", "No.");
//                             if NextOfKinApp.Find('-') then begin
//                                 repeat
//                                     NextOfKin.Init;
//                                     NextOfKin."Account No" := "No.";

//                                     NextOfKin.Name := NextOfKinApp.Name;
//                                     NextOfKin.Relationship := NextOfKinApp.Relationship;
//                                     NextOfKin.Beneficiary := NextOfKinApp.Beneficiary;
//                                     NextOfKin."Date of Birth" := NextOfKinApp."Date of Birth";
//                                     NextOfKin.Address := NextOfKinApp.Address;
//                                     NextOfKin.Telephone := NextOfKinApp.Telephone;
//                                     NextOfKin.Fax := NextOfKinApp.Fax;
//                                     NextOfKin.Email := NextOfKinApp.Email;
//                                     NextOfKin."ID No." := NextOfKinApp."ID No.";
//                                     NextOfKin."%Allocation" := NextOfKinApp."%Allocation";
//                                     NextOfKin.Insert;

//                                 until NextOfKinApp.Next = 0;
//                             end;

//                             AccountSignApp.Reset;
//                             AccountSignApp.SetRange(AccountSignApp."Account No", "No.");
//                             if AccountSignApp.Find('-') then begin
//                                 repeat
//                                     AccountSign.Init;
//                                     AccountSign."Account No" := AcctNo;
//                                     AccountSign.Names := AccountSignApp.Names;
//                                     AccountSign."Date Of Birth" := AccountSignApp."Date Of Birth";
//                                     AccountSign."Staff/Payroll" := AccountSignApp."Staff/Payroll";
//                                     AccountSign."ID No." := AccountSignApp."ID No.";
//                                     AccountSign.Signatory := AccountSignApp.Signatory;
//                                     AccountSign."Must Sign" := AccountSignApp."Must Sign";
//                                     AccountSign."Must be Present" := AccountSignApp."Must be Present";
//                                     AccountSign.Picture := AccountSignApp.Picture;
//                                     AccountSign.Signature := AccountSignApp.Signature;
//                                     AccountSign."Expiry Date" := AccountSignApp."Expiry Date";
//                                     AccountSign."Mobile Phone No." := AccountSignApp."Mobile Phone No.";
//                                     AccountSign.Insert;

//                                 until AccountSignApp.Next = 0;
//                             end;

//                             if "Micro Single" = true then begin
//                                 //MICRO FINANCE ACTIVITY
//                                 //Create BOSA account
//                                 Cust."No." := AcctNo;
//                                 Cust.Name := Name;
//                                 Cust.Address := Address;
//                                 Cust."Post Code" := "Post Code";
//                                 Cust.County := City;
//                                 Cust."Phone No." := "Phone No.";
//                                 Cust."Global Dimension 1 Code" := "Global Dimension 1 Code";
//                                 Cust."Global Dimension 2 Code" := "Global Dimension 2 Code";
//                                 Cust."Customer Posting Group" := 'MICRO';
//                                 Cust."Registration Date" := "Registration Date";
//                                 Cust.Status := Cust.Status::Active;
//                                 Cust."Employer Code" := "Employer Code";
//                                 Cust."Date of Birth" := "Date of Birth";
//                                 Cust."E-Mail" := "E-Mail (Personal)";
//                                 Cust.Location := Location;
//                                 //**
//                                 Cust."ID No." := "ID No.";
//                                 Cust."Group Code" := "Group Code";
//                                 Cust."Mobile Phone No" := "Mobile Phone No";
//                                 Cust."Marital Status" := "Marital Status";
//                                 Cust."Customer Type" := Cust."customer type"::MicroFinance;
//                                 Message('The Micro Account No is %1', Cust."No.");
//                                 Message('The Micro Member No is %1', Cust."No.");
//                                 Cust.Insert(true);
//                                 //END OF MICRO
//                             end;
//                             //END;
//                             "Application Status" := "application status"::Converted;
//                             Modify;
//                             //SMS Notification
//                             SendSMS;
//                             Message('Account approved & created successfully. Assign No. is - %1', AcctNo);

//                         end;

//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         FnUpdateControls();
//     end;

//     trigger OnOpenPage()
//     var
//     begin
//         FnUpdateControls();
//     end;

//     var

//         AccoutTypes: Record "Account Types-Saving Products";
//         Accounts: Record Vendor;
//         AcctNo: Code[50];
//         DimensionValue: Record "Dimension Value";
//         NextOfKin: Record "Accounts Next Of Kin Details";
//         NextOfKinApp: Record "Accounts App Kin Details";
//         // AccountSign: Record "Account Signatories Details";
//         // AccountSignApp: Record "Account App Signatories";
//         Acc: Record Vendor;
//         UsersID: Record User;
//         FieldEditable: Boolean;
//         Nok: Record "Accounts App Kin Details";
//         Cust: Record Customer;
//         NOKBOSA: Record "Accounts Next Of Kin Details";
//         BranchC: Code[20];
//         SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
//         DimensionV: Record "Dimension Value";
//         IncrementNo: Code[20];
//         MicSingle: Boolean;
//         MicGroup: Boolean;
//         BosaAcnt: Boolean;
//         EmailEdiatble: Boolean;
//         SaccoSetup: Record "Sacco No. Series";
//         MicroGroupCode: Boolean;
//         Vendor: Record Vendor;

//         Vend: Record Vendor;
//         GenSetUp: Record "Sacco General Set-Up";
//         CompInfo: Record "Company Information";
//         SMSMessage: Record "SMS Messages";
//         iEntryNo: Integer;
//         Text003: label 'Kindly specify the next of kin';
//         Text004: label 'Kindly Specify the Signatories';
//         parent: Boolean;
//         members: Record Customer;
//         SendApprovalEnabled: Boolean;
//         CancelApprovalEnabled: Boolean;
//         PostApprovalEnabled: Boolean;

//     local procedure OnAfterGetCurrRec()
//     begin
//         FnUpdateControls();
//     end;

//     local procedure FnMemberAccountAlreadyExists(): Boolean
//     var
//         VendorTable: Record Vendor;
//     begin
//         VendorTable.Reset();
//         VendorTable.SetRange(VendorTable."BOSA Account No", "BOSA Account No");
//         VendorTable.SetRange(VendorTable."Account Type", "Account Type");
//         if VendorTable.find('-') = true then begin
//             exit(true);
//         end else
//             if VendorTable.find('-') = false then begin
//                 exit(false);
//             end;
//     end;

//     local procedure FnUpdateControls()
//     begin
//         if status = Status::Open then begin
//             SendApprovalEnabled := true;
//             CancelApprovalEnabled := false;
//             PostApprovalEnabled := false;
//             FieldEditable := true;
//         end else
//             if status = Status::Pending then begin
//                 SendApprovalEnabled := false;
//                 FieldEditable := false;
//                 CancelApprovalEnabled := true;
//                 PostApprovalEnabled := false;
//             end else
//                 if status = Status::Approved then begin
//                     SendApprovalEnabled := false;
//                     CancelApprovalEnabled := false;
//                     PostApprovalEnabled := true;
//                     FieldEditable := false;
//                 end else
//                     if status = Status::Created then begin
//                         SendApprovalEnabled := false;
//                         CancelApprovalEnabled := false;
//                         FieldEditable := false;
//                         PostApprovalEnabled := false;
//                     end;
//     end;

//     procedure Controls()
//     var
//         ErrorProductExists: Label 'The member has this product';
//     begin
//         //.........................Check If Account is already opened
//         if FnMemberAccountAlreadyExists() = true then begin
//             Error(ErrorProductExists);
//         end;

//         if "Micro Single" = true then
//             MicroGroupCode := true;
//         if "Account Type" = 'JUNIOR' then
//             parent := true;
//     end;

//     procedure SendSMS()
//     begin

//     end;
// }
