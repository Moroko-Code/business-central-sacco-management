// Table 51516402 "Loans Guarantee Details backup"
// {
//     fields
//     {
//         field(1; "Loan No"; Code[20])
//         {
//             NotBlank = true;
//             TableRelation = "Loans Register"."Loan  No.";
//             trigger OnValidate()
//             var
//                 GuarantorTable: Record "Loans Guarantee Details";
//             begin

//             end;
//         }
//         field(2; "Member No"; Code[20])
//         {
//             // TableRelation = Customer."No." where("Group Account No" = field("Group Account No."));

//             trigger OnValidate()
//             begin
//                 "Self Guarantee" := false;
//                 SelfGuaranteedA := 0;
//                 Date := Today;

//                 //Evaluate guarantor basic info
//                 if Cust.Get("Member No") then begin
//                     Cust.CalcFields(Cust."Outstanding Balance", Cust."Current Shares");//,Cust."Loans Guaranteed"
//                     Name := Cust.Name;
//                     "Staff/Payroll No." := Cust."Payroll/Staff No";
//                     "Loan Balance" := Cust."Outstanding Balance";
//                     Shares := Cust."Current Shares";
//                     "ID No." := Cust."ID No.";

//                 end;

//                 GenSetUp.Get();

//                 if Cust."Registration Date" <> 0D then begin
//                     if CalcDate(GenSetUp."Min. Loan Application Period", Cust."Registration Date") > Today then
//                         if Confirm('Member is less than' + ' ' + GenSetUp."Min. Loan Application Period" + ' ' +
//                         'months old therefore not eligibl to guarantee a loan,Is the Member Self-Guranteeing?') then

//                             //Check Max garantors
//                             LoansG := 0;
//                     LoanGuarantors.Reset;
//                     LoanGuarantors.SetRange(LoanGuarantors."Member No", "Member No");
//                     LoanGuarantors.SetRange(LoanGuarantors.Substituted, false);
//                     if LoanGuarantors.Find('-') then begin
//                         repeat
//                             if Loans.Get(LoanGuarantors."Loan No") then begin
//                                 Loans.CalcFields(Loans."Outstanding Balance");
//                                 if Loans."Outstanding Balance" > 0 then begin
//                                     LoansG := LoansG + 1;

//                                     if LoanGuarantors."Self Guarantee" = true then begin
//                                         SelfGuaranteedA := SelfGuaranteedA + Loans."Outstanding Balance";
//                                     end;
//                                 end;
//                             end;
//                         until LoanGuarantors.Next = 0;
//                     end;
//                     GenSetUp.Get();
//                     if LoansR.Get("Loan No") then begin
//                         if LoansR."Client Code" = "Member No" then begin
//                             if GenSetUp.Get(0) then begin
//                                 if GenSetUp."Member Can Guarantee Own Loan" = false then
//                                     Error('Member can not guarantee own loan.')
//                             end;

//                             "Self Guarantee" := true;

//                         end;
//                     end;

//                     if Cust.Get("Member No") then begin
//                         if Loans.Source = Loans.Source::MICRO then begin
//                             Cust.SetRange(Cust."Customer Type", Cust."customer type"::MicroFinance);
//                             if Cust.Find('-') = false then
//                                 Error('Sorry selected Member is not a micro member');
//                         end;
//                         "Employer Code" := Cust."Employer Code";
//                         "Employer Name" := Cust."Employer Name";
//                         "ID No." := Cust."ID No.";
//                     end;

//                     Loans.Reset;
//                     Loans.SetRange(Loans."Client Code", "Member No");
//                     if Loans.Find('-') then begin
//                         if LoanGuarantors."Self Guarantee" = true then
//                             Message('This Member has Self Guaranteed and Can not Guarantee another Loan');
//                     end;

//                     Loans.Reset;
//                     Loans.SetRange(Loans."Loan  No.", "Loan No");
//                     if Loans.Find('-') then begin
//                         "Loanees  No" := Loans."Client Code";
//                         "Loanees  Name" := Loans."Client Name";
//                     end;
//                 end;

