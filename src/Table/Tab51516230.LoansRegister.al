#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516230 "Loans Register"
{
    DrillDownPageID = "Loans DrillDown List";
    LookupPageID = "Loans DrillDown List";
    fields
    {
        field(1; "Loan  No."; Code[30])
        {
            trigger OnValidate()
            begin

                //SURESTEP
                if Source = Source::BOSA then
                    if "Loan  No." <> xRec."Loan  No." then begin
                        SalesSetup.Get;
                        NoSeriesMgt.TestManual(SalesSetup."BOSA Loans Nos");
                        "No. Series" := '';
                    end;
            end;
        }
        field(2; "Application Date"; Date)
        {
            // trigger OnValidate()
            // begin
            //     if "Application Date" <> Today then
            //         Error('Application date MUST be Today.');
            // end;
        }
        field(3; "Client Code"; Code[50])
        {
            TableRelation = if (Source = const(BOSA)) Customer."No." where("Customer Posting Group" = const('MEMBER'), Status = const(Active))
            else
            if (Source = const(FOSA)) Customer."No."
            else
            if (Source = const(MICRO)) Customer."No." where("Customer Posting Group" = const('MICRO'));

            trigger OnValidate()
            begin
                //--------------------------------------------------------
                GenSetUp.Get();

                "BOSA No" := "Client Code";

                if "Client Code" = '' then
                    "Client Name" := '';

                if CustomerRecord.Get("Client Code") then begin
                    if CustomerRecord.Blocked = CustomerRecord.Blocked::All then
                        Error('Member is blocked from transacting ' + "Client Code");

                    //-------------------------------------------------

                    if Source = Source::BOSA then begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "Client Code");
                        if Cust.Find('-') then begin
                            Cust.CalcFields(Cust."Current Shares");
                            sHARES := Cust."Current Shares" * -1;
                            IF CUST."Account Category" <> CUST."Account Category"::Individual then
                                if (sHARES = 0) then
                                    Error(Text012);
                        end;
                    end;
                    //-------------------------------------------------------------------
                    if CustomerRecord."Registration Date" <> 0D then
                        if "Loan Product Type" <> 'KARIBU' then
                            if (CalcDate(GenSetUp."Min. Loan Application Period", CustomerRecord."Registration Date") > Today) then
                                Error('Member is less than six months old therefor not eligible for loan application.');
                    //-------------------------------------------------------------------
                    CustomerRecord.CalcFields(CustomerRecord."Current Shares", CustomerRecord."Outstanding Balance",
                    CustomerRecord."Current Loan");
                    "Client Name" := CustomerRecord.Name;
                    "Employer Code" := CustomerRecord."Employer Code";
                    "Shares Balance" := CustomerRecord."Current Shares";
                    Savings := CustomerRecord."Current Shares";
                    "Existing Loan" := CustomerRecord."Outstanding Balance";
                    "Staff No" := CustomerRecord."Payroll/Staff No";
                    if Cust."Date of Birth" <> 0D then
                        "Estimated Years to Retire" := Round(((Calcdate(GenSetUp."Retirement Age", Cust."Date of Birth") - Today) / 365), 1, '=');
                    "ID NO" := CustomerRecord."ID No.";
                    "Member Deposits" := CustomerRecord."Current Shares";
                    "Group Name" := CustomerRecord."Group Account Name";
                    // "Group Account" := CustomerRecord."Group Account No";
                    "Loan Officer" := CustomerRecord."Loan Officer Name";
                    "Branch Code" := CustomerRecord."Global Dimension 2 Code";
                    "Non-member Account" := true;
                    // "Account Category" := CustomerRecord."Account Category";// should it be non member or just account category
                    //---------------------------------------------------------
                end;

                //Block if loan Previously recovered from gurantors
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."BOSA No", "BOSA No");
                LoanApp.SetRange("Recovered From Guarantor", true);
                if LoanApp.Find('-') then
                    Error('Member has a loan which has previously been recovered from gurantors. - %1', LoanApp."Loan  No.");
                //-------------------------------------------------------------------

                //..........................................................
                //Existing Pending Approval
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Client Code", "Client Code");
                LoanApp.SetRange(LoanApp."Loan Product Type", "Loan Product Type");
                LoanApp.SetRange(LoanApp.Posted, false);
                LoanApp.SetRange(LoanApp."Approval Status", LoanApp."Approval Status"::Pending);
                if LoanApp.Find('-') then
                    repeat
                        if LoanApp."Loan Status" <> LoanApp."loan status"::Rejected then
                            if LoanApp."Loan  No." <> "Loan  No." then
                                Error('Member already has an existing %1 application pending approval: %2 - %3', LoanApp."Loan Product Type Name", "Account No", LoanApp."Loan  No.");
                    until LoanApp.Next = 0;

                //     if Posted <> true then begin
                //         if Installments > LoanType."No of Installment" then
                //             Error('Installments cannot be greater than the maximum installments.%1', LoanType."No of Installment");
                //     end;
            end;
        }
        field(4; "Loan Product Type"; Code[20])
        {
            Editable = true;
            TableRelation = "Loan Products Setup".Code;// where(Source = const(BOSA));

            trigger OnValidate()
            begin
                // if Source = Source::BOSA then begin
                "Batch Source" := "batch source"::BOSA;
                //............................
                if LoanType.Get("Loan Product Type") then begin
                    LoanType.SetRange(LoanType.Code, "Loan Product Type");

                    if (LoanType."Loan Product Expiry Date" = 0D) or (LoanType."Loan Product Expiry Date" > Today) then begin
                        sHARES := 0;
                        MonthlyRepayT := 0;

                        if Source = Source::BOSA then begin
                            Cust.Reset;
                            Cust.SetRange(Cust."No.", "Client Code");
                            if Cust.Find('-') then begin
                                Cust.CalcFields(Cust."Current Shares");
                                sHARES := Cust."Current Shares";
                            end;
                        end;
                        //.............................................................................

                        // LoanApp.Reset;
                        // LoanApp.SetRange(LoanApp."Client Code", "Client Code");
                        // LoanApp.SetRange(LoanApp."Loan Product Type", "Loan Product Type");
                        // LoanApp.SetRange(LoanApp.Posted, true);
                        // LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        // LoanApp.SetFilter(LoanApp."Outstanding Balance", '>%1', 0);
                        // if LoanApp.Find('-') then begin
                        //     repeat
                        //         loannums := loannums + 1;
                        //     until LoanApp.Next = 0;
                        // end;
                        //.....................................................................

                        //Compute all loan repayments
                        // LoanApp.Reset;
                        // LoanApp.SetRange(LoanApp."Client Code", "Client Code");
                        // if LoanApp.Find('-') then begin
                        //     LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        //     repeat
                        //         LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        //         if (LoanApp."Outstanding Balance" > 0) then begin
                        //             if LoanApp."Outstanding Balance" < LoanApp."Loan Principle Repayment" then
                        //                 MonthlyRepayT := (LoanApp."Outstanding Balance" + LoanApp."Loan Interest Repayment")
                        //             else
                        //                 MonthlyRepay := (LoanApp."Loan Principle Repayment" + LoanApp."Loan Interest Repayment");

                        //             MonthlyRepayT := MonthlyRepayT + MonthlyRepay;
                        //         end;
                        //     until LoanApp.Next = 0;
                        // end;

                        //------------------------------------------------------
                        if LoanType.Get("Loan Product Type") then begin
                            "Loan Product Type Name" := LoanType."Product Description";
                            Interest := LoanType."Interest rate";
                            Mulitiplier := LoanType."Deposits Multiplier";
                            "Deposits Mulitiplier" := (sHARES * Mulitiplier);
                            "Instalment Period" := LoanType."Instalment Period";
                            "Grace Period" := LoanType."Grace Period";
                            "Grace Period - Principle (M)" := LoanType."Grace Period - Principle (M)";
                            "Grace Period - Interest (M)" := LoanType."Grace Period - Interest (M)";
                            "Loan to Share Ratio" := LoanType."Loan to Share Ratio";
                            "Interest Calculation Method" := LoanType."Interest Calculation Method";
                            "Repayment Method" := LoanType."Repayment Method";
                            Installments := LoanType."Default Installements";
                            "Max. Installments" := LoanType."No of Installment";
                            "Max. Loan Amount" := LoanType."Max. Loan Amount";
                            "Repayment Frequency" := LoanType."Repayment Frequency";
                            "Paying Bank Account No" := LoanType."Loan Bank Account";
                            rec.modify;
                            if LoanType."Use Cycles" = false then begin
                                "Loan Cycle" := 0;
                                "Max. Installments" := LoanType."No of Installment";
                                "Max. Loan Amount" := LoanType."Max. Loan Amount";
                                Installments := LoanType."Default Installements";
                                "Paying Bank Account No" := LoanType."Loan Bank Account";
                            end;

                            // if LoanType."Use Cycles" = true then begin
                            //     LoanApp.Reset;
                            //     LoanApp.SetRange(LoanApp."Client Code", "Client Code");
                            //     LoanApp.SetRange(LoanApp."Loan Product Type", "Loan Product Type");
                            //     LoanApp.SetRange(LoanApp.Posted, true);
                            //     if LoanApp.Find('-') then
                            //         MemberCycle := LoanApp.Count + 1
                            //     else
                            //         MemberCycle := 1;

                            //     ProdCycles.Reset;
                            //     ProdCycles.SetRange(ProdCycles."Product Code", "Loan Product Type");
                            //     if ProdCycles.Find('-') then begin
                            //         repeat
                            //             if MemberCycle = ProdCycles.Cycle then begin
                            //                 "Loan Cycle" := ProdCycles.Cycle;
                            //                 "Max. Installments" := ProdCycles."Max. Installments";
                            //                 "Max. Loan Amount" := ProdCycles."Max. Amount";
                            //                 Installments := ProdCycles."Max. Installments";
                            //             end;
                            //         until ProdCycles.Next = 0;
                            //         if "Loan Cycle" = 0 then begin
                            //             "Loan Cycle" := ProdCycles.Cycle;
                            //             "Max. Installments" := ProdCycles."Max. Installments";
                            //             "Max. Loan Amount" := ProdCycles."Max. Amount";
                            //             Installments := ProdCycles."Max. Installments";
                            //         end;
                            //     end;
                            if Posted <> true then
                                if Installments > LoanType."No of Installment" then
                                    Error('Installments cannot be greater than the maximum installments.%1', LoanType."No of Installment");

                            // end;
                        end;
                        //--------------------------------------------------------
                    end;
                end else
                    exit;
                //..........................................
            end;
        }
        field(5; "Group Code"; Code[20])
        {
        }
        field(6; Savings; Decimal)
        {
            Editable = false;
        }
        field(7; "Existing Loan"; Decimal)
        {
            Editable = false;
        }
        field(8; "Requested Amount"; Decimal)
        {
            trigger OnValidate()
            var
                AvailableAmount: Decimal;

            begin
                AvailableAmount := "Deposits Mulitiplier" - "Existing Loan";
                if LoanType.Get("Loan Product Type") then
                    if Posted = false then
                        if "Requested Amount" > LoanType."Max. Loan Amount" then
                            Error('Requested Amount cannot be greater than the maximum Loan Amount.%1', LoanType."Max. Loan Amount");
                "Approved Amount" := "Requested Amount";
                // "Net Payment to FOSA" := "Requested Amount";

                Validate("Approved Amount");

                CalcFields("Total Loans Outstanding");
                TotalOutstanding := "Total Loans Outstanding" + "Requested Amount";

                if "Repayment Method" = "repayment method"::"Reducing Balance" then begin

                    TestField(Interest);
                    TestField(Installments);

                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 0.05, '>');
                    Repayment := LPrincipal + LInterest;
                    "Loan Principle Repayment" := LPrincipal;
                    "Loan Interest Repayment" := LInterest;
                end;

                //...................................................................................
                if "Repayment Method" = "repayment method"::Amortised then begin

                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');

                    LPrincipal := TotalMRepay - LInterest;
                    "Loan Principle Repayment" := LPrincipal;
                    "Loan Interest Repayment" := LInterest;
                    Repayment := TotalMRepay;
                    //---------------------------------------------------------------------
                end;
                if "Requested Amount" > ("Deposits Mulitiplier" - "Existing Loan") then
                    if Confirm('Member is about to apply Loan amount of ' + Format("Requested Amount") + ' that is greator than available amount of ' + Format(AvailableAmount) + ' . Do you wish to continue with the application?') = false then
                        "Requested Amount" := 0;
            end;
        }
        field(9; "Approved Amount"; Decimal)
        {
            Editable = true;

            trigger OnValidate()
            begin

                LAppCharges.Reset;
                LAppCharges.SetRange(LAppCharges."Loan No", "Loan  No.");
                if LAppCharges.Find('-') then
                    LAppCharges.DeleteAll;

                "Flat rate Interest" := 0;

                "Total Repayment" := 0;
                TotalMRepay := 0;
                LPrincipal := 0;
                LInterest := 0;
                InterestRate := Interest;
                LoanAmount := "Approved Amount";
                RepayPeriod := Installments;
                LBalance := "Approved Amount";

                if "Repayment Method" = "repayment method"::"Straight Line" then begin
                    TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                    LInterest := ROUND((InterestRate / 12 / 100) * LoanAmount, 1, '>');
                    Repayment := LPrincipal;
                    "Loan Principle Repayment" := LPrincipal;
                    "Loan Interest Repayment" := LInterest;
                end;
                //------------------------------------------
                //SURESTEP
                //Repayments for reducing balance method
                if "Repayment Method" = "repayment method"::"Reducing Balance" then begin
                    if "Loan Product Type" <> 'OVERDRAFT' then;
                    //TestField(Interest);
                    //TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 0.05, '>');
                    Repayment := LPrincipal + LInterest;
                    "Loan Principle Repayment" := LPrincipal;
                    "Loan Interest Repayment" := LInterest;
                end;
                //SURESTEP
                if "Repayment Method" = "repayment method"::Amortised then begin
                    TestField(Interest);
                    TestField(Installments);

                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');

                    LPrincipal := TotalMRepay - LInterest;
                    "Loan Principle Repayment" := LPrincipal;
                    "Loan Interest Repayment" := LInterest;
                    "Approved Repayment" := TotalMRepay;
                end;
                if "Repayment Method" = "repayment method"::Constants then begin
                    TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                    LInterest := ROUND((InterestRate / 100) * LoanAmount, 1, '>');
                    Repayment := LPrincipal;
                    "Loan Principle Repayment" := LPrincipal;
                    "Loan Interest Repayment" := LInterest;
                end;
            end;
        }
        field(16; Interest; Decimal)
        {
            trigger OnValidate()
            begin
            end;
        }
        field(17; Insurance; Decimal)
        {
            Editable = false;
        }
        field(22; "Client Cycle"; Integer)
        {
            Editable = false;
        }
        field(26; "Client Name"; Text[80])
        {
            Editable = true;
        }
        field(27; "Loan Status"; Option)
        {
            OptionMembers = Application,Appraisal,Rejected,Approved,Issued;

            trigger OnValidate()
            begin
            end;
        }
        field(29; "Issued Date"; Date)
        {
            trigger OnValidate()
            begin
            end;
        }
        field(30; Installments; Integer)
        {
            trigger OnValidate()
            begin
                if Posted <> true then
                    if Installments > "Max. Installments" then
                        ERROR('Installments cannot be greater than the maximum installments.');

                Validate("Approved Amount");

                GenSetUp.Get();
                if Cust.Get("Client Code") then
                    if (Cust."Date of Birth" <> 0D) and ("Application Date" <> 0D) and (Installments > 0) then
                        if CalcDate(Format(Installments) + 'M', "Application Date") > CalcDate(GenSetUp."Retirement Age", Cust."Date of Birth") then
                            if Confirm('Member due to retire before loan repayment is complete. Do you wish to continue?') = false then
                                Installments := 0;
            end;
        }
        field(34; "Loan Disbursement Date"; Date)
        {
            trigger OnValidate()
            begin
                if Date2dmy("Loan Disbursement Date", 1) <= 15 then
                    "Repayment Start Date" := CalcDate('CM', "Loan Disbursement Date")
                else
                    "Repayment Start Date" := CalcDate('CM', CalcDate('CM+1M', "Loan Disbursement Date"));
                "Expected Date of Completion" := CalcDate('CM', CalcDate('CM+' + Format(Installments) + 'M', "Loan Disbursement Date"));
            end;
        }
        field(35; "Mode of Disbursement"; Enum "Mode Of Disbursement")
        {
            // OptionCaption = ' ,Cheque,Transfer To FOSA,EFT,RTGS,Cheque NonMember,FOSA Loans,Individual Cheques';
            // OptionMembers = " ",Cheque,"Bank Transfer",EFT,RTGS,"Cheque NonMember","FOSA Loans","Individual Cheques";

            trigger OnValidate()
            begin
                // if "Mode of Disbursement" = "mode of disbursement"::"Bank Transfer" then begin
                //     TestField("Account No");
                // end;
            end;
        }
        field(53; "Affidavit - Item 1 Details"; Text[100])
        {
        }
        field(54; "Affidavit - Estimated Value 1"; Decimal)
        {
        }
        field(55; "Affidavit - Item 2 Details"; Text[100])
        {
        }
        field(56; "Affidavit - Estimated Value 2"; Decimal)
        {
        }
        field(57; "Affidavit - Item 3 Details"; Text[100])
        {
        }
        field(58; "Affidavit - Estimated Value 3"; Decimal)
        {
        }
        field(59; "Affidavit - Item 4 Details"; Text[100])
        {
        }
        field(60; "Affidavit - Estimated Value 4"; Decimal)
        {
        }
        field(61; "Affidavit - Item 5 Details"; Text[100])
        {
        }
        field(62; "Affidavit - Estimated Value 5"; Decimal)
        {
        }
        field(63; "Magistrate Name"; Text[30])
        {
        }
        field(64; "Date for Affidavit"; Date)
        {
        }
        field(65; "Name of Chief/ Assistant"; Text[30])
        {
        }
        field(66; "Affidavit Signed?"; Boolean)
        {
        }
        field(67; "Date Approved"; Date)
        {
        }
        field(68; Mulitiplier; Decimal)
        {
        }
        field(69; "Deposits Mulitiplier"; Decimal)
        {
        }
        field(53048; "Grace Period"; DateFormula)
        {
        }
        field(53049; "Instalment Period"; DateFormula)
        {
        }
        field(53050; Repayment; Decimal)
        {
            trigger OnValidate()
            begin

                "Previous Repayment" := xRec.Repayment;
                Advice := true;

                if "Recovery Mode" = "recovery mode"::Checkoff then
                    "Monthly Repayment" := Repayment;

                if LoanTypes.Get("Loan Product Type") then
                    if Cust.Get("Client Code") then begin
                        Loan."Staff No" := Cust."Payroll/Staff No";

                        DataSheet.Init;
                        DataSheet."PF/Staff No" := "Staff No";
                        DataSheet."Type of Deduction" := LoanTypes."Product Description";
                        DataSheet."Remark/LoanNO" := "Loan  No.";
                        DataSheet.Name := "Client Name";
                        DataSheet."ID NO." := "ID NO";
                        DataSheet."Amount ON" := Repayment;
                        DataSheet."Amount OFF" := xRec.Repayment;

                        DataSheet."REF." := '2026';
                        DataSheet."New Balance" := "Approved Amount";
                        DataSheet.Date := Loan."Issued Date";
                        DataSheet.Date := Today;
                        DataSheet.Employer := "Employer Code";
                        DataSheet."Transaction Type" := DataSheet."transaction type"::"ADJUSTMENT LOAN";
                        DataSheet.Insert;
                    end;
            end;
        }
        field(53051; "Pays Interest During GP"; Boolean)
        {
        }
        field(53053; "Percent Repayments"; Decimal)
        {
            Editable = false;
        }
        field(53054; "Paying Bank Account No"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(53055; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(53056; "Loan Product Type Name"; Text[100])
        {
        }
        field(53057; "Cheque Number"; Code[20])
        {
            trigger OnValidate()
            begin

                if "Cheque No." <> '' then begin
                    Loan.Reset;
                    Loan.SetRange(Loan."Cheque No.", "Cheque No.");
                    Loan.SetRange(Loan."Bela Branch", "Bela Branch");
                    if Loan.Find('-') then
                        if Loan."Cheque No." <> "Cheque No." then
                            Error('"Cheque No.". already exists');
                end;
            end;
        }
        field(53058; "Bank No"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Bank Account"."No.";
        }
        field(53059; "Slip Number"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(53060; "Total Paid"; Decimal)
        {
            FieldClass = FlowFilter;
        }
        field(53061; "Schedule Repayments"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Principal Repayment" where("Loan No." = field("Loan  No."),
                                                                                     "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53062; "Doc No Used"; Code[20])
        {
        }
        field(53063; "Posting Date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(53065; "Batch No."; Code[20])
        {
            Editable = false;
            FieldClass = Normal;
            TableRelation = if (Source = const(BOSA)) "Loan Disburesment-Batching"."Batch No." where(Posted = const(false),
                                                                                                            // Status = const(Open),
                                                                                                            Source = const(BOSA),
                                                                                                            "Batch Type" = filter(Loans));
            // else
            // if (Source = const(MICRO)) "Loan Disburesment-Batching"."Batch No." where(Posted = const(false), Status = const(Open), Source = const(MICRO), "Batch Type" = filter(Loans))
            // else
            // if (Source = const(FOSA)) "Loan Disburesment-Batching"."Batch No." where(Posted = const(false),
            //    Status = const(Open),
            //    Source = const(FOSA),
            //    "Batch Type" = filter(Loans));

            trigger OnValidate()
            begin

                // RepaySched.Reset;
                // RepaySched.SetRange(RepaySched."Loan No.", "Loan  No.");
                // if not RepaySched.Find('-') then
                //     Error('Loan Schedule must be generated and confirmed before loan is attached to batch');

                // if "Batch No." <> '' then begin
                //     if "Loan Product Type" = '' then
                //         Error('You must specify Loan Product Type before assigning a loan a Batch No.');

                //     if LoansBatches.Get("Batch No.") then begin
                //         if LoansBatches.Status <> LoansBatches.Status::Open then
                //             Error('You cannot modify the loan because the batch is already %1', LoansBatches.Status);
                //     end;
                // end;
                // if "Approval Status" <> "approval status"::Approved then
                //     Error('You can only batch Approved Loans');
            end;
        }
        field(53066; "Edit Interest Rate"; Boolean)
        {
        }
        field(53067; Posted; Boolean)
        {
            Editable = true;
        }
        field(53077; "Document No 2 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(53078; "Field Office"; Code[20])
        {
            // TableRelation = "Dimension Value".Code where("Dimension Code" = const('FIELD OFFICE'));
        }
        field(53079; Dimension; Code[20])
        {
        }
        field(53080; "Amount Disbursed"; Decimal)
        {
        }
        field(53081; "Fully Disbursed"; Boolean)
        {
        }
        field(53082; "New Interest Rate"; Decimal)
        {
            Editable = false;
        }
        field(53083; "New No. of Instalment"; Integer)
        {
            Editable = false;
        }
        field(53084; "New Grace Period"; DateFormula)
        {
            Editable = false;
        }
        field(53086; "Loan Balance at Rescheduling"; Decimal)
        {
            Editable = false;
        }
        field(53087; "Loan Reschedule"; Boolean)
        {
        }
        field(53088; "Date Rescheduled"; Date)
        {
        }
        field(53089; "Reschedule by"; Code[20])
        {
        }
        field(53090; "Flat Rate Principal"; Decimal)
        {
        }
        field(53091; "Flat rate Interest"; Decimal)
        {
        }
        field(53092; "Total Repayment"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan  No."),
                                                                  "Customer No." = field("Client Code"),
                                                                  "Transaction Type" = const(Repayment),
                                                                  "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(53093; "Interest Calculation Method"; Option)
        {
            OptionMembers = ,"No Interest","Flat Rate","Reducing Balances";
        }
        field(53094; "Edit Interest Calculation Meth"; Boolean)
        {
        }
        field(53095; "Balance BF"; Decimal)
        {
        }
        field(53098; "Interest to be paid"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Interest" where("Loan No." = field("Loan  No."),
                                                                                  "Member No." = field("Client Code"),
                                                                                  "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53099; "Date filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(53101; "Cheque Date"; Date)
        {
        }
        field(53102; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Client Code"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter(Loan | Repayment),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(53103; "Loan to Share Ratio"; Decimal)
        {
        }
        field(53104; "Shares Balance"; Decimal)
        {
            Editable = false;
        }
        field(53105; "Max. Installments"; Integer)
        {
            Editable = false;
        }
        field(53106; "Max. Loan Amount"; Decimal)
        {
            Editable = false;
        }
        field(53107; "Loan Cycle"; Integer)
        {
            Editable = false;
        }
        field(53108; "Penalty Charged"; Decimal)
        {
            // CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Client Code"),
            //                                                       "Transaction Type" = filter("Kuscco Shares" | "Withdrawable Deposits"),
            //                                                       "Loan No" = field("Loan  No."),
            //                                                       "Posting Date" = field("Date filter"),
            //                                                        Reversed = const(false)));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(53109; "Loan Amount"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter(Loan),
                                                                  "Loan No" = field("Loan  No."),
                                                                   Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(53110; "Current Shares"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Client Code"),
                                                                   "Transaction Type" = filter("Deposit Contribution")
                                                                   , "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(53111; "Loan Repayment"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter(Repayment),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(53112; "Repayment Method"; Option)
        {
            OptionMembers = Amortised,"Reducing Balance","Straight Line",Constants;

            trigger OnValidate()
            begin
                Validate("Approved Amount");
            end;
        }
        field(53113; "Grace Period - Principle (M)"; Integer)
        {
            trigger OnValidate()
            begin
                Installments := "Installment Including Grace" - "Grace Period - Principle (M)"
            end;
        }
        field(53114; "Grace Period - Interest (M)"; Integer)
        {
        }
        field(53115; Adjustment; Text[100])
        {
        }
        field(53116; "Payment Due Date"; Text[100])
        {
        }
        field(53117; "Tranche Number"; Integer)
        {
        }
        field(53118; "Amount Of Tranche"; Decimal)
        {
        }
        field(53119; "Total Disbursment to Date"; Decimal)
        {
        }
        field(53133; "Copy of ID"; Boolean)
        {
        }
        field(53134; Contract; Boolean)
        {
        }
        field(53135; Payslip; Boolean)
        {
        }
        field(53136; "Contractual Shares"; Decimal)
        {
        }
        field(53182; "Last Pay Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Loan No" = field("Loan  No."),
                                                                          "Transaction Type" = filter(Repayment | Loan),
                                                                   Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(53183; "Interest Due"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter("Interest Due"),
                                                                  "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(53185; "Interest Paid"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter("Interest Paid"),
                                                                  "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(53186; "Penalty Paid"; Decimal)
        {
            // CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Client Code"),
            //                                                       "Transaction Type" = filter("Withdrawable Deposits"),
            //                                                       "Loan No" = field("Loan  No."),
            //                                                       "Posting Date" = field("Date filter"),
            //                                                        Reversed = const(false)));
            // FieldClass = FlowField;
        }
        field(53189; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(53190; "Repayment Start Date"; Date)
        {
        }
        field(53191; "Installment Including Grace"; Integer)
        {
            trigger OnValidate()
            begin
                //SAM
                if "Installment Including Grace" > "Max. Installments" then
                    //ERROR('Installments cannot be greater than the maximum installments.');
                    Message('Installments cannot be greater than the maximum installments.');

                Installments := "Installment Including Grace" - "Grace Period - Principle (M)"
            end;
        }
        field(53192; "Schedule Repayment"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Principal Repayment" where("Loan No." = field("Loan  No."),
                                                                                     "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53193; "Loans Insurance"; Decimal)
        {
            // CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Client Code"),
            //                                                       "Transaction Type" = filter("Loan Insurance Paid"),
            //                                                       "Loan No" = field("Loan  No."),
            //                                                       "Posting Date" = field("Date filter"),
            //                                                        Reversed = const(false)));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(53195; "Schedule Interest to Date"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Interest" where("Loan No." = field("Loan  No."),
                                                                                  "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(68000; "Account No"; Code[20])
        {
            TableRelation = Vendor."No." where("Creditor Type" = const(Account));

            trigger OnValidate()
            begin

                //Surestep
                if (Source = Source::BOSA) or (Source = Source::MICRO) then
                    exit;

                GenSetUp.Get(0);

                LoansClearedSpecial.Reset;
                LoansClearedSpecial.SetRange(LoansClearedSpecial."Loan No.", "Loan  No.");
                if LoansClearedSpecial.Find('-') then
                    LoansClearedSpecial.DeleteAll;

                if Vendor.Get("Account No") then begin
                    CustomerRecord.Reset;
                    CustomerRecord.SetRange(CustomerRecord."No.", Vendor."BOSA Account No");
                    if CustomerRecord.Find('-') then begin
                        CustomerRecord.CalcFields(CustomerRecord."Current Shares", CustomerRecord."Outstanding Balance",
                        CustomerRecord."Current Loan");
                        "Client Name" := CustomerRecord.Name;
                        "Shares Balance" := CustomerRecord."Current Shares";
                        Savings := CustomerRecord."Current Shares";
                        "Existing Loan" := CustomerRecord."Outstanding Balance";
                        "Staff No" := CustomerRecord."Payroll/Staff No";
                        Gender := CustomerRecord.Gender;
                        "BOSA No" := Vendor."BOSA Account No";
                        "Client Code" := Vendor."BOSA Account No";
                        "Branch Code" := Vendor."Global Dimension 2 Code";
                        "ID NO" := Vendor."ID No.";
                        if "Branch Code" = '' then
                            "Branch Code" := CustomerRecord."Global Dimension 2 Code";

                    end else

                        if CustR.Get("Account No") then begin
                            "BOSA No" := Vendor."BOSA Account No";
                            "Client Code" := Vendor."No.";
                            "Client Name" := Vendor.Name;

                        end else begin
                            // "BOSA No" := Vendor."BOSA Account No";
                            // "Client Code" := Vendor."No.";
                            // "Client Name" := Vendor.Name;
                            // CustR.Init;
                            // CustR."No." := Vendor."No.";
                            // CustR.Name := Vendor.Name;
                            // CustR."Global Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                            // CustR."Global Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                            // CustR.Status := Cust.Status::Active;
                            // CustR."Customer Type" := CustR."customer type"::FOSA;
                            // CustR."Customer Posting Group" := 'FOSA';
                            // CustR."FOSA Account" := "Account No";
                            // if CustR."Payroll/Staff No" <> '' then
                            //     CustR."Payroll/Staff No" := Vendor."Staff No";
                            // CustR."ID No." := Vendor."ID No.";
                            // CustR.Gender := Vendor.Gender;
                            // CustR.Insert;

                            CustR.Reset;
                            if CustR.Get("Account No") then begin
                                CustR.Name := Vendor.Name;
                                CustR."Global Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                                CustR."Global Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                                CustR."Customer Posting Group" := 'FOSA';
                                CustR.Validate(CustR.Name);
                                CustR.Validate(CustR."Global Dimension 1 Code");
                                CustR.Validate(CustR."Global Dimension 2 Code");
                                CustR.Modify;
                            end;
                        end;


                end;

                //Block if loan Previously recovered from gurantors
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."BOSA No", "BOSA No");
                LoanApp.SetRange("Recovered From Guarantor", true);
                if LoanApp.Find('-') then
                    Error('Member has a loan which has previously been recovered from gurantors. - %1', LoanApp."Loan  No.");
                //Block if loan Previously recovered from gurantors

                // Cust.Reset;
                // Cust.SetRange(Cust."ID No.", "ID NO");
                // if Cust.Find('-') then begin
                //     Cust.CalcFields(Cust."Outstanding Balance", Cust."Current Shares");//,Cust."Loans Guaranteed"
                //     "BOSA Deposits" := Cust."Current Shares";
                // end;
            end;
        }
        field(68001; "BOSA No"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(68002; "Staff No"; Code[20])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(68003; "BOSA Loan Amount"; Decimal)
        {
        }
        field(68004; "Top Up Amount"; Decimal)
        {
            CalcFormula = sum("Loan Offset Details"."Principle Top Up" where("Loan No." = field("Loan  No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68005; "Loan Received"; Boolean)
        {
        }
        field(68006; "Period Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(68007; "Current Repayment"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter(Repayment),
                                                                  "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        // field(68008; "Oustanding Interest"; Decimal)
        // {
        //     CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan  No."),
        //                                                           "Transaction Type" = filter("Interest Paid" | "Interest Due"),
        //                                                           "Posting Date" = field("Date filter"),
        //                                                            Reversed = const(false)));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(68009; "Oustanding Interest to Date"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter("Interest Paid" | "Interest Due"),
                                                                  "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68010; "Current Interest Paid"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = const("Interest Paid"),
                                                                  "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68011; "Document No. Filter"; Code[100])
        {
            FieldClass = FlowFilter;
        }
        field(68012; "Cheque No."; Code[20])
        {
            trigger OnValidate()
            begin

                if "Cheque No." <> '' then begin
                    Loan.Reset;
                    Loan.SetRange(Loan."Cheque No.", "Cheque No.");
                    Loan.SetRange(Loan."Bela Branch", "Bela Branch");
                    if Loan.Find('-') then
                        if Loan."Cheque No." = "Cheque No." then
                            Error('Cheque No. already exists');
                end;
            end;
        }
        field(68013; "Personal Loan Off-set"; Decimal)
        {
        }
        field(68014; "Old Account No."; Code[20])
        {
        }
        field(68015; "Loan Principle Repayment"; Decimal)
        {
            trigger OnValidate()
            begin
                Repayment := "Loan Principle Repayment" + "Loan Interest Repayment";
                Advice := true;
                Validate(Repayment);
            end;
        }
        field(68016; "Loan Interest Repayment"; Decimal)
        {
        }
        field(68018; "Transacting Branch"; Code[20])
        {
            TableRelation = "User Setup".Branch where("User ID" = field("captured by"));
        }
        field(68019; Source; Enum LoanSourcesEnum)
        {
        }
        field(68020; "Net Income"; Decimal)
        {
        }
        field(68021; "No. Of Guarantors"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Loan No" = field("Loan  No."),
                                                                 Substituted = const(false)));
            FieldClass = FlowField;
        }
        field(68023; "Shares Boosted"; Boolean)
        {
        }
        field(68024; "Basic Pay"; Decimal)
        {
            trigger OnValidate()
            begin
                "Net Income" := ("Basic Pay" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance" + "Other Benefits")
                - "Total Deductions";
            end;
        }
        field(68025; "House Allowance"; Decimal)
        {
            trigger OnValidate()
            begin
                "Net Income" := ("Basic Pay" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance" + "Other Benefits")
                - "Total Deductions";
            end;
        }
        field(68026; "Other Allowance"; Decimal)
        {
            trigger OnValidate()
            begin
                "Net Income" := ("Basic Pay" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance" + "Other Benefits")
                - "Total Deductions";
            end;
        }
        field(68027; "Total Deductions"; Decimal)
        {
            trigger OnValidate()
            begin
                "Net Income" := ("Basic Pay" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance" + "Other Benefits")
                - "Total Deductions";
            end;
        }
        field(68028; "Cleared Effects"; Decimal)
        {
            trigger OnValidate()
            begin
            end;
        }
        field(68029; Remarks; Text[60])
        {
        }
        field(68030; Advice; Boolean)
        {
        }
        field(68031; "Special Loan Amount"; Decimal)
        {
            CalcFormula = sum("Loan Special Clearance"."Total Off Set" where("Loan No." = field("Loan  No."),
                                                                              "Client Code" = field("BOSA No")));
            Caption = 'Bridging Loan Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(68032; "Bridging Loan Posted"; Boolean)
        {
        }
        field(68033; "BOSA Loan No."; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(68034; "Previous Repayment"; Decimal)
        {
        }
        field(68035; "No Loan in MB"; Boolean)
        {
        }
        field(68036; "Recovered Balance"; Decimal)
        {
        }
        field(68037; "Recon Issue"; Boolean)
        {
        }
        field(68038; "Loan Purpose"; Code[20])
        {
            TableRelation = "Loans Purpose".Code;
        }
        field(68039; Reconciled; Boolean)
        {
        }
        field(68040; "Appeal Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                if Posted = false then
                    Error('Appeal only applicable for issued loans.');
            end;
        }
        field(68041; "Appeal Posted"; Boolean)
        {
        }
        field(68042; "Project Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                CalcFields("Top Up Amount", "Special Loan Amount");

                SpecialComm := 0;
                if "Special Loan Amount" > 0 then
                    SpecialComm := ("Special Loan Amount" * 0.01) + ("Special Loan Amount" + ("Special Loan Amount" * 0.01)) * 0.1;

                if "Project Amount" > ("Approved Amount" - ("Top Up Amount" + "Special Loan Amount" + SpecialComm)) then
                    Error('Amount to project cannot be more than the net payable amount i.e.  %1',
                         ("Approved Amount" - ("Top Up Amount" + "Special Loan Amount" + SpecialComm)));
            end;
        }
        field(68043; "Project Account No"; Code[20])
        {
            TableRelation = Vendor."No." where("Creditor Type" = const(Account),
                                                "Account Type" = filter('SAVINGS' | 'ENCASHCH'),
                                                Status = const(Active));
        }
        field(68046; "Discounted Amount"; Decimal)
        {
            Editable = false;
        }
        field(68047; "Transport Allowance"; Decimal)
        {
            trigger OnValidate()
            begin
                "Mileage Allowance" := 0;
                "Net Income" := ("Basic Pay" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance") - "Total Deductions";
            end;
        }
        field(68048; "Mileage Allowance"; Decimal)
        {
            trigger OnValidate()
            begin
                "Transport Allowance" := 0;
                "Net Income" := ("Basic Pay" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance") - "Total Deductions";
            end;
        }
        field(68049; "System Created"; Boolean)
        {
        }
        field(68050; "Boosting Commision"; Decimal)
        {
        }
        field(68051; "Voluntary Deductions"; Decimal)
        {
        }
        field(68054; Defaulted; Boolean)
        {
        }
        field(68055; "Bridging Posting Date"; Date)
        {
        }
        field(68056; "Commitements Offset"; Decimal)
        {
        }
        field(68057; Gender; Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(68058; "Captured By"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(68059; "Branch Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            ValidateTableRelation = false;
        }
        field(68060; "Recovered From Guarantor"; Boolean)
        {
        }
        field(68061; "Guarantor Amount"; Decimal)
        {
        }
        field(68062; "External EFT"; Boolean)
        {
            trigger OnValidate()
            begin
            end;
        }
        field(68065; "Last Interest Pay Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Loan No" = field("Loan  No."),
                                                                          "Transaction Type" = filter("Interest Paid"),
                                                                          "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68066; "Other Benefits"; Decimal)
        {
            trigger OnValidate()
            begin
                "Net Income" := ("Basic Pay" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance" + "Other Benefits")
                - "Total Deductions";
            end;
        }
        field(68067; "Recovered Loan"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(68068; "1st Notice"; Date)
        {
        }
        field(68069; "2nd Notice"; Date)
        {
        }
        field(68070; "Final Notice"; Date)
        {
        }
        field(68072; "Last Advice Date"; Date)
        {
        }
        field(68073; "Advice Type"; Option)
        {
            OptionMembers = " ","Fresh Loan",Adjustment,Reintroduction,Stoppage,"Top Up";
        }
        field(68093; "ID NO"; Code[40])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(68095; "Employer Code"; Code[50])
        {
            TableRelation = "Sacco Employers";
        }
        field(68096; "Loans Category Previous Year"; Enum LoansCategorySASRA)
        {
            DataClassification = ToBeClassified;
        }
        field(69001; "Loans Category-SASRA"; Enum LoansCategorySASRA)
        {
            // CalcFormula = lookup("Loan Classification Calculator"."SASRA Loan Category" where("Loan No" = field("Loan  No.")));
            // FieldClass = FlowField;
        }
        field(69002; "Bela Branch"; Code[100])
        {
        }
        field(69005; "Bank Name"; Text[150])
        {
        }
        field(69006; "Bank Branch"; Text[120])
        {
        }
        field(69007; "Outstanding Loan"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter(Loan | Repayment),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69008; "Loan Count"; Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where("Customer No." = field("Client Code"),
                                                             "Transaction Type" = filter(Loan),
                                                             "Loan No" = field("Loan  No."),
                                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69011; "Topup Loan No"; Code[20])
        {
            CalcFormula = lookup("Loan Offset Details"."Loan No." where("Loan Top Up" = field("Loan  No."),
                                                                         "Client Code" = field("Client Code")));
            FieldClass = FlowField;
        }
        field(69012; Defaulter; Boolean)
        {
        }
        field(69013; DefaulterInfo; Text[50])
        {
        }
        field(69014; "Total Earnings(Salary)"; Decimal)
        {
            FieldClass = Normal;
        }
        field(69015; "Total Deductions(Salary)"; Decimal)
        {
            FieldClass = Normal;
        }
        field(69018; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            TableRelation = Currency;
        }
        field(69019; "Amount Disburse"; Decimal)
        {
        }
        field(69022; "Expected Date of Completion"; Date)
        {
        }
        field(69024; "Recovery Mode"; Option)
        {
            OptionMembers = " ",Checkoff,"Standing Order",Salary,Dividend,"Direct Debits";
            ;
        }
        field(69025; "Repayment Frequency"; Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quaterly';
            OptionMembers = Daily,Weekly,Monthly,Quaterly;
            //initvalue = 'Monthly';
            trigger OnValidate()
            begin
                if "Repayment Frequency" = "repayment frequency"::Daily then
                    Evaluate("Instalment Period", '1D')
                else
                    if "Repayment Frequency" = "repayment frequency"::Weekly then
                        Evaluate("Instalment Period", '1W')
                    else
                        if "Repayment Frequency" = "repayment frequency"::Monthly then
                            Evaluate("Instalment Period", '1M')
                        else
                            if "Repayment Frequency" = "repayment frequency"::Quaterly then
                                Evaluate("Instalment Period", '1Q');
            end;
        }
        field(69026; "Approval Status"; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(69027; "Old Vendor No"; Code[20])
        {
        }
        field(69029; "Total TopUp Commission"; Decimal)
        {
            CalcFormula = sum("Loan Offset Details".Commision where("Loan No." = field("Loan  No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69030; "Total loan Outstanding"; Decimal)
        {
            FieldClass = Normal;
        }
        field(69031; "Monthly Shares Cont"; Decimal)
        {
        }
        field(69032; "Insurance On Shares"; Decimal)
        {
        }
        field(69035; "Net Payment to FOSA"; Decimal)
        {
        }
        field(69036; "Processed Payment"; Boolean)
        {
        }
        field(69037; "Date payment Processed"; Date)
        {
        }
        field(69038; "Attached Amount"; Decimal)
        {
        }
        field(69039; PenaltyAttached; Decimal)
        {
        }
        field(69040; InDueAttached; Decimal)
        {
        }
        field(69041; Attached; Boolean)
        {
        }
        field(69042; "Advice Date"; Date)
        {
        }
        field(69044; "Total Loans Outstanding"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter(Loan | Repayment),

                                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69046; "Member Deposits"; Decimal)
        {
            Editable = false;
        }
        field(69051; Bridged; Boolean)
        {
        }
        field(69052; "Deposit Reinstatement"; Decimal)
        {
        }
        field(69054; "Recommended Amount"; Decimal)
        {
        }
        field(69056; "partially Bridged"; Boolean)
        {
        }
        // field(69058; "BOSA Deposits"; Decimal)
        // {
        // }
        field(69059; "Topup Commission"; Decimal)
        {
            CalcFormula = sum("Loan Offset Details".Commision where("Loan No." = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69060; "Topup iNTEREST"; Decimal)
        {
            CalcFormula = sum("Loan Offset Details"."Interest Top Up" where("Loan No." = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69062; "Loan No Found"; Boolean)
        {
        }
        field(69063; "Checked By"; Code[30])
        {
        }
        field(69064; "Approved By"; Code[50])
        {
        }
        field(69066; "Rejected By"; Code[30])
        {
        }
        // field(69067; "Alpha Savings"; Decimal)
        // {
        //     CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Client Code"),
        //                                                           "Transaction Type" = filter(Junior_2),
        //                                                           "Loan No" = field("Loan  No."),
        //                                                            Reversed = const(false)));
        //     FieldClass = FlowField;
        // }
        field(69069; "Approval remarks"; Code[40])
        {
            FieldClass = Normal;
        }
        field(69070; "Loan Disbursed Amount"; Decimal)
        {
        }
        field(69071; "Bank Bridge Amount"; Decimal)
        {
        }
        field(69072; "Approved Repayment"; Decimal)
        {
        }
        field(69073; "Rejection  Remark"; Text[80])
        {
            CalcFormula = lookup("Approval Comment Line".Comment where("Document No." = field("Loan  No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69077; "Employer Name"; Text[100])
        {
            CalcFormula = lookup(Customer."Employer Name" where("Employer Code" = field("Employer Code")));
            FieldClass = FlowField;
        }
        field(69079; "Interest Upfront Amount"; Decimal)
        {
        }
        field(69082; "Loan Insurance"; Decimal)
        {
        }
        field(69083; TotalInterestCharged; Boolean)
        {
        }
        field(69084; "Last IntcalcDate"; Date)
        {
        }
        field(69085; "Loan Collateral Fee"; Decimal)
        {
        }
        field(69086; "Net Loan Disbursed"; Decimal)
        {
        }
        field(69089; "Partial Disbursement"; Boolean)
        {
        }
        field(69090; "Partial Amount Disbursed"; Decimal)
        {
            trigger OnValidate()
            begin

                if not "Partial Disbursement" then
                    Error('This Loan Application is not set for Partial Disbursment');
            end;
        }
        field(69091; "Boosting Shares"; Decimal)
        {
            CalcFormula = sum("Boosting Shares"."Boosting Amount" where("Loan No." = field("Loan  No."),
                                                                         "Client Code" = field("Client Code")));
            FieldClass = FlowField;
        }
        field(69094; "Bridge Shares"; Decimal)
        {
        }
        field(69095; "Discount Amount"; Decimal)
        {
        }
        field(69096; "Vendor No"; Code[20])
        {
            TableRelation = Vendor."No." where("Creditor Type" = filter(<> Account));

            trigger OnValidate()
            begin
            end;
        }
        field(69097; "Vendor Name"; Text[30])
        {
        }
        field(69098; "Monthly Repayment"; Decimal)
        {
        }
        field(69099; "Defaulted install"; Decimal)
        {
        }
        field(69100; LastPayDateImport; Date)
        {
        }
        field(69101; "Total Loans Default"; Decimal)
        {
        }
        field(69102; "Installment Defaulted"; Decimal)
        {
        }
        field(69103; "old no"; Code[20])
        {
            trigger OnValidate()
            begin
                CustomerRecord.Reset;
                CustomerRecord.SetRange(CustomerRecord."Old Account No.", "old no");
                if CustomerRecord.Find('-') then
                    "Client Code" := CustomerRecord."No.";
            end;
        }
        field(69104; "Eft Amount"; Decimal)
        {
        }
        field(69105; "Initial Approved Amount"; Decimal)
        {
        }
        field(69106; "Appeal Date"; Date)
        {
        }
        field(69107; "Appeal Loan"; Boolean)
        {
        }
        field(69109; "Tax Excempt"; Boolean)
        {
        }
        field(69110; "Group Account"; Code[50])
        {
            TableRelation = Customer."No." where("Customer Posting Group" = const('MICRO'),
                                                            "Group Account" = const(true));
        }
        field(69111; "Loan Officer"; Code[30])
        {
            // TableRelation = "Loan Officers Details".Name;
        }
        field(69112; "Group Name"; Text[50])
        {
        }
        field(69117; "Check Int"; Boolean)
        {
        }
        field(69118; "Loan Next Pay Date"; Date)
        {
        }
        field(69169; Rescheduled; Boolean)
        {
        }
        field(69170; "Loan Rescheduled Date"; Date)
        {
        }
        field(69171; "Loan Rescheduled By"; Code[15])
        {
        }
        field(69172; "Reason For Loan Reschedule"; Text[20])
        {
        }
        field(69173; "Batch Source"; Option)
        {
            OptionCaption = 'BOSA';
            OptionMembers = BOSA;
        }
        field(69174; "Principle Due"; Decimal)
        {
            Editable = true;
        }
        field(69175; "Expected Total Int."; Decimal)
        {
            Editable = false;
        }
        field(69176; "Check Off Amount"; Decimal)
        {
        }
        field(69177; "Int Paid Finsacco"; Decimal)
        {
        }
        field(69178; "Principal Paid"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Client Code"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter(Repayment),
                                                                  "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69179; "Total Direct Recovery"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan  No."),
                                                                   "Transaction Type" = filter(Repayment),
                                                                   "Document No." = filter('RCV*'),
                                                                   "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69180; "Total Loan Paid"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan  No."),
                                                                   "Transaction Type" = filter(Repayment),
                                                                   "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69181; "OPening Bal"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter(Loan),
                                                                  "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69182; "Total Direct Recovery Int"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan  No."),
                                                                   "Transaction Type" = filter("Interest Paid"),
                                                                   "Document No." = filter('RECOVERY' | 'ARECOVERY'),
                                                                   "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69183; "Total Direct Recovery IntP"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan  No."),
                                                                   "Transaction Type" = filter(Repayment | "Interest Paid"),
                                                                   "Document No." = filter('RCV*'),
                                                                   "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69184; Recoveries; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan  No."),
                                                                   "Transaction Type" = filter(Repayment | "Interest Paid"),
                                                                   "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69185; "Journal Batch Filter"; Code[100])
        {
            FieldClass = FlowFilter;
        }
        field(69186; "Interest Recovered"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan  No."),
                                                                   "Transaction Type" = filter("Interest Paid"),
                                                                   "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69187; "Prinncipal Recovered"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan  No."),
                                                                   "Transaction Type" = filter(Repayment),
                                                                   "Posting Date" = field("Date filter"),
                                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69188; "Main Sector"; Code[10])
        {
            TableRelation = "Main Sector".Code;

            trigger OnValidate()
            begin
                TestField(Posted, false);
            end;
        }
        field(69189; "Sub-Sector"; Code[10])
        {
            TableRelation = "Sub-Sector".Code;//where(No = FIELD("Main Sector"));
            trigger OnValidate()
            begin
                TestField(Posted, false);
            end;
        }
        field(69190; "Specific Sector"; Code[10])
        {
            TableRelation = "Specific-Sector".Code;//where(No = FIELD("Sub-Sector"));
            trigger OnValidate()
            begin
                TestField(Posted, false);
            end;
        }
        field(69191; "Insider Board"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(customer.board WHERE("No." = FIELD("Client Code")));

            trigger OnValidate()
            begin
            end;
        }
        field(69192; "Insider Lending"; Boolean)//Staff lending
        {
            FieldClass = FlowField;
            CalcFormula = lookup(customer.staff WHERE("No." = FIELD("Client Code")));

            trigger OnValidate()
            begin
            end;
        }
        field(69193; "Amount in Arrears"; Decimal)
        {
            // CalcFormula = lookup("Loan Classification Calculator"."Amount In Arrears" where("Loan No" = field("Loan  No.")));
            // FieldClass = FlowField;
        }
        field(69194; "No of Months in Arrears"; Integer)
        {
            // CalcFormula = lookup("Loan Classification Calculator"."No of months In Arrears" where("Loan No" = field("Loan  No.")));
            // FieldClass = FlowField;
        }
        field(69195; "No of Days in Arrears"; Integer)
        {
            // CalcFormula = lookup("Loan Classification Calculator"."No of Days In Arrears" where("Loan No" = field("Loan  No.")));
            // FieldClass = FlowField;
        }
        field(69196; "Sacco Insider"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(customer."Sacco Insider" WHERE("No." = FIELD("Client Code")));

            trigger OnValidate()
            begin
            end;
        }
        field(69197; "Principal In Arrears"; Decimal)
        {
            CalcFormula = lookup("Loan Classification Calculator"."Principle In Arrears" where("Loan No" = field("Loan  No.")));
            FieldClass = FlowField;
        }

        field(69199; "disbursement time"; Time)
        {
        }
        field(69200; "Posted By"; Code[40])
        {
        }
        field(69201; "Outstanding Penalty"; Decimal)
        {
        }
        field(69202; "Outstanding Insurance"; Decimal)
        {
        }
        field(69203; "Loan Insurance Charged"; Decimal)
        {
        }
        field(69204; "Total Insurance Paid"; Decimal)
        {
        }
        field(69205; "Total Penalty Paid"; Decimal)
        {
        }
        field(69207; "Total Interest Paid"; Decimal)
        {
        }
        field(69208; "Insurance Payoff"; Decimal)
        {
        }
        field(69209; "Overdraft Installements"; Option)
        {
            OptionCaption = ' ,1,2,3,Loan';
            OptionMembers = " ","1 Month","2 Months","3 Month","Loan";
        }
        //....................................................................New For Help In Loan Classification

        field(69210; "Scheduled Principle Payments"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Principal Repayment" where("Loan No." = field("Loan  No."),
                                                                                     "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(69211; "Schedule Loan Amount Issued"; Decimal)
        {
            CalcFormula = lookup("Loan Repayment Schedule"."Loan Amount" where("Loan No." = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69212; "Schedule Installments"; Integer)
        {
            CalcFormula = count("Loan Repayment Schedule" where("Loan No." = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69213; "Scheduled Interest Payments"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Interest" where("Loan No." = field("Loan  No."),
                                                                                     "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(69214; "Loan Last Pay Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Loan No" = field("Loan  No."),
                                                                          "Transaction Type" = filter(Repayment | "Interest Paid"),
                                                                   Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69215; "Last Autrecovery Run Date"; Date)
        {
        }
        field(69216; "Last Reminder SMS Date"; Date)
        {
        }
        field(69217; "Total Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Client Code"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter(Loan | Repayment | "Interest Paid" | "Interest Due"),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69218; "Total Loan Issued"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Client Code"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter(Loan),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69219; "Last Loan Issue Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("Client Code"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter(Loan),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69220; NHIF; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69221; NSSF; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69230; "Account Category"; enum "Memb App Acc Categ")
        {
        }
        field(68109; "Non-member Account"; Boolean)
        {
        }
        field(68110; "Valuation Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(68111; "Legal Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(68112; "Appealed Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68113; "Exempt From Payroll Deduction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516294; "Out. Loan Application fee"; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter("Application Fee"), "Loan No" = field("Loan  No."), Reversed = filter(false),
            // "Posting Date" = field("Date filter"), Reversed = filter(false)));
        }
        // field(51516295; "Outstanding Interest"; Decimal)
        // {
        //     CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Client Code"),
        //                                                           "Loan No" = field("Loan  No."),
        //                                                           "Transaction Type" = filter("Interest Paid" | "Interest Due"),
        //                                                           "Posting Date" = field("Date filter"),
        //                                                            Reversed = const(false)));

        //     FieldClass = FlowField;
        // }
        field(51516296; "Deboost Loan Applied"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516297; "Deboost Commision"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        Field(51516299; "Estimated Years to Retire"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(51516300; Appraised; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(515163001; "Loan Payments"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Client Code"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter(Repayment),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(515163002; "Recommended Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan  No.")
        {
            Clustered = true;
        }
        key(Key2; Posted)
        {
        }
        key(Key3; "Loan Product Type")
        {
        }
        key(Key4; Source, "Client Code", "Loan Product Type", "Issued Date")
        {
        }
        key(Key5; "Batch No.", Source, "Loan Status", "Loan Product Type")
        {
        }
        key(Key6; "BOSA Loan No.", "Account No", "Batch No.")
        {
        }
        key(Key7; "Old Account No.")
        {
        }
        key(Key8; "Client Code")
        {
        }
        key(Key9; "Staff No")
        {
        }
        key(Key10; "BOSA No")
        {
        }
        key(Key11; "Loan Product Type", "Client Code", Posted)
        {
        }
        key(Key12; "Client Code", "Loan Product Type", Posted, "Issued Date")
        {
        }
        key(Key13; "Loan Product Type", "Application Date", Posted)
        {
        }
        key(Key14; Source, "Mode of Disbursement", "Issued Date", Posted)
        {
        }
        key(Key15; "Issued Date", "Loan Product Type")
        {
        }
        key(Key16; "Application Date")
        {
        }
        key(Key17; "Client Code", "Old Account No.")
        {
        }
        key(Key18; "Group Code")
        {
        }
        key(Key19; "Account No")
        {
        }
        key(Key20; Source, "Issued Date", "Loan Product Type", "Client Code")
        {
        }
        key(Key21; "Client Code", "Loan Product Type")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Loan  No.", "Loan Product Type", "Client Code", "Outstanding Balance", Repayment)
        {
        }
    }

    trigger OnDelete()
    begin
        IF Posted = true THEN
            Error('A loan cannot be deleted ');
        IF "Approval Status" = "Approval Status"::Approved THEN
            Error('A loan cannot be deleted ');
        // IF "Approval Status" = "Approval Status"::Pending THEN
        //     Error('A loan cannot be deleted ');
    end;

    trigger OnInsert()
    var
        UserSetUp: Record "User Setup";
    begin

        //SURESTEP
        if Source = Source::BOSA then begin
            if "Loan  No." = '' then begin
                SalesSetup.Get;
                SalesSetup.TestField(SalesSetup."BOSA Loans Nos");
                NoSeriesMgt.InitSeries(SalesSetup."BOSA Loans Nos", xRec."No. Series", 0D, "Loan  No.", "No. Series");
            end;

        end else
            if Source = Source::MICRO then begin
                if "Loan  No." = '' then begin
                    SalesSetup.Get;
                    SalesSetup.TestField(SalesSetup."Micro Loans");
                    NoSeriesMgt.InitSeries(SalesSetup."Micro Loans", xRec."No. Series", 0D, "Loan  No.", "No. Series");
                end;

            end else
                IF (Source = Source::FOSA) AND ("Loan Product Type" <> 'OVERDRAFT') AND ("Loan Product Type" <> 'OKOA') then begin

                    if "Loan  No." = '' then begin
                        SalesSetup.Get;
                        SalesSetup.TestField(SalesSetup."FOSA Loans Nos");
                        NoSeriesMgt.InitSeries(SalesSetup."FOSA Loans Nos", xRec."No. Series", 0D, "Loan  No.", "No. Series");
                    end;
                end
                else
                    if (Source = Source::FOSA) AND ("Loan Product Type" = 'OVERDRAFT') then begin
                        if "Loan  No." = '' then begin
                            SalesSetup.Get;
                            SalesSetup.TestField(SalesSetup."OVerdraft Nos");
                            NoSeriesMgt.InitSeries(SalesSetup."OVerdraft Nos", xRec."No. Series", 0D, "Loan  No.", "No. Series");
                        end;
                    end
                    else
                        if (Source = Source::FOSA) AND ("Loan Product Type" = 'OKOA') then
                            if "Loan  No." = '' then begin
                                SalesSetup.Get;
                                SalesSetup.TestField(SalesSetup."Okoa No.");
                                NoSeriesMgt.InitSeries(SalesSetup."Okoa No.", xRec."No. Series", 0D, "Loan  No.", "No. Series");
                            end;
        //SURESTEP
        "Repayment Frequency" := "Repayment Frequency"::Monthly;
        "Application Date" := Today;
        Advice := true;
        "Loan Status" := "Loan Status"::Application;
        "Captured By" := UpperCase(UserId);

        IF UserSetUp.GET(USERID) THEN
            "Transacting Branch" := UserSetUp.Branch;
    end;

    trigger OnModify()
    begin
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LoanType: Record "Loan Products Setup";
        CustomerRecord: Record Customer;
        i: Integer;
        PeriodDueDate: Date;
        Gnljnline: Record "Gen. Journal Line";
        // Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        IssuedDate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        NoOfGracePeriod: Integer;
        G: Integer;
        RunningDate: Date;
        NewSchedule: Record "Loan Repayment Schedule";
        ScheduleCode: Code[30];
        GP: Text[30];
        Groups: Record "Loan Product Cycles";
        PeriodInterval: Code[10];
        GLSetup: Record "General Ledger Setup";
        Users: Record User;
        FlatPeriodInterest: Decimal;
        FlatRateTotalInterest: Decimal;
        FlatPeriodInterval: Code[10];
        ProdCycles: Record "Loan Product Cycles";
        LoanApp: Record "Loans Register";
        MemberCycle: Integer;
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        Vendor: Record Vendor;
        Cust: Record Customer;
        Vend: Record Vendor;
        Cust2: Record Customer;
        TotalMRepay: Decimal;
        LPrincipal: Decimal;
        LInterest: Decimal;
        InterestRate: Decimal;
        LoanAmount: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        UsersID: Record User;
        LoansBatches: Record "Loan Disburesment-Batching";
        Employer: Record "Sacco Employers";
        GenSetUp: Record "Sacco General Set-Up";
        Batches: Record "Loan Disburesment-Batching";
        MovementTracker: Record "Movement Tracker";
        SpecialComm: Decimal;
        CustR: Record Customer;
        RAllocation: Record "Receipt Allocation";
        "Standing Orders": Record "Standing Orders";
        StatusPermissions: Record "Status Change Permision";
        CustLedg: Record "Cust. Ledger Entry";
        LoansClearedSpecial: Record "Loan Special Clearance";
        BridgedLoans: Record "Loan Special Clearance";
        Loan: Record "Loans Register";
        banks: Record "Bank Account";
        DefaultInfo: Text[180];
        LoanGuarantorDetailsTable: Record "Loans Guarantee Details";
        sHARES: Decimal;
        MonthlyRepayT: Decimal;
        MonthlyRepay: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        RepaySched: Record "Loan Repayment Schedule";
        currYear: Integer;
        StartDate: Date;
        EndDate: Date;
        Month: Integer;
        Mwezikwisha: Date;
        AvailDep: Decimal;
        LoansOut: Decimal;
        Mdep: Decimal;
        BANDING: Record "Deposit Tier Setup";
        Band: Decimal;
        TotalOutstanding: Decimal;
        Insuarence: Decimal;
        LoanTyped: Record "Loan Products Setup";
        DAY: Integer;
        loannums: Integer;
        Enddates: Date;
        Partial: Record "Partial Disbursment Table";
        VendLPO: Record Vendor;
        DataSheet: Record "Data Sheet Main";
        LoanTypes: Record "Loan Products Setup";
        Text012: label '<Member does not have shares, therefore cannot qualify for any Loan>';
        LoanAppeal: Record "Loans Register";

    procedure GetGracePeriod()
    begin
        IssuedDate := "Loan Disbursement Date";
        GracePeiodEndDate := CalcDate("Grace Period", IssuedDate);
        InstalmentEnddate := CalcDate("Instalment Period", IssuedDate);
        GracePerodDays := GracePeiodEndDate - IssuedDate;
        InstalmentDays := InstalmentEnddate - IssuedDate;
        if InstalmentDays <> 0 then
            NoOfGracePeriod := ROUND(GracePerodDays / InstalmentDays, 1);
    end;
}
