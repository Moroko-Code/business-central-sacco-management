codeunit 51516154 Emailcodeunit
{
    local procedure SaveReportAsPDF()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeGetEmailSubject', '', false, false)]
    local procedure SDHCustomEmailsubject(var EmailSubject: Text[250]; PostedDocNo: Code[20]; ReportUsage: Integer; var IsHandled: Boolean)
    Var
        ReportUsageEnum: Enum "Report Selection Usage";
    begin
        ReportUsageEnum := "Report Selection Usage".FromInteger(ReportUsage);
        if ReportUsageEnum <> ReportUsageEnum::"S.Order" then
            exit;
        EmailSubject := 'Devco Subject ' + PostedDocNo;
        IsHandled := true;
    end;

    //From
    //To
    //Subject
    //Body
    local procedure Simpleemail(var ReceiverEmail: Text[100]; var Subject: Text[100]; Var EmailBody: text[300])
    var
        TempEmailItem: Record "Email Item" temporary;
    begin
        TempEmailItem."Send to" := ReceiverEmail;
        TempEmailItem.Subject := Subject;
        TempEmailItem.SetBodyText(EmailBody);
        TempEmailItem.Send(true);
    end;

    procedure SendMail(EmailAddress: Text[60]; EmailSubject: text[100]; EmailBody: Text[200])
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;

    begin
        EmailMessage.Create(EmailAddress, EmailSubject, EmailBody, true);
        Email.Send(EmailMessage);
    end;
}