//                 if Cust.Get("Member No") then
//                     Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained");
//                 Name := Cust.Name;
//                 "ID No." := Cust."ID No.";
//                 "Staff/Payroll No." := Cust."Payroll/Staff No";
//                 "Cummulative Shares" := (Cust."Current Shares");
//                 "Cummulative Shares2" := ROUND((Cust."Current Shares") * 10 * 2 / 3);

//                 Reset;
//                 LoanGuarantors.Reset;
//                 LoanGuarantors.SetRange(LoanGuarantors."Member No", "Member No");
//                 LoanGuarantors.SetRange(LoanGuarantors.Substituted, false);
//                 if LoanGuarantors.Find('-') then begin
//                     repeat

//                         LoanGuarantors.CalcFields(LoanGuarantors."Outstanding Balance", LoanGuarantors."Loan amount");
//                         if LoanGuarantors."Outstanding Balance" <> 0 then begin
//                             if LoanGuarantors.Substituted = false then begin
//                                 balance := balance + LoanGuarantors."Outstanding Balance";
//                                 amountg := amountg + LoanGuarantors."Amont Guaranteed";
//                                 loanamnt := loanamnt + LoanGuarantors."Loan amount";
//                             end;
//                         end;
//                     until LoanGuarantors.Next = 0;
//                 end;
//                 //..........................Check If is self guarantor
//                 Loans.Reset;
//                 Loans.SetRange(Loans."Loan  No.", "Loan No");
//                 if Loans.Find('-') then begin
//                     if "Member No" = "Loanees  No" then begin
//                         "Self Guarantee" := true;
//                     end
//                     else begin
//                         if "Member No" = Loans."BOSA No" then begin
//                             "Self Guarantee" := true;
//                         end;
//                     END;
//                 end;
//                 //...........................
//             end;
//         }
//         field(3; Name; Text[200])
//         {
//             Editable = false;
//         }
//         field(4; "Loan Balance"; Decimal)
//         {
//             CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Member No"),
//                                                                   "Transaction Type" = filter(Loan | Repayment)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(5; Shares; Decimal)
//         {
//             Editable = false;
//         }
//         field(6; "No Of Loans Guaranteed"; Integer)
//         {
//             // CalcFormula = count("Loans Guarantee Details" where("Member No" = field("Member No"),
//             //                                                      "Outstanding Balance" = filter(> 1000)));
//             // Editable = false;
//             // FieldClass = FlowField;
//         }
//         field(7; Substituted; Boolean)
//         {
//             trigger OnValidate()
//             begin
//                 TestField("Substituted Guarantor");
//             end;
//         }
//         field(8; Date; Date)
//         {
//         }
//         field(9; "Shares Recovery"; Boolean)
//         {
//         }
//         field(10; "New Upload"; Boolean)
//         {
//         }
//         field(11; "Amont Guaranteed"; Decimal)
//         {
//             trigger OnValidate()
//             begin

//                 Reset;
//                 LoanApp.Reset;
//                 LoanApp.SetRange(LoanApp."Loan  No.", "Loan No");

//                 if LoanApp.Find('-') then begin

//                 end;

//                 "Amount Committed" := "Amont Guaranteed";
//                 if Loans.Get("Loan No") then
//                     "% Proportion" := ("Amont Guaranteed" / Loans."Approved Amount") * 100;

//             end;
//         }
//         field(12; "Staff/Payroll No."; Code[20])
//         {
//             trigger OnValidate()
//             begin
//                 Cust.Reset;
//                 Cust.SetRange(Cust."Payroll/Staff No", "Staff/Payroll No.");
//                 if Cust.Find('-') then begin
//                     "Member No" := Cust."No.";
//                     Validate("Member No");
//                 end
//                 else
//                     "Member No" := '';//ERROR('Record not found.')
//             end;
//         }
//         field(13; "Account No."; Code[20])
//         {
//         }
//         field(14; "Self Guarantee"; Boolean)
//         {
//         }
//         field(15; "ID No."; Code[50])
//         {
//         }
//         field(16; "Outstanding Balance"; Decimal)
//         {
//             CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter(Loan | Repayment),
//                                                                   "Loan No" = field("Loan No")));
//             FieldClass = FlowField;
//         }
//         field(17; "Total Loans Guaranteed"; Decimal)
//         {
//             FieldClass = Normal;
//         }
//         field(18; "Loans Outstanding"; Decimal)
//         {
//             CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter(Loan | Repayment),
//                                                                   "Loan No" = field("Loan No")));
//             FieldClass = FlowField;

