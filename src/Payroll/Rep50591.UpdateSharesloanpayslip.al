Report 50591 "Update Shares & loan payslip"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("prPeriod Transactions."; "prPeriod Transactions.")
        {
            RequestFilterFields = "Employee Code";
            trigger OnAfterGetRecord();
            begin

                if Customer.get("Employee Code") then
                    if "prPeriod Transactions."."Transaction Code" = 'DEVCO' then begin
                        Customer.SetRange(Customer."No.", "prPeriod Transactions."."Employee Code");
                        // memb.SetRange(memb."Transaction Type", memb."transaction type"::Loan);
                        if memb.Find('-') then begin
                            Totalshares := 0;
                            Totalshares := Customer."Monthly Contribution";
                        end;
                        "prPeriod Transactions.".Balance := Totalshares;
                        "prPeriod Transactions.".Modify;
                    end;
                //end of shares update
                //Getting Loan OutStanding Balance Manu
                if ("prPeriod Transactions."."Loan Number" <> '') and ("prPeriod Transactions."."coop parameters" = "prPeriod Transactions."."coop parameters"::loan) then begin
                    LoanR.SetRange(LoanR."Loan  No.", "Loan Number");
                    ;
                    if LoanR.Find('-') then begin
                        LNPric := 0;
                        LoanR.CalcFields(LoanR."Outstanding Balance");
                        LNPric := LoanR."Outstanding Balance";
                    end;
                    //End of getting loan
                    //updating Payroll Employee transactions
                    "prPeriod Transactions.".Balance := (LNPric);
                    "prPeriod Transactions.".Modify;
                end;
                if ("prPeriod Transactions."."Loan Number" <> '') and ("prPeriod Transactions."."coop parameters" = "prPeriod Transactions."."coop parameters"::"loan Interest") then begin
                    LoanR.SetRange(LoanR."Loan  No.", "Loan Number");
                    if LoanR.Find('-') then begin
                        LNPric := 0;
                        LoanR.CalcFields(LoanR."Interest Due");
                        LNPric := LoanR."Interest Due";
                    end;
                    //End of getting loan
                    //updating Payroll Employee transactions
                    "prPeriod Transactions.".Balance := (LNPric);
                    "prPeriod Transactions.".Modify;
                end;
                //end of Loan D005 update
            end;
        }
    }

    requestpage
    {
        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
        end;
    }

    trigger OnInitReport()
    begin
        ;
    end;

    trigger OnPostReport()
    begin
        ;
    end;

    trigger OnPreReport()
    begin
        ;
    end;

    var
        Customer: Record Customer;
        Totalshares: Decimal;
        memb: Record "Cust. Ledger Entry";
        LoanR: Record "Loans Register";
        LNPric: Decimal;

    var
}