// codeunit 50040 "Track System"
// {
//     [EventSubscriber(ObjectType::Codeunit, 40, 'OnAfterLogInStart', '', false, false)]
//     local procedure sephOnAfterLogInStart()
//     var
//         LogInTimeReg: Record "Log in time";
//         LineNo: Integer;
//         LogInTime: Time;
//         LogInDate: Date;

//     begin
//         LogInTimeReg.RESET;
//         LogInTimeReg.SETCURRENTKEY(LogInTimeReg.LineNo);
//         IF LogInTimeReg.FINDLAST THEN BEGIN
//             LineNo := LogInTimeReg.LineNo + 1;
//         END;
//         LogInTimeReg.INIT;
//         LogInTimeReg.LineNo := LineNo;
//         LogInTimeReg.Name := USERID;
//         LogInTimeReg.TimeLogIn := LogInTime;
//         LogInTimeReg.DateLogIn := LogInDate;
//         LogInTimeReg.Date := LogInDate;
//         LogInTimeReg.INSERT;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, 40, 'OnAfterLogInStart', '', false, false)]
//     local procedure sephOnAfterLogInEnd()
//     var
//         LogInTimeReg: Record "Log in time";
//         LineNo: Integer;
//         LogInTime: Time;
//         LogInDate: Date;
//         Machine: Code[100];

//     begin
//         LogInTimeReg.RESET;
//         LogInTimeReg.SETCURRENTKEY(LogInTimeReg.LineNo);
//         IF LogInTimeReg.FINDLAST THEN BEGIN
//             LineNo := LogInTimeReg.LineNo + 1;
//         END;
//         LogInTimeReg.INIT;
//         LogInTimeReg.LineNo := LineNo;
//         LogInTimeReg.Name := USERID;
//         LogInTimeReg.TimeLogIn := LogInTime;
//        LogInTimeReg.DateLogIn := LogInDate;
//         LogInTimeReg.Date := LogInDate;
//         LogInTimeReg.INSERT;
//     end;

// }