//             trigger OnValidate()
//             begin
//                 "Total Loans Guaranteed" := "Outstanding Balance";
//                 Modify;
//             end;
//         }
//         field(19; "Guarantor Outstanding"; Decimal)
//         {
//             CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Member No"),
//                                                                   "Transaction Type" = filter(Loan | Repayment)));
//             FieldClass = FlowField;
//         }
//         field(20; "Employer Code"; Code[20])
//         {
//             TableRelation = Customer."No.";
//         }
//         field(21; "Employer Name"; Text[100])
//         {
//         }
//         field(22; "Substituted Guarantor"; Code[80])
//         {
//             TableRelation = Customer."No.";

//             trigger OnValidate()
//             begin
//                 GenSetUp.Get();
//                 if LoansG > GenSetUp."Maximum No of Guarantees" then begin
//                     Error('Member has guaranteed more than 30 active loans and  can not Guarantee any other Loans');
//                     "Member No" := '';
//                     "Staff/Payroll No." := '';
//                     Name := '';
//                     "Loan Balance" := 0;
//                     Date := 0D;
//                     exit;
//                 end;

//                 Loans.Reset;
//                 Loans.SetRange(Loans."Client Code", "Member No");
//                 if Loans.Find('-') then begin
//                     if LoanGuarantors."Self Guarantee" = true then
//                         Error('This Member has Self Guaranteed and Can not Guarantee another Loan');
//                 end;
//             end;
//         }
//         field(23; "Loanees  No"; Code[30])
//         {
//             FieldClass = Normal;
//         }
//         field(24; "Loanees  Name"; Text[80])
//         {
//         }
//         field(25; "Member Guaranteed"; Code[50])
//         {
//             Enabled = false;
//         }
//         field(26; "Telephone No"; Code[10])
//         {
//         }
//         field(27; "Cummulative Shares"; Decimal)
//         {
//         }
//         field(28; "Cummulative Shares2"; Decimal)
//         {
//         }
//         field(29; "Loan amount"; Decimal)
//         {
//             CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan No"),
//                                                                   "Transaction Type" = filter(Loan | "Unallocated Funds")));
//             FieldClass = FlowField;
//         }
//         field(30; "Amount Committed"; Decimal)
//         {
//         }
//         field(31; "% Proportion"; Decimal)
//         {
//         }
//         field(32; "Amount Released"; Decimal)
//         {
//         }
//         field(33; Signed; Boolean)
//         {
//         }
//         field(34; "Distribution %"; Decimal)
//         {
//         }
//         field(35; "Distribution Amount"; Decimal)
//         {
//         }
//         field(36; "Group Account No."; Code[50])
//         {
//         }
//     }

//     keys
//     {
//         key(Key1; "Loan No", "Member No", "Group Account No.")
//         {
//         }
//         // key(Key2; "Loan No", "Member No", "Group Account No.")
//         // {
//         //     Clustered = true;
//         //     SumIndexFields = Shares;
//         // }
//         key(Key2; "Group Account No.")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         Cust: Record Customer;
//         LoanGuarantors: Record "Loans Guarantee Details";
//         Loans: Record "Loans Register";
//         LoansR: Record "Loans Register";
//         LoansG: Integer;
//         GenSetUp: Record "Sacco General Set-Up";
//         SelfGuaranteedA: Decimal;
//         StatusPermissions: Record "Status Change Permision";
//         Employer: Record "Sacco Employers";
//         loanG: Record "Loans Guarantee Details";
//         CustomerRecord: Record Customer;
//         MemberSaccoAge: Date;
//         LoanApp: Record "Loans Register";
//         SMSMessage: Record "SMS Messages";
//         iEntryNo: Integer;
//         Vend: Record Vendor;
//         StrTel: Text[150];
//         MessageFailed: Boolean;
//         LoansH: Record "Loans Register";
//         balance: Decimal;
//         amountg: Decimal;
//         loanamnt: Decimal;
//         Liability: Decimal;
//         TotGuranteed: Decimal;

