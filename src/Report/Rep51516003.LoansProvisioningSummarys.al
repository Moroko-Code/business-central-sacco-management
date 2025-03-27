// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
// Report 51516003 "Loans Provisioning Summarys"
// {
//     RDLCLayout = './Layouts/LoansProvisioningSummarys.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Loans Register"; "Loans Register")
//         {
//             DataItemTableView = sorting("Loan  No.") where(Posted = const(true));
//             RequestFilterFields = "Branch Code", "Date filter";
//             column(RescTcount; RescTcount)
//             {
//             }
//             column(RescPortfolio; RescPortfolio)
//             {
//             }
//             column(RescTprovision; RescTprovision)
//             {
//             }
//             column(Tcount; Tcount)
//             {
//             }
//             column(Portfolio; Portfolio)
//             {
//             }
//             column(Tprovision; Tprovision)
//             {
//             }
//             column(Datefilter; Datefilter)
//             {
//             }
//             column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
//             {
//             }
//             column(RescPERFOMBAL; RescPERFOMBAL)
//             {
//             }
//             column(RescPERFOMCOUNT; RescPERFOMCOUNT)
//             {
//             }
//             column(RescPROVPERFOMBAL; RescPROVPERFOMBAL)
//             {
//             }
//             //--------------------------------------------
//             column(RescWATCHBAL; RescWATCHBAL)
//             {
//             }
//             column(RescWATCHCOUNT; RescWATCHCOUNT)
//             {
//             }
//             column(RescPROVWATCHBAL; RescPROVWATCHBAL)
//             {
//             }
//             //----------------------------------
//             column(RescSUBBAL; RescSUBBAL)
//             {
//             }
//             column(RescSUBCOUNT; RescSUBCOUNT)
//             {
//             }
//             column(RescPROVSUBBAL; RescPROVSUBBAL)
//             {
//             }
//             //----------------------------------------
//             column(RescLOSSBAL; RescLOSSBAL)
//             {
//             }
//             column(RescLOSSCOUNT; RescLOSSCOUNT)
//             {
//             }
//             column(RescPROVLOSSBAL; RescPROVLOSSBAL)
//             {
//             }
//             //------------------------------------------
//             column(RescDOUBTBAL; RescDOUBTBAL)
//             {
//             }
//             column(RescDOUBTCOUNT; RescDOUBTCOUNT)
//             {
//             }
//             column(RescPROVDOUBTBAL; RescPROVDOUBTBAL)
//             {
//             }
//             //----------------------------------
//             column(PERFOMBAL; PERFOMBAL)
//             {
//             }
//             column(PERFOMCOUNT; PERFOMCOUNT)
//             {
//             }
//             column(PROVPERFOMBAL; PROVPERFOMBAL)
//             {
//             }
//             //--------------------------------------------
//             column(WATCHBAL; WATCHBAL)
//             {
//             }
//             column(WATCHCOUNT; WATCHCOUNT)
//             {
//             }
//             column(PROVWATCHBAL; PROVWATCHBAL)
//             {
//             }
//             //----------------------------------
//             column(SUBBAL; SUBBAL)
//             {
//             }
//             column(SUBCOUNT; SUBCOUNT)
//             {
//             }
//             column(PROVSUBBAL; PROVSUBBAL)
//             {
//             }
//             //----------------------------------------
//             column(LOSSBAL; LOSSBAL)
//             {
//             }
//             column(LOSSCOUNT; LOSSCOUNT)
//             {
//             }
//             column(PROVLOSSBAL; PROVLOSSBAL)
//             {
//             }
//             //------------------------------------------
//             column(DOUBTBAL; DOUBTBAL)
//             {
//             }
//             column(DOUBTCOUNT; DOUBTCOUNT)
//             {
//             }
//             column(PROVDOUBTBAL; PROVDOUBTBAL)
//             {
//             }
//             //-----------------------------------------
//             column(UserId; UserId)
//             {
//             }
//             column(COMPANYNAME; COMPANYNAME)
//             {
//             }
//             column(CompanyPic; Company.Picture)
//             {
//             }

