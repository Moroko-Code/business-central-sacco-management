tableextension 51516079 "CustomerExt" extends Customer
{
    fields
    {
        field(10001; "No. of Approved Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Status" = const(Approved),
                                                        "Client Code" = field("No."),
                                                        "Outstanding Balance" = filter(<> 0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10002; "No. of Issued Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Status" = const(Issued),
                                                        "Client Code" = field("No.")));

            Editable = false;
            FieldClass = FlowField;
        }
        field(10003; "No. of Rejected Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Status" = const(Rejected),
                                                        "Client Code" = field("No.")));
            Caption = 'No. of Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10004; "No. of Members Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("No."),
                                                                 "Outstanding Balance" = filter(<> 0),
                                                                 Substituted = filter(false)));
            Caption = 'No. Members Guaranteed';
            Editable = false;
            FieldClass = FlowField;
        }
        field(68000; "Customer Type"; Option)
        {
            OptionMembers = " ",Member,Checkoff,Investments,Property,MicroFinance;
        }
        field(68001; "Registration Date"; Date)
        {
        }
        field(68002; "Current Loan"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = const(Loan),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Document No." = field("Document No. Filter"), "Posting Date" = field("Date Filter"),
                                                                   Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68003; "Current Shares"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Deposit Contribution"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                    Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }

        field(68005; "Principal Balance"; Decimal)
        {
        }
        field(68006; "Principal Repayment"; Decimal)
        {
        }
        field(68011; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(Loan | Repayment),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68012; Status; enum "Account Status")
        {
            trigger OnValidate()
            begin
            end;
        }

        field(68015; "Old Account No."; Code[20])
        {
        }
        field(68016; "Loan Product Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Loan Products Setup".Code;
        }
        field(68017; "Employer Code"; Code[50])
        {
            TableRelation = "Sacco Employers".Code;

            trigger OnValidate()
            var
                SCEMPCODE: Record "Sacco Employers";
            begin
                if SCEMPCODE.Get("Employer Code") then
                    "Employer Name" := SCEMPCODE.Description;
            end;
        }
        field(68018; "Date of Birth"; Date)
        {
            trigger OnValidate()
            begin
            end;
        }
        field(68019; "E-Mail (Personal)"; Text[50])
        {
        }
        field(68020; "Station/Department"; Code[20])
        {
            TableRelation = "Loans Guarantee Details"."Loan No" where(Name = field("Employer Code"));
        }
        field(68021; "Home Address"; Text[50])
        {
        }
        field(68022; Location; Text[50])
        {
        }
        field(68023; "Sub-County"; Text[50])
        {
        }
        field(68024; "Home county"; Text[50])
        {
        }
        field(68025; "Resons for Status Change"; Text[80])
        {
        }
        field(68026; "Payroll/Staff No"; Code[20])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(68027; "ID No."; Code[50])
        {
            Caption = 'ID No.';
            trigger OnValidate()
            begin
            end;
        }
        field(68028; "Mobile Phone No"; Code[50])
        {
            Caption = 'Mobile Phone No';
            trigger OnValidate()
            begin
            end;
        }
        field(68029; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Devorced,Widower;
        }
        field(68030; Signature; Media)
        {
            Caption = 'Signature';

        }
        field(68031; "Passport No."; Code[50])
        {
        }
        field(68032; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;

            trigger OnValidate()
            begin
            end;
        }
        field(68033; "Withdrawal Date"; Date)
        {
        }
        field(68034; "Withdrawal Fee"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }

        field(68036; "Withdrawal Application Date"; Date)
        {
            trigger OnValidate()
            begin
                if "Withdrawal Application Date" <> 0D then
                    "Withdrawal Date" := CalcDate('2M', "Withdrawal Application Date");
            end;
        }
        field(68037; "Investment Monthly Cont"; Decimal)
        {
        }
        field(68038; "Investment Max Limit."; Decimal)
        {
        }
        field(68039; "Current Investment Total"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = const("Application Fee"),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        "Document No." = field("Document No. Filter")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(68040; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(68041; "Shares Retained"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Shares Capital"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                    Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68043; "Registration Fee Paid"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                           "Transaction Type" = const("Registration Fee"),
                                                                           "Posting Date" = field("Date Filter"),
                                                                            Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68044; "Registration Fee"; Decimal)
        {
        }
        field(68045; "Society Code"; Code[20])
        {
        }
        // field(68046; "Insurance Fund"; Decimal)
        // {
        //     CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
        //                                                            "Transaction Type" = filter("Benevolent Fund"),
        //                                                            "Posting Date" = field("Date Filter"),
        //                                                            "Document No." = field("Document No. Filter"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(68047; "Holiday Monthly Contribution"; Decimal)
        // {
        //     trigger OnValidate()
        //     begin
        //     end;
        // }
        field(68048; "Investment B/F"; Decimal)
        {
        }
        field(68049; "Dividend Amount"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = const(dividend),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  Reversed = filter(false),
                                                                  "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68050; "Name of Chief"; Text[50])
        {
        }
        field(68051; "Office Telephone No."; Code[50])
        {
        }
        field(68052; "Extension No."; Code[30])
        {
        }
        field(68053; "Insurance Contribution"; Decimal)
        {
            trigger OnValidate()
            begin
                //Advice:=TRUE;
            end;
        }
        field(68054; Advice; Boolean)
        {
        }
        field(68055; Province; Code[50])
        {
        }
        field(68056; "Previous Share Contribution"; Decimal)
        {
        }
        field(68057; "Un-allocated Funds"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Unallocated Funds"),
                                                                   "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68058; "Refund Request Amount"; Decimal)
        {
            CalcFormula = sum(Refunds.Amount where("Member No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68059; "Refund Issued"; Boolean)
        {
            Editable = false;
        }
        field(68060; "Batch No."; Code[20])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(68061; "Current Status"; Option)
        {
            OptionMembers = Approved,Rejected;
        }
        field(68062; "Cheque No."; Code[20])
        {
        }
        field(68063; "Cheque Date"; Date)
        {
        }
        field(68064; "Accrued Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68065; "Defaulted Loans Recovered"; Boolean)
        {
        }
        field(68066; "Withdrawal Posted"; Boolean)
        {
        }
        field(68069; "Loan No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("No."));
        }
        field(68070; "Currect File Location"; Code[50])
        {
            CalcFormula = max("File Movement Tracker".Station where("Member No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68071; "Move To1"; Integer)
        {
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));
        }
        field(68073; "File Movement Remarks"; Text[50])
        {
        }
        field(68076; "Status Change Date"; Date)
        {
        }
        field(68077; "Last Payment Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No."), "Transaction Type" = filter("Deposit Contribution" | Repayment)));
            FieldClass = FlowField;
        }
        field(68078; "Discounted Amount"; Decimal)
        {
        }
        field(68079; "Current Savings"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Deposit Contribution"),
                                                                    "Posting Date" = field("Date Filter"),
                                                                    Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(68080; "Payroll Updated"; Boolean)
        {
        }
        field(68081; "Last Marking Date"; Date)
        {
        }
        field(68082; "Dividends Capitalised %"; Decimal)
        {
            trigger OnValidate()
            begin
            end;
        }
        field(68083; "FOSA Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(Loan | Repayment | "Unallocated Funds"),
                                                                  "Global Dimension 1 Code" = filter('FOSA'), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(68084; "FOSA Oustanding Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Interest Due"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(68085; "Formation/Province"; Code[20])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(68086; "Division/Department"; Code[20])
        {
            // TableRelation = Table51516158.Field1;
        }
        field(68087; "Station/Section"; Code[20])
        {
            // TableRelation = Table51516159.Field1;
        }
        field(68088; "Closing Deposit Balance"; Decimal)
        {
        }
        field(68089; "Closing Loan Balance"; Decimal)
        {
        }
        field(68090; "Closing Insurance Balance"; Decimal)
        {
        }
        field(68091; "Dividend Progression"; Decimal)
        {
        }
        field(68092; "Closing Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(68093; "Welfare Fund"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(68094; "Discounted Dividends"; Decimal)
        {
        }
        field(68095; "Mode of Dividend Payment"; Option)
        {
            OptionCaption = ' ,FOSA,EFT,Cheque,Defaulted Loan (Capitalised)';
            OptionMembers = " ",FOSA,EFT,Cheque,"Defaulted Loan";
        }
        field(68096; "Qualifying Shares"; Decimal)
        {
        }
        field(68097; "Defaulter Overide Reasons"; Text[60])
        {
        }
        field(68098; "Defaulter Overide"; Boolean)
        {
            trigger OnValidate()
            begin
            end;
        }
        field(68099; "Closure Remarks"; Text[40])
        {
        }
        field(68100; "Bank Account No."; Code[120])
        {
        }
        field(68101; "Bank Code"; Code[120])
        {
            //TableRelation = "Member App Signatories"."Account No";
            // ValidateTableRelation = false;
        }
        field(68102; "Dividend Processed"; Boolean)
        {
        }
        field(68103; "Dividend Error"; Boolean)
        {
        }
        field(68104; "Dividend Capitalized"; Decimal)
        {
        }
        field(68105; "Dividend Paid FOSA"; Decimal)
        {
        }
        field(68106; "Dividend Paid EFT"; Decimal)
        {
        }
        field(68107; "Dividend Withholding Tax"; Decimal)
        {
        }
        field(68109; "Loan Last Payment Date"; Date)
        {
            FieldClass = Normal;
        }
        // field(68110; "Outstanding Interest"; Decimal)
        // {
        //     CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
        //                                                                   "Transaction Type" = filter("Interest Paid" | "Interest Due"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
        //     FieldClass = FlowField;
        // }
        field(68111; "Last Transaction Date"; Date)
        {
            FieldClass = Normal;
        }
        field(68116; "Share Capital"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Shares Capital"),
                                                                   "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68112; "Account Category"; Option)
        {
            OptionCaption = 'Individual,Joint,Corporate,Group,Junior';
            OptionMembers = Individual,Joint,Corporate,Group,Junior;
        }
        field(68113; "Type Of Organisation"; Option)
        {
            OptionCaption = ' ,Club,Association,Partnership,Investment,Merry go round,Other,Group';
            OptionMembers = " ",Club,Association,Partnership,Investment,"Merry go round",Other,Group;
        }
        field(68114; "Source Of Funds"; Option)
        {
            OptionCaption = ' ,Business Receipts,Income from Investment,Salary,Other';
            OptionMembers = " ","Business Receipts","Income from Investment",Salary,Other;
        }
        field(68115; "MPESA Mobile No"; Code[20])
        {
        }
        field(68120; "Force No."; Code[20])
        {
        }
        field(68121; "Last Advice Date"; Date)
        {
        }
        field(68122; "Advice Type"; Option)
        {
            OptionMembers = " ","New Member","Shares Adjustment","ABF Adjustment","Registration Fees",Withdrawal,Reintroduction,"Reintroduction With Reg Fees";
        }
        field(68140; "Share Balance BF"; Decimal)
        {
        }
        field(68143; "Move to"; Integer)
        {
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));

            trigger OnValidate()
            var
                Approvalsetup: Record "Approvals Set Up";
            begin
                Approvalsetup.Reset;
                Approvalsetup.SetRange(Approvalsetup.Stage, "Move to");
                if Approvalsetup.Find('-') then
                    "Move to description" := Approvalsetup.Station;
            end;
        }
        field(68144; "File Movement Remarks1"; Option)
        {
            OptionCaption = ' ,Reconciliation purposes,Auditing purposes,Refunds,Loan & Signatories,Withdrawal,Risks payment,Cheque Payment,Custody,Document Filing,Passbook,Complaint Letters,Defaulters,Dividends,Termination,New Members Details,New Members Verification';
            OptionMembers = " ","Reconciliation purposes","Auditing purposes",Refunds,"Loan & Signatories",Withdrawal,"Risks payment","Cheque Payment",Custody,"Document Filing",Passbook,"Complaint Letters",Defaulters,Dividends,Termination,"New Members Details","New Members Verification";
        }
        field(68145; "File MVT User ID"; Code[20])
        {
        }
        field(68146; "File MVT Time"; Time)
        {
        }
        field(68147; "File Previous Location"; Code[20])
        {
        }
        field(68148; "File MVT Date"; Date)
        {
        }
        field(68149; "file received date"; Date)
        {
        }
        field(68150; "File received Time"; Time)
        {
        }
        field(68151; "File Received by"; Code[30])
        {
        }
        field(68152; "file Received"; Boolean)
        {
        }
        field(68153; User; Code[30])
        {
        }
        field(68154; "Change Log"; Integer)
        {
            CalcFormula = count("Change Log Entry" where("Primary Key Field 1 Value" = field("No.")));
            FieldClass = FlowField;
        }
        field(68155; Section; Code[10])
        {
            // TableRelation = if (Section = const('')) Table51516170.Field3;
        }
        field(68156; rejoined; Boolean)
        {
        }
        field(68157; "Job title"; Code[30])
        {
        }
        field(68158; Pin; Code[20])
        {
        }
        field(68160; "Remitance mode"; Option)
        {
            OptionCaption = ',Check off,Cash,Standing Order';
            OptionMembers = ,"Check off",Cash,"Standing Order";
        }
        field(68161; "Terms of Service"; Option)
        {
            OptionCaption = ',Permanent,Temporary,Contract';
            OptionMembers = ,Permanent,"Temporary",Contract;
        }
        field(68162; Comment1; Text[10])
        {
        }
        field(68163; Comment2; Text[20])
        {
        }
        field(68164; "Current file location"; Code[10])
        {
        }
        field(68165; "Work Province"; Code[10])
        {
        }
        field(68166; "Work District"; Code[10])
        {
        }
        field(68167; "Bank Name"; Text[160])
        {
        }
        field(68168; "Bank Branch"; Text[60])
        {
        }
        field(68169; "Customer Paypoint"; Code[10])
        {
            Enabled = false;
        }
        field(68170; "Date File Opened"; Date)
        {
        }
        field(68171; "File Status"; Code[10])
        {
        }
        field(68172; "Customer Title"; Code[10])
        {
        }
        field(68173; "Folio Number"; Code[20])
        {
            Enabled = false;
        }
        field(68174; "Move to description"; Text[20])
        {
        }
        field(68175; Filelocc; Integer)
        {
            CalcFormula = max("File Movement Tracker"."Entry No." where("Member No." = field("No.")));
            FieldClass = FlowField;
        }
        field(68176; "S Card No."; Code[10])
        {
        }
        field(68177; "Reason for file overstay"; Text[50])
        {
            Enabled = false;
        }
        field(68179; "Loc Description"; Text[100])
        {
            CalcFormula = lookup("File Movement Tracker".Description where("Entry No." = field(upperlimit(Filelocc)),
                                                                            "Member No." = field("No.")));
            FieldClass = FlowField;
        }
        field(68180; "Current Balance"; Decimal)
        {
        }
        field(68181; "Member Transfer Date"; Date)
        {
        }
        field(68182; "Contact Person"; Code[20])
        {
        }
        // field(68183; "Member withdrawable Deposits"; Decimal)
        // {
        //     CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
        //                                                           "Posting Date" = field("Date Filter"),
        //                                                           "Document No." = field("Document No. Filter"),
        //                                                           "Transaction Type" = const("Insurance Contribution")));
        //     FieldClass = FlowField;
        // }
        field(68184; "Current Location"; Text[20])
        {
        }
        field(68185; "Group Code"; Code[20])
        {
        }
        field(68186; "Monthly contribution"; Decimal)
        {
        }
        // field(68187; "Benevolent Fund"; Decimal)
        // {
        //     CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
        //                                                            "Transaction Type" = const("Benevolent Fund"),
        //                                                            "Posting Date" = field("Date Filter"),
        //                                                             Reversed = Const(false),
        //                                                            "Document No." = field("Document No. Filter")));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(68188; "Office Branch"; Code[20])
        {
        }
        field(68189; Department; Code[200])
        {
            //TableRelation = Table51516158.Field1;
        }
        field(68190; Occupation; Text[30])
        {
        }
        field(68191; Designation; Text[30])
        {
        }
        field(68192; "Current Residence"; Text[50])
        {

        }
        field(68193; "Incomplete Shares"; Boolean)
        {
            Enabled = false;
        }
        field(68194; "Contact Person Phone"; Code[30])
        {
        }
        // field(68195; "Development Shares"; Decimal)
        // {
        //     CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
        //                                                           "Transaction Type" = filter("Xmas Contribution"),
        //                                                           "Posting Date" = field("Date Filter")));
        //     Enabled = false;
        //     FieldClass = FlowField;
        // }
        // field(68196; "Fanikisha savings"; Decimal)
        // {
        //     CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
        //                                                            "Transaction Type" = filter("Penalty Paid"),
        //                                                            "Posting Date" = field("Date Filter")));
        //     Enabled = false;
        //     FieldClass = FlowField;
        // }
        field(68197; "Old Fosa Account"; Code[50])
        {
        }
        field(68198; "Recruited By"; Code[50])
        {
        }
        field(68200; "ContactPerson Relation"; Code[20])
        {
            // TableRelation = Table50091;
        }
        field(68201; "ContactPerson Occupation"; Code[20])
        {
            Enabled = false;
        }
        field(68202; "Member No. 2"; Code[20])
        {
        }


        field(68206; "Insurance on Shares"; Decimal)
        {
            Enabled = false;
        }
        field(68207; "Physical States"; Option)
        {
            Enabled = false;
            OptionCaption = 'Normal,Deaf,Blind';
            OptionMembers = Normal,Deaf,Blind;
        }
        field(68208; DIOCESE; Code[30])
        {
            Enabled = false;
        }
        field(68212; "Mobile No. 2"; Code[20])
        {
        }
        field(68213; "Employer Name"; Text[50])
        {
        }
        field(68214; Title; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(68215; Town; Code[30])
        {
            Editable = false;
        }
        field(68222; "Home Town"; Code[30])
        {
            Editable = false;
        }
        field(69038; "Loans Defaulter Status"; Option)
        {
            CalcFormula = lookup("Loans Register"."Loans Category-SASRA" where("Client Code" = field("No.")));
            FieldClass = FlowField;
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(69039; "Home Postal Code"; Code[15])
        {
            TableRelation = "Post Code".Code;
        }
        field(69040; "Total Loans Outstanding"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(69041; "No of Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("No."),
                                                                 "Outstanding Balance" = filter(<> 0),
                                                                 Substituted = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69042; "Member Found"; Boolean)
        {
        }




        field(69048; "Rejoining Date"; Date)
        {
        }
        field(69049; "Active Loans Guarantor"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("No."),
                                                                 "Outstanding Balance" = filter(> 0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69050; "Loans Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("No."),
             "Outstanding Balance" = filter(> 0)));

            Editable = false;
            FieldClass = FlowField;
        }
        field(69051; "Member Deposit *3"; Decimal)
        {
        }
        field(69052; "New loan Eligibility"; Decimal)
        {
        }
        field(69053; "Share Certificate No"; Integer)
        {
        }
        field(69054; "Last Share Certificate No"; Integer)
        {
            CalcFormula = max(Customer."Share Certificate No");
            FieldClass = FlowField;
        }
        field(69055; "No Of Days"; Integer)
        {
        }

        field(69060; "Loan Officer Name"; Text[30])
        {
            Editable = true;
        }
        field(69061; "Micro Group Code"; Code[30])
        {
        }
        field(69064; "Account Type"; Option)
        {
            OptionCaption = ' ,Single,Group';
            OptionMembers = " ",Single,Group;
        }
        field(69072; "Repayment Method"; Option)
        {
            OptionCaption = ' ,Amortised,Reducing Balance,Straight Line,Constants,Ukulima Flat';
            OptionMembers = " ",Amortised,"Reducing Balance","Straight Line",Constants,"Ukulima Flat";
        }
        field(69073; "Sms Notification"; Boolean)
        {
        }
        field(69074; "Group Account"; Boolean)
        {
        }
        field(69075; "Group Account Name"; Code[50])
        {
        }
        field(69076; "BOSA Account No."; Code[10])
        {
        }
        field(69077; "School Fees Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter("COOP Shares"), "Posting Date" = field("Date Filter"), Reversed = const(false),
            //                                                        "Document No." = field("Document No. Filter")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(69078; "Monthly Fixed Deposits Cont."; Decimal)
        {
        }
        field(69079; PortalPassword; Text[20])
        {
        }
        field(69080; "Monthly ShareCap Cont."; Decimal)
        {
        }
        field(69081; "MICRO Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(Loan | Repayment | "Unallocated Funds"),
                                                                  "Global Dimension 1 Code" = filter('MICRO'), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69082; "Fosa Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter("FOSA Shares"),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        Reversed = filter(false),
            //                                                        "Document No." = field("Document No. Filter")));
            // FieldClass = FlowField;
        }
        field(69083; "Rejoined By"; Text[100])
        {
        }
        field(69084; "van Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter("van Shares"),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        Reversed = filter(false),
            //                                                        "Document No." = field("Document No. Filter")));
            // FieldClass = FlowField;
        }
        field(69085; "Ceep Reg Paid"; Boolean)
        {
        }

        field(69089; "Loan Officer No"; Code[20])
        {
        }
        field(69090; "Direct Recovery Total"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter(Repayment | "Interest Paid"),
                                                                   "Document No." = filter('RCV*'),
                                                                   "Posting Date" = field("Date Filter"), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69091; Membership; Boolean)
        {
        }
        field(69092; "Lift Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter("Lift Shares"),
            //                                                        "Posting Date" = field("Date Filter"), Reversed = const(false)));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(69093; "Tamba Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter("Tamba Shares"),
            //                                                        "Posting Date" = field("Date Filter")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(69094; "Changamka Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter("Changamka Shares"),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        "Document No." = field("Document No. Filter")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(69095; "Kussco Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = const("Kuscco Shares"),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        "Document No." = field("Document No. Filter")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(69096; "CIC Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter("CIC shares"),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        "Document No." = field("Document No. Filter")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(69097; "Business Loan Officer"; Code[100])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(69098; Board; Boolean)
        {
        }
        field(69099; staff; Boolean)
        {
        }
        field(69100; "Net Dividend Payable"; Decimal)
        {
        }
        field(69101; "Shares Variance"; Decimal)
        {
        }
        field(69102; "Tax on Dividend"; Decimal)
        {
        }
        field(69103; "Div Amount"; Decimal)
        {
        }
        field(69104; "Gross Dividend Amount Payable"; Decimal)
        {
        }
        field(69105; "Member Picture"; Blob)
        {
        }
        field(69106; "Loan Arrears"; Decimal)
        {
            Editable = false;
        }
        field(69107; "Sacco Insider"; Boolean)
        {
        }
        field(69231; "Member Risk Level"; Option)
        {
            OptionCaption = 'Low Risk,Medium Risk,High Risk';
            OptionMembers = "Low Risk","Medium Risk","High Risk";
        }
        field(69232; "Due Diligence Measure"; Text[40])
        {
        }
        field(69233; "Retaine Dividends"; Boolean)
        {
        }
        field(69217; "Member Residency Status"; Text[20])
        {
            Description = 'What is the customer''s residency status?';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter("Residency Status"));
            ValidateTableRelation = false;
        }
        field(69218; "Individual Category"; Text[40])
        {
            Description = 'What is the customer category?';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter(Individuals));
            ValidateTableRelation = false;
        }
        field(69219; Entities; Text[35])
        {
            Description = 'What is the Entity Type?';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter(Entities));
            ValidateTableRelation = false;
        }
        field(69220; "Industry Type"; Text[40])
        {
            Description = 'What Is the Industry Type?';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter(Industry));
            ValidateTableRelation = false;
        }
        field(69221; "Length Of Relationship"; Text[35])
        {
            Description = 'What Is the Lenght Of the Relationship';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter("Length Of Relationship"));
            ValidateTableRelation = false;
        }
        field(69222; "International Trade"; Text[35])
        {
            Description = 'Is the customer involved in International Trade?';
            TableRelation = "Customer Risk Rating"."Sub Category" where(Category = filter("International Trade"));
            ValidateTableRelation = false;
        }
        field(69223; "Electronic Payment"; Text[20])
        {
            Description = 'Does the customer engage in electronic payments?';
            TableRelation = "Product Risk Rating"."Product Type Code" where("Product Category" = filter("Electronic Payment"));
            ValidateTableRelation = false;
        }
        field(69209; IPRS; Code[20])
        {
        }
        field(69224; "Accounts Type Taken"; Text[40])
        {
            Description = 'Which account type is the customer taking?';
            TableRelation = "Product Risk Rating"."Product Type Code" where("Product Category" = filter(Accounts));
            ValidateTableRelation = false;
        }
        field(69225; "Cards Type Taken"; Text[15])
        {
            Description = 'Which card is the customer taking?';
            TableRelation = "Product Risk Rating"."Product Type Code" where("Product Category" = filter(Cards));
            ValidateTableRelation = false;
        }
        field(69226; "Others(Channels)"; Text[40])
        {
            Description = 'Which products or channels is the customer taking?';
            TableRelation = "Product Risk Rating"."Product Type Code" where("Product Category" = filter(Others));
            ValidateTableRelation = false;
        }
        field(69227; "Enquiries Made"; Integer)
        {
            CalcFormula = count("General Equiries." where("Calling For" = const(Enquiry), "Lead Status" = const(Closed), "Member No" = field("No.")));
            FieldClass = FlowField;
        }
        field(69228; "Request Made"; Integer)
        {
            CalcFormula = count("General Equiries." where("Calling For" = const(Request), "Lead Status" = const(Closed), "Member No" = field("No.")));
            FieldClass = FlowField;
        }
        field(69229; "Appreciations Made"; Integer)
        {
            CalcFormula = count("General Equiries." where("Calling For" = const(Appreciation), "Lead Status" = const(Closed), "Member No" = field("No.")));
            FieldClass = FlowField;
        }
        field(69230; "Complains Made"; Integer)
        {
            CalcFormula = count("General Equiries." where("Calling For" = const(Complaint), "Lead Status" = const(Closed), "Member No" = field("No.")));
            FieldClass = FlowField;
        }
        field(69239; "Criticisms Made"; Integer)
        {
            CalcFormula = count("General Equiries." where("Calling For" = const(Criticism), "Lead Status" = const(Closed), "Member No" = field("No.")));
            FieldClass = FlowField;
        }
        field(69240; "Captured By"; Code[100])
        {
        }
        field(69241; "Account Created By"; Code[100])
        {
        }
        field(69242; "Principal Paid"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(Repayment), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69243; "Interest Paid"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Interest paid"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69245; "Group Officer"; Code[100])
        {
            //TableRelation = "Loan Officers Details".Name;
            // CalcFormula = lookup(Customer."Loan Officer Name" where("No." = field("Group Account No")));
            // FieldClass = FlowField;
        }
        field(69246; "Principal Arrears"; Decimal)
        {
            CalcFormula = sum("Loan Classification Calculator"."Principle In Arrears" where("Client Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(69247; "Interest Arrears"; Decimal)
        {
            CalcFormula = sum("Loan Classification Calculator"."Interest In Arrears" where("Client Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(69248; "Total Arrears"; Decimal)
        {
            CalcFormula = sum("Loan Classification Calculator"."Amount In Arrears" where("Client Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(69430; "Non Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //  field(69431; "Account Category"; enum "Memb App Acc Categ")
        // {
        // }
        field(69431; "Date Employed"; Date)
        {
        }
        field(69432; "Guardian No."; Code[50])
        {
            TableRelation = Customer."No.";
            DataClassification = ToBeClassified;

            // trigger OnValidate()
            // begin
            //     Cust.Reset;
            //     Cust.SetRange(Cust."No.", "Guardian No.");
            //     if Cust.Find('-') then begin
            //         "Guardian Name" := Cust.Name;
            //     end;
            // end;
        }
        field(69433; "Guardian Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69434; "Don't Charge Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69435; "Re-instated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69436; "Dormantancy Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69437; "Source of Income Member One"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(69438; "Source of IncomeMember Two"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(69439; JointRelationship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(69440; "Reasontocreatingajointaccount"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(69441; "Birth Certficate No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        //
        field(69442; "Registration No"; Code[30])
        {
        }
        field(69443; "ID NO/Passport 2"; Code[30])
        {
        }
        field(69444; "Registration office"; Text[30])
        {
            TableRelation = Location.Code;
        }
        field(69445; "Picture 2"; Blob)
        {
            SubType = Bitmap;
        }
        field(69446; "Signature  2"; Blob)
        {
            SubType = Bitmap;
        }
        field(69447; Title2; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(69448; "Mobile No. 3"; Code[20])
        {
        }
        field(69449; "Date of Birth2"; Date)
        {
        }
        field(69450; "Marital Status2"; Option)
        {
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(69451; Gender2; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(69452; Address3; Code[30])
        {
        }
        field(69453; "Home Postal Code2"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(69454; "Home Town2"; Text[60])
        {
        }
        field(69455; "Payroll/Staff No2"; Code[20])
        {
        }
        field(69456; "Employer Code2"; Code[20])
        {
            TableRelation = "Sacco Employers";
        }
        field(69457; "Employer Name2"; Code[50])
        {
        }
        field(69458; "E-Mail (Personal2)"; Text[50])
        {
        }
        field(69459; "Share Of Ownership Two"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69460; "Recruiter Name"; Text[50])
        {
        }
        field(69461; "Second Member Name"; Text[30])
        {
        }
        field(69462; "Share Of Ownership One"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69463; "Nature of Business"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(69464; Age; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(69195; "Reason For Membership Withdraw"; Option)
        {
            OptionMembers = ,Relocation,Expulsion,"Financial Constraints","Personal Reasons",Death;
        }

        field(69196; "Alpha Monthly Contribution"; Decimal) { }
        field(69197; "Junior Monthly Contribution"; Decimal) { }

        field(69200; "Dividend Processed Date"; Date) { }
        field(69201; "Receivables Amount"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(" "),
                                                                  "Posting Date" = field("Date Filter"),
                                                                   Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69202; "First Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(69203; "Second Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(69204; "Last Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(69205; "Fixed deposit"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Fixed Deposits Savings"),
                                                                    "Posting Date" = field("Date Filter"),
                                                                    Reversed = const(false)));

            Editable = false;
            FieldClass = FlowField;
        }
    }
}
