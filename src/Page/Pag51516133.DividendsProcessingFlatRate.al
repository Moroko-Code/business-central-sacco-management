page 51516133 "Dividends Processing Flat Rate"
{
    ApplicationArea = All;
    Caption = 'Dividends Processing Flat Rate-List';
    PageType = ListPart;
    SourceTable = "Dividends Register Flat Rate";
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field("Dividend Year"; "Dividend Year")
                {
                }
                field("Current Shares"; "Current Shares")
                {
                }
                field("Qualifying Current Shares"; "Qualifying Current Shares")
                {
                }
                field("Gross Interest -Current Shares"; "Gross Interest -Current Shares")
                {
                }
                field("WTX -Current Shares"; "WTX -Current Shares")
                {
                }
                field("Net Interest -Current Shares"; "Net Interest -Current Shares")
                {
                }
                field("FOSA Shares"; "FOSA Shares")
                {
                }
                field("Qualifying FOSA Shares"; "Qualifying FOSA Shares")
                {
                }
                field("Gross Interest -FOSA Shares"; "Gross Interest -FOSA Shares")
                {
                }
                field("WTX -FOSA Shares"; "WTX -FOSA Shares")
                {
                }
                field("Net Interest -FOSA Shares"; "Net Interest -FOSA Shares")
                {
                }
                //...
                field("Computer Shares"; "Computer Shares")
                {
                }
                field("Qualifying Computer Shares"; "Qualifying Computer Shares")
                {
                }
                field("Gross Interest-Computer Shares"; "Gross Interest-Computer Shares")
                {
                }
                field("WTX -Computer Shares"; "WTX -Computer Shares")
                {
                }
                field("Net Interest -Computer Shares"; "Net Interest -Computer Shares")
                {
                }
                //--
                field("Van Shares"; "Van Shares")
                {
                }
                field("Qualifying Van Shares"; "Qualifying Van Shares")
                {
                }
                field("Gross Interest-Van Shares"; "Gross Interest-Van Shares")
                {
                }
                field("WTX -Van Shares"; "WTX -Van Shares")
                {
                }
                field("Net Interest -Van Shares"; "Net Interest -Van Shares")
                {
                }
                //--
                field("Preferential Shares"; "Preferential Shares")
                {
                }
                field("Qualifying Preferential Shares"; "Qualifying Preferential Shares")
                {
                }
                field("Gross Interest-Preferential Shares"; "Gross Int-Preferential Shares")
                {
                }
                field("WTX -Preferential Shares"; "WTX -Preferential Shares")
                {
                }
                field("Net Int-Preferential Shares"; "Net Int-Preferential Shares")
                {
                }
                //--
                field("Lift Shares"; "Lift Shares")
                {
                }
                field("Qualifying Lift Shares"; "Qualifying Lift Shares")
                {
                }
                field("Gross Interest-Lift Shares"; "Gross Int-Lift Shares")
                {
                }
                field("WTX -Lift Shares"; "WTX -Van Shares")
                {
                }
                field("Net Interest -Lift Shares"; "Net Int-Lift Shares")
                {
                }
                //...
                field("Tambaa Shares"; "Tambaa Shares")
                {
                }
                field("Qualifying Tambaa Shares"; "Qualifying Tambaa Shares")
                {
                }
                field("Gross Interest-Tambaa Shares"; "Gross Int-Tambaa Shares")
                {
                }
                field("WTX -Tambaa Shares"; "WTX -Tambaa Shares")
                {
                }
                field("Net Interest -Tambaa Shares"; "Net Int-Tambaa Shares")
                {
                }
                //--
                field("Pepea Shares"; "Pepea Shares")
                {
                }
                field("Qualifying Pepea Shares"; "Qualifying Pepea Shares")
                {
                }
                field("Gross Interest-Pepea Shares"; "Gross Int-Pepea Shares")
                {
                }
                field("WTX -Pepea Shares"; "WTX -Pepea Shares")
                {
                }
                field("Net Interest -Pepea Shares"; "Net Int-Pepea Shares")
                {
                }
                //--
                field("Housing Shares"; "Housing Shares")
                {
                }
                field("Qualifying Housing Shares"; "Qualifying Housing Shares")
                {
                }
                field("Gross Interest-Housing Shares"; "Gross Int-Housing Shares")
                {
                }
                field("WTX -Housing Shares"; "WTX -Housing Shares")
                {
                }
                field("Net Interest -Housing Shares"; "Net Int-Housing Shares")
                {
                }
            }
        }
    }
}
