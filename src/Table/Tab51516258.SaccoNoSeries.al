#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516258 "Sacco No. Series"
{
    fields
    {
        field(1; "Primary Key"; Code[100])
        {
        }
        field(2; "FOSA Loans Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(3; "Members Nos"; Code[10])
        {
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
            end;
        }
        field(4; "BOSA Loans Nos"; Code[10])
        {
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                /*LoanApps.RESET;
                LoanApps.SETRANGE(LoanApps."No. Series","BOSA Loans Nos");
                IF LoanApps.FIND('-') = FALSE THEN BEGIN
                 ERROR('You cannot Delete/Modify since Series has been used in one or more transactions');
                END;
                    */
            end;
        }
        field(5; "Loans Batch Nos"; Code[10])
        {
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                /*LoanApps.RESET;
                LoanApps.SETRANGE(LoanApps."Batch No.","Loans Batch Nos");
                IF LoanApps.FIND('-') = FALSE THEN BEGIN
                 ERROR('You cannot Delete/Modify since Series has been used in one or more transactions');
                END;
                         */
            end;
        }
        field(6; "Investors Nos"; Code[10])
        {
        }
        field(7; "Property Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(8; "BOSA Receipts Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(9; "Investment Project Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(10; "BOSA Transfer Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(11; "SMS Request Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(12; "Withholding Tax %"; Decimal)
        {
        }
        field(13; "Withholding Tax Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(14; "VAT %"; Decimal)
        {
        }
        field(15; "VAT Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(16; "PV No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(17; "Receipts Nos"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(18; "Petty Cash  No."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(19; "Member Application Nos"; Code[10])
        {
            TableRelation = "No. Series".Code;

            trigger OnValidate()
            begin
                /*
             CustMembApp.RESET;
             CustMembApp.SETRANGE(CustMembApp."No. Series","Member Application Nos");
             IF CustMembApp.FIND('-') = FALSE THEN BEGIN
              ERROR('You cannot Delete/Modify since Series has been used in one or more entries');
             END;
                   */
            end;
        }
        field(20; "Closure  Nos"; Code[10])
        {
            TableRelation = "No. Series".Code;

            trigger OnValidate()
            begin
                /*AccClosure.RESET;
                AccClosure.SETRANGE(AccClosure."No. Series","Closure  Nos");
                IF AccClosure.FIND('-') = TRUE THEN BEGIN
                 ERROR('You cannot Delete/Modify since Series has been used in one or more entries');
                END;
                    */
            end;
        }
        field(21; "Bosa Transaction Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(22; "Transaction Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(23; "Treasury Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(24; "Standing Orders Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(25; "FOSA Current Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(26; "BOSA Current Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(27; "Teller Transactions No"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(28; "Treasury Transactions No"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(29; "Applicants Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(30; "STO Register No"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(31; "EFT Header Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(32; "EFT Details Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(33; "Salaries Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(34; "Requisition No"; Code[10])
        {
            Caption = 'Requisition No';
            TableRelation = "No. Series";
        }
        field(35; "Internal Requisition No."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(36; "Internal Purchase No."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(37; "Quatation Request No"; Code[10])
        {
            Caption = 'Quatation Request No';
            TableRelation = "No. Series";
        }
        field(38; "ATM Applications"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(39; "Stores Requisition No"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(40; "Requisition Default Vendor"; Code[10])
        {
        }
        field(41; "Use Procurement limits"; Boolean)
        {
        }
        field(42; "Request for Quotation Nos"; Code[20])
        {
        }
        field(43; "Teller Bulk Trans Nos."; Code[10])
        {
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                /*RcptBuffer.RESET;
                RcptBuffer.SETRANGE(RcptBuffer."No. Series","Receipt Buffer Nos.");
                IF RcptBuffer.FIND('-') = FALSE THEN BEGIN
                 ERROR('You cannot Delete/Modify since Series has been used in one or more transactions');
                END;
                 */
            end;
        }
        field(44; "Micro Loans"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(45; "Micro Transactions"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(46; "Micro Finance Transactions"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(47; "Micro Group Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(48; "MPESA Change Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(49; "MPESA Application Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50; "Change MPESA PIN Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(51; "Change MPESA Application Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(52; "Last Memb No."; Code[30])
        {
        }
        field(53; BosaNumber; Code[30])
        {
        }
        field(54; "Investor Application Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(55; "Investor Nos"; Code[30])
        {
        }
        field(56; "Paybill Processing"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(57; "Checkoff-Proc Distributed Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(58; "Tracker no"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(59; "SurePESA Registration Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(60; "Activation Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(61; "Customer Care Log Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(62; "Cheque Nos."; Code[15])
        {
            TableRelation = "No. Series";
        }
        field(51516002; "Banking Shares Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516003; "Cheque Application Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516004; "Cheque Receipts Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516005; "OVerdraft Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516006; "Lead Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(51516007; "Disciplinary Cases Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(51516008; "Top Up Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(51516009; "Agency Members Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(51516010; "Okoa No."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(51516011; "Change Request No"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(51516012; "Member Agent/NOK Change"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(51516013; "Agent Serial Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(51516014; "Guarantor Sub No."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(51516015; "Safe Custody Package Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(51516016; "Top Up Loan Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(51516017; "Loan Recovery Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(51516018; "Member Periodics Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516019; "Share Capital Transfer No.s"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516020; "Member Re-Application No.s"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516021; "Loan Appeal Numbers"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            //Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LoanApps: Record "Loans Register";
        CustMemb: Record Customer;
        CustMembApp: Record "Membership Applications";
        

    procedure TestNoEntriesExist(CurrentFieldName: Text[100])
    var
        LoanApps: Record "Loans Register";
    begin
        /*
        //To prevent change of field
         LoanApps.SETCURRENTKEY(LoanApps."No. Series");
         LoanApps.SETRANGE(LoanApps."No. Series","No.");
        IF LoanApps.FIND('-') THEN
          ERROR(
          Text000,
           CurrentFieldName);
        */
    end;
}
