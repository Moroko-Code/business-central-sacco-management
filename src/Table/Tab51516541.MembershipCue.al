#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516541 "Membership Cue"
{
    fields
    {
        field(1; "User ID"; Code[50])
        {
        }
        field(2; "Active Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Active),
                                                          "Customer Type" = filter('MEMBER')));
            FieldClass = FlowField;
        }
        field(3; "Dormant Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Dormant)));
            FieldClass = FlowField;
        }
        field(4; "Deceased Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Deceased)));
            FieldClass = FlowField;
        }
        field(5; "Withdrawn Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Withdrawal)));
            FieldClass = FlowField;
        }
        field(6; "Male Members"; Integer)
        {
            CalcFormula = count(Customer where(Gender = const(Male)));
            FieldClass = FlowField;
        }
        field(7; "Female Members"; Integer)
        {
            CalcFormula = count(Customer where(Gender = const(Female)));
            FieldClass = FlowField;
        }
        // field(8;"Resigned Members";Integer)
        // {
        //     CalcFormula = count(Customer where (Status=const(Resi)));
        //     FieldClass = FlowField;
        // }
        field(9; Asset; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('ASSET'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(10; "Ceep New"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('CEEP NEW'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(11; College; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('COLLEGE'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(12; "Xmas Adv"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('CHRISTMAS ADV'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(13; "School Fees"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('SCHOOL FEES'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(14; "Members with ID No"; Integer)
        {
            CalcFormula = count(Customer where("ID No." = filter(> '0')));
            FieldClass = FlowField;
        }
        field(15; "Members With Tell No"; Integer)
        {
            CalcFormula = count(Customer where("Phone No." = filter(> '0')));
            FieldClass = FlowField;
        }
        field(16; "Members With Mobile No"; Integer)
        {
            CalcFormula = count(Customer where("Mobile Phone No" = filter(> '0')));
            FieldClass = FlowField;
        }
        field(17; Crop; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('CROP'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(18; Development; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('DEVELOPMENT'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(19; "Devt Savings"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('DEVTVIA_SAVINGS'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(20; Digital; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('DIGITAL'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(21; Executive; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('EXECUTIVE'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(22; Housing; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('HOUSING'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(23; Mfadhili; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('MFADHILI'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(24; Mkombozi; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('MKOMBOZI'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(25; MILK; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('MILK'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(26; "Non-Active Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const("Non-Active")));
            FieldClass = FlowField;
        }
        field(27; "Normal Adv Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('NORM ADV'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(28; Pepea; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('PEPEA'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(29; StaffCar; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('STAFF CAR'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(30; StaffHousing; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('STAFF HOUSING'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(31; "Normal Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('DEVELOPMENT'),
                                                        Posted = const(true)));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(33; "Junior Members"; Integer)
        {
            CalcFormula = count(Vendor where("Account Type" = filter('JUNIOR'),
                                              Status = filter(Active)));
            FieldClass = FlowField;
        }
        field(34; Cooperative; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('COOPERATIVE'),
                                                        Posted = const(true),
                                                        "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(35; "Maua Members"; Integer)
        {
            CalcFormula = count(Customer where("Global Dimension 2 Code" = filter('001'),
                                                          Status = filter(Active),
                                                          //   "Account Category"=filter(<>Junior),
                                                          "Customer Posting Group" = filter(<> 'MICRO')));
            FieldClass = FlowField;
        }
        field(36; "KK Members"; Integer)
        {
            CalcFormula = count(Customer where("Global Dimension 2 Code" = filter('003'),
                                                          Status = filter(Active),
                                                          //   "Account Category"=filter(<>Junior),
                                                          "Customer Posting Group" = filter(<> 'MICRO')));
            FieldClass = FlowField;
        }
        field(37; "Mutuati Members"; Integer)
        {
            CalcFormula = count(Customer where("Global Dimension 2 Code" = filter('002'),
                                                          Status = filter(Active),
                                                          //   "Account Category"=filter(<>Junior),
                                                          "Customer Posting Group" = filter(<> 'MICRO')));
            FieldClass = FlowField;
        }
        field(38; "Muriri Members"; Integer)
        {
            CalcFormula = count(Customer where("Global Dimension 2 Code" = filter('004'),
                                                          Status = filter(Active),
                                                          //   "Account Category"=filter(<>Junior),
                                                          "Customer Posting Group" = filter(<> 'MICRO')));
            FieldClass = FlowField;
        }
        field(39; "Mikinduri Members"; Integer)
        {
            CalcFormula = count(Customer where("Global Dimension 2 Code" = filter('005'),
                                                          Status = filter(Active),
                                                          //   "Account Category"=filter(<>Junior),
                                                          "Customer Posting Group" = filter(<> 'MICRO')));
            FieldClass = FlowField;
        }
        field(40; "Ceep Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Active),
                                                          //   "Account Category"=filter(<>Junior),
                                                          "Customer Posting Group" = filter('MICRO'),
                                                          "Group Account" = filter(false)));
            FieldClass = FlowField;
        }
        field(41; "Ceep Groups"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Active),
                                                          //   "Account Category"=filter(<>Junior),
                                                          "Customer Posting Group" = filter('MICRO'),
                                                          "Group Account" = filter(true)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