//             column(AUTHORIZATIONCaption; AUTHORIZATIONCaptionLbl)
//             {
//             }
//             column(We_declare_that_this_return__to_the_best_of_our_knowledge_and_belief_is_correct_Caption; We_declare_that_this_return__to_the_best_of_our_knowledge_and_belief_is_correct_CaptionLbl)
//             {
//             }
//             column(Sign__________________________________________________Date_____________________________Caption; Sign__________________________________________________Date_____________________________CaptionLbl)
//             {
//             }
//             column(Name_of_Authorizing_OfficerCaption; Name_of_Authorizing_OfficerCaptionLbl)
//             {
//             }
//             column(Sign__________________________________________________Date_____________________________Caption_Control1102756084; Sign__________________________________________________Date_____________________________Caption_Control1102756084Lbl)
//             {
//             }
//             column(Name_of_Counter_Signing_OfficerCaption; Name_of_Counter_Signing_OfficerCaptionLbl)
//             {
//             }
//             column(Loans_Loan__No_; "Loans Register"."Loan  No.")
//             {
//             }
//             column(TBal; TBal)
//             {
//             }
//             trigger OnPreDataItem();
//             begin

//             end;

//             trigger OnAfterGetRecord();
//             begin
//                 //**************************All loans
//                 //Performing Loans
//                 IF "Loans Register".GET("Loans Register"."Loan  No.") THEN begin
//                     repeat
//                         "Loans Register".CalcFields("Loans Register"."Outstanding Balance");
//                         "Loans Register".SetFilter("Loans Register"."Issued Date", Datefilter);
//                         IF "Loans Register"."Outstanding Balance" > 0 THEN begin
//                             IF "Loans Register"."Loans Category-SASRA" = "Loans Register"."Loans Category-SASRA"::Perfoming then begin
//                                 PERFOMBAL := PERFOMBAL + "Loans Register"."Outstanding Balance";
//                                 PERFOMCOUNT := PERFOMCOUNT + 1;
//                                 PROVPERFOMBAL := PERFOMBAL * 0.01;
//                             end else
//                                 IF "Loans Register"."Loans Category-SASRA" = "Loans Register"."loans category-sasra"::Watch then begin
//                                     WATCHBAL := WATCHBAL + "Loans Register"."Outstanding Balance";
//                                     WATCHCOUNT += 1;
//                                     PROVWATCHBAL := WATCHBAL * 0.05;
//                                 end else
//                                     IF "Loans Register"."Loans Category-SASRA" = "Loans Register"."loans category-sasra"::Substandard then begin
//                                         SUBBAL := SUBBAL + "Loans Register"."Outstanding Balance";
//                                         SUBCOUNT += 1;
//                                         PROVSUBBAL := SUBBAL * 0.25;
//                                     end else
//                                         IF "Loans Register"."Loans Category-SASRA" = "Loans Register"."loans category-sasra"::Doubtful then begin
//                                             DOUBTBAL := DOUBTBAL + "Loans Register"."Outstanding Balance";
//                                             DOUBTCOUNT += 1;
//                                             PROVDOUBTBAL := DOUBTBAL * 0.5;
//                                         end else
//                                             IF "Loans Register"."Loans Category-SASRA" = "Loans Register"."loans category-sasra"::Loss then begin
//                                                 LOSSBAL := LOSSBAL + "Loans Register"."Outstanding Balance";
//                                                 LOSSCOUNT += 1;
//                                                 PROVLOSSBAL := LOSSBAL * 0.5;
//                                             end;
//                         end;
//                     until "Loans Register".Next = 0;
//                     //GetSumTotals
//                     Tcount := PERFOMCOUNT + WATCHCOUNT + SUBCOUNT + DOUBTCOUNT + LOSSCOUNT;
//                     Portfolio := PERFOMBAL + WATCHBAL + SUBBAL + DOUBTBAL + LOSSBAL;
//                     Tprovision := PROVPERFOMBAL + PROVWATCHBAL + PROVSUBBAL + PROVDOUBTBAL + PROVLOSSBAL;
//                 end;

