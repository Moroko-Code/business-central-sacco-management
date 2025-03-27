table 51516027 "Member FeedBack"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Member FeedBack List";
    LookupPageId = "Member FeedBack List";

    fields
    {
        field(1; "No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
            trigger OnValidate()
            begin
                if Customer.Get("No.") then begin
                    Rec.Name := Customer.Name;
                    Rec.Modify();
                end;
            end;
        }
        field(2; INCCode; Integer)
        {
            AutoIncrement = true;
        }
        field(3; Name; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(68054; "Customer FeedBack"; Text[2000])
        {
        }
        field(4; "Type of Feed Back"; Option)
        {
            OptionMembers = Complaint,"Member Feedback and Satisfaction Report","Member suggestion report";
        }
    }

    keys
    {
        key(Key1; INCCode)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        Customer: Record Customer;

    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin
    end;

    trigger OnRename()
    begin
    end;
}