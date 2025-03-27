report 51516356 AuditReport
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/AuditTrail.rdl';

    dataset
    {
        dataitem("Change Log Entry"; "Change Log Entry")
        {
            RequestFilterFields = Logdate;
            PrintOnlyIfDetail = false;
            column(pic; info.Picture)
            {
            }
            column(SN; SN)
            {
            }
            column(Table_Caption; "Table Caption") { }
            column(User_ID; "User ID") { }
            column(Field_Caption; "Field Caption") { }
            column(Old_Value; "Old Value") { }
            column(Type_of_Change; "Type of Change") { }
            column(New_Value; "New Value") { }
            column(Date_and_Time; "Date and Time") { }
            column(Full_Name; "Full Name") { }
            column(Logdate; Logdate) { }
            trigger OnAfterGetRecord()
            var
            // myInt: Integer;
            //ActiveSession: Record "Active Session";
            begin
                SN := SN + 1;
                // ActiveSession.get("User ID");
                // "Computer Name" := ActiveSession."Client Computer Name";
                // Modify();
            end;

            trigger OnPreDataItem()
            begin
                /*IF UserSetup.GET(USERID) THEN
                BEGIN
                IF UserSetup."View Payroll"=FALSE THEN ERROR ('You dont have permissions for payroll, Contact your system administrator! ')
                END ELSE BEGIN
                ERROR('You have been setup in the user setup!');
                END;*/

                info.Get;
                info.CalcFields(Picture);
            end;
        }
    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //                 ApplicationArea = All;

    //             }
    //         }
    //     }
    // }

    var
        SN: Integer;
        Info: Record "Company Information";
}