#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516016 "Cheque Truncation"
{
    trigger OnRun()
    begin
        fnGetMemberNo();
    end;

    var
        objChequeTruncationBuffer: Record "Cheque Truncation Buffer";
        FilePath: Text[1024];
        Imge: Codeunit "File Management";
        InStream1: InStream;
        InputFile: File;
        OutStream1: OutStream;
        TempBlob: Record "Cheque Truncation Buffer";
        FilePath2: Text[1024];
        icduFileMgt: Codeunit "File Management";
        tmpattach: Record Attachment;
        serverfileNAme: Text[250];

    procedure fnSaveChequeData(FilePath: Text; rcode: Code[10]; vtype: Code[10]; amount: Decimal; entryMode: Code[10]; currCode: Code[10]; destBank: Code[10]; destBranch: Code[10]; destAccount: Code[10]; cheqdgt: Code[10]; pBank: Code[10]; pBranch: Code[10]; filler: Code[10]; colAcc: Code[100]; SNO: Code[10]; procNo: Code[10]; FImageSizeBW: Integer; FImageSignBW: Integer; FImageSize: Integer; FImageSign: Integer; BImageSize: Integer; BImageSign: Integer)
    begin
        //Data being fed from running service that reads the data
        objChequeTruncationBuffer.INIT;
        objChequeTruncationBuffer.RCODE := rcode;
        objChequeTruncationBuffer.VTYPE := vtype;
        objChequeTruncationBuffer.AMOUNT := amount;
        objChequeTruncationBuffer.ENTRYMODE := entryMode;
        objChequeTruncationBuffer.CURRENCYCODE := currCode;
        objChequeTruncationBuffer.DESTBANK := destBank;
        objChequeTruncationBuffer.DESTBRANCH := destBranch;
        objChequeTruncationBuffer.DESTACC := destAccount;
        objChequeTruncationBuffer.CHQDGT := cheqdgt;
        objChequeTruncationBuffer.PBANK := pBank;
        objChequeTruncationBuffer.PBRANCH := pBranch;
        objChequeTruncationBuffer.FILLER := filler;
        objChequeTruncationBuffer.COLLACC := colAcc;
        objChequeTruncationBuffer.SNO := SNO;
        objChequeTruncationBuffer.PROCNO := procNo;
        objChequeTruncationBuffer.FIMAGESIGN := FImageSign;
        objChequeTruncationBuffer.FIMAGESIZE := FImageSize;
        objChequeTruncationBuffer.FIMAGESIGNBW := FImageSignBW;
        objChequeTruncationBuffer.FIMAGESIZEBW := FImageSizeBW;
        objChequeTruncationBuffer.BIMAGESIGN := BImageSign;
        objChequeTruncationBuffer.BIMAGESIZE := BImageSize;
        objChequeTruncationBuffer.INSERT;
    end;

    procedure FnSaveFBWImages(fileName: Text[200]; SerialNo: Integer)
    begin
        objChequeTruncationBuffer.RESET;
        objChequeTruncationBuffer.SETRANGE(objChequeTruncationBuffer.ChequeDataId, SerialNo);
        IF objChequeTruncationBuffer.FIND('-') THEN BEGIN
            IF objChequeTruncationBuffer.FrontBWImage.HASVALUE THEN
                CLEAR(objChequeTruncationBuffer.FrontBWImage);
            IF FILE.EXISTS(fileName) THEN BEGIN
                InputFile.OPEN(fileName);
                InputFile.CREATEINSTREAM(InStream1);
                objChequeTruncationBuffer.FrontBWImage.CREATEOUTSTREAM(OutStream1);
                COPYSTREAM(OutStream1, InStream1);
                objChequeTruncationBuffer.MODIFY;
                InputFile.CLOSE;
            END;
        END;
    end;

    procedure FnSaveGrayImages(fileName: Text[200]; SerialNo: Integer)
    begin
        objChequeTruncationBuffer.Reset;
        objChequeTruncationBuffer.SetRange(objChequeTruncationBuffer.ChequeDataId, SerialNo);
        if objChequeTruncationBuffer.Find('-') then begin
            if objChequeTruncationBuffer.FrontGrayScaleImage.Hasvalue then
                Clear(objChequeTruncationBuffer.FrontGrayScaleImage);

            if FILE.Exists(fileName) then begin
                InputFile.Open(fileName);
                InputFile.CreateInstream(InStream1);
                objChequeTruncationBuffer.FrontGrayScaleImage.CreateOutstream(OutStream1);
                CopyStream(OutStream1, InStream1);
                objChequeTruncationBuffer.Modify;
                InputFile.Close;
            end;
        end;
    end;

    procedure FnSaveRearImages(fileName: Text[200]; SerialNo: Integer)
    begin
        objChequeTruncationBuffer.Reset;
        objChequeTruncationBuffer.SetRange(objChequeTruncationBuffer.ChequeDataId, SerialNo);
        if objChequeTruncationBuffer.Find('-') then begin
            if objChequeTruncationBuffer.RearImage.Hasvalue then
                Clear(objChequeTruncationBuffer.RearImage);

            if FILE.Exists(fileName) then begin
                InputFile.Open(fileName);
                InputFile.CreateInstream(InStream1);
                objChequeTruncationBuffer.RearImage.CreateOutstream(OutStream1);
                CopyStream(OutStream1, InStream1);
                objChequeTruncationBuffer.Modify;
                InputFile.Close;
            end;
        end;
    end;

    procedure fnGetMemberNo()
    begin
        objChequeTruncationBuffer.Reset;
        if objChequeTruncationBuffer.Find('-') then
            repeat
                objChequeTruncationBuffer.MemberNo := '0' + CopyStr(objChequeTruncationBuffer.DESTACC, 1, 5);
                objChequeTruncationBuffer.Modify;
            until objChequeTruncationBuffer.Next = 0;
    end;
}
