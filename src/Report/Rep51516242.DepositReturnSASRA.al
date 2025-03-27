#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516242 "Deposit Return SASRA"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/DepositReturnSASRA.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            CalcFields = "Current Shares";
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Date Filter", "No.";

            column(Datefilter; Datefilter)
            {
            }
            column(TotalAmounts; TotalAmounts)
            {
            }
            column(TotalCounts; TotalCounts)
            {
            }
            column(SavingsDeposit1; SavingsDeposit1)
            {
            }
            column(SavingsDeposit2; SavingsDeposit2)
            {
            }
            column(SavingsDeposit3; SavingsDeposit3)
            {
            }
            column(SavingsDeposit4; SavingsDeposit4)
            {
            }
            column(SavingsDeposit5; SavingsDeposit5)
            {
            }
            column(SavingsDeposit1Count; SavingsDeposit1Count)
            {
            }
            column(SavingsDeposit2Count; SavingsDeposit2Count)
            {
            }
            column(SavingsDeposit3Count; SavingsDeposit3Count)
            {
            }
            column(SavingsDeposit4Count; SavingsDeposit4Count)
            {
            }
            column(SavingsDeposit5Count; SavingsDeposit5Count)
            {
            }
            //............................................................
            column(TermDeposit1; TermDeposit1)
            {
            }
            column(TermDeposit2; TermDeposit2)
            {
            }
            column(TermDeposit3; TermDeposit3)
            {
            }
            column(TermDeposit4; TermDeposit4)
            {
            }
            column(TermDeposit5; TermDeposit5)
            {
            }
            column(TermDeposit1Count; TermDeposit1Count)
            {
            }
            column(TermDeposit2Count; TermDeposit2Count)
            {
            }
            column(TermDeposit3Count; TermDeposit3Count)
            {
            }
            column(TermDeposit4Count; TermDeposit4Count)
            {
            }
            column(TermDeposit5Count; TermDeposit5Count)
            {
            }
            column(NWD1; NWD1)
            {
            }
            column(NWD2; NWD2)
            {
            }
            column(NWD3; NWD3)
            {
            }
            column(NWD4; NWD4)
            {
            }
            column(NWD5; NWD5)
            {
            }
            column(NWD1Count; NWD1Count)
            {
            }
            column(NWD2Count; NWD2Count)
            {
            }
            column(NWD3Count; NWD3Count)
            {
            }
            column(NWD4Count; NWD4Count)
            {
            }
            column(NWD5Count; NWD5Count)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //--------------------------------------------------------------Non-Withdrawable shares
                if Customer.get(Customer."No.") then begin
                    Customer.SetFilter(Customer."Date Filter", Datefilter);
                    Customer.SetAutoCalcFields(Customer."Current Shares", Customer."Tamba Shares");
                    repeat
                        if Customer."Current Shares" + Customer."Tamba Shares" < 50000 then begin
                            //-----------------------
                            NWD1 := NWD1 + Customer."Current Shares" + Customer."Tamba Shares";
                            NWD1Count := NWD1Count + 1;
                            //---------------------------
                        end else
                            if (customer."Current Shares" + Customer."Tamba Shares" > 50000) and (customer."Current Shares" + Customer."Tamba Shares" < 100000) then begin
                                //-----------------------
                                NWD2 := NWD2 + Customer."Current Shares" + Customer."Tamba Shares";
                                NWD2Count := NWD2Count + 1;
                                //-----------------------
                            end else
                                if (customer."Current Shares" + Customer."Tamba Shares" > 100000) and (customer."Current Shares" + Customer."Tamba Shares" < 300000) then begin
                                    //-----------------------
                                    NWD3 := NWD3 + Customer."Current Shares" + Customer."Tamba Shares";
                                    NWD3Count := NWD3Count + 1;
                                    //-----------------------
                                end else
                                    if (customer."Current Shares" + Customer."Tamba Shares" > 300000) and (customer."Current Shares" + Customer."Tamba Shares" < 1000000) then begin
                                        //-----------------------
                                        NWD4 := NWD4 + Customer."Current Shares" + Customer."Tamba Shares";
                                        NWD4Count := NWD4Count + 1;
                                        //-----------------------
                                    end
                                    else
                                        if (customer."Current Shares" + Customer."Tamba Shares" > 1000000) then begin
                                            //-----------------------
                                            NWD5 := NWD5 + Customer."Current Shares" + Customer."Tamba Shares";
                                            NWD5Count := NWD5Count + 1;
                                            //-----------------------
                                        end;
                        //------------------------------ORDINARY SHARES
                        TotalNetChange := 0;
                        VendorTable.Reset();
                        VendorTable.SetFilter(VendorTable."Date Filter", Datefilter);
                        VendorTable.SetRange(VendorTable."BOSA Account No", Customer."No.");
                        VendorTable.SetAutoCalcFields(VendorTable."Account Balance");
                        VendorTable.SetFilter(VendorTable."Account Type", '%1|%2|%3|%4', 'ORDINARY', 'CURRENT', 'JUNIOR', 'NON-MEMBER');
                        if VendorTable.Find('-') then begin
                            TotalNetSavings := 0;
                            repeat
                                TotalNetSavings += (VendorTable."Account Balance");
                                if TotalNetSavings < 50000 then begin
                                    //-----------------------
                                    SavingsDeposit1 += TotalNetSavings;
                                    SavingsDeposit1Count := SavingsDeposit1Count + 1;
                                    //---------------------------
                                end else
                                    if (TotalNetSavings > 50000) and (TotalNetSavings < 100000) then begin
                                        //-----------------------

                                        SavingsDeposit2 += TotalNetSavings;
                                        SavingsDeposit2Count := SavingsDeposit2Count + 1;
                                        //-----------------------
                                    end else
                                        if (TotalNetSavings > 100000) and (TotalNetSavings < 300000) then begin
                                            //-----------------------

                                            SavingsDeposit3 += TotalNetSavings;
                                            SavingsDeposit3Count := SavingsDeposit3Count + 1;
                                            //-----------------------
                                        end else
                                            if (TotalNetSavings > 300000) and (TotalNetSavings < 1000000) then begin
                                                //-----------------------
                                                SavingsDeposit4 += TotalNetSavings;
                                                SavingsDeposit4Count := SavingsDeposit4Count + 1;
                                                //-----------------------
                                            end
                                            else
                                                if (TotalNetSavings > 1000000) then begin
                                                    //-----------------------
                                                    SavingsDeposit5 += TotalNetSavings;
                                                    SavingsDeposit5Count := SavingsDeposit5Count + 1;
                                                    //-----------------------
                                                end;
                            UNTIL VendorTable.Next = 0;
                        end;

                        //-----------------------------FIXED DEPOSITS
                        TotalNetChange := 0;
                        VendorTable.Reset();
                        VendorTable.SetFilter(VendorTable."Date Filter", Datefilter);
                        VendorTable.SetRange(VendorTable."BOSA Account No", Customer."No.");
                        VendorTable.SetAutoCalcFields(VendorTable."Account Balance");
                        VendorTable.SetFilter(VendorTable."Account Type", '%1|%2|%3|%4', 'FIXED', 'CHRISTMAS', 'JAZA', 'HOLIDAY');
                        if VendorTable.Find('-') then begin
                            TotalNetChange := 0;
                            repeat
                                TotalNetChange += (VendorTable."Account Balance");
                                if TotalNetChange < 50000 then begin
                                    //-----------------------
                                    TermDeposit1 += TotalNetChange;
                                    TermDeposit1Count := TermDeposit1Count + 1;
                                    //---------------------------
                                end else
                                    if (TotalNetChange > 50000) and (TotalNetChange < 100000) then begin
                                        //-----------------------

                                        TermDeposit2 += TotalNetChange;
                                        TermDeposit2Count := TermDeposit2Count + 1;
                                        //-----------------------
                                    end else
                                        if (TotalNetChange > 100000) and (TotalNetChange < 300000) then begin
                                            //-----------------------

                                            TermDeposit3 += TotalNetChange;
                                            TermDeposit3Count := TermDeposit3Count + 1;
                                            //-----------------------
                                        end else
                                            if (TotalNetChange > 300000) and (TotalNetChange < 1000000) then begin
                                                //-----------------------
                                                TermDeposit4 += TotalNetChange;
                                                TermDeposit4Count := TermDeposit4Count + 1;
                                                //-----------------------
                                            end
                                            else
                                                if (TotalNetChange > 1000000) then begin
                                                    //-----------------------
                                                    TermDeposit5 += TotalNetChange;
                                                    TermDeposit5Count := TermDeposit5Count + 1;
                                                    //-----------------------
                                                end;
                            until VendorTable.Next = 0;
                        end;
                    until Customer.Next = 0;
                end;

                //-----------------------------------------------------------------------Savings
                TotalCounts := NWD1Count + NWD2Count + NWD3Count + NWD4Count + NWD5Count + TermDeposit1Count + TermDeposit2Count + TermDeposit3Count
                + TermDeposit4Count + TermDeposit5Count + SavingsDeposit1Count + SavingsDeposit2Count +
                 SavingsDeposit3Count + SavingsDeposit4Count + SavingsDeposit5Count;

                TotalAmounts := NWD1 + NWD2 + NWD3 + NWD4 + NWD5 + TermDeposit1 + TermDeposit2 + TermDeposit3
                + TermDeposit4 + TermDeposit5 + SavingsDeposit1 + SavingsDeposit2 +
                 SavingsDeposit3 + SavingsDeposit4 + SavingsDeposit5;
            end;

            trigger OnPostDataItem()
            begin
            end;

            trigger OnPreDataItem()
            begin
                Datefilter := Customer.GETFILTER("Date Filter");
                NWD1 := 0;
                NWD2 := 0;
                NWD3 := 0;
                NWD4 := 0;
                NWD5 := 0;
                NWD1Count := 0;
                NWD2Count := 0;
                NWD3Count := 0;
                NWD4Count := 0;
                NWD5Count := 0;
                TermDeposit1 := 0;
                TermDeposit2 := 0;
                TermDeposit3 := 0;
                TermDeposit4 := 0;
                TermDeposit5 := 0;
                TermDeposit1Count := 0;
                TermDeposit2Count := 0;
                TermDeposit3Count := 0;
                TermDeposit4Count := 0;
                TermDeposit5Count := 0;
                SavingsDeposit1 := 0;
                SavingsDeposit2 := 0;
                SavingsDeposit3 := 0;
                SavingsDeposit4 := 0;
                SavingsDeposit5 := 0;
                SavingsDeposit1Count := 0;
                SavingsDeposit2Count := 0;
                SavingsDeposit3Count := 0;
                SavingsDeposit4Count := 0;
                SavingsDeposit5Count := 0;
                TotalNetSavings := 0;
                TotalNetChange := 0;
                TotalNetChange := 0;
                TotalCounts := 0;
                TotalAmounts := 0;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        TotalAmounts: Decimal;
        TotalCounts: Decimal;
        Datefilter: Text;
        NWD1: Decimal;
        NWD2: Decimal;
        NWD3: Decimal;
        NWD4: Decimal;
        NWD5: Decimal;
        NWD1Count: Decimal;
        NWD2Count: Decimal;
        NWD3Count: Decimal;
        NWD4Count: Decimal;
        NWD5Count: Decimal;
        TermDeposit1: Decimal;
        TermDeposit2: Decimal;
        TermDeposit3: Decimal;
        TermDeposit4: Decimal;
        TermDeposit5: Decimal;
        GLTable: Record "G/L Account";
        TotalNetChange: Decimal;
        TermDeposit1Count: Decimal;
        TermDeposit2Count: Decimal;
        TermDeposit3Count: Decimal;
        TermDeposit4Count: Decimal;
        TermDeposit5Count: Decimal;

        TotalNetSavings: Decimal;
        SavingsDeposit1Count: Decimal;
        SavingsDeposit2Count: Decimal;
        SavingsDeposit3Count: Decimal;
        SavingsDeposit4Count: Decimal;
        SavingsDeposit5Count: Decimal;
        SavingsDeposit1: Decimal;
        SavingsDeposit2: Decimal;
        SavingsDeposit3: Decimal;
        SavingsDeposit4: Decimal;
        SavingsDeposit5: Decimal;
        VendorTable: Record Vendor;
        OrdinaryAccount: Code[100];
}
