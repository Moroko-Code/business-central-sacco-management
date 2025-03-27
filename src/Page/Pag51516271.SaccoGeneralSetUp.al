#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516271 "Sacco General Set-Up"
{
    ApplicationArea = Basic;
    PageType = Card;
    SourceTable = "Sacco General Set-Up";
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Max. Non Contribution Periods"; "Max. Non Contribution Periods")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Contribution"; "Min. Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Member Age"; "Min. Member Age")
                {
                    ApplicationArea = Basic;
                }
                field("Retirement Age"; "Retirement Age")
                {
                    ApplicationArea = Basic;
                }
                field("Retained Shares"; "Retained Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Minimum Share Capital';
                }
                field("Maximum No of Loans Guaranteed"; "Maximum No of Loans Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Guarantors"; "Min. Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Guarantors"; "Max. Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Loan Application Period"; "Min. Loan Application Period")
                {
                    ApplicationArea = Basic;
                }
                field("Boosting Fees Account"; "Boosting Fees Account")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend (%)"; "Dividend (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Interest on Deposits (%)"; "Interest on Deposits (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Dividend Proc. Period"; "Min. Dividend Proc. Period")
                {
                    ApplicationArea = Basic;
                }
                field("Member Can Guarantee Own Loan"; "Member Can Guarantee Own Loan")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Withdrawal Period"; "Withdrawal Period")
                {
                    ApplicationArea = Basic;
                }
                field("Use Bands"; "Use Bands")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Maximum No of Guarantees"; "Maximum No of Guarantees")
                {
                    ApplicationArea = Basic;
                }
                field("Top up Account"; "Top up Account")
                {
                    ApplicationArea = basic;
                }
                field("Max. Contactual Shares"; "Max. Contactual Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Commision (%)"; "Commision (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Fee"; "Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Commision"; "Withdrawal Commision")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Closure Fee(With Notice)';
                }
                // field("Speed Charge"; "Speed Charge")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Account Closure Fee(Without Notice)';
                // }
                // field("Speed Charge (%)"; "Speed Charge (%)")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Asset Valuation Cost"; "Asset Valuation Cost")
                {
                    ApplicationArea = all;
                }
                field("Legal Fees"; "Legal Fees")
                {
                    ApplicationArea = all;
                }
                field("Banks Charges"; "Banks Charges")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank charges Account';
                }
                field("Withdrawal Fee Account"; "Withdrawal Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Registration Fee"; "Registration Fee")
                {
                    ApplicationArea = Basic;
                    Caption = 'Membership Fee';
                }
                field("Rejoining Fee"; "Rejoining Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Welfare Contribution"; "Welfare Contribution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Insurance Contribution';
                }
                field("Boosting Shares %"; "Boosting Shares %")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Excise Duty(%)"; "Excise Duty(%)")
                {
                    ApplicationArea = Basic;
                }
                field("Boosting Shares Maturity (M)"; "Boosting Shares Maturity (M)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Approved Loans Letter"; "Approved Loans Letter")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("ATM Expiry Duration"; "ATM Expiry Duration")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Rejected Loans Letter"; "Rejected Loans Letter")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Monthly Share Contributions"; "Monthly Share Contributions")
                {
                    ApplicationArea = Basic;
                }
                field("Auto Open FOSA Savings Acc."; "Auto Open FOSA Savings Acc.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Auto Open Agile Savings Acc.';
                    Visible = false;
                }
                field("FOSA Account Type"; "FOSA Account Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Customer Care No"; "Customer Care No")
                {
                    ApplicationArea = Basic;
                }
                field("Send SMS Notifications"; "Send SMS Notifications")
                {
                    ApplicationArea = Basic;
                }
                field("Send Email Notifications"; "Send Email Notifications")
                {
                    ApplicationArea = Basic;
                }
                field("Auto Fill Msacco Application"; "Auto Fill Msacco Application")
                {
                    ApplicationArea = Basic;
                    Caption = 'Auto Fill S-Pesa Application';
                    Visible = false;
                }
                field("Auto Fill ATM Application"; "Auto Fill ATM Application")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Form Fee"; "Form Fee")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Passcard Fee"; "Passcard Fee")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                // field("share Capital"; "share Capital")
                // {
                //     ApplicationArea = Basic;

                // }
                field("Form Fee Account"; "Form Fee Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Membership Form Acct"; "Membership Form Acct")
                {
                    ApplicationArea = Basic;
                    Caption = 'PassCard Acct';
                    Visible = false;
                }
                field("Ceep Reg Fee"; "Ceep Reg Fee")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Ceep Reg Acct"; "Ceep Reg Acct")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Withholding Tax Account"; "Withholding Tax Account")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                Visible = false;
                field("Overdraft App Nos."; "Overdraft App Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Overdraft Limit"; "Overdraft Limit")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Micro)
            {
                Visible = false;
                Caption = 'Micro';
                field("Group Account No"; "Group Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Business Loans A/c Format"; "Business Loans A/c Format")
                {
                    ApplicationArea = Basic;
                    Caption = 'MICRO Loans A/C Format';
                }
                field("Min. Contribution Bus Loan"; "Min. Contribution Bus Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Min. Contribution CEEP';
                }
            }
            group("Mail Setup")
            {
                Caption = 'Mail Setup';
                Visible = false;
                field("Incoming Mail Server"; "Incoming Mail Server")
                {
                    ApplicationArea = Basic;
                }
                field("Outgoing Mail Server"; "Outgoing Mail Server")
                {
                    ApplicationArea = Basic;
                }
                field("Email Text"; "Email Text")
                {
                    ApplicationArea = Basic;
                }
                field("Sender User ID"; "Sender User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Sender Address"; "Sender Address")
                {
                    ApplicationArea = Basic;
                }
                field("Email Subject"; "Email Subject")
                {
                    ApplicationArea = Basic;
                }
                field("Statement Message #1"; "Statement Message #1")
                {
                    ApplicationArea = Basic;
                }
                field("Statement Message #2"; "Statement Message #2")
                {
                    ApplicationArea = Basic;
                }
                field("Statement Message #3"; "Statement Message #3")
                {
                    ApplicationArea = Basic;
                }
                field("Statement Message #4"; "Statement Message #4")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Others)
            {
                Caption = 'Others';
                field("Insurance Retension Account"; "Insurance Retension Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Fixed Deposit A/C"; "Fixed Deposit A/C")
                {
                    ApplicationArea = all;
                }

                field("Fixed Deposit Int Percentage"; "Fixed Deposit Int Percentage")
                {
                    Caption = 'Fixed Depossit Interest Percentage';
                    ApplicationArea = all;

                }
                field("Shares Retension Account"; "Shares Retension Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Loan Transfer Fees Account"; "Loan Transfer Fees Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bridging Commision Account"; "Bridging Commision Account")
                {
                    ApplicationArea = Basic;
                }
                field("Funeral Expenses Amount"; "Funeral Expenses Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Funeral Expenses Account"; "Funeral Expenses Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Excise Duty Account"; "Excise Duty Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Cheque Processing Fee"; "Cheque Processing Fee")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Cheque Processing Fee Account"; "Cheque Processing Fee Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
            group("Dividends Processing Setups")
            {
                field("Withholding Tax (%)"; "Withholding Tax (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Interest On Current Shares"; "Interest On Current Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest On Current Shares(%)';
                }
                field("Interest on Share Capital(%)"; "Interest on Share Capital(%)")
                {
                    ApplicationArea = Basic;
                }
                field("Dividends Paying Bank Account"; "Dividends Paying Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Interest On FOSA Shares"; "Interest On FOSA Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest On FOSA Shares(%)';
                    Visible = false;
                }
                field("Dividend Payable Account"; "Dividend Payable Account")
                {
                    ApplicationArea = Basic;
                }
                field("Interest On Preferential Shares"; "Interest On PreferentialShares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest On Preferential Shares(%)';
                    Visible = false;
                }
                field("Interest On Lift Shares"; "Interest On LiftShares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest On Lift Shares(%)';
                    Visible = false;
                }
                field("Interest On PreferentialShares"; "Interest On PreferentialShares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest On Preferential Shares(%)';
                    Visible = false;
                }
                field("Interest On TambaaShares"; "Interest On TambaaShares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest On Tambaa Shares(%)';
                    Visible = false;
                }
                field("Interest On PepeaShares"; "Interest On PepeaShares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest On Pepea Shares(%)';
                    Visible = false;
                }
                field("Interest On HousingShares"; "Interest On HousingShares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest On Housing Shares(%)';
                    Visible = false;
                }
                field("Dividends Capitalization Rate"; "Dividends Capitalization Rate")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividends Capitalization Rate(%)';
                    Visible = false;
                }
            }
            group(ATM)
            {
                visible = false;
                field("ATM Card Fee-New Coop"; "ATM Card Fee-New Coop")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee-New Sacco"; "ATM Card Fee-New Sacco")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee-Replacement"; "ATM Card Fee-Replacement")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee-Renewal"; "ATM Card Fee-Renewal")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee-Account"; "ATM Card Fee-Account")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee Co-op Bank"; "ATM Card Fee Co-op Bank")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Co-op Bank Amount"; "ATM Card Co-op Bank Amount")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Shares Bands")
            {
                Visible = false;
                Caption = 'Shares Bands';
            }
        }
        area(processing)
        {
            action("Reset Data Sheet")
            {
                Visible = false;
                ApplicationArea = Basic;
                Caption = 'Reset Data Sheet';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                end;
            }
        }
    }

    var
        Cust: Record Customer;
        Loans: Record "Loans Register";

    trigger OnInit()
    begin
        if Rec.IsEmpty() then
            Rec.Insert();
    end;
}