//                 //------------------------------------------------------------------------------------------
//                 //Rescheduled loan
//                 IF "Loans Register".GET("Loans Register"."Loan  No.") THEN begin
//                     repeat
//                         "Loans Register".CalcFields("Loans Register"."Outstanding Balance");
//                         IF "Loans Register"."Outstanding Balance" > 0 THEN begin
//                             "Loans Register".SetFilter("Loans Register"."Issued Date", Datefilter);
//                             IF (("Loans Register"."Loans Category-SASRA" = "Loans Register"."Loans Category-SASRA"::Perfoming) and ("Loans Register".Rescheduled = true)) then begin
//                                 RescPERFOMBAL := RescPERFOMBAL + "Loans Register"."Outstanding Balance";
//                                 RescPERFOMCOUNT := RescPERFOMCOUNT + 1;
//                                 RescPROVPERFOMBAL := RescPERFOMBAL * 0.01;

//                             end else
//                                 IF ("Loans Register"."Loans Category-SASRA" = "Loans Register"."loans category-sasra"::Watch) and ("Loans Register".Rescheduled = true) then begin
//                                     RescWATCHBAL := RescWATCHBAL + "Loans Register"."Outstanding Balance";
//                                     RescWATCHCOUNT += 1;
//                                     RescPROVWATCHBAL := RescWATCHBAL * 0.05;

//                                 end else
//                                     IF ("Loans Register"."Loans Category-SASRA" = "Loans Register"."loans category-sasra"::Substandard) and ("Loans Register".Rescheduled = true) then begin
//                                         RescSUBBAL := RescSUBBAL + "Loans Register"."Outstanding Balance";
//                                         RescSUBCOUNT += 1;
//                                         RescPROVSUBBAL := RescSUBBAL * 0.25;

//                                     end else
//                                         IF ("Loans Register"."Loans Category-SASRA" = "Loans Register"."loans category-sasra"::Doubtful) and ("Loans Register".Rescheduled = true) then begin
//                                             RescDOUBTBAL := RescDOUBTBAL + "Loans Register"."Outstanding Balance";
//                                             RescDOUBTCOUNT += 1;
//                                             RescPROVDOUBTBAL := RescDOUBTBAL * 0.5;

//                                         end else
//                                             IF ("Loans Register"."Loans Category-SASRA" = "Loans Register"."loans category-sasra"::Loss) and ("Loans Register".Rescheduled = true) then begin
//                                                 RescLOSSBAL := RescLOSSBAL + "Loans Register"."Outstanding Balance";
//                                                 RescLOSSCOUNT += 1;
//                                                 RescPROVLOSSBAL := RescLOSSBAL * 0.5;
//                                                 //RescPERFOMBAL:=0;

//                                             end;
//                         end;
//                     until "Loans Register".Next = 0;
//                 end;

//                 //GetSumTotals
//                 RescTcount := RescPERFOMCOUNT + RescWATCHCOUNT + RescSUBCOUNT + RescDOUBTCOUNT + RescLOSSCOUNT;
//                 RescPortfolio := RescPERFOMBAL + RescWATCHBAL + RescSUBBAL + RescDOUBTBAL + RescLOSSBAL;
//                 RescTprovision := RescPROVPERFOMBAL + RescPROVWATCHBAL + RescPROVSUBBAL + RescPROVDOUBTBAL + RescPROVLOSSBAL;
//                 //...........................................................................................................
//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = false;
//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';

//                 }
//             }
//         }

//         actions
//         {
//         }
//         trigger OnOpenPage()
//         begin
//             //:= false;
//         end;
//     }

//     trigger OnInitReport()
//     begin
//         Company.Get();
//         Company.CalcFields(Company.Picture);
//         ;

//     end;

//     trigger OnPostReport()
//     begin

