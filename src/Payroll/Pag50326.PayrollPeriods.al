page 50326 "Payroll Periods."
{
    ApplicationArea = Basic, Suite;
    Caption = 'Payroll Periods.';
    UsageCategory = Tasks;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Payroll Calender.";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Date Opened"; "Date Opened")
                {
                    ApplicationArea = All;
                }
                field("Period Name"; "Period Name")
                {
                    ApplicationArea = All;
                }
                field("Period Month"; "Period Month")
                {
                    ApplicationArea = All;
                }
                field("Period Year"; "Period Year")
                {
                    ApplicationArea = All;
                }

                field("Date Closed"; "Date Closed")
                {
                    ApplicationArea = All;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = All;
                }
                field("Payroll Code"; "Payroll Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Close Period")
            {
                ApplicationArea = All;
                Caption = 'Close Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    fnGetOpenPeriod;

                    Question := 'Once a period has been closed it can NOT be opened.\It is assumed that you have PAID out salaries.\'
                    + 'Still want to close [' + strPeriodName + ']';
                    PayrollDefined := '';
                    Answer := DIALOG.Confirm(Question, false);
                    if Answer = true then begin
                        Clear(objOcx);
                        objOcx.fnClosePayrollPeriod(dtOpenPeriod, PayrollCode);
                        Message('Process Complete');
                    end else
                        Message('You have selected NOT to Close the period');
                end;
            }
            // action("Create Period")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            //     trigger OnAction()
            //     begin
            //         ContrInfo.Init();

            //         ContrInfo."Primary Key" := ' ';
            //         ContrInfo.Name := 'DEVCO';
            //         ContrInfo.Insert();
            //     end;
            // }
        }
    }

    var
        PayPeriod: Record "Payroll Calender.";
        strPeriodName: Text[30];
        Question: Text[250];
        Answer: Boolean;
        objOcx: Codeunit "Payroll Processing";
        dtOpenPeriod: Date;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];

    procedure fnGetOpenPeriod()
    begin
        // PayPeriod.Reset();
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.FindLast() then begin
            strPeriodName := PayPeriod."Period Name";
            dtOpenPeriod := PayPeriod."Date Opened";
        end;
    end;
}
