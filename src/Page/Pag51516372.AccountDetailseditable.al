// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Page 51516372 "Account Details-editable"
// {
//     ApplicationArea = Basic;
//     CardPageID = "Account Card-editable";
//     DeleteAllowed = false;
//     Editable = false;
//     PageType = List;
//     SourceTable = Vendor;
//     UsageCategory = Tasks;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("No.";"No.")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Name;Name)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Staff No";"Staff No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Search Name";"Search Name")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Account Type";"Account Type")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Vendor Posting Group";"Vendor Posting Group")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Salary Processing";"Salary Processing")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Global Dimension 2 Code";"Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("ATM No.""";"ATM No.")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'ATM No.';
//                 }
//                 field("BOSA Account No";"BOSA Account No")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Member No.';
//                 }
//                 field("ID No.";"ID No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Balance;Balance)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Company Code";"Company Code")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Mobile Phone No";"Mobile Phone No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Phone No.";"Phone No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Disabled ATM Card No";"Disabled ATM Card No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Status;Status)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Monthly Contribution";"Monthly Contribution")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Account)
//             {
//                 Caption = 'Account';
//                 action("Ledger E&ntries")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Ledger E&ntries';
//                     Image = VendorLedger;
//                     RunObject = Page "Vendor Ledger Entries";
//                     RunPageLink = "Vendor No."=field("No.");
//                     RunPageView = sorting("Vendor No.");
//                     ShortCutKey = 'Ctrl+F7';
//                 }
//                 action("Co&mments")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page "Comment Sheet";
//                     RunPageLink = "Table Name"=const(Vendor),
//                                   "No."=field("No.");
//                 }
//                 action(Dimensions)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     RunObject = Page "Default Dimensions";
//                     RunPageLink = "Table ID"=const(23),
//                                   "No."=field("No.");
//                     ShortCutKey = 'Shift+Ctrl+D';
//                 }
//                 separator(Action1102755228)
//                 {
//                 }
//                 separator(Action1102755226)
//                 {
//                 }
//                 separator(Action1102755225)
//                 {
//                 }
//                 action("Member Page")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Member Page';
//                     Image = Planning;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "Member Account Card";
//                     RunPageLink = "No."=field("BOSA Account No");
//                 }
//                 action("<Action11027600800>")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Loans Statements';
//                     Image = "Report";
//                     Promoted = true;
//                     PromotedCategory = "Report";

//                     trigger OnAction()
//                     begin
//                         /*Cust.RESET;
//                         Cust.SETRANGE(Cust."No.","No.");
//                         IF Cust.FIND('-') THEN
//                         REPORT.RUN(,TRUE,TRUE,Cust)
//                         */

//                     end;
//                 }
//                 separator(Action1102755222)
//                 {
//                 }
//             }
//             group(ActionGroup1102755220)
//             {
//                 action("Next Of Kin")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Next Of Kin';
//                     Image = Relationship;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "Account Next of Kin Details";
//                     RunPageLink = "Account No"=field("No.");
//                 }
//                 separator(Action1102755217)
//                 {
//                 }
//                 action("Page Vendor Statement")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Statement';
//                     Image = "Report";
//                     Promoted = true;
//                     PromotedCategory = "Report";

//                     trigger OnAction()
//                     begin
//                         /*
//                         Vend.RESET;
//                         Vend.SETRANGE(Vend."No.","No.");
//                         IF Vend.FIND('-') THEN
//                         REPORT.RUN(,TRUE,FALSE,Vend)
//                         */

//                     end;
//                 }
//                 action("Page Vendor Statistics")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     RunObject = Page "FOSA Statistics";
//                     RunPageLink = "No."=field("No."),
//                                   "Global Dimension 1 Filter"=field("Global Dimension 1 Filter"),
//                                   "Global Dimension 2 Filter"=field("Global Dimension 2 Filter");
//                     ShortCutKey = 'F7';
//                 }
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin

//         StatusPermissions.Reset;
//         StatusPermissions.SetRange(StatusPermissions."User Id",UserId);
//         StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::Edit);
//         if StatusPermissions.Find('-') = false then
//         Error('You do not have permissions to charge member statement,please contact systems administrator');
//     end;

//     var
//         Cust: Record Customer;
//         Vend: Record Vendor;
//         StatusPermissions: Record "Status Change Permision";
// }
