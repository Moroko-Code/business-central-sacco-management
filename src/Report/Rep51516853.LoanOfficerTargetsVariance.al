// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 51516853 "Loan Officer Targets/Variance"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/LoanOfficerTargetsVariance.rdlc';

//     dataset
//     {
//         dataitem("Loan Officers Details";"Loan Officers Details")
//         {
//             RequestFilterFields = "Savings Target","Membership Target",Branch,"Disbursement Target","Payment Target","Exit Target","Account No.","Account Name","Group Target","No. of Loans";
//             column(ReportForNavId_1000000000; 1000000000)
//             {
//             }
//             column(Account_No;"Loan Officers Details"."Account No.")
//             {
//             }
//             column(Name;"Loan Officers Details"."Account Name")
//             {
//             }
//             column("Code";"Loan Officers Details".Code)
//             {
//             }
//             column(Sales_Code_Type;"Loan Officers Details"."Sales Code Type")
//             {
//             }
//             column(Savings_Targets;"Loan Officers Details"."Savings Target")
//             {
//             }
//             column(Membership_Target;"Loan Officers Details"."Membership Target")
//             {
//             }
//             column(Group_Target;"Loan Officers Details"."Group Target")
//             {
//             }
//             column(Disbursement_Target;"Loan Officers Details"."Disbursement Target")
//             {
//             }
//             column(Payment_Target;"Loan Officers Details"."Payment Target")
//             {
//             }
//             column(Exit_Target;"Loan Officers Details"."Exit Target")
//             {
//             }
//             column(Branch;"Loan Officers Details".Branch)
//             {
//             }
//             column(No_Of_Loans;"Loan Officers Details"."No. of Loans")
//             {
//             }
//             column(companyInfo_Picture;companyInfo.Picture)
//             {
//             }
//             column(companyInfo_Name;companyInfo.Name)
//             {
//             }
//             column(i;i)
//             {
//             }
//             column(LoanCount;LoanCount)
//             {
//             }
//             column(MemberCount;MemberCount)
//             {
//             }
//             column(GroupCount;GroupCount)
//             {
//             }
//             column(SavingsCount;SavingsCount)
//             {
//             }
//             column(ApprovedAmount;ApprovedAmount)
//             {
//             }
//             column(CurrentSavings;CurrentSavings)
//             {
//             }
//             column(LoanRepayment;-LoanRepayment)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin

//                 i:=i+1;

//                 LoanCount := 0;
//                 Loans.Reset;
//                 Loans.SetRange(Loans."Loan Officer","Loan Officers Details"."Account No.");
//                 if Loans.FindSet then
//                 LoanCount := Loans.Count;

//                 MemberCount:=0;
//                 Member.Reset;
//                 Member.SetRange(Member."Recruited By","Loan Officers Details"."Account No.");
//                 if Member.FindSet then
//                 MemberCount:=Member.Count;

//                 GroupCount:=0;
//                 Member.Reset;
//                 Member.SetRange(Member."Recruited By","Loan Officers Details"."Account No.");
//                 if Member.FindSet then
//                 GroupCount:=Member.Count;

//                 SavingsCount:=0;
//                 Member.Reset;
//                 Member.SetRange(Member."Current Shares","Loan Officers Details"."Savings Target");
//                 if Member.FindSet then
//                 begin
//                 Member.CalcSums("Current Shares");
//                 SavingsCount := Member."Current Shares";
//                 end;

//                 //*** Compute Actual Dirsbursement Amount***
//                 ApprovedAmount := 0;
//                 Loans.Reset;
//                 Loans.SetRange(Loans."Loan Officer","Loan Officers Details"."Account No.");
//                 if Loans.FindSet then
//                 Loans.CalcSums(Loans."Approved Amount");
//                 ApprovedAmount:=Loans."Approved Amount";
//                 //***  End Compute Actual Dirsbursement Amount***

//                 CurrentSavings := 0;
//                 Member.Reset;
//                 Member.SetRange(Member."Recruited By","Loan Officers Details"."Account No.") ;
//                 if Member.Find('-') then repeat
//                 Member.CalcFields(Member."Current Shares");

//                 CurrentSavings+=Member."Current Shares";
//                 until Member.Next=0;

//                 LoanRepayment:=0;
//                 Loans.Reset;
//                 Loans.SetRange(Loans."Loan Officer","Loan Officers Details"."Account No.");
//                 if Loans.Find('-') then begin repeat
//                  Loans.CalcFields(Loans."Loan Repayment",Loans."Interest Paid");
//                  LoanRepayment+= Loans."Loan Repayment"+Loans."Interest Paid";
//                 until Loans.Next=0; end;
//             end;

//             trigger OnPreDataItem()
//             begin
//                    companyInfo.Get();
//                    companyInfo.CalcFields(Picture);
//             end;
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         companyInfo: Record "Company Information";
//         i: Integer;
//         Loans: Record "Loans Register";
//         LoanCount: Integer;
//         MemberCount: Integer;
//         GroupCount: Integer;
//         SavingsCount: Decimal;
//         Member: Record Customer;
//         ApprovedAmount: Decimal;
//         CurrentSavings: Decimal;
//         LoanRepayment: Decimal;
// }