//     end;

//     trigger OnPreReport()
//     begin
//         Datefilter := "Loans Register".GETFILTER("Date Filter");
//         PERFOMBAL := 0;
//         WATCHBAL := 0;
//         SUBBAL := 0;
//         DOUBTBAL := 0;
//         LOSSBAL := 0;
//         PERFOMCOUNT := 0;
//         WATCHCOUNT := 0;
//         SUBCOUNT := 0;
//         DOUBTCOUNT := 0;
//         LOSSCOUNT := 0;
//         PROVPERFOMBAL := 0;
//         PROVWATCHBAL := 0;
//         PROVSUBBAL := 0;
//         PROVDOUBTBAL := 0;
//         PROVLOSSBAL := 0;
//         RescTcount := 0;
//         RescPortfolio := 0;
//         RescTprovision := 0;
//         Tcount := 0;
//         Portfolio := 0;
//         Tprovision := 0;
//         RescPERFOMCOUNT := 0;
//         RescPROVPERFOMBAL := 0;
//         RescWATCHBAL := 0;
//         RescWATCHCOUNT := 0;
//         RescPROVWATCHBAL := 0;
//         RescSUBBAL := 0;
//         RescSUBCOUNT := 0;
//         RescPROVSUBBAL := 0;
//         RescDOUBTBAL := 0;
//         RescDOUBTCOUNT := 0;
//         RescPROVDOUBTBAL := 0;
//         RescLOSSBAL := 0;
//         RescLOSSCOUNT := 0;
//         RescPROVLOSSBAL := 0;
//     end;

//     var
//         IntAmount: Decimal;
//         RInst: Integer;
//         "Net Repayment": Decimal;
//         InCount: Integer;
//         LoansT: Record "Loans Register";
//         PERFOMBAL: Decimal;
//         WATCHBAL: Decimal;
//         SUBBAL: Decimal;
//         DOUBTBAL: Decimal;
//         LOSSBAL: Decimal;
//         PERFOMCOUNT: Integer;
//         WATCHCOUNT: Integer;
//         SUBCOUNT: Integer;
//         DOUBTCOUNT: Integer;
//         LOSSCOUNT: Integer;
//         PROVPERFOMBAL: Decimal;
//         PROVWATCHBAL: Decimal;
//         PROVSUBBAL: Decimal;
//         PROVDOUBTBAL: Decimal;
//         PROVLOSSBAL: Decimal;
//         Tcount: Integer;
//         Portfolio: Decimal;
//         Tprovision: Decimal;
//         RESCHEDULE: Decimal;
//         RescTcount: Decimal;
//         RescPortfolio: Decimal;
//         RescTprovision: Decimal;
//         CurrReport_PAGENOCaptionLbl: label 'Page';
//         RISK_CLASSIFICATION_OF_ASSETS_AND_PROVISIONINGCaptionLbl: label 'RISK CLASSIFICATION OF ASSETS AND PROVISIONING';
//         FORM_4CaptionLbl: label 'FORM 4';
//         SASRA_2_004CaptionLbl: label 'SASRA 2/004';
//         R__46_CaptionLbl: label 'R.(46)';
//         No__of_A_C_sCaptionLbl: label 'No. of A/C''s';
//         Outstanding_Loan_Portfolio__Kshs__CaptionLbl: label 'Outstanding Loan Portfolio (Kshs.)';
//         Required_Provision____CaptionLbl: label 'Required Provision (%)';
//         Required_Provision_Amount__Kshs__CaptionLbl: label 'Required Provision Amount (Kshs.)';
//         ClassificationCaptionLbl: label 'Classification';
//         No_CaptionLbl: label 'No.';
//         ACaptionLbl: label 'A';
//         BCaptionLbl: label 'B';
//         CCaptionLbl: label 'C';
//         DCaptionLbl: label 'D';
//         PORTFOLIO_AGEING_REPORTCaptionLbl: label 'PORTFOLIO AGEING REPORT';
//         LossCaptionLbl: label 'Loss';
//         DoubtfulCaptionLbl: label 'Doubtful';
//         SubstandardCaptionLbl: label 'Substandard';
//         WatchCaptionLbl: label 'Watch';
//         PerfomingCaptionLbl: label 'Perfoming';
//         V1CaptionLbl: label '1';
//         V2CaptionLbl: label '2';
//         V3CaptionLbl: label '3';
//         V4CaptionLbl: label '4';
//         V5CaptionLbl: label '5';
//         LossCaption_Control1102756051Lbl: label 'Loss';
//         DoubtfulCaption_Control1102756052Lbl: label 'Doubtful';
//         V4Caption_Control1102756057Lbl: label '4';
//         V5Caption_Control1102756058Lbl: label '5';
//         SubstandardCaption_Control1102756059Lbl: label 'Substandard';
//         V3Caption_Control1102756064Lbl: label '3';
//         WatchCaption_Control1102756065Lbl: label 'Watch';
//         V2Caption_Control1102756070Lbl: label '2';
//         PerfomingCaption_Control1102756071Lbl: label 'Perfoming';
//         V1Caption_Control1102756076Lbl: label '1';
//         Rescheduled_Renegotiated_LoansCaptionLbl: label 'Rescheduled/Renegotiated Loans';
//         Sub_TotalCaptionLbl: label 'Sub-Total';
//         AUTHORIZATIONCaptionLbl: label 'AUTHORIZATION';
//         We_declare_that_this_return__to_the_best_of_our_knowledge_and_belief_is_correct_CaptionLbl: label 'We declare that this return, to the best of our knowledge and belief is correct.';
//         Sign__________________________________________________Date_____________________________CaptionLbl: label '................................................Sign..................................................Date.............................';
//         Name_of_Authorizing_OfficerCaptionLbl: label 'Name of Authorizing Officer';
//         Sign__________________________________________________Date_____________________________Caption_Control1102756084Lbl: label '................................................Sign..................................................Date.............................';
//         Name_of_Counter_Signing_OfficerCaptionLbl: label 'Name of Counter Signing Officer';
//         Company: Record "Company Information";
//         TBal: Decimal;
//         Datefilter: Text;