//     procedure SendSMS()
//     begin
//         //SMS MESSAGE
//         LoanApp.Reset;
//         LoanApp.SetRange(LoanApp."Loan  No.", "Loan No");
//         if LoanApp.Find('-') then begin

//             SMSMessage.Reset;
//             if SMSMessage.Find('+') then begin
//                 iEntryNo := SMSMessage."Entry No";
//                 iEntryNo := iEntryNo + 1;
//             end
//             else begin
//                 iEntryNo := 1;
//             end;

//             SMSMessage.Init;
//             SMSMessage."Entry No" := iEntryNo;
//             SMSMessage."Account No" := "Staff/Payroll No.";
//             SMSMessage."Date Entered" := Today;
//             SMSMessage."Time Entered" := Time;
//             SMSMessage.Source := 'LOAN GUARANTORS';
//             SMSMessage."Entered By" := UserId;
//             SMSMessage."System Created Entry" := true;
//             SMSMessage."Document No" := "Loan No";
//             SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
//             SMSMessage."SMS Message" := 'You have guaranteed ' + Format("Amont Guaranteed") + ', ' + LoanApp."Client Name" + ' ' + 'Staff No:-' + LoanApp."Staff No" + ' Loan Type ' + LoanApp."Loan Product Type" + ' ' + ' at TELEPOST SACCO.'
//             + ' ' + 'Call if in dispute.';
//             /*LoansH.RESET;
//             IF LoansH.GET("Loan No") THEN BEGIN
//             IF LoansH.Posted = TRUE THEN BEGIN
//             {SMSMessage."SMS Message":='You guaranteed '+LoansH."Client Name"+
//             ' amount '+FORMAT(LoansH."Approved Amount") +' on ' + FORMAT(LoansH."Application Date") +
//             '. He/She has defaulted and Safaricom Sacco has attached you as a guarantor. For help call ';  }
//             END;
//             END;
//               */
//             //FOSA
//             if LoanApp.Source = LoanApp.Source::FOSA then begin
//                 Vend.Reset;
//                 Vend.SetRange(Vend."No.", "Member No");
//                 if Vend.Find('-') then begin
//                     SMSMessage."Telephone No" := Vend."MPESA Mobile No";
//                 end;
//             end;

//             //BOSA
//             if LoanApp.Source = LoanApp.Source::BOSA then begin
//                 Cust.Reset;
//                 Cust.SetRange(Cust."No.", "Member No");
//                 Cust.SetRange(Cust."Customer Posting Group", 'MEMBER');
//                 if Cust.Find('-') then begin
//                     SMSMessage."Telephone No" := Cust."Phone No.";//Cust."Mobile Phone No";
//                 end;
//             end;

//             MessageFailed := false;

//             StrTel := CopyStr(SMSMessage."Telephone No", 1, 4);

//             if StrTel <> '+254' then begin
//                 MessageFailed := true;
//             end;

//             if StrLen(SMSMessage."Telephone No") <> 13 then begin
//                 MessageFailed := true;
//             end;

//             if MessageFailed = true then begin
//                 SMSMessage."Sent To Server" := SMSMessage."sent to server"::Failed;
//             end;

//             SMSMessage.Insert;

//         end;

//     end;

//     local procedure FnBOSANO(LoaneesNo: Code[30]): Code[20]
//     var
//         Vendor: Record Vendor;
//     begin
//         Vendor.Reset();
//         Vendor.SetRange(Vendor."No.", LoaneesNo);
//         if Vendor.Find('-') then begin
//             exit(Vendor."BOSA Account No");
//         end;
//     end;
// }
