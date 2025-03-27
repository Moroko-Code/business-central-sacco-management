#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50322 "Payroll General Setup."
{
    PageType = Card;
    SourceTable = "Payroll General Setup.";

    layout
    {
        area(content)
        {
            group(Relief)
            {
                field("Tax Relief"; "Tax Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Relief %"; Rec."Insurance Relief %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insurance Relief % field.', Comment = '%';
                }

                field("Max Relief"; "Max Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Mortgage Relief"; "Mortgage Relief")
                {
                    ApplicationArea = Basic;
                }
            }
            group(NHIF)
            {
                field("NHIF Based on"; "NHIF Based on")
                {
                    ApplicationArea = Basic;
                }
                field("SHIF Percentage"; Rec."SHIF Percentage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SHIF Percentage field.', Comment = '%';
                }
                field("NHIF Relief %"; Rec."NHIF Relief %")
                {
                    Caption = 'SHIF Relief %';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NHIF Relief % field.', Comment = '%';
                }

            }
            group(NSSF)
            {
                field("NSSF Employee"; "NSSF Employee")
                {
                    ApplicationArea = Basic;
                }
                field("NSSF Lower Limit"; Rec."NSSF Lower Limit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NSSF Lower Limit field.', Comment = '%';
                }
                field("NSSF Upper Limit"; Rec."NSSF Upper Limit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NSSF Upper Limit field.', Comment = '%';
                }
                field("NSSF Employer Factor"; "NSSF Employer Factor")
                {
                    ApplicationArea = Basic;
                }
                field("NSSF Based on"; "NSSF Based on")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Housing Levy")
            {
                field("Housing Levy Percentage"; Rec."Housing Levy Percentage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Housing Levy Percentage field.', Comment = '%';
                }
                field("Housing Levy relief %"; Rec."Housing Levy relief %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Housing Levy relief % field.', Comment = '%';
                }
            }
            group(Pension)
            {
                field("Max Pension Contribution"; "Max Pension Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Tax On Excess Pension"; "Tax On Excess Pension")
                {
                    ApplicationArea = Basic;
                }
                field("Pension Deduction %"; Rec."Pension Deduction %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pension Deduction % field.', Comment = '%';
                }
            }
            group("Staff Loan")
            {
                field("Loan Market Rate"; "Loan Market Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Corporate Rate"; "Loan Corporate Rate")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Mortgage)
            {
            }
            group("Owner Occupier Interest")
            {
                field("OOI Deduction"; "OOI Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("OOI December"; "OOI December")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}