//         RescPERFOMBAL: Decimal;
//         RescWATCHBAL: Decimal;
//         RescSUBBAL: Decimal;
//         RescDOUBTBAL: Decimal;
//         RescLOSSBAL: Decimal;
//         RescPERFOMCOUNT: Integer;
//         RescWATCHCOUNT: Integer;
//         RescSUBCOUNT: Integer;
//         RescDOUBTCOUNT: Integer;
//         RescLOSSCOUNT: Integer;
//         RescPROVPERFOMBAL: Decimal;
//         RescPROVWATCHBAL: Decimal;
//         RescPROVSUBBAL: Decimal;
//         RescPROVDOUBTBAL: Decimal;
//         RescPROVLOSSBAL: Decimal;

//     local procedure FnTotalOutstanding(): Decimal
//     var
//         TotalBalance: Decimal;
//     begin
//         /*
//         LoansT.RESET;
//         //LoansT.SETRANGE(LoansT."Loan  No.","Loans Register"."Loan  No.");
//         //LoansT.SETRANGE(LoansT."Loans Category-SASRA",LoansT."Loans Category-SASRA"::Perfoming);
//         IF LoansT.FIND('-') THEN BEGIN
//         LoansT.CALCFIELDS(LoansT."Outstanding Balance");
//         REPEAT
//         IF LoansT."Outstanding Balance">0 THEN BEGIN
//          TotalBalance:=TotalBalance+LoansT."Outstanding Balance";
//         END;
//        UNTIL LoansT.NEXT=0;
//        END;
//        EXIT(TotalBalance);
//        */

//     end;

//     // --> Reports ForNAV Autogenerated code - do not delete or modify
//     //51516139_v6_3_0_2259;

//     // Reports ForNAV Autogenerated code - do not delete or modify -->
// }
