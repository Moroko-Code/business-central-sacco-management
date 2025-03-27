tableextension 51516069 "VendorExt" extends Vendor
{
    fields
    {
        field(1000; "Creditor Type"; enum CreditorTypeExt)
        {
            Caption = 'Creditor Type';
            DataClassification = ToBeClassified;
        }
        field(1001; "Preferred Bank Account"; Code[10])
        {
            Caption = 'Preferred Bank Account';
            TableRelation = "Vendor Bank Account".Code where("Vendor No." = field("No."));
        }
        field(10004; "UPS Zone"; Code[2])
        {
            Caption = 'UPS Zone';
        }
        field(10016; "Federal ID No."; Text[30])
        {
            Caption = 'Federal ID No.';
        }
        field(10017; "Bank Communication"; Option)
        {
            Caption = 'Bank Communication';
            OptionCaption = 'E English,F French,S Spanish';
            OptionMembers = "E English","F French","S Spanish";
        }
        field(10018; "Check Date Format"; Option)
        {
            Caption = 'Check Date Format';
            OptionCaption = ' ,MM DD YYYY,DD MM YYYY,YYYY MM DD';
            OptionMembers = " ","MM DD YYYY","DD MM YYYY","YYYY MM DD";
        }
        field(10019; "Check Date Separator"; Option)
        {
            Caption = 'Check Date Separator';
            OptionCaption = ' ,-,.,/';
            OptionMembers = " ","-",".","/";
        }
        field(10020; "IRS 1099 Code"; Code[10])
        {
            Caption = 'IRS 1099 Code';
        }
        field(10021; "Balance on Date"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount Posted" where("Vendor No." = field("No."),
                                                                           "Posting Date" = field(upperlimit("Date Filter")),
                                                                           "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                           "Currency Code" = field("Currency Filter")));
            Caption = 'Balance on Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10022; "Balance on Date (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount Posted" where("Vendor No." = field("No."),
                                                                                   "Posting Date" = field(upperlimit("Date Filter")),
                                                                                   "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = field("Currency Filter")));
            Caption = 'Balance on Date ($)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10023; "RFC No."; Code[13])
        {
            Caption = 'RFC No.';

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                case "Tax Identification Type" of
                //   "tax identification type"::"Legal Entity":
                //     ValidateRFCNo(12);
                //   "tax identification type"::"Natural Person":
                //     ValidateRFCNo(13);
                end;
                Vendor.Reset;
                Vendor.SetRange("RFC No.", "RFC No.");
                Vendor.SetFilter("No.", '<>%1', "No.");
                // if Vendor.FindFirst then
            end;
        }
        field(10024; "CURP No."; Code[18])
        {
            Caption = 'CURP No.';

            trigger OnValidate()
            begin
            end;
        }
        field(10025; "State Inscription"; Text[30])
        {
            Caption = 'State Inscription';
        }
        field(14020; "Tax Identification Type"; Option)
        {
            Caption = 'Tax Identification Type';
            OptionCaption = 'Legal Entity,Natural Person';
            OptionMembers = "Legal Entity","Natural Person";
        }
        field(68001; "Staff No"; Code[20])
        {
        }
        field(68002; "ID No."; Code[50])
        {
        }
        field(68003; "Last Maintenance Date"; Date)
        {
        }
        field(68004; "Activate Sweeping Arrangement"; Boolean)
        {
        }
        field(68005; "Sweeping Balance"; Decimal)
        {
        }
        field(68006; "Sweep To Account"; Code[30])
        {
            TableRelation = Vendor;
        }
        field(68007; "Fixed Deposit Status"; Option)
        {
            OptionCaption = ' ,Active,Matured,Closed,Not Matured';
            OptionMembers = " ",Active,Matured,Closed,"Not Matured";
        }
        field(68008; "Call Deposit"; Boolean)
        {
            trigger OnValidate()
            begin
            end;
        }
        field(68009; "Mobile Phone No"; Code[50])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(68010; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married,Divorced,Widower';
            OptionMembers = " ",Single,Married,Divorced,Widower;
        }
        field(68011; "Registration Date"; Date)
        {
            trigger OnValidate()
            begin
                //IF FDType.GET("Fixed Deposit Type") THEN
                //"FD Maturity Date":=CALCDATE(FDType.Duration,"Registration Date");
                if "Account Type" = 'FIXED' then begin
                    TestField("Registration Date");
                    "FD Maturity Date" := CalcDate("Fixed Duration", "Registration Date");
                end;
            end;
        }
        field(68012; "BOSA Account No"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(68013; Signature; Media)
        {
            Caption = 'Signature';
            //SubType = Bitmap;
        }
        field(68014; "Passport No."; Code[50])
        {
        }
        field(68015; "Company Code"; Code[80])
        {
            TableRelation = "Sacco Employers";
        }
        field(68016; Status; Option)
        {
            OptionCaption = 'Active,Frozen,Closed,Archived,New,Dormant,Deceased';
            OptionMembers = Active,Frozen,Closed,Archived,New,Dormant,Deceased;

            trigger OnValidate()
            begin
                if (Status = Status::Active) or (Status = Status::New) then
                    Blocked := Blocked::" "
                else
                    Blocked := Blocked::All
            end;
        }
        field(68017; "Account Type"; Code[20])
        {
            TableRelation = "Account Types-Saving Products".Code;

            trigger OnValidate()
            var
                AccountTypes: Record "Account Types-Saving Products";
            begin
                if AccountTypes.Get("Account Type") then begin
                    AccountTypes.TestField(AccountTypes."Posting Group");
                    "Vendor Posting Group" := AccountTypes."Posting Group";
                    "Call Deposit" := false;
                end;
            end;
        }
        field(68018; "Account Category"; Option)
        {
            OptionCaption = 'Single,Joint,Corporate,Group,Branch,Project';
            OptionMembers = Single,Joint,Corporate,Group,Branch,Project;
        }
        field(68019; "FD Marked for Closure"; Boolean)
        {
        }
        field(68020; "Last Withdrawal Date"; Date)
        {
        }
        field(68021; "Last Overdraft Date"; Date)
        {
        }
        field(68022; "Last Min. Balance Date"; Date)
        {
        }
        field(68023; "Last Deposit Date"; Date)
        {
        }
        field(68024; "Last Transaction Posting Date"; Date)
        {
        }
        field(68025; "Date Closed"; Date)
        {
        }
        field(68026; "Uncleared Cheques"; Decimal)
        {
            CalcFormula = sum(Transactions.Amount where("Account No" = field("No."),
                                                         Posted = const(true),
                                                         "Cheque Processed" = const(false),
                                                         Type = const('Cheque Deposit')));
            FieldClass = FlowField;
        }
        field(68027; "Expected Maturity Date"; Date)
        {
        }
        field(68028; "ATM Transactions"; Decimal)
        {
            CalcFormula = sum("ATM Transactions".Amount where("Account No" = field("No."),
                                                               Posted = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68029; "Date of Birth"; Date)
        {
            trigger OnValidate()
            begin
                if "Date of Birth" > Today then
                    Error('Date of birth cannot be greater than today');
            end;
        }
        field(68030; "Last Transaction Date"; Date)
        {
            AutoFormatType = 1;
            CalcFormula = max("Detailed Vendor Ledg. Entry"."Posting Date" where("Vendor No." = field("No.")));
            Caption = 'Last Transaction Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(68032; "E-Mail (Personal)"; Text[50])
        {
        }
        field(68033; Section; Code[20])
        {
            TableRelation = Stations.Code where("Employer Code" = field("Company Code"));
        }
        field(68034; "Card No."; Code[50])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(68035; "Home Address"; Text[50])
        {
        }
        field(68036; Location; Text[50])
        {
        }
        field(68037; "Sub-Location"; Text[50])
        {
        }
        field(68038; District; Text[50])
        {
        }
        field(68039; "Resons for Status Change"; Text[200])
        {
        }
        field(68040; "Closure Notice Date"; Date)
        {
        }

        // field(68042; "Interest Earned"; Decimal)
        // {
        //     CalcFormula = sum("Interest Buffer"."Interest Amount" where("Account No" = field("No.")));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(68043; "Untranfered Interest"; Decimal)
        // {
        //     CalcFormula = sum("Interest Buffer"."Interest Amount" where("Account No" = field("No."),
        //                                                                  Transferred = const(false)));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(68044; "FD Maturity Date"; Date)
        {
            trigger OnValidate()
            begin
                /*"FD Duration":="FD Maturity Date"-"Registration Date";
                 "FD Duration":=ROUND("FD Duration"/30,1);
                MODIFY;*/
            end;
        }
        field(68045; "Savings Account No."; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("BOSA Account No"));
        }
        field(68046; "Old Account No."; Code[20])
        {
        }
        field(68047; "Salary Processing"; Boolean)
        {
        }
        field(68048; "Amount to Transfer"; Decimal)
        {
            trigger OnValidate()
            begin
                CalcFields(Balance);
                TestField("Registration Date");
            end;
        }
        field(68049; Proffesion; Text[50])
        {
        }
        field(68050; "Signing Instructions"; Text[250])
        {
        }
        field(68051; Hide; Boolean)
        {
        }
        field(68052; "Monthly Contribution"; Decimal)
        {
        }
        field(68053; "Not Qualify for Interest"; Boolean)
        {
        }
        field(68054; Gender; Option)
        {
            OptionMembers = Male,Female;
        }
        field(68055; "Fixed Duration"; DateFormula)
        {
            trigger OnValidate()
            begin
                if "Account Type" = 'FIXED' then begin
                    TestField("Registration Date");
                    "FD Maturity Date" := CalcDate("Fixed Duration", "Registration Date");
                end;
            end;
        }
        field(68056; "System Created"; Boolean)
        {
        }
        field(68057; "External Account No"; Code[50])
        {
        }
        field(68058; "Bank Code"; Code[20])
        {
            TableRelation = Banks.Code;
        }
        field(68059; Enabled; Boolean)
        {
        }
        field(68061; "Defaulted Loans Recovered"; Boolean)
        {
        }
        field(68062; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(68064; "Formation/Province"; Code[20])
        {
            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
                Vend.Reset;
                Vend.SetRange(Vend."Staff No", "Staff No");
                if Vend.Find('-') then
                    repeat
                        Vend."Formation/Province" := "Formation/Province";
                        Vend.Modify;
                    until Vend.Next = 0;
            end;
        }
        field(68065; "Division/Department"; Code[20])
        {
            TableRelation = "Member Departments"."No.";
        }
        field(68066; "Station/Sections"; Code[20])
        {
            TableRelation = "Member Section"."No.";
        }
        field(68067; "Neg. Interest Rate"; Decimal)
        {
        }
        field(68068; "Date Renewed"; Date)
        {
        }
        // field(68069; "Last Interest Date"; Date)
        // {
        //     CalcFormula = max("Interest Buffer"."Interest Date" where("Account No" = field("No.")));
        //     FieldClass = FlowField;
        // }

        field(68073; "MPESA Mobile No"; Code[20])
        {
        }
        field(68094; "ATM Prov. No"; Code[18])
        {
        }
        field(68096; "Dividend Paid"; Decimal)
        {
        }
        field(68120; "Force No."; Code[20])
        {
        }
        field(68121; "Card Expiry Date"; Date)
        {
        }
        field(68122; "Card Valid From"; Date)
        {
        }
        field(68123; "Card Valid To"; Date)
        {
        }
        field(69002; Service; Text[50])
        {
        }
        field(69005; Reconciled; Boolean)
        {
        }
        field(69009; "FD Duration"; Integer)
        {
            trigger OnValidate()
            begin
                // "FD Maturity Date":="Registration Date"+("FD Duration"*30);
                //MODIFY;
            end;
        }
        field(69010; "Employer P/F"; Code[20])
        {
        }
        field(69017; "Outstanding Balance"; Decimal)
        {
        }
        field(69018; "Atm card ready"; Boolean)
        {
            trigger OnValidate()
            var
                StatusPermissions: Record "Status Change Permision";
            begin
                if "Atm card ready" = true then begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User Id", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Atm card ready");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permission to change atm status');
                end;
            end;
        }
        field(69019; "Current Shares"; Decimal)
        {
        }
        field(69020; "Debtor Type"; Option)
        {
            OptionCaption = ',FOSA Account,Micro Finance';
            OptionMembers = " ","FOSA Account","Micro Finance";
        }
        field(69021; "Group Code"; Code[30])
        {
        }
        field(69022; "Group Account"; Boolean)
        {
        }
        field(69023; "Shares Recovered"; Boolean)
        {
        }
        field(69024; "Group Balance"; Decimal)
        {
        }
        field(69025; "Old Bosa Acc no"; Code[30])
        {
        }
        field(69026; "Group Loan Balance"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter(Repayment | Loan | "Unallocated Funds"),
                                                                   "Group Code" = field("Group Code"),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69027; "ContactPerson Relation"; Code[20])
        {
        }
        field(69028; "ContactPerson Occupation"; Code[20])
        {
        }
        field(69029; "ContacPerson Phone"; Text[30])
        {
        }
        field(69030; "Recruited By"; Code[20])
        {
        }
        field(69031; "ClassB Shares"; Decimal)
        {
        }
        field(69032; "Date ATM Linked"; Date)
        {
        }
        field(69033; "ATM No."; Code[50])
        {
        }
        field(69034; "Reason For Blocking Account"; Text[50])
        {
        }
        field(69035; "Uncleared Loans"; Decimal)
        {
            CalcFormula = sum("Loans Register"."Net Payment to FOSA" where("Account No" = field("No."),
                                                                            Posted = filter(true),
                                                                            "Processed Payment" = filter(false)));
            FieldClass = FlowField;
        }
        field(69036; NetDis; Decimal)
        {
            CalcFormula = sum("Loans Register"."Net Payment to FOSA" where("Account No" = field("No."),
                                                                            "Processed Payment" = filter(false)));
            FieldClass = FlowField;
        }
        field(69037; "Transfer Amount to Savings"; Decimal)
        {
        }
        field(69038; "Notice Date"; Date)
        {
        }
        field(69039; "Account Frozen"; Boolean)
        {
            Editable = false;
        }
        field(69040; "Interest rate"; Decimal)
        {
        }
        field(69041; "Fixed duration2"; Integer)
        {
        }
        field(69042; "FDR Deposit Status Type"; Option)
        {
            Editable = false;
            OptionCaption = 'New,Renewed,Terminated';
            OptionMembers = New,Renewed,Terminated;
        }
        field(69043; "ATM Expiry Date"; Date)
        {
        }
        field(69044; "Authorised Over Draft"; Decimal)
        {
            CalcFormula = sum("Over Draft Authorisation"."Approved Amount" where("Account No." = field("No."),
                                                                                  Status = const(Approved),
                                                                                  Expired = const(false),
                                                                                  Liquidated = const(false),
                                                                                  "Effective/Start Date" = field("Date Filter"),
                                                                                  Posted = const(true)));
            FieldClass = FlowField;
        }
        field(69045; "Net Salary"; Decimal)
        {
        }
        field(69046; "FD Maturity Instructions"; Option)
        {
            OptionCaption = ' ,Transfer to Savings,Transfer Interest & Renew,Renew';
            OptionMembers = " ","Transfer to Savings","Transfer Interest & Renew",Renew;
        }
        field(69047; "ATM Card Approved by"; Code[50])
        {
        }
        field(69048; "Disabled ATM Card No"; Code[18])
        {
            Editable = false;
        }
        field(69049; "Reason For Disabling ATM Card"; Text[200])
        {
        }
        field(69050; "Disable ATM Card"; Boolean)
        {
            trigger OnValidate()
            var
                StatusPermissions: Record "Status Change Permision";
            begin
                if "Disable ATM Card" = true then begin

                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User Id", UserId);
                    // StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"29");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to disable Atm cards');

                    if "ATM No." = '' then
                        Error('You cannot disable a blank ATM Card');

                    if "Reason For Disabling ATM Card" = '' then
                        Error('You must specify reason for disabling this atm');

                    "Disabled ATM Card No" := "ATM No.";
                    "ATM No." := '';
                    "ATM Prov. No" := '';
                    "Atm card ready" := false;
                    "Disabled By" := UserId;
                    Modify;
                end;
            end;
        }
        field(69051; "Disabled By"; Code[50])
        {
        }
        field(69052; "Transfer Type"; Option)
        {
            OptionCaption = ' ,Deposits,Share Capital,Jaza Jaza';
            OptionMembers = " ",Deposits,"Share Capital","Jaza Jaza";
        }
        field(69053; "ATM Alert Sent"; Boolean)
        {
        }
        field(69054; "Old Vendor No."; Code[10])
        {
        }
        field(69055; "Loan No"; Code[20])
        {
            // TableRelation = "Loans Register"."Loan  No." where("Account No" = field("No."),
            //                                                     Posted = const(true),
            //                                                     "Outstanding Balance" = filter(> 0));
            TableRelation = "Loans Register"."Loan  No." where("Account No" = field("No."),
                                                               "Total Balance" = filter(<> 0));
        }
        field(69056; "Principle Amount"; Decimal)
        {
        }
        field(69057; "Interest Amount"; Decimal)
        {
        }
        field(69058; "Bankers Cheque Amount"; Decimal)
        {
        }
        field(69060; "Registered M-Sacco"; Boolean)
        {
        }
        field(69061; "Sms Notification"; Boolean)
        {
        }
        field(69062; "Reason for Enabling ATM Card"; Text[30])
        {
        }
        field(69063; "Enabled By"; Code[20])
        {
        }
        field(69064; "Date Enabled"; Date)
        {
        }
        field(69065; "Pepea Shares"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount Posted" where("Vendor No." = field("No."),
                                                                                   "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = field("Currency Filter"),
                                                                                   "Transaction Type" = filter("Pepea Shares")));
            FieldClass = FlowField;
        }
        field(69066; "Transaction Type Fosa"; Option)
        {
            OptionCaption = ' ,Pepea Shares,School Fees Shares';
            OptionMembers = " ","Pepea Shares","School Fees Shares";
        }
        field(69067; "School Fees Shares"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount Posted" where("Vendor No." = field("No."),
                                                                          "Transaction Type Fosa" = filter("School Fees Shares")));
            FieldClass = FlowField;
        }
        field(69068; "Pepea Share"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount Posted" where("Vendor No." = field("No."),
                                                                          "Transaction Type Fosa" = filter("Pepea Shares")));
            FieldClass = FlowField;
        }
        field(69069; "Modified By"; Code[45])
        {
        }
        field(69070; "Outstanding Loans"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(Loan | Repayment | "Unallocated Funds"),

                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69071; "Outstanding Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid"),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69072; "Grower No"; Code[20])
        {
        }
        field(69073; "Pastrol Cont"; Decimal)
        {
        }
        field(69074; "Paid RegFee"; Boolean)
        {
        }
        field(69075; "Piggy Amount"; Decimal)
        {
        }
        field(69076; "Junior Trip"; Decimal)
        {
        }
        field(69077; "Holiday Savings"; Decimal)
        {
        }
        field(69078; "Cheque Acc. No"; Code[20])
        {
        }
        field(69079; "Overdraft amount"; Decimal)
        {
        }
        field(69080; "Remaining balance"; Decimal)
        {
        }
        field(69081; "Outstanding Overdraft"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                  "Transaction Type" = filter(Loan | Repayment),
                                                                  "Loan product Type" = const('OVERDRAFT'),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69082; "Sacco Lawyer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516062; "Do Not Include?"; Boolean)
        {
        }
        field(51516063; "Oustanding Overdraft interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                  "Transaction Type" = filter("Interest due" | "Interest Paid"),
                                                                  "Loan product Type" = const('OVERDRAFT'),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(51516065; "Mobile Transactions"; Decimal)
        {
        }
        field(51516066; "Account Balance"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount Posted" WHERE("Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6907001; "Outstanding okoa biashara"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                  "Transaction Type" = filter(Loan | Repayment),
                                                                  "Loan product Type" = const('OKOA'),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(6907002; "FOSA Balance"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter"), "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6907003; "Outstanding FOSA Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid"),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)
                                                                  , "Global Dimension 1 Code" = const('FOSA')));
            FieldClass = FlowField;
        }
        field(6907004; "Outstanding FOSA Loan"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                  "Transaction Type" = filter("Loan" | "Repayment"),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)
                                                                  , "Global Dimension 1 Code" = const('FOSA')
                                                                  ));
            FieldClass = FlowField;
        }
        field(6907005; "Outstanding Overdraft Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid"),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)
                                                                  , "Loan product Type" = const('OVERDRAFT')));
            FieldClass = FlowField;
        }
        field(6907006; "Outstanding OKOA Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid"),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)
                                                                  , "Loan product Type" = const('OKOA')));
            FieldClass = FlowField;
        }
        field(6907008; "Total Outstanding Overdraft"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid" | "Loan" | "Repayment"),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)
                                                                  , "Loan product Type" = const('OVERDRAFT')));
            FieldClass = FlowField;
        }
        field(6907009; "Total Outstanding Okoa"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid" | "Loan" | "Repayment"),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)
                                                                  , "Loan product Type" = const('OKOA')));
            FieldClass = FlowField;
        }
        field(6907010; "Total Debits"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Debit Amount" WHERE("Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter"), "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6907011; "Total Credits"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Credit Amount" WHERE("Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter"), "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key22; "Account Type")
        {
        }
        key(Key23; "BOSA Account No")
        {
        }
    }

    fieldgroups
    {
        addlast(DropDown; "ID No.")
        {
        }
    }

    trigger OnDelete()
    begin

        // Error('You cannot delete an existing FOSA Account');

        // MoveEntries.MoveVendorEntries(Rec);

        // CommentLine.SetRange("Table Name", CommentLine."table name"::Vendor);
        // CommentLine.SetRange("No.", "No.");
        // CommentLine.DeleteAll;

        // VendBankAcc.SetRange("Vendor No.", "No.");
        // VendBankAcc.DeleteAll;

        // OrderAddr.SetRange("Vendor No.", "No.");
        // OrderAddr.DeleteAll;

        // // ItemCrossReference.SetCurrentkey("Cross-Reference Type", "Cross-Reference Type No.");
        // // ItemCrossReference.SetRange("Cross-Reference Type", ItemCrossReference."cross-reference type"::Vendor);
        // // ItemCrossReference.SetRange("Cross-Reference Type No.", "No.");
        // // ItemCrossReference.DeleteAll;

        // PurchOrderLine.SetCurrentkey("Document Type", "Pay-to Vendor No.");
        // PurchOrderLine.SetFilter(
        //   "Document Type", '%1|%2',
        //   PurchOrderLine."document type"::Order,
        //   PurchOrderLine."document type"::"Return Order");
        // PurchOrderLine.SetRange("Pay-to Vendor No.", "No.");
        // if PurchOrderLine.FindFirst then
        //     Error(
        //       Text000,
        //       TableCaption, "No.",
        //       PurchOrderLine."Document Type");

        // PurchOrderLine.SetRange("Pay-to Vendor No.");
        // PurchOrderLine.SetRange("Buy-from Vendor No.", "No.");
        // if PurchOrderLine.FindFirst then
        //     Error(
        //       Text000,
        //       TableCaption, "No.");

        // UpdateContFromVend.OnDelete(Rec);

        // DimMgt.DeleteDefaultDim(Database::Vendor, "No.");

        // ServiceItem.SetRange("Vendor No.", "No.");
        // ServiceItem.ModifyAll("Vendor No.", '');

        // ItemVendor.SetRange("Vendor No.", "No.");
        // ItemVendor.DeleteAll(true);

        // PurchPrice.SetCurrentkey("Vendor No.");
        // PurchPrice.SetRange("Vendor No.", "No.");
        // PurchPrice.DeleteAll(true);

        // PurchLineDiscount.SetCurrentkey("Vendor No.");
        // PurchLineDiscount.SetRange("Vendor No.", "No.");
        // PurchLineDiscount.DeleteAll(true);

        // CustomReportSelection.SetRange("Source Type", Database::Vendor);
        // CustomReportSelection.SetRange("Source No.", "No.");
        // CustomReportSelection.DeleteAll;

        // PurchPrepmtPct.SetCurrentkey("Vendor No.");
        // PurchPrepmtPct.SetRange("Vendor No.", "No.");
        // PurchPrepmtPct.DeleteAll(true);
    end;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            PurchSetup.Get;
            PurchSetup.TestField("Vendor Nos.");
            NoSeriesMgt.InitSeries(PurchSetup."Vendor Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        if "Invoice Disc. Code" = '' then
            "Invoice Disc. Code" := "No.";
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
        "Modified By" := UserId;

        if (Name <> xRec.Name) or
           ("Search Name" <> xRec."Search Name") or
           ("Name 2" <> xRec."Name 2") or
           (Address <> xRec.Address) or
           ("Address 2" <> xRec."Address 2") or
           (City <> xRec.City) or
           ("Phone No." <> xRec."Phone No.") or
           ("Telex No." <> xRec."Telex No.") or
           ("Territory Code" <> xRec."Territory Code") or
           ("Currency Code" <> xRec."Currency Code") or
           ("Language Code" <> xRec."Language Code") or
           ("Purchaser Code" <> xRec."Purchaser Code") or
           ("Country/Region Code" <> xRec."Country/Region Code") or
           ("Fax No." <> xRec."Fax No.") or
           ("Telex Answer Back" <> xRec."Telex Answer Back") or
           ("VAT Registration No." <> xRec."VAT Registration No.") or
           ("Post Code" <> xRec."Post Code") or
           (County <> xRec.County) or
           ("E-Mail" <> xRec."E-Mail") or
           ("Home Page" <> xRec."Home Page")
        then;
        //MODIFY;
        //UpdateContFromVend.OnModify(Rec);
        //IF FIND THEN;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
        "Modified By" := UserId;
    end;

    var
        Text003: label 'Do you wish to create a contact for %1 %2?';
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UpdateContFromVend: Codeunit "VendCont-Update";
        DimMgt: Codeunit DimensionManagement;
        InsertFromContact: Boolean;
        Text005: label 'post';
        Text006: label 'create';
        Text011: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text10000: label '%1 is not a valid RFC No.';

    procedure AssistEdit(OldVend: Record Vendor): Boolean
    var
        Vend: Record Vendor;
    begin
        with Vend do begin
            Vend := Rec;
            PurchSetup.Get;
            PurchSetup.TestField("Vendor Nos.");
            if NoSeriesMgt.SelectSeries(PurchSetup."Vendor Nos.", OldVend."No. Series", "No. Series") then begin
                PurchSetup.Get;
                PurchSetup.TestField("Vendor Nos.");
                NoSeriesMgt.SetSeries("No.");
                Rec := Vend;
                exit(true);
            end;
        end;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::Vendor, "No.", FieldNumber, ShortcutDimCode);
        Modify;
    end;

    procedure ShowContact()
    var
        ContBusRel: Record "Contact Business Relation";
        Cont: Record Contact;
    begin
        if "No." = '' then
            exit;

        ContBusRel.SetCurrentkey("Link to Table", "No.");
        ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Vendor);
        ContBusRel.SetRange("No.", "No.");
        if not ContBusRel.FindFirst then begin
            if not Confirm(Text003, false, TableCaption, "No.") then
                exit;
            UpdateContFromVend.InsertNewContact(Rec, false);
            ContBusRel.FindFirst;
        end;
        Commit;

        Cont.SetCurrentkey("Company Name", "Company No.", Type, Name);
        Cont.SetRange("Company No.", ContBusRel."Contact No.");
        Page.Run(Page::"Contact List", Cont);
    end;

    procedure SetInsertFromContact(FromContact: Boolean)
    begin
        InsertFromContact := FromContact;
    end;

    procedure CheckBlockedVendOnDocs(Vend2: Record Vendor; Transaction: Boolean)
    begin
        if Vend2.Blocked = Vend2.Blocked::All then
            VendBlockedErrorMessage(Vend2, Transaction);
    end;

    procedure CheckBlockedVendOnJnls(Vend2: Record Vendor; DocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund; Transaction: Boolean)
    begin
        with Vend2 do
            if (Blocked = Blocked::All) or
               (Blocked = Blocked::Payment) and (DocType = Doctype::Payment)
            then
                VendBlockedErrorMessage(Vend2, Transaction);
    end;

    procedure CreateAndShowNewInvoice()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader."Document Type" := PurchaseHeader."document type"::Invoice;
        PurchaseHeader.SetRange("Buy-from Vendor No.", "No.");
        PurchaseHeader.Insert(true);
        Commit;
        // Page.RunModal(Page::"Mini Purchase Invoice",PurchaseHeader)
    end;

    procedure CreateAndShowNewCreditMemo()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader."Document Type" := PurchaseHeader."document type"::"Credit Memo";
        PurchaseHeader.SetRange("Buy-from Vendor No.", "No.");
        PurchaseHeader.Insert(true);
        Commit;
        //  Page.RunModal(Page::"Mini Purchase Credit Memo",PurchaseHeader)
    end;

    procedure VendBlockedErrorMessage(Vend2: Record Vendor; Transaction: Boolean)
    var
        "Action": Text[30];
    begin
        if Transaction then
            Action := Text005
        else
            Action := Text006;
        // For Divindends Export Comment this Error
        //ERROR(Text007,Action,Vend2."No.",Vend2.Blocked);
    end;

    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        if MapPoint.FindFirst then
            MapMgt.MakeSelection(Database::Vendor, GetPosition)
        else
            Message(Text011);
    end;

    procedure CalcOverDueBalance() OverDueBalance: Decimal
    var
        [SecurityFiltering(Securityfilter::Filtered)]
        VendLedgEntryRemainAmtQuery: Query "Vend. Ledg. Entry Remain. Amt.";
    begin
        VendLedgEntryRemainAmtQuery.SetRange(Vendor_No, "No.");
        VendLedgEntryRemainAmtQuery.SetRange(IsOpen, true);
        VendLedgEntryRemainAmtQuery.SetFilter(Due_Date, '<%1', WorkDate);
        VendLedgEntryRemainAmtQuery.Open;

        if VendLedgEntryRemainAmtQuery.Read then
            OverDueBalance := VendLedgEntryRemainAmtQuery.Sum_Remaining_Amt_LCY;
    end;

    procedure ValidateRFCNo(Length: Integer)
    begin
        if StrLen("RFC No.") <> Length then
            Error(Text10000, "RFC No.");
    end;

    procedure GetInvoicedPrepmtAmountLCY(): Decimal
    var
        PurchLine: Record "Purchase Line";
    begin
        PurchLine.SetCurrentkey("Document Type", "Pay-to Vendor No.");
        PurchLine.SetRange("Document Type", PurchLine."document type"::Order);
        PurchLine.SetRange("Pay-to Vendor No.", "No.");
        PurchLine.CalcSums("Prepmt. Amount Inv. (LCY)", "Prepmt. VAT Amount Inv. (LCY)");
        exit(PurchLine."Prepmt. Amount Inv. (LCY)" + PurchLine."Prepmt. VAT Amount Inv. (LCY)");
    end;

    procedure GetTotalAmountLCY(): Decimal
    begin
        CalcFields(
          "Balance (LCY)", "Outstanding Orders (LCY)", "Amt. Rcd. Not Invoiced (LCY)", "Outstanding Invoices (LCY)");

        exit(
          "Balance (LCY)" + "Outstanding Orders (LCY)" +
          "Amt. Rcd. Not Invoiced (LCY)" + "Outstanding Invoices (LCY)" - GetInvoicedPrepmtAmountLCY);
    end;
}
