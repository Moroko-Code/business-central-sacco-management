tableextension 51516078 changeLogExt extends "Change Log Entry"
{
    fields
    {
        field(50000; Logdate; date)
        {
            trigger OnValidate()
            begin
                Logdate := DT2DATE("Date and Time");
                Modify();
            end;
        }
        field(5001; "Full Name"; Code[100])
        {
            CalcFormula = lookup(User."Full Name" where("User Name" = field("User ID")));
            Caption = 'Name Logged';
            FieldClass = FlowField;
        }
        field(5002; "Computer Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                ActiveSession: Record "Active Session";
            begin
                ActiveSession.get("User ID");

                if ActiveSession."User ID" = "User ID" then begin
                    "Computer Name" := ActiveSession."Client Computer Name";
                    Modify();
                end
            end;
        }
        field(50002; "Client Name"; Code[140])
        {
            CalcFormula = lookup(User."User Name" where("User Name" = field("User ID")));
            FieldClass = FlowField;
        }
        modify("Date and Time")
        {
            trigger OnAfterValidate()
            var
                DateTimee: DateTime;
                LoogDate: Date;

            begin
                begin
                    rec.Find('-');

                    DateTimee := "Date and Time";
                    Loogdate := DT2DATE(DateTimee);
                    Logdate := LoogDate;

                    Modify();
                end;
            end;
        }
        // Add changes to table fields here
    }

    // trigger OnBeforeInsert()
    // begin
    //     Logdate := DT2DATE("Date and Time");
    // end;
}