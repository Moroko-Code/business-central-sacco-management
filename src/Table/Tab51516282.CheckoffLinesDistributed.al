#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516282 "Checkoff Lines-Distributed"
{
    fields
    {
        field(1; "Staff/Payroll No"; Code[20])
        {
        }
        field(2; Amount; Decimal)
        {
        }
        field(3; "No Repayment"; Boolean)
        {
        }
        field(4; "Staff Not Found"; Boolean)
        {
        }
        field(5; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(6; "Transaction Date"; Date)
        {
        }
        field(7; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(8; Generated; Boolean)
        {
        }
        field(9; "Payment No"; Integer)
        {
        }
        field(10; Posted; Boolean)
        {
        }
        field(11; "Multiple Receipts"; Boolean)
        {
        }
        field(12; Name; Text[200])
        {
        }
        field(13; "Early Remitances"; Boolean)
        {
        }
        field(14; "Early Remitance Amount"; Decimal)
        {
        }
        field(15; "Loan No."; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Member No."));
        }
        field(16; "Member No."; Code[20])
        {
        }
        field(17; Interest; Decimal)
        {
        }
        field(18; "Loan Type"; Code[10])
        {
        }
        field(19; DEPT; Code[10])
        {
        }
        field(20; "Expected Amount"; Decimal)
        {
        }
        field(21; "FOSA Account"; Code[20])
        {
        }
        field(22; "Utility Type"; Code[20])
        {
        }
        field(23; "Transaction Type"; Option)
        {
            OptionMembers = " ","Deposits Contribution","Insurance contribution","SchFees Shares","Interest Paid";
        }
        field(24; Reference; Code[50])
        {
        }
        field(25; "Account type"; Code[10])
        {
        }
        field(26; Variance; Decimal)
        {
        }
        field(27; "Employer Code"; Code[20])
        {
        }
        field(28; GPersonalNo; Code[10])
        {
        }
        field(29; Gnames; Text[80])
        {
        }
        field(30; Gnumber; Code[10])
        {
        }
        field(31; Userid1; Code[15])
        {
        }
        field(32; "Loans Not found"; Boolean)
        {
        }
        field(33; "Receipt Header No"; Code[20])
        {
            TableRelation = "Checkoff Header-Distributed".No;
        }
        field(34; "Loan Balance"; Decimal)
        {
        }
        field(35; adviced; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Receipt Header No", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
