// page 51516108 SafecustodyListRegister
// {
//     ApplicationArea = All;
//     Caption = 'Safe custody List Register';
//     PageType = List;
//     CardPageId=safecustodyCardRegister;
//     SourceTable = "Safe Custody Package Register";
//     UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("Charge Account"; Rec."Charge Account")
//                 {
//                     ToolTip = 'Specifies the value of the Charge Account field.';
//                 }
//                 field("Charge Account Name"; Rec."Charge Account Name")
//                 {
//                     ToolTip = 'Specifies the value of the Charge Account Name field.';
//                 }
//                 field("Collected At"; Rec."Collected At")
//                 {
//                     ToolTip = 'Specifies the value of the Collected At field.';
//                 }
//                 field("Collected By"; Rec."Collected By")
//                 {
//                     ToolTip = 'Specifies the value of the Collected By field.';
//                 }
//                 field("Collected On"; Rec."Collected On")
//                 {
//                     ToolTip = 'Specifies the value of the Collected On field.';
//                 }
//                 field("Custody Period"; Rec."Custody Period")
//                 {
//                     ToolTip = 'Specifies the value of the Custody Period field.';
//                 }
//                 field("Date Lodged"; Rec."Date Lodged")
//                 {
//                     ToolTip = 'Specifies the value of the Date Lodged field.';
//                 }
//                 field("Date Received"; Rec."Date Received")
//                 {
//                     ToolTip = 'Specifies the value of the Date Received field.';
//                 }
//                 field("Date Released"; Rec."Date Released")
//                 {
//                     ToolTip = 'Specifies the value of the Date Released field.';
//                 }
//                 field("File Serial No"; Rec."File Serial No")
//                 {
//                     ToolTip = 'Specifies the value of the File Serial No field.';
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
//                 }
//                 field("Lodged By(Custodian 1)"; Rec."Lodged By(Custodian 1)")
//                 {
//                     ToolTip = 'Specifies the value of the Lodged By(Custodian 1) field.';
//                 }
//                 field("Lodged By(Custodian 2)"; Rec."Lodged By(Custodian 2)")
//                 {
//                     ToolTip = 'Specifies the value of the Lodged By(Custodian 2) field.';
//                 }
//                 field("Maturity Date"; Rec."Maturity Date")
//                 {
//                     ToolTip = 'Specifies the value of the Maturity Date field.';
//                 }
//                 field("Maturity Instruction"; Rec."Maturity Instruction")
//                 {
//                     ToolTip = 'Specifies the value of the Maturity Instruction field.';
//                 }
//                 field("Member Name"; Rec."Member Name")
//                 {
//                     ToolTip = 'Specifies the value of the Member Name field.';
//                 }
//                 field("Member No"; Rec."Member No")
//                 {
//                     ToolTip = 'Specifies the value of the Member No field.';
//                 }
//                 field("No. Series"; Rec."No. Series")
//                 {
//                     ToolTip = 'Specifies the value of the No. Series field.';
//                 }
//                 field("Package Description"; Rec."Package Description")
//                 {
//                     ToolTip = 'Specifies the value of the Package Description field.';
//                 }
//                 field("Package ID"; Rec."Package ID")
//                 {
//                     ToolTip = 'Specifies the value of the Package ID field.';
//                 }
//                 field("Package Re_Booked On"; Rec."Package Re_Booked On")
//                 {
//                     ToolTip = 'Specifies the value of the Package Re_Booked On field.';
//                 }
//                 field("Package Re_Lodge Fee Charged"; Rec."Package Re_Lodge Fee Charged")
//                 {
//                     ToolTip = 'Specifies the value of the Package Re_Lodge Fee Charged field.';
//                 }
//                 field("Package Rebooked By"; Rec."Package Rebooked By")
//                 {
//                     ToolTip = 'Specifies the value of the Package Rebooked By field.';
//                 }
//                 field("Package Type"; Rec."Package Type")
//                 {
//                     ToolTip = 'Specifies the value of the Package Type field.';
//                 }
//                 field("Received By"; Rec."Received By")
//                 {
//                     ToolTip = 'Specifies the value of the Received By field.';
//                 }
//                 field("Released By(Custodian 1)"; Rec."Released By(Custodian 1)")
//                 {
//                     ToolTip = 'Specifies the value of the Released By(Custodian 1) field.';
//                 }
//                 field("Released By(Custodian 2)"; Rec."Released By(Custodian 2)")
//                 {
//                     ToolTip = 'Specifies the value of the Released By(Custodian 2) field.';
//                 }
//                 field("Retrieved At"; Rec."Retrieved At")
//                 {
//                     ToolTip = 'Specifies the value of the Retrieved At field.';
//                 }
//                 field("Retrieved By (Custodian 2)"; Rec."Retrieved By (Custodian 2)")
//                 {
//                     ToolTip = 'Specifies the value of the Retrieved By (Custodian 2) field.';
//                 }
//                 field("Retrieved By(Custodian 1)"; Rec."Retrieved By(Custodian 1)")
//                 {
//                     ToolTip = 'Specifies the value of the Retrieved By(Custodian 1) field.';
//                 }
//                 field("Retrieved On"; Rec."Retrieved On")
//                 {
//                     ToolTip = 'Specifies the value of the Retrieved On field.';
//                 }
//                 field("Safe Custody Fee Charged"; Rec."Safe Custody Fee Charged")
//                 {
//                     ToolTip = 'Specifies the value of the Safe Custody Fee Charged field.';
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ToolTip = 'Specifies the value of the Status field.';
//                 }
//                 field("Time Lodged"; Rec."Time Lodged")
//                 {
//                     ToolTip = 'Specifies the value of the Time Lodged field.';
//                 }
//                 field("Time Received"; Rec."Time Received")
//                 {
//                     ToolTip = 'Specifies the value of the Time Received field.';
//                 }
//                 field("Time Released"; Rec."Time Released")
//                 {
//                     ToolTip = 'Specifies the value of the Time Released field.';
//                 }
//             }
//         }
//     }
// }
