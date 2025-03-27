#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516226 "Member List"
{
    ApplicationArea = Basic;
    Caption = 'Member List';
    CardPageID = "Member Account Card";
    Editable = false;
    DeleteAllowed = true;
    PageType = List;
    SourceTable = Customer;
    SourceTableView = sorting("No.")
                      order(ascending)
                      where("Customer Type" = filter(Member));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the First Name field.', Comment = '%';
                }
                field("Second Name"; Rec."Second Name")
                {
                    ToolTip = 'Specifies the value of the Second Name field.', Comment = '%';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.', Comment = '%';
                }

                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile Phone';
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = basic;
                }
                field("Shares Retained"; "Shares Retained")
                {
                    ApplicationArea = Basic;
                    Caption = 'Share Capital';
                }
                field("Current Shares"; "Current Shares")
                {
                    Caption = 'Non-withdrawable Deposits';
                    Style = StrongAccent;
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance"; "Outstanding Balance")
                {
                    Style = StrongAccent;
                    Caption = 'Oustanding Loan Balance';
                    ApplicationArea = Basic;
                }
                // field("Outstanding Interest"; "Outstanding Interest")
                // {
                //     Style = StrongAccent;
                //     Caption = 'Oustanding Loan Interest';
                //     ApplicationArea = Basic;
                // }

                // field("Un-allocated Funds"; "Un-allocated Funds")
                // {
                //     ApplicationArea = all;
                // }

            }
        }
        area(factboxes)
        {
            part("Member Statistics FactBox"; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
                Visible = true;
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(ActionGroup1102755007)
            {
                action(DetailedStatement)
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "process";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516223, true, false, Cust);
                    end;
                }
                action(GStatement)
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guaranteed';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "process";
                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516226, true, false, Cust);
                    end;
                }
                action("Shares Statement")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    visible = false;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516302, true, false, Cust);
                    end;
                }
                action("Loans Statement")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    visible = false;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516608, true, false, Cust);
                    end;
                }
                action("Shares Certificate")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    //visible = false;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516303, true, false, Cust);
                    end;
                }
                action(Statement)
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    //visible = false;
                    Caption = 'Member Statement';
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51001, true, false, Cust);
                    end;
                }
                action(Export)
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    Image = Export;
                    Caption = 'Export Members';
                    trigger OnAction()
                    begin
                        ExportMemberList(Cust);
                    end;

                }
                action("Update Payroll No.")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    Image = Export;
                    Caption = 'update Payroll Nos';
                    trigger OnAction()
                    var
                        cust: Record Customer;
                    begin
                        // cust.SetFilter("Payroll/Staff No", '<>%1', "Payroll/Staff No");
                        // if 

                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
    end;

    var
        SurestepFactory: Codeunit "SURESTEP Factory";
        Cust: Record Customer;
        GeneralSetup: Record "Sacco General Set-Up";
        Gnljnline: Record "Gen. Journal Line";
        TotalRecovered: Decimal;
        TotalAvailable: Integer;
        Loans: Record "Loans Register";
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        TotalDefaulterR: Decimal;
        Value2: Decimal;
        AvailableShares: Decimal;
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        RoundingDiff: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        LoansR: Record "Loans Register";
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";

    local procedure ExportMemberList(var CustRec: Record Customer)
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        MemberDetailsLbl: Label 'Member Details';
        ExcelFileName: Label 'Members_%1_%2';
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(CustRec.FieldCaption("No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CustRec.FieldCaption(Name), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CustRec.FieldCaption("ID No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CustRec.FieldCaption("Phone No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CustRec.FieldCaption("Date of Birth"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CustRec.FieldCaption(Status), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

        if CustRec.FindSet() then
            repeat
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(CustRec."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(CustRec.Name, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                TempExcelBuffer.AddColumn(CustRec."ID No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(CustRec."Phone No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(CustRec."Date of Birth", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(CustRec.Status, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            until CustRec.Next() = 0;

        TempExcelBuffer.CreateNewBook(MemberDetailsLbl);
        TempExcelBuffer.WriteSheet(MemberDetailsLbl, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
    end;
}
