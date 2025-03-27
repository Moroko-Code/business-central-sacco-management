pageextension 51516028 AuditTrail extends "Change Log Entries"
{
    Caption = 'Devco Sacco Audit';
    layout
    {
        modify("Date and Time")
        {
            trigger OnAfterValidate()
            var
                DateTimee: DateTime;
                LoogDate: Date;
            begin
                rec.Find('-');
                repeat
                    DateTimee := "Date and Time";
                    Loogdate := DT2DATE(DateTimee);
                    Logdate := LoogDate;
                    Modify();
                until rec.Next = 0;
            end;
        }
        // Add changes to page layout here

        modify("Primary Key Field 1 Value")
        {
            Visible = false;
            Enabled = false;
        }
        modify("Primary Key Field 2 Value")
        {
            Visible = false;
            Enabled = false;
        }
        modify("Primary Key Field 3 Value")
        {
            Visible = false;
            Enabled = false;
        }
        modify("Old Value Local")
        {
            Visible = false;
            Enabled = false;
        }
        modify("New Value Local")
        {
            Visible = false;
            Enabled = false;
        }
        addafter("Date and Time")
        {
            field("Computer Name"; "Computer Name")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Logdate; Logdate)
            {
                ApplicationArea = all;
            }
            field("Full Name"; "Full Name")
            {
                ApplicationArea = all;
            }
            field("Client Name"; "Client Name")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify("&Print")
        {
            Visible = false;
            Enabled = false;
        }
        addafter(Setup)
        {
            action(KLBAuditReport)
            {
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = report AuditReport;
                Caption = 'Viwanda System Audit Report';
                ApplicationArea = all;
            }
        }
    }
    trigger OnOpenPage()

    var
        DateTimee: DateTime;
        LoogDate: Date;
        Msg: Label 'The client type that is running in current session is "%1" ';

    begin
        begin
            rec.Find('-');
            repeat
                DateTimee := "Date and Time";
                Loogdate := DT2DATE(DateTimee);
                Logdate := LoogDate;
                Modify();
            until rec.Next = 0;
        end;

        Message(Msg, CurrentClientType);
    end;

    procedure GetUserClientName(): Text[100]
    var
        ChangeLogEntry: Record "Change Log Entry";
    begin
        if ChangeLogEntry.Get("User ID") then
            exit(ChangeLogEntry."Client Name")
        else
            exit('');
    end;
}
