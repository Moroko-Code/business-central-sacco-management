#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516005 "Dates Calculation"
{
    trigger OnRun()
    begin
    end;

    var
        dayOfWeek: Integer;
        weekNumber: Integer;
        year: Integer;
        weekends: Integer;
        NextDay: Date;
        TEXTDATE1: label 'The Start date cannot be Greater then the end Date.';

    procedure DetermineAge(DateOfBirth: Date; DateOfJoin: Date) AgeString: Text[45]
    var
        dayB: Integer;
        monthB: Integer;
        yearB: Integer;
        dayJ: Integer;
        monthJ: Integer;
        yearJ: Integer;
        Year: Integer;
        Month: Integer;
        Day: Integer;
        monthsToBirth: Integer;
        D: Date;
        DateCat: Integer;
    begin
        if ((DateOfBirth <> 0D) and (DateOfJoin <> 0D)) then begin
            dayB := Date2dmy(DateOfBirth, 1);
            monthB := Date2dmy(DateOfBirth, 2);
            yearB := Date2dmy(DateOfBirth, 3);
            dayJ := Date2dmy(DateOfJoin, 1);
            monthJ := Date2dmy(DateOfJoin, 2);
            yearJ := Date2dmy(DateOfJoin, 3);
            Day := 0;
            Month := 0;
            Year := 0;
            DateCat := DateCategory(dayB, dayJ, monthB, monthJ, yearB, yearJ);
            case (DateCat) of
                1:
                    begin
                        Year := yearJ - yearB;
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            Year := Year - 1;
                        end;

                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else if (dayJ < dayB) then begin
                            Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                            Month := Month - 1;
                        end;

                        AgeString := '%1  Years, %2  Months and #3## Days';
                        AgeString := StrSubstNo(AgeString, Year, Month, Day);
                    end;

                2, 3, 7:
                    begin
                        if (monthJ <> monthB) then
                            if monthJ >= monthB then
                                Month := monthJ - monthB;
                        //  ELSE ERROR('The wrong date category!');

                        if (dayJ <> dayB) then
                            if (dayJ >= dayB) then
                                Day := dayJ - dayB
                            else if (dayJ < dayB) then begin
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                Month := Month - 1;
                            end;

                        AgeString := '%1  Months %2 Days';
                        AgeString := StrSubstNo(AgeString, Month, Day);
                    end;
                4:
                    begin
                        Year := yearJ - yearB;
                        AgeString := '#1## Years';
                        AgeString := StrSubstNo(AgeString, Year);
                    end;
                5:
                    begin
                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else if (dayJ < dayB) then begin
                            Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                            monthJ := monthJ - 1;
                            Month := (monthJ + 12) - monthB;
                            yearJ := yearJ - 1;
                        end;

                        Year := yearJ - yearB;
                        AgeString := '%1  Years, %2 Months and #3## Days';
                        AgeString := StrSubstNo(AgeString, Year, Month, Day);
                    end;
                6:
                    begin
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            yearJ := yearJ - 1;
                        end;
                        Year := yearJ - yearB;
                        AgeString := '%1  Years and #2## Months';
                        AgeString := StrSubstNo(AgeString, Year, Month);
                    end;
                else
                    AgeString := '';
            end;
        end else
            Message('For Date Calculation Enter All Applicable Dates!');
        exit;
    end;

    procedure DifferenceStartEnd(StartDate: Date; EndDate: Date) DaysValue: Integer
    var
        dayStart: Integer;
        monthS: Integer;
        yearS: Integer;
        dayEnd: Integer;
        monthE: Integer;
        yearE: Integer;
        Year: Integer;
        Month: Integer;
        Day: Integer;
        monthsBetween: Integer;
        i: Integer;
        j: Integer;
        monthValue: Integer;
        monthEnd: Integer;
        p: Integer;
        q: Integer;
        l: Integer;
        DateCat: Integer;
        daysInYears: Integer;
        m: Integer;
        yearStart: Integer;
        t: Integer;
        s: Integer;
        WeekendDays: Integer;
        AbsencePreferences: Record "Absence Preferences";
        Holidays: Integer;
    begin

        if ((StartDate <> 0D) and (EndDate <> 0D)) then begin
            Day := 0;
            monthValue := 0;
            p := 0;
            q := 0;
            l := 0;
            Year := 0;
            daysInYears := 0;
            DaysValue := 0;
            dayStart := Date2dmy(StartDate, 1);
            monthS := Date2dmy(StartDate, 2);
            yearS := Date2dmy(StartDate, 3);
            dayEnd := Date2dmy(EndDate, 1);
            monthE := Date2dmy(EndDate, 2);
            yearE := Date2dmy(EndDate, 3);

            WeekendDays := 0;
            AbsencePreferences.Find('-');
            if (AbsencePreferences."Include Weekends" = true) then
                WeekendDays := DetermineWeekends(StartDate, EndDate);

            Holidays := 0;
            AbsencePreferences.Find('-');
            if (AbsencePreferences."Include Holidays" = true) then
                Holidays := DetermineHolidays(StartDate, EndDate);

            DateCat := DateCategory(dayStart, dayEnd, monthS, monthE, yearS, yearE);
            case (DateCat) of
                1:
                    begin
                        p := 0;
                        q := 0;
                        Year := yearE - yearS;
                        yearStart := yearS;
                        t := 1;
                        s := 1;
                        if (monthE <> monthS) then begin

                            for j := 1 to (monthS - 1) do begin
                                q := q + DetermineDaysInMonth(t, yearS);
                                t := t + 1;
                            end;
                            q := q + dayStart;

                            for i := 1 to (monthE - 1) do begin
                                p := p + DetermineDaysInMonth(s, yearE);
                                s := s + 1;
                            end;
                            p := p + dayEnd;

                            for m := 1 to Year do begin
                                if LeapYear(yearStart) then
                                    daysInYears := daysInYears + 366
                                else
                                    daysInYears := daysInYears + 365;
                                yearStart := yearStart + 1;
                            end;
                            DaysValue := (((daysInYears - q) + p) - WeekendDays) - Holidays;
                        end;
                    end;

                2, 7:
                    begin
                        for l := (monthS + 1) to (monthE - 1) do
                            DaysValue := DaysValue + DetermineDaysInMonth(l, yearS);
                        DaysValue := ((DaysValue + (DetermineDaysInMonth(monthS, yearS) - dayStart) + dayEnd) - WeekendDays) - Holidays;
                    end;

                3:
                    if (dayEnd >= dayStart) then
                        DaysValue := dayEnd - dayStart - WeekendDays - Holidays
                    else if (dayEnd = dayStart) then
                        DaysValue := 0
                    else
                        DaysValue := ((dayStart - dayEnd) - WeekendDays) - Holidays;

                4:
                    begin
                        DaysValue := 0;
                        Year := yearE - yearS;
                        yearStart := yearS;
                        for m := 1 to Year do begin
                            if (LeapYear(yearStart)) then
                                daysInYears := 366
                            else
                                daysInYears := 365;
                            DaysValue := DaysValue + daysInYears;
                            yearStart := yearStart + 1;
                        end;
                        DaysValue := (DaysValue - WeekendDays) - Holidays;
                    end;

                5:
                    begin
                        Year := yearE - yearS;
                        yearStart := yearS;
                        for m := 1 to Year do begin
                            if LeapYear(yearStart) then
                                daysInYears := daysInYears + 366
                            else
                                daysInYears := daysInYears + 365;
                            yearStart := yearStart + 1;
                        end;
                        DaysValue := daysInYears;
                        if dayEnd > dayStart then
                            DaysValue := (DaysValue + (dayEnd - dayStart) - WeekendDays) - Holidays
                        else if dayStart > dayEnd then
                            DaysValue := (DaysValue - (dayStart - dayEnd) - WeekendDays) - Holidays;
                    end;

                6:
                    begin
                        q := 0;
                        p := 0;
                        Year := yearE - yearS;
                        yearStart := yearS;
                        t := 1;
                        s := 1;

                        for j := 1 to monthS do begin
                            q := q + DetermineDaysInMonth(t, yearS);
                            t := t + 1;
                        end;

                        for i := 1 to monthE do begin
                            p := p + DetermineDaysInMonth(s, yearE);
                            s := s + 1;
                        end;

                        for m := 1 to Year do begin
                            if LeapYear(yearStart) then
                                daysInYears := daysInYears + 366
                            else
                                daysInYears := daysInYears + 365;
                            yearStart := yearStart + 1;
                        end;

                        DaysValue := ((daysInYears - q) + p) - WeekendDays - Holidays;
                    end;
                else
                    DaysValue := 0;
            end;
        end else
            Message('Enter all applicable dates for calculation!');
        DaysValue += 1;
        exit;
    end;

    procedure DetermineDaysInMonth(Month: Integer; Year: Integer) DaysInMonth: Integer
    begin
        case (Month) of
            1:
                DaysInMonth := 31;
            2:
                if (LeapYear(Year)) then
                    DaysInMonth := 29
                else
                    DaysInMonth := 28;
            3:
                DaysInMonth := 31;
            4:
                DaysInMonth := 30;
            5:
                DaysInMonth := 31;
            6:
                DaysInMonth := 30;
            7:
                DaysInMonth := 31;
            8:
                DaysInMonth := 31;
            9:
                DaysInMonth := 30;
            10:
                DaysInMonth := 31;
            11:
                DaysInMonth := 30;
            12:
                DaysInMonth := 31;
            else
                Message('Not valid date. The month must be between 1 and 12');
        end;

        exit;
    end;

    procedure DateCategory(BDay: Integer; EDay: Integer; BMonth: Integer; EMonth: Integer; BYear: Integer; EYear: Integer) Category: Integer
    begin
        if ((EYear > BYear) and (EMonth <> BMonth) and (EDay <> BDay)) then
            Category := 1
        else if ((EYear = BYear) and (EMonth <> BMonth) and (EDay = BDay)) then
            Category := 2
        else if ((EYear = BYear) and (EMonth = BMonth) and (EDay <> BDay)) then
            Category := 3
        else if ((EYear > BYear) and (EMonth = BMonth) and (EDay = BDay)) then
            Category := 4
        else if ((EYear > BYear) and (EMonth = BMonth) and (EDay <> BDay)) then
            Category := 5
        else if ((EYear > BYear) and (EMonth <> BMonth) and (EDay = BDay)) then
            Category := 6
        else if ((EYear = BYear) and (EMonth <> BMonth) and (EDay <> BDay)) then
            Category := 7
        else if ((EYear = BYear) and (EMonth = BMonth) and (EDay = BDay)) then
            Category := 3
        else if ((EYear < BYear)) then
            //ERROR(TEXTDATE1)
            //ELSE BEGIN
            Category := 0;
        //ERROR('The start date cannot be after the end date.');
        //END;
        exit;
    end;

    procedure LeapYear(Year: Integer) LY: Boolean
    var
        CenturyYear: Boolean;
        DivByFour: Boolean;
    begin
        CenturyYear := Year MOD 100 = 0;
        DivByFour := Year MOD 4 = 0;
        if ((not CenturyYear and DivByFour) or (Year MOD 400 = 0)) then
            LY := true
        else
            LY := false;
    end;

    procedure ReservedDates(NewStartDate: Date; NewEndDate: Date; EmployeeNumber: Code[20]) Reserved: Boolean
    var
        AbsenceHoliday: Record "Absence Preferences";
        OK: Boolean;
    begin
        /*AbsenceHoliday.SETFILTER("Employee No.",EmployeeNumber);
        OK:= AbsenceHoliday.FIND('-');
        REPEAT
            IF (NewStartDate > AbsenceHoliday."Start Date") AND (NewStartDate < AbsenceHoliday."End Date") THEN
               Reserved := TRUE
            ELSE
            IF (NewEndDate < AbsenceHoliday."End Date") AND (NewEndDate > AbsenceHoliday."Start Date") THEN
               Reserved := TRUE
            ELSE
            IF (NewStartDate > AbsenceHoliday."Start Date") AND (NewEndDate < AbsenceHoliday."End Date") THEN
               Reserved := TRUE
            ELSE Reserved := FALSE;
        UNTIL AbsenceHoliday.NEXT = 0;*/
    end;

    procedure DetermineWeekends(DateStart: Date; DateEnd: Date) Weekends: Integer
    begin
        Weekends := 0;
        while (DateStart <= DateEnd) do begin
            dayOfWeek := Date2dwy(DateStart, 1);
            if (dayOfWeek = 6) or (dayOfWeek = 7) then
                Weekends := Weekends + 1;
            NextDay := CalculateNextDay(DateStart);
            DateStart := NextDay;
        end;
    end;

    procedure CalculateNextDay(Date: Date) NextDate: Date
    var
        today: Integer;
        month: Integer;
        year: Integer;
        nextDay: Integer;
        daysInMonth: Integer;
    begin
        today := Date2dmy(Date, 1);
        month := Date2dmy(Date, 2);
        year := Date2dmy(Date, 3);
        daysInMonth := DetermineDaysInMonth(month, year);
        nextDay := today + 1;
        if (nextDay > daysInMonth) then begin
            nextDay := 1;
            month := month + 1;
            if (month > 12) then begin
                month := 1;
                year := year + 1;
            end;
        end;
        NextDate := Dmy2date(nextDay, month, year);
    end;

    procedure DetermineHolidays(DateStart: Date; DateEnd: Date) Holiday: Integer
    var
        StatutoryHoliday: Record "Absence Preferences";
        NextDay: Date;
    begin
        /*Holiday:= 0;
        WHILE (DateStart <= DateEnd) DO BEGIN
          dayOfWeek:= DATE2DWY(DateStart,1);
          StatutoryHoliday.FIND('-');
          REPEAT
           IF (DateStart = StatutoryHoliday."Non Working Dates") THEN
              Holiday:= Holiday + StatutoryHoliday.Code;
          UNTIL StatutoryHoliday.NEXT = 0;
          NextDay:= CalculateNextDay(DateStart);
          DateStart:= NextDay;
       END;*/
    end;

    procedure ConvertDate(nDate: Date) strDate: Text[30]
    var
        lDay: Integer;
        lMonth: Integer;
        lYear: Integer;
        strDay: Text[4];
        StrMonth: Text[20];
        strYear: Text[6];
    begin
        //this function converts the date to the format required by ksps
        lDay := Date2dmy(nDate, 1);
        lMonth := Date2dmy(nDate, 2);
        lYear := Date2dmy(nDate, 3);

        if lDay = 1 then
            strDay := '1st';
        if lDay = 2 then
            strDay := '2nd';
        if lDay = 3 then
            strDay := '3rd';
        if lDay = 4 then
            strDay := '4th';
        if lDay = 5 then
            strDay := '5th';
        if lDay = 6 then
            strDay := '6th';
        if lDay = 7 then
            strDay := '7th';
        if lDay = 8 then
            strDay := '8th';
        if lDay = 9 then
            strDay := '9th';
        if lDay = 10 then
            strDay := '10th';
        if lDay = 11 then
            strDay := '11th';
        if lDay = 12 then
            strDay := '12th';
        if lDay = 13 then
            strDay := '13th';
        if lDay = 14 then
            strDay := '14th';
        if lDay = 15 then
            strDay := '15th';
        if lDay = 16 then
            strDay := '16th';
        if lDay = 17 then
            strDay := '17th';
        if lDay = 18 then
            strDay := '18th';
        if lDay = 19 then
            strDay := '19th';
        if lDay = 20 then
            strDay := '20th';
        if lDay = 21 then
            strDay := '21st';
        if lDay = 22 then
            strDay := '22nd';
        if lDay = 23 then
            strDay := '23rd';
        if lDay = 24 then
            strDay := '24th';
        if lDay = 25 then
            strDay := '25th';
        if lDay = 26 then
            strDay := '26th';
        if lDay = 27 then
            strDay := '27th';
        if lDay = 28 then
            strDay := '28th';
        if lDay = 29 then
            strDay := '29th';
        if lDay = 30 then
            strDay := '30th';
        if lDay = 31 then
            strDay := '31st';

        if lMonth = 1 then
            StrMonth := ' January ';
        if lMonth = 2 then
            StrMonth := ' February ';
        if lMonth = 3 then
            StrMonth := ' March ';
        if lMonth = 4 then
            StrMonth := ' April ';
        if lMonth = 5 then
            StrMonth := ' May ';
        if lMonth = 6 then
            StrMonth := ' June ';
        if lMonth = 7 then
            StrMonth := ' July ';
        if lMonth = 8 then
            StrMonth := ' August ';
        if lMonth = 9 then
            StrMonth := ' September ';
        if lMonth = 10 then
            StrMonth := ' October ';
        if lMonth = 11 then
            StrMonth := ' November ';
        if lMonth = 12 then
            StrMonth := ' December ';

        strYear := Format(lYear);
        //return the date
        strDate := strDay + StrMonth + strYear;
    end;
}
