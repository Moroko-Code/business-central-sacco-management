tableextension 51516075 "General Ledger SetUpExt" extends "General Ledger Setup"
{
    fields
    {
        field(10001; "VAT in Use"; Boolean)
        {
            Caption = 'VAT in Use';
        }
        field(10002; "Bank Rec. Adj. Doc. Nos."; Code[10])
        {
            Caption = 'Bank Rec. Adj. Doc. Nos.';
            TableRelation = "No. Series";
        }
        field(10003; "Deposit Nos."; Code[10])
        {
            Caption = 'Deposit Nos.';
            TableRelation = "No. Series";
        }
        field(10004; "SAT Certificate Thumbprint"; Text[250])
        {
            Caption = 'SAT Certificate Thumbprint';
        }
        field(10005; "Send PDF Report"; Boolean)
        {
            Caption = 'Send PDF Report';
        }
        field(10006; "Hash Algorithm"; Option)
        {
            Caption = 'Hash Algorithm';
            OptionCaption = ',SHA-1';
            OptionMembers = ,"SHA-1";
        }
        field(10007; "PAC Code"; Code[10])
        {
            Caption = 'PAC Code';

            trigger OnValidate()
            begin
                if "PAC Code" = '' then
                    "PAC Environment" := "pac environment"::Disabled;
            end;
        }
        field(10008; "PAC Environment"; Option)
        {
            Caption = 'PAC Environment';
            OptionCaption = 'Disabled,Test,Production';
            OptionMembers = Disabled,Test,Production;
        }
        field(10010; "Sim. Signature"; Boolean)
        {
            Caption = 'Sim. Signature';
        }
        field(10011; "Sim. Send"; Boolean)
        {
            Caption = 'Sim. Send';
        }
        field(10012; "Sim. Request Stamp"; Boolean)
        {
            Caption = 'Sim. Request Stamp';
        }
        field(10120; "Bank Recon. with Auto. Match"; Boolean)
        {
            Caption = 'Bank Recon. with Auto. Match';
            InitValue = true;

            trigger OnValidate()
            begin
                // if "Bank Recon. with Auto. Match" then
                //     CheckSelectedReports(Report::"Bank Account Statement", Report::"Bank Acc. Reconciliation")
                // else
                //     CheckSelectedReports(Report::"Bank Reconciliation", Report::"Bank Rec. Test Report");
            end;
        }
        field(50001; "M-SACCO Registration Charge"; Code[20])
        {
        }
        field(50002; "MPESA Application Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50003; "MPESA Change Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50004; "Change MPESA PIN Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50005; "Bulk SMS Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50006; "Customer Care No"; Code[20])
        {
        }
        field(50007; "Send Salary SMS"; Option)
        {
            OptionCaption = ',YES,NO';
            OptionMembers = ,YES,NO;
        }
        field(50008; "Mobile Transfer Charge"; Code[20])
        {
            TableRelation = Charges;
        }
        field(50009; "CloudPESA Comm Acc"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50010; "CloudPESA Charge"; Decimal)
        {
        }
        field(50011; "Agency Application Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50012; "Agency Charges Acc"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50013; "MPESA Recon Acc"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(50014; "M-banking Charges Acc"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50015; PaybillAcc; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(50016; AirTimeSettlAcc; Code[30])
        {
            TableRelation = "Bank Account";
        }
        field(50017; "Mobile Charge"; Code[20])
        {
        }
        field(50018; "Imprest Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
    }

    fieldgroups
    {
    }

    var
        Text016: label 'Enter one number or two numbers separated by a colon. ';
        Text017: label 'The online Help for this field describes how you can fill in the field.';
        Text018: label 'You cannot change the contents of the %1 field because there are posted ledger entries.';
        Text023: label '%1\You cannot use the same dimension twice in the same setup.';
        Dim: Record Dimension;
        GLEntry: Record "G/L Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        JobLedgEntry: Record "Job Ledger Entry";
        ResLedgEntry: Record "Res. Ledger Entry";
        FALedgerEntry: Record "FA Ledger Entry";
        MaintenanceLedgerEntry: Record "Maintenance Ledger Entry";
        InsCoverageLedgerEntry: Record "Ins. Coverage Ledger Entry";
        AnalysisView: Record "Analysis View";
        AnalysisViewEntry: Record "Analysis View Entry";
        AnalysisViewBudgetEntry: Record "Analysis View Budget Entry";
        ErrorMessage: Boolean;

    procedure CheckDecimalPlacesFormat(var DecimalPlaces: Text[5])
    var
        OK: Boolean;
        ColonPlace: Integer;
        DecimalPlacesPart1: Integer;
        DecimalPlacesPart2: Integer;
        Check: Text[5];
    begin
        OK := true;
        ColonPlace := StrPos(DecimalPlaces, ':');

        if ColonPlace = 0 then begin
            if not Evaluate(DecimalPlacesPart1, DecimalPlaces) then
                OK := false;
            if (DecimalPlacesPart1 < 0) or (DecimalPlacesPart1 > 9) then
                OK := false;
        end else begin
            Check := CopyStr(DecimalPlaces, 1, ColonPlace - 1);
            if Check = '' then
                OK := false;
            if not Evaluate(DecimalPlacesPart1, Check) then
                OK := false;
            Check := CopyStr(DecimalPlaces, ColonPlace + 1, StrLen(DecimalPlaces));
            if Check = '' then
                OK := false;
            if not Evaluate(DecimalPlacesPart2, Check) then
                OK := false;
            if DecimalPlacesPart1 > DecimalPlacesPart2 then
                OK := false;
            if (DecimalPlacesPart1 < 0) or (DecimalPlacesPart1 > 9) then
                OK := false;
            if (DecimalPlacesPart2 < 0) or (DecimalPlacesPart2 > 9) then
                OK := false;
        end;

        if not OK then
            Error(
              Text016 +
              Text017);

        if ColonPlace = 0 then
            DecimalPlaces := Format(DecimalPlacesPart1)
        else
            DecimalPlaces := StrSubstNo('%1:%2', DecimalPlacesPart1, DecimalPlacesPart2);
    end;

    procedure GetCurrencyCode(CurrencyCode: Code[10]): Code[10]
    begin
        case CurrencyCode of
            '':
                exit("LCY Code");
            "LCY Code":
                exit('');
            else
                exit(CurrencyCode);
        end;
    end;

    local procedure RoundingErrorCheck(NameOfField: Text[100])
    begin
        ErrorMessage := false;
        if GLEntry.FindFirst then
            ErrorMessage := true;
        if ItemLedgerEntry.FindFirst then
            ErrorMessage := true;
        if JobLedgEntry.FindFirst then
            ErrorMessage := true;
        if ResLedgEntry.FindFirst then
            ErrorMessage := true;
        if FALedgerEntry.FindFirst then
            ErrorMessage := true;
        if MaintenanceLedgerEntry.FindFirst then
            ErrorMessage := true;
        if InsCoverageLedgerEntry.FindFirst then
            ErrorMessage := true;
        if ErrorMessage then
            Error(
              Text018,
              NameOfField);
    end;

    local procedure DeleteIntrastatJnl()
    var
        IntrastatJnlBatch: Record "Intrastat Jnl. Batch";
        IntrastatJnlLine: Record "Intrastat Jnl. Line";
    begin
        IntrastatJnlBatch.SetRange(Reported, false);
        IntrastatJnlBatch.SetRange("Amounts in Add. Currency", true);
        if IntrastatJnlBatch.Find('-') then
            repeat
                IntrastatJnlLine.SetRange("Journal Template Name", IntrastatJnlBatch."Journal Template Name");
                IntrastatJnlLine.SetRange("Journal Batch Name", IntrastatJnlBatch.Name);
                IntrastatJnlLine.DeleteAll;
            until IntrastatJnlBatch.Next = 0;
    end;

    local procedure DeleteAnalysisView()
    begin
        if AnalysisView.Find('-') then
            repeat
                if AnalysisView.Blocked = false then begin
                    AnalysisViewEntry.SetRange("Analysis View Code", AnalysisView.Code);
                    AnalysisViewEntry.DeleteAll;
                    AnalysisViewBudgetEntry.SetRange("Analysis View Code", AnalysisView.Code);
                    AnalysisViewBudgetEntry.DeleteAll;
                    AnalysisView."Last Entry No." := 0;
                    AnalysisView."Last Budget Entry No." := 0;
                    AnalysisView."Last Date Updated" := 0D;
                    AnalysisView.Modify;
                end else begin
                    AnalysisView."Refresh When Unblocked" := true;
                    AnalysisView.Modify;
                end;
            until AnalysisView.Next = 0;
    end;

    procedure IsPostingAllowed(PostingDate: Date): Boolean
    begin
        exit(PostingDate >= "Allow Posting From");
    end;

    procedure OptimGLEntLockForMultiuserEnv(): Boolean
    begin
        // if "Use Legacy G/L Entry Locking" then
        //     exit(false);

        // if InventorySetup.Get then
        //     if InventorySetup."Automatic Cost Posting" then
        //         exit(false);

        // exit(true);
    end;

    procedure FirstAllowedPostingDate() AllowedPostingDate: Date
    var
        InvtPeriod: Record "Inventory Period";
    begin
        AllowedPostingDate := "Allow Posting From";
        if not InvtPeriod.IsValidDate(AllowedPostingDate) then
            AllowedPostingDate := CalcDate('<+1D>', AllowedPostingDate);
    end;

    procedure UpdateDimValueGlobalDimNo(xDimCode: Code[20]; DimCode: Code[20]; ShortcutDimNo: Integer)
    var
        DimensionValue: Record "Dimension Value";
    begin
        if Dim.CheckIfDimUsed(DimCode, ShortcutDimNo, '', '', 0) then
            Error(Text023, Dim.GetCheckDimErr);
        if xDimCode <> '' then begin
            DimensionValue.SetRange("Dimension Code", xDimCode);
            DimensionValue.ModifyAll("Global Dimension No.", 0);
        end;
        if DimCode <> '' then begin
            DimensionValue.SetRange("Dimension Code", DimCode);
            DimensionValue.ModifyAll("Global Dimension No.", ShortcutDimNo);
        end;
        Modify;
    end;

    local procedure HideDialog(): Boolean
    begin
        exit((CurrFieldNo = 0) or not GuiAllowed);
    end;

    local procedure SelectReport(UsageValue: Option): Text
    var
        ReportSelections: Record "Report Selections";
    begin
        ReportSelections.SetRange(Usage, UsageValue);

        case true of
        // ReportSelections.IsEmpty:
        //     begin
        //         ReportSelections.Reset;
        //         ReportSelections.InsertRec(UsageValue, '1', ReportID);
        //         exit(StrSubstNo(ReportIsSelectedTxt, Description, FieldCaption("Bank Recon. with Auto. Match")));
        //     end;
        // ReportSelections.Count = 1:
        //     begin
        //         ReportSelections.FindFirst;
        //         if ReportSelections."Report ID" <> ReportID then begin
        //             ReportSelections.Validate("Report ID", ReportID);
        //             ReportSelections.Modify;
        //             exit(StrSubstNo(AutoSelectReportTxt, Description, FieldCaption("Bank Recon. with Auto. Match")));
        //         end;
        //     end;
        // else
        //     exit(StrSubstNo(TooManyReportsAreSelectedTxt, FieldCaption("Bank Recon. with Auto. Match"), ReportID, Description));
        end;
    end;
}