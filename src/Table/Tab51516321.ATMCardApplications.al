#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516321 "ATM Card Applications"
{
    fields
    {
        field(1; "Account No"; Code[19])
        {
            TableRelation = Vendor."No." where("Account Type" = const('ORDINARY'));

            trigger OnValidate()
            begin
                /*Vend.RESET;
                IF Vend.GET(UserID) THEN BEGIN
                "Payment Journal Template":=PADSTR(Vend.Name,19);
                "Default Receipts Bank":=Vend."ID No.";
                "Receipt Journal Template":='000';
                "Phone No.":=Vend."Phone No.";
                END;
                "Max. Cheque Collection":=TODAY;

                "Account No C":=CONVERTSTR(UserID,'-',' ');
                  */
                Vend.Reset;
                Vend.SetRange(Vend."No.", "Account No");
                if Vend.Find('-') then begin
                    "Account Name" := Vend.Name;
                    "Phone No." := Vend."Phone No.";
                end;
            end;
        }
        field(2; "Branch Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(3; "Account Type"; Option)
        {
            OptionCaption = 'Savings,Current';
            OptionMembers = Savings,Current;

            trigger OnValidate()
            begin
                /*IF "Receipt Journal Batch"="Receipt Journal Batch"::"0" THEN
                "Account Type C":='05'
                ELSE
                "Account Type C":='04'
                   */
            end;
        }
        field(4; "Account Name"; Text[50])
        {
        }
        field(5; "Address 1"; Text[35])
        {
        }
        field(6; "Address 2"; Text[35])
        {
        }
        field(7; "Address 3"; Text[35])
        {
        }
        field(8; "Address 4"; Text[35])
        {
        }
        field(9; "Address 5"; Text[35])
        {
        }
        field(10; "Customer ID"; Code[10])
        {
        }
        field(11; "Relation Indicator"; Option)
        {
            OptionCaption = 'Primary,Suplimentary';
            OptionMembers = Primary,Suplimentary;

            trigger OnValidate()
            begin
                /*IF "Default Payment Bank"="Default Payment Bank"::"0" THEN
                "Relation Indicator C":='P'
                ELSE
                "Relation Indicator C":='S'
                   */
            end;
        }
        field(12; "Card Type"; Text[30])
        {
        }
        field(13; "Request Type"; Option)
        {
            OptionCaption = 'New,Replacement,Re-Pin';
            OptionMembers = New,Replacement,"Re-Pin",Supplementary;

            trigger OnValidate()
            begin
                /*IF "Max. Cash Collection"="Max. Cash Collection"::"0" THEN
                "Request Type C":='N'
                ELSE IF "Max. Cash Collection"="Max. Cash Collection"::"1" THEN
                "Request Type C":='R'
                ELSE
                "Request Type C":='P'
                    */
            end;
        }
        field(14; "Application Date"; Date)
        {
        }
        field(15; "Card No"; Code[30])
        {
        }
        field(16; "Date Issued"; Date)
        {
        }
        field(17; Limit; Decimal)
        {
        }
        field(18; "Terms Read and Understood"; Boolean)
        {
        }
        field(19; "Card Issued"; Boolean)
        {
        }
        field(20; "Form No"; Code[30])
        {
        }
        field(21; "Sent To External File"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(22; "Card Status"; Option)
        {
            OptionMembers = Pending,Active,Frozen;
        }
        field(23; "Date Activated"; Date)
        {
        }
        field(24; "Date Frozen"; Date)
        {
        }
        field(27; "Replacement For Card No"; Code[20])
        {
        }
        field(28; "Has Other Accounts"; Boolean)
        {
        }
        field(29; "Account Type C"; Code[2])
        {
        }
        field(30; "Relation Indicator C"; Code[1])
        {
        }
        field(31; "Request Type C"; Code[1])
        {
        }
        field(32; "Account No C"; Code[19])
        {
        }
        field(33; "Phone No."; Code[20])
        {
            trigger OnValidate()
            begin
                if "Phone No." <> '' then begin
                    StrTel := CopyStr("Phone No.", 1, 4);

                    if StrTel <> '+254' then
                        Error('The MPESA Mobile Phone No. should be in the format +254XXXYYYZZZ.');

                    if StrLen("Phone No.") <> 13 then
                        Error('Invalid MPESA mobile phone number. Please enter the correct mobile phone number.');
                end;
            end;
        }
        field(34; "No."; Code[20])
        {
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."ATM Applications");
                    "No. Series" := '';
                end;
            end;
        }
        field(35; "No. Series"; Code[10])
        {
        }
        field(36; Collected; Boolean)
        {
        }
        field(37; "Application Approved"; Boolean)
        {
        }
        field(38; "Date Collected"; Date)
        {
        }
        field(39; "Card Issued By"; Code[50])
        {
        }
        field(40; "Approval Date"; Date)
        {
        }
        field(41; "Reason for Account blocking"; Text[50])
        {
        }
        field(42; "ATM Expiry Date"; Date)
        {
        }
        field(43; "Card Issued to Customer"; Option)
        {
            OptionCaption = 'Owner Collected,Card Sent,Card Issued to';
            OptionMembers = "Owner Collected","Card Sent","Card Issued to";
        }
        field(44; "Issued to"; Text[70])
        {
        }
    }

    keys
    {
        key(Key1; "Account No", "Card No")
        {
            Clustered = true;
        }
        key(Key2; "Account No", "Relation Indicator")
        {
        }
        key(Key3; "Application Date", "Account No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Vend: Record Vendor;
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        StrTel: Text[30];
}
