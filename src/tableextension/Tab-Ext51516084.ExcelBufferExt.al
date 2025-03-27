tableextension 51516084 "ExcelBufferExt" extends "Excel Buffer"
{
    fields
    {
    }
    procedure AddInfoColumn(Value: Variant; IsFormula: Boolean; CommentText: Text[1000]; IsBold: Boolean; IsItalics: Boolean; IsUnderline: Boolean; NumFormat: Text[30]; CellType: Option)
    begin
        IF CurrentRow < 1 THEN
            NewRow;

        CurrentCol := CurrentCol + 1;
        INIT;
        InfoExcelBuf.VALIDATE("Row No.", CurrentRow);
        InfoExcelBuf.VALIDATE("Column No.", CurrentCol);
        IF IsFormula THEN
            InfoExcelBuf.SetFormula(FORMAT(Value))
        ELSE
            InfoExcelBuf."Cell Value as Text" := FORMAT(Value);
        InfoExcelBuf.Bold := IsBold;
        InfoExcelBuf.Italic := IsItalics;
        InfoExcelBuf.Underline := IsUnderline;
        InfoExcelBuf.NumberFormat := NumFormat;
        InfoExcelBuf."Cell Type" := CellType;
        InfoExcelBuf.INSERT;
    end;

    var
        CurrentRow: Integer;
        CurrentCol: Integer;
        InfoExcelBuf: Record "Excel Buffer";
}
