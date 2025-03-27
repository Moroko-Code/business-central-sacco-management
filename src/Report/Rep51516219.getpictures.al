#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516219 "get pictures"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './Layouts/get pictures.rdlc';

    dataset
    {
        dataitem("Members Register"; Customer)
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Members Register".Get("Members Register"."No.") then begin

                    if "Members Register".Signature.HasValue() then
                        CurrReport.Skip();

                    FileName := 'C:\Users\signatures\' + "Members Register"."No." + '.BMP';
                    //........................Check if file exists
                    if Exists(FileName) then begin
                        "Members Register".Signature.ImportFile(FileName, ClientFileName);
                        if not "Members Register".Modify(true) then
                            "Members Register".Insert(true);
                    end;
                end;
                //....................................................................................
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Customer: Record Customer;
        FileManagement: Codeunit "File Management";
        FileName: Text;
        ClientFileName: Text;
        //...............................................................
        NameValueBuffer: Record "Name/Value Buffer";
        TempNameValueBuffer: Record "Name/Value Buffer" temporary;
        ToFile: Text;
        ExportPath: Text;
}
