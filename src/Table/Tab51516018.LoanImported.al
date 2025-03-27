table 51516018 "Loan Imported"
{
    Caption = 'Loan Imported';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No"; Code[40])
        {
            Caption = 'Loan No';
        }
        field(2; Source; Enum LoanSourcesEnum)
        {
            Caption = 'Source';
        }
        field(3; "Loan Product Type"; Code[100])
        {
            Caption = 'Loan Product Type';
        }
        field(4; "Repayment Method"; Option)
        {
            Caption = 'Repayement Method';
            OptionCaption = 'Checkoff,Standing Order,Salary,Pension,Direct Debits,Tea,Milk,Tea Bonus,Dividend,Loan,Direct,Dividends';
            OptionMembers = Checkoff,"Standing Order",Salary,Pension,"Direct Debits",Tea,Milk,"Tea Bonus",Dividend,Loan,Direct,Dividends;
        }
        field(5; "Applied Amount"; Decimal)
        {
            Caption = 'Applied Amount';
        }
        field(6; "Loan Balance"; Decimal)
        {
            Caption = 'Loan Balance';
        }
        field(7; "Application Date"; Date)
        {
            Caption = 'Application Date';
        }
        field(8; "Captured By"; Code[100])
        {
            Caption = 'Captured By';
        }
        field(9; "Overdraft Period"; Integer)
        {
            Caption = 'Overdraft Period';
        }
        field(11; "Loan Disbursement Date"; date)
        {
            Caption = 'Loan Disbursement Date';
        }
        field(12; "Vendor No"; Code[50])
        {
        }
        field(13; "Client Code"; Code[50])
        {
        }
    }
    keys
    {
        key(PK; "Loan No")
        {
            Clustered = true;
        }
    }
}
