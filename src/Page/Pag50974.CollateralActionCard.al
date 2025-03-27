#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50974 "Collateral Action Card"
{
    PageType = Card;
    SourceTable = "Loan Collateral Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Type"; Rec."Collateral Type")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Description"; Rec."Collateral Description")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Posting Group"; Rec."Collateral Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }

                field("Asset Value"; Rec."Asset Value")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Date Received"; Rec."Date Received")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
                field("Registered Owner"; Rec."Registered Owner")
                {
                    ApplicationArea = Basic;

                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Registration/Reference No.';
                }
                field("Received By"; Rec."Received By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Released"; Rec."Date Released")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Released By"; Rec."Released By")
                {
                    ApplicationArea = Basic;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                    Enabled = true;

                }

            }
            group("Insurance Details")
            {
                Visible = false;
                field("Insurance Effective Date"; Rec."Insurance Effective Date")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Expiration Date"; Rec."Insurance Expiration Date")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Policy No."; Rec."Insurance Policy No.")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Annual Premium"; Rec."Insurance Annual Premium")
                {
                    ApplicationArea = Basic;
                }
                field("Policy Coverage"; Rec."Policy Coverage")
                {
                    ApplicationArea = Basic;
                }
                field("Total Value Insured"; Rec."Total Value Insured")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Type"; Rec."Insurance Type")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Vendor No."; Rec."Insurance Vendor No.")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Depreciation Details")
            {
                Visible = false;

                field("Depreciation Completion Date"; Rec."Depreciation Completion Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Date of Loan Complition';
                    Visible = false;
                }
                field("Depreciation Percentage"; Rec."Depreciation Percentage")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Collateral Depreciation Method"; Rec."Collateral Depreciation Method")
                {
                    Visible = false;

                }

            }

            group("Received at HQ")
            {
                Visible = ReceivedAtHQVisible;
                field("Received to HQ By"; Rec."Received to HQ By")
                {
                    ApplicationArea = Basic;
                }
                field("Received to HQ On"; Rec."Received to HQ On")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Strong Room")
            {
                Visible = StrongRoomVisible;
                field("Lodged to Strong Room By"; Rec."Lodged to Strong Room By")
                {
                    ApplicationArea = Basic;
                }
                field("Lodged to Strong Room On"; Rec."Lodged to Strong Room On")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved From Strong Room By"; Rec."Retrieved From Strong Room By")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved From Strong Room On"; Rec."Retrieved From Strong Room On")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Lawyer)
            {
                Visible = LawyerVisible;
                field("Issued to Lawyer By"; Rec."Issued to Lawyer By")
                {
                    ApplicationArea = Basic;
                }
                field("Issued to Lawyer On"; Rec."Issued to Lawyer On")
                {
                    ApplicationArea = Basic;
                }
                field("Lawyer Code"; Rec."Lawyer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Lawyer Name"; Rec."Lawyer Name")
                {
                    ApplicationArea = Basic;
                }
                field("Received From Lawyer By"; Rec."Received From Lawyer By")
                {
                    ApplicationArea = Basic;
                }
                field("Received From Lawyer On"; Rec."Received From Lawyer On")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Insurance Agent")
            {
                Visible = InsuranceAgentVisible;
                field("Issued to Insurance Agent By"; Rec."Issued to Insurance Agent By")
                {
                    ApplicationArea = Basic;
                }
                field("Issued to Insurance Agent On"; Rec."Issued to Insurance Agent On")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Agent Code"; Rec."Insurance Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Agent Name"; Rec."Insurance Agent Name")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Branch)
            {
                Visible = BranchVisible;
                field("Dispatched to Branch By"; Rec."Dispatched to Branch By")
                {
                    ApplicationArea = Basic;
                }
                field("Dispatched to Branch On"; Rec."Dispatched to Branch On")
                {
                    ApplicationArea = Basic;
                }
                field("Dispatch to Branch"; Rec."Dispatch to Branch")
                {
                    ApplicationArea = Basic;
                }
                field("Received at Branch By"; Rec."Received at Branch By")
                {
                    ApplicationArea = Basic;
                }
                field("Received at Branch On"; Rec."Received at Branch On")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Issue to Member")
            {
                Visible = IssuetoMemberVisible;
                field("Released to Member By"; Rec."Released to Member By")
                {
                    ApplicationArea = Basic;
                }
                field("Released to Member on"; Rec."Released to Member on")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Issued to Auctioneers")
            {
                Visible = IssuetoAuctioneerVisible;
                field("Issued to Auctioneer By"; Rec."Issued to Auctioneer By")
                {
                    ApplicationArea = Basic;
                }
                field("Issued to Auctioneer On"; Rec."Issued to Auctioneer On")
                {
                    ApplicationArea = Basic;
                }
            }

        }
    }



    var

        ObjCollateralDetails: Record "Loan Collateral Details";
        VarNoofYears: Integer;
        VarDepreciationValue: Decimal;

        VarDepreciationNo: Integer;

        VarCurrentNBV: Decimal;
        ReceivedAtHQVisible: Boolean;
        StrongRoomVisible: Boolean;
        LawyerVisible: Boolean;
        InsuranceAgentVisible: Boolean;
        BranchVisible: Boolean;
        IssuetoMemberVisible: Boolean;
        IssuetoAuctioneerVisible: Boolean;
        SafeCustodyVisible: Boolean;

        ObjVendors: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        JTemplate: Code[20];
        JBatch: Code[20];
        DocNo: Code[20];
        GenSetup: Record "Sacco General Set-Up";
        LineNo: Integer;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due ";
        AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        BalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;

        LodgeFee: Decimal;
        LodgeFeeAccount: Code[20];
        SurestepFactory: Codeunit "SURESTEP Factory";
        ObjNoSeries: Record "Sacco No. Series";
        VarPackageNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;



}

