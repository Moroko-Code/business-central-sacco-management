codeunit 50039 "Portal Integration"
{
    trigger OnRun()
    begin
    end;

    var
        Memb: Record "Membership Applications";
        MembNextOfKin: Record "Members Next Kin Details";
        ReferenceNo: Code[30];
        NoK: Record "Members Next Kin Details";
        SelectProduct: Record "Account Types-Saving Products";
        TbDocumentAttachment: Record "Document Attachment";
        MemberLedgerEntry: Record "Cust. Ledger Entry";
        Members: Record Customer;
        Dates: codeunit "Dates Calculation";
        VarNewMembNo: Code[20];
        MobileDetails: Record "Password Manager";

    procedure MembReg(FirstName: Text[100]; MidName: Text[100]; LastName: Text[100]; Name: Text[200]; RoCode: Code[20]; MobileNo: code[20]; country: code[20]; Town: code[30]; DateOfBirth: Date; Email: Code[50]; Gender: Option; MaritalStatus: Option; EmployementInfo: Option; AccountC: Option; MembershipType: Option) response: Code[20]
    var
        EmploymentDetails: Text[30];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SaccoNoSeries: Record "Sacco No. Series";

    begin
        SaccoNoSeries.Get();
        VarNewMembNo := NoSeriesMgt.GetNextNo(SaccoNoSeries."Member Application Nos", Today, true);
        Memb.Init();
        Memb."No." := VarNewMembNo;
        // Memb."RO Code" := RoCode;
        Memb.Name := Name;
        Memb."First Name" := FirstName;
        Memb."Second Name" := MidName;
        Memb."Last Name" := LastName;
        Memb."Account Category" := AccountC;
        Memb."Date of Birth" := DateOfBirth;
        Memb.Age := Dates.DetermineAge(DateOfBirth, Today);
        Memb.Gender := Gender;
        Memb."Marital Status" := MaritalStatus;
        Memb."Phone No." := MobileNo;
        Memb."E-Mail" := LowerCase(Email);
        Memb.Insert();
        response := VarNewMembNo;
    end;

    procedure PortalApplication(firstName: Text[100]; middleName: Text[100]; lastName: Text[100]; emailAddress: Text[100]; typeOfMembership: Option; dateOfBirth: Date; identityDocument: Option; idNumber: Text[100]; mobilePhone: Text[100]; whatsappNo: Text[100]; gender: Option; maritalStatus: Option; secondaryPhone: Text[100]; facebookName: Text[100]; postalCode: Text[100]; state: Text[100]; membersResidency: Text[100]; branchCode: Text[100]; town: Text[100]; country: Text[100]; positionInSacco: Option) response: Code[20]
    var
        EmploymentDetails: Text[30];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SaccoNoSeries: Record "Sacco No. Series";

    begin
        SaccoNoSeries.Get();
        VarNewMembNo := NoSeriesMgt.GetNextNo(SaccoNoSeries."Member Application Nos", Today, true);
        Memb.Init();
        Memb."No." := VarNewMembNo;
        Memb."First Name" := firstName;
        Memb."Second Name" := middleName;
        Memb."Last Name" := lastName;
        Memb.Validate(Memb."Last Name");
        Memb."E-Mail" := emailAddress;
        Memb."Account Category" := typeOfMembership;
        Memb."Date of Birth" := dateOfBirth;
        Memb.Validate(Memb."Date of Birth");
        // Memb."Identification Document" := identityDocument;
        Memb."ID No." := idNumber;
        Memb."Phone No." := mobilePhone;
        //Memb.WhatsApp := whatsappNo;
        Memb.Gender := gender;
        Memb."Marital Status" := maritalStatus;
        Memb."Mobile No. 2" := secondaryPhone;
        Memb.Insert();
        response := VarNewMembNo;
    end;

    procedure NextOfKin(Name: text; TelNo: Code[20]; AppNo: Code[30]) R_Value: Boolean
    var
        Nok: Record "Members Next Kin Details";
        MembApp: Record "Membership Applications";
        NokFound: Boolean;
        FromRecRe: RecordRef;
    begin
        NoK.Init();
        NoK.Name := Name;
        NoK.Telephone := TelNo;
        Nok."Account No" := AppNo;
        if Nok.insert then
            NoKFound := True
        else
            NoKFound := false;
        //end;
    end;

    procedure FnSendOTP(emailAddress: Text) response: Text
    var
        MailToSend: Codeunit "Email Message";
        FnEmail: Codeunit Email;
        SendEmailTo: Text;
        EmailSubject: Text;
        EmailBody: Text;
        otp: Integer;
    begin
        Members.Reset();
        Members.SetRange(Members."E-Mail", emailAddress);
        if Members.Find('-') then begin
            otp := FnGenerateOTP();
            SendEmailTo := '';
            SendEmailTo := emailAddress;
            EmailSubject := '';
            EmailSubject := 'One Time Password for Mobile App Account Activation';

            EmailBody := '';
            EmailBody := 'Dear ' + Members.Name + '  Your One-Time Password (OTP) to activate your account is ' + Format(otp) + '. Thank you for choosing Bulsho Sacco.';

            MailToSend.Create(SendEmailTo, EmailSubject, EmailBody);
            FnEmail.Send(MailToSend, Enum::"Email Scenario"::Default);

            SMSMessage(Format(otp), Members."No.", Members."Phone No.", EmailBody);

            MobileDetails.Reset();
            MobileDetails.SetRange(MobileDetails.Email, LowerCase(emailAddress));
            if MobileDetails.Find('-') then begin // MobileDetails.Init();
                MobileDetails.OTP := otp;
                MobileDetails.Modify();
                response := 'OTP sent successfully';
            end
            else begin
                response := 'Member account not found';
            end;
        end;
    end;

    procedure FnUpdatePassword(emailAddress: Text; hashedPassword: Text[250]) response: Text
    var
    begin
        MobileDetails.Reset();
        MobileDetails.SetRange(MobileDetails.Email, LowerCase(emailAddress));
        if MobileDetails.Find('-') then begin
            //MobileDetails.Init();
            MobileDetails.Password := hashedPassword;
            MobileDetails.Modify();

            response := 'Password created successfully';
        end else begin
            response := 'Member account not activated';
        end;
    end;

    procedure SetUsernameOnFirstLogin(emailOrUsername: Text);
    var
        newUsername: Text;
    begin
        // You can customize this logic to prompt the user to set their username

        // For testing purposes, setting a static username
        newUsername := 'NewUser';

        MobileDetails.Reset();
        MobileDetails.SetRange(Email, LowerCase(emailOrUsername));
        if MobileDetails.Find('-') then begin
            MobileDetails.Username := newUsername;
            MobileDetails.Modify();
        end;
    end;

    procedure FnShares(Email: Text[100]; BulShoNo: Code[50]) returnT: Text
    var
    begin

        Members.Reset();
        // Members.SetRange(Members."E-Mail", LowerCase(Email));
        Members.SetRange(Members."No.", BulShoNo);
        if Members.Find('-') then begin
            Members.CalcFields(Members."Shares Retained");
            returnT := Format(Members."Shares Retained");
        end else begin
            returnT := '';
        end;
    end;

    procedure fnGetMemberNo(Email: text[100]) returnE: code[100]

    begin
        members.reset;
        Members.setrange(Members."E-Mail", LowerCase(Email));
        if members.find('-') then begin
            returnE := Members."No."
        end else
            returnE := 'No';

    end;

    procedure fnGetMemberNo1(Value: Text[100]; var returnE: Code[100])
    begin
        // Reset any existing filters on the Members table
        Members.Reset();

        // Check by email
        Members.SetRange(Members."E-Mail", LowerCase(Value));
        if Members.Find('-') then begin
            returnE := Members."No.";
            exit; // Exit if found by email
        end;

        // If not found by email, check by username
        MobileDetails.Reset();
        MobileDetails.SetRange(MobileDetails.Username, LowerCase(Value));
        if MobileDetails.Find('-') then begin
            //returnE := MobileDetails."MemberNo.";
            exit; // Exit if found by username
        end;
        // Return 'No' if neither email nor username was found
        returnE := 'No';
    end;


    procedure fnGetBULNumber(Username: text[100]) returnE: code[100]
    var
        _correctEmail: Text;
    begin
        MobileDetails.Reset();
        if STRPOS(Username, '@') > 0 then
            MobileDetails.SetRange(MobileDetails.Email, LowerCase(Username))
        else
            MobileDetails.SetRange(MobileDetails.Username, Username);
        if MobileDetails.Find('-') then begin
            _correctEmail := MobileDetails.Email;
        end else begin
            returnE := 'No';
        end;

        members.reset;
        Members.setrange(Members."E-Mail", LowerCase(_correctEmail));
        if members.find('-') then begin
            returnE := Members."No."
        end else
            returnE := 'No';
    end;

    procedure FnResetPassword(accountNumber: Text; password: Text; confirmPassword: Text; otpCode: Integer) response: Text

    begin
        if password <> confirmPassword then begin
            response := 'Passwords do not match';
        end else begin
            MobileDetails.Reset();
            MobileDetails.SetRange(OTP, otpCode);
            MobileDetails.SetRange(MemberNo, accountNumber);
            if MobileDetails.Find('-') then begin
                MobileDetails.Password := password;
                MobileDetails.Modify();
                response := 'Password reset successful';
            end;
        end;
    end;

    procedure FnChangePassword(accountNumber: Text; password: Text; confirmPassword: Text) response: Text
    begin
        if password <> confirmPassword then begin
            response := 'Passwords do not match';
        end else begin
            MobileDetails.Reset();
            MobileDetails.SetRange(MemberNo, accountNumber);
            if MobileDetails.Find('-') then begin
                MobileDetails.Password := password;
                MobileDetails.Modify();
                response := 'Password reset successful';
            end;
        end;
    end;

    procedure FnMemberStatement(Email: Text[100]; BulShoNo: Code[50]) MiniStmt: Text
    var
        shareCap: Integer;
        depContribution: Integer;
        loanrepayment2: Integer;
        MaxNumberofRows: integer;
        runcount: integer;
    begin
        Members.RESET;
        Members.SETRANGE(Members."No.", BulShoNo);
        IF Members.FIND('-') THEN BEGIN
            shareCap := MemberLedgerEntry."Transaction Type"::"Shares Capital";
            depContribution := MemberLedgerEntry."Transaction Type"::"Deposit Contribution";
            loanrepayment2 := MemberLedgerEntry."Transaction Type"::Repayment;
            MaxNumberOfRows := 10;
            runcount := 0;

            MemberLedgerEntry.RESET;
            MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Customer No.", Members."No.");
            MemberLedgerEntry.SETFILTER(MemberLedgerEntry."Transaction Type", '%1|%2|%3', shareCap, depContribution, loanrepayment2);
            MemberLedgerEntry.ASCENDING(FALSE);
            IF MemberLedgerEntry.FIND('-') THEN BEGIN
                REPEAT
                    MiniStmt := MiniStmt + FORMAT(MemberLedgerEntry."Posting Date") + '|' + FORMAT(MemberLedgerEntry."Transaction Type") + '|' + FORMAT((ABS(MemberLedgerEntry.Amount))) + ';';
                    runcount := runcount + 1;
                    IF runcount >= 10 THEN BEGIN
                        EXIT(MiniStmt);
                    END;
                UNTIL MemberLedgerEntry.NEXT = 0;
            END ELSE BEGIN
                MiniStmt := 'No transactions were found';
                EXIT(MiniStmt);
            END
        END ELSE BEGIN
            MiniStmt := 'Member not found';
            EXIT(MiniStmt);
        END
    END;

    procedure FnChangeOTP(emailAddress: Text) response: Text
    var
        MailToSend: Codeunit "Email Message";
        FnEmail: Codeunit Email;
        SendEmailTo: Text;
        EmailSubject: Text;
        EmailBody: Text;
        otp: Integer;

    begin
        Members.Reset();
        Members.SetRange("E-Mail", LowerCase(emailAddress));
        if Members.Find('-') then begin
            otp := FnGenerateOTP();

            SendEmailTo := '';
            SendEmailTo := emailAddress;
            EmailSubject := '';
            EmailSubject := 'Reset Password';

            EmailBody := '';
            EmailBody := 'Dear ' + Members.Name + '  Your One-Time Password (OTP) to reset your password is ' + Format(otp) + '. Thank you for choosing Bulsho Sacco.';

            MailToSend.Create(SendEmailTo, EmailSubject, EmailBody);
            FnEmail.Send(MailToSend, Enum::"Email Scenario"::Default);

            MobileDetails.Reset();
            MobileDetails.SetRange(Email, LowerCase(emailAddress));
            if MobileDetails.Find('-') then begin
                MobileDetails.OTP := otp;
                MobileDetails.Modify();

                response := 'OTP sent successfully';
            end
            else begin
                response := 'Member account not found';
            end;
        end;
    end;


    procedure fnGetPostCodes() postalCodes: Text
    var
        PostCode: Record "Post Code";
    begin
        PostCode.Reset;
        if PostCode.Find('-') then begin
            postalCodes := '';
            repeat
                postalCodes := PostCode.Code + '.:' + PostCode.City + ':::' + postalCodes;
            until PostCode.Next = 0;
        end;
    end;

    procedure fnGetCountries() loadCountries: Text
    var
        CountryTable: Record "Country/Region";
    begin
        CountryTable.Reset;
        if CountryTable.Find('-') then begin
            loadCountries := '';
            repeat
                loadCountries := CountryTable.Code + '.:' + CountryTable.Name + '.:::' + loadCountries;
            until CountryTable.Next = 0;
        end;
    end;

    procedure fnGetBranchCodes() branchCodes: Text
    var
        BranchTable: Record "Dimension Value";
    begin
        BranchTable.Reset;
        if BranchTable.Find('-') then begin
            branchCodes := '';
            repeat
                branchCodes := BranchTable.Code + '.:' + BranchTable.Name + '.:::' + branchCodes;
            until BranchTable.Next = 0;
        end;
    end;

    procedure GetDashboardStatistics(MemberNo: Code[20]) responsetext: Text
    var
        objMember: record Customer;
        bdeposits: Decimal;
        mDeposits: Decimal;
        rsf: Decimal;
        fosaShares: Decimal;
        outstandingLoans: Decimal;
        overallSavings: Decimal;
        sharecapital: Decimal;
        overallLoans: Decimal;
    begin
        bdeposits := 0;
        mDeposits := 0;
        rsf := 0;
        fosaShares := 0;
        outstandingLoans := 0;
        overallSavings := 0;
        sharecapital := 0;
        overallLoans := 0;

        if objMember.Get(MemberNo) then begin
            objMember.CalcFields("Shares Retained", "Outstanding Balance", "Accrued Interest", "Current Shares");
            bdeposits := objMember."Current Shares";
            outstandingLoans := objMember."Outstanding Balance" + objMember."Accrued Interest";
            sharecapital := objMember."Shares Retained";
        end;

        overallSavings := bdeposits + mDeposits + rsf + fosaShares;
        overallLoans := outstandingLoans;
        responsetext := Format(bdeposits) + ':::' + Format(mDeposits) + ':::' + Format(rsf) + ':::' + Format(fosaShares) + ':::' + Format(outstandingLoans) + ':::' + Format(overallSavings) + ':::' + Format(sharecapital) + ':::' + Format(overallLoans) + ':::';
    end;

    procedure fnGetNextofkin(MemberNumber: Code[20]) return: Text
    var
        objNextKin: Record "Next of Kin/Account Sign";
    begin
        objNextKin.Reset;
        objNextKin.SetRange("Account No", MemberNumber);
        if objNextKin.Find('-') then begin
            repeat
                return := return + objNextKin.Name + ':::' + objNextKin.Relationship + ':::' + Format(objNextKin."%Allocation") + '::::';
            until objNextKin.Next = 0;
        end;
    end;

    Procedure FnGurantorsList(MemberNo: Code[50]): Text
    var
        LoanG: Record "Loans Guarantee Details";
        Loans: Record "Loans Register";
        LoanguarantorsDetails: Text;
        ClientName: Text;
    begin
        LoanG.Reset();
        LoanG.SetRange(LoanG."Member No", MemberNo);
        LoanG.SetAutoCalcFields(LoanG."Loans Outstanding");
        LoanG.SetFilter(LoanG."Loans Outstanding", '>%1', 0);
        if LoanG.FindSet() then begin
            repeat

                Loans.Reset();
                Loans.SetRange(Loans."Loan  No.", LoanG."Loan No");
                if Loans.FindFirst() then begin
                    ClientName := Loans."Client Name";
                end;
                LoanguarantorsDetails := LoanguarantorsDetails + LoanG."Loan No" + Format(LoanG."% Proportion") + ClientName + Format(LoanG."Amont Guaranteed");

            until LoanG.Next = 0;

        end;
    end;

    procedure FnGetMemberDepositStatement(MemberNo: Code[50]; StartDate: Date; EndDate: Date): Text
    var
        Outs: OutStream;
        InS: InStream;
        TempBlob: Codeunit "Temp Blob";
        Base64: Codeunit "Base64 Convert";
        RecRef: RecordRef;
        Cust: Record Customer;
    begin
        Cust.Reset();
        Cust.SetRange(Cust."No.", UpperCase(MemberNo));
        Cust.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
        if Cust.FindFirst() then begin
            RecRef.GetTable(Cust);
            TempBlob.CreateOutStream(Outs);
            Report.SaveAs(Report::"Members Deposits Statement", '', REPORTFORMAT::Pdf, Outs, RecRef);
            TempBlob.CreateInStream(InS);
            exit(Base64.ToBase64(InS));
        end;
    end;
    //Loan Guarantors
    procedure FnGetMemberLoansGuaranteed(MemberNo: Code[50]): Text
    var
        Outs: OutStream;
        InS: InStream;
        TempBlob: Codeunit "Temp Blob";
        Base64: Codeunit "Base64 Convert";
        RecRef: RecordRef;
        Cust: Record Customer;
    begin
        Cust.Reset();
        Cust.SetRange(Cust."No.", UpperCase(MemberNo));
        if Cust.FindFirst() then begin
            RecRef.GetTable(Cust);
            TempBlob.CreateOutStream(Outs);
            Report.SaveAs(Report::"Loan Guarantors", '', REPORTFORMAT::Pdf, Outs, RecRef);
            TempBlob.CreateInStream(InS);
            exit(Base64.ToBase64(InS));
        end;
    end;
    //Loans Guaranteed
    procedure FnGetMemberLoansGuarantors(MemberNo: Code[50]): Text
    var
        Outs: OutStream;
        InS: InStream;
        TempBlob: Codeunit "Temp Blob";
        Base64: Codeunit "Base64 Convert";
        RecRef: RecordRef;
        Cust: Record Customer;
    begin

        Cust.Reset();
        Cust.SetRange(Cust."No.", UpperCase(MemberNo));
        if Cust.FindFirst() then begin
            RecRef.GetTable(Cust);
            TempBlob.CreateOutStream(Outs);
            Report.SaveAs(Report::"Loans Guaranteed", '', REPORTFORMAT::Pdf, Outs, RecRef);
            TempBlob.CreateInStream(InS);
            exit(Base64.ToBase64(InS));
        end;
    end;

    procedure LoanStatement(MemberNo: Code[50]; StartDate: Date; EndDate: Date): Text
    var
        Outs: OutStream;
        InS: InStream;
        TempBlob: Codeunit "Temp Blob";
        Base64: Codeunit "Base64 Convert";
        RecRef: RecordRef;
        Cust: Record Customer;
    begin

        Cust.Reset();
        Cust.SetRange(Cust."No.", UpperCase(MemberNo));
        Cust.SetFilter("Date filter", '%1..%2', StartDate, EndDate);
        if Cust.FindFirst() then begin
            RecRef.GetTable(Cust);
            TempBlob.CreateOutStream(Outs);
            Report.SaveAs(Report::"Member Loans Statement", '', REPORTFORMAT::Pdf, Outs, RecRef);
            TempBlob.CreateInStream(InS);
            exit(Base64.ToBase64(InS));
        end;
    end;

    //OTP Functions//
    procedure FnGenerateOTP() otpValue: Integer
    var
        RandomNumber: Text;
    begin
        Randomize();
        RandomNumber := FORMAT(RANDOM(8)) + FORMAT(RANDOM(7)) + FORMAT(RANDOM(4)) + FORMAT(RANDOM(7)) + FORMAT(RANDOM(6));
        EVALUATE(otpValue, RandomNumber);
        exit(otpValue);
    end;

    PROCEDURE SMSMessage(documentNo: Text[30]; accfrom: Text[30]; phone: Text[30]; message: Text[250]);
    var
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
    begin
        iEntryNo := 0;
        SMSMessages.RESET;
        if SMSMessages.FIND('+') then iEntryNo := SMSMessages."Entry No";
        iEntryNo += 1;
        SMSMessages.INIT;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Batch No" := documentNo;
        SMSMessages."Document No" := documentNo;
        SMSMessages."Account No" := accfrom;
        SMSMessages."Date Entered" := TODAY;
        SMSMessages."Time Entered" := TIME;
        SMSMessages.Source := 'MOBILETRAN';
        SMSMessages."Entered By" := USERID;
        SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
        SMSMessages."SMS Message" := message;
        SMSMessages."Telephone No" := phone;
        IF SMSMessages."Telephone No" <> '' THEN
            SMSMessages.INSERT;
    end;

    procedure FnActivateAccount(memberNumber: code[15]; Email: Text[50]) R_Value: code[30]
    var
        MembersTable: record Customer;
        OTP: Integer;
        SMS: Text[300];
    begin
        MobileDetails.Reset();
        MobileDetails.SetRange(ID_Number, memberNumber);
        MobileDetails.SetRange(Email, Email);
        MobileDetails.SetRange(Activated, TRUE);
        if MobileDetails.Find('-') then begin
            R_Value := 'Member Activated';
            exit;
        end;
        MobileDetails.Reset();
        MobileDetails.SetRange(ID_Number, memberNumber);
        MobileDetails.SetRange(Email, Email);
        MobileDetails.SetRange(Activated, FALSE);
        if MobileDetails.Find('-') then begin
            OTP := FnGenerateOTP();
            MobileDetails.OTP := OTP;
            SMS := 'Your OTP for account activation is ' + Format(OTP) + '. This code will be valid for 5 minutes. Thank you. KCAU Sacco.';
            SMSMessage(Format(OTP), MobileDetails.MemberNo, MobileDetails.Phone_Number, SMS);
            MobileDetails.Modify();
            R_Value := 'Modified';
            exit;
        end;
        MembersTable.Reset;
        MembersTable.SetRange("ID No.", memberNumber);
        if MembersTable.find('-') then begin
            MembersTable."E-Mail" := format(Lowercase(MembersTable."E-Mail"));
            MembersTable.modify(true);
        end;
        Members.Reset();
        Members.SetRange(Members."E-Mail", LowerCase(Email));
        Members.SetRange(Members."ID No.", memberNumber);
        if Members.Find('-') then begin
            OTP := FnGenerateOTP();
            MobileDetails.Init();
            MobileDetails.Email := LowerCase(Email);
            MobileDetails.MemberNo := Members."No.";
            MobileDetails.MemberName := Members.Name;
            MobileDetails.Activated := false;
            MobileDetails.ID_Number := Members."ID No.";
            MobileDetails.Phone_Number := Members."Phone No.";
            MobileDetails.OTP := OTP;
            MobileDetails.Insert();
            SMS := 'Your OTP for account activation is ' + Format(OTP) + '. This code will be valid for 5 minutes. Thank you. KCAU Sacco.';
            SMSMessage(Format(OTP), Members."No.", Members."Phone No.", SMS);
            R_Value := 'Created';
            //FnSendOTP(LowerCase(Email));
        end else
            R_Value := 'Member not found';
    end;

    procedure FnVerifyOTP(otp: Integer; memberid: Text) response: Text
    var
    begin
        MobileDetails.Reset();
        MobileDetails.SetRange(MobileDetails.OTP, otp);
        MobileDetails.SetRange(MobileDetails.ID_Number, memberid);
        if MobileDetails.Find('-') then begin
            MobileDetails.Modify();
            response := 'OTP verified successfully';
        end else begin
            response := 'OTP could not be verified';
        end;
    end;

    procedure FnCreateAccount(memberid: Text; username: Text; hashedPassword: Text[250]) response: Text
    var
        username_: Text;
    begin
        //Check if the username is Already used....
        MobileDetails.Reset();
        MobileDetails.SetRange(MobileDetails.Username, Lowercase(username));
        if MobileDetails.Find('-') then begin
            response := 'Username in use';
        end else begin
            MobileDetails.Reset();
            MobileDetails.SetRange(MobileDetails.ID_Number, memberid);
            if MobileDetails.Find('-') then begin
                MobileDetails.OTP := 0;
                MobileDetails.Activated := TRUE;
                MobileDetails.Username := Lowercase(username); // Set the username
                MobileDetails.Password := hashedPassword;
                MobileDetails.Modify();

                response := 'Account Activated';
            end else begin
                //here the emil does not exists
                response := 'Member not found';
            end;
        end;

    end;

    procedure FnLogin(username: Text; password: Text) response: Text
    begin
        MobileDetails.Reset();
        MobileDetails.SetRange(MobileDetails.ID_Number, LowerCase(username));
        if MobileDetails.Find('-') then begin
            MobileDetails.SetRange(MobileDetails.Activated, TRUE);
            if MobileDetails.Find('-') then begin
                response := MobileDetails.Password;
                exit;
            end else begin
                response := 'not active';
                exit;
            end;
        end else begin
            MobileDetails.Reset();
            MobileDetails.SetRange(MobileDetails.Username, LowerCase(username));
            if MobileDetails.Find('-') then begin
                response := MobileDetails.MemberNo + '::' + MobileDetails.Password;
                exit;
            end else begin
                response := 'notactive';
                exit;
            end;
        end;
        response := 'wrongdetails';
    end;

    procedure FnmemberInfo(MemberNo: Code[20]) info: Text
    var
        objMember: record Customer;
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            objMember.CalcFields(objMember."Current Shares", objMember."Share Capital", objMember."Fixed deposit", objMember."Outstanding Balance");
            info := objMember."No." + '.' + ':' + objMember.Name + '.' + ':' + objMember."E-Mail" + '.' + ':' + Format(objMember.Status) + '.' + ':' + Format(objMember."Account Category") + '.' + ':' + objMember."Mobile Phone No"
            + '.' + ':' + objMember."ID No." + '.' + '.:' + Format(objMember."Date Of Birth") + '.:' + Format(objMember."Registration Date") + '.:' + Format(objMember.Gender) + '.:' +
            Format(objMember."Current Shares") + '.:' + Format(objMember."Share Capital") + '.:' + Format(objMember."Fixed deposit") + '.:' + Format(objMember."Outstanding Balance");
        end
    end;


    procedure MemberStatement(MemberNo: Code[50]; StartDate: Date; EndDate: Date): Text
    var
        Outs: OutStream;
        InS: InStream;
        TempBlob: Codeunit "Temp Blob";
        Base64: Codeunit "Base64 Convert";
        RecRef: RecordRef;
        Cust: Record Customer;
    begin
        Cust.Reset();
        Cust.SetRange(Cust."No.", UpperCase(MemberNo));
        Cust.SetFilter(Cust."Date filter", '%1..%2', StartDate, EndDate);
        if Cust.FindFirst() then begin
            RecRef.GetTable(Cust);
            TempBlob.CreateOutStream(Outs);
            Report.SaveAs(Report::"Member Detailed Statement", '', REPORTFORMAT::Pdf, Outs, RecRef);
            TempBlob.CreateInStream(InS);
            exit(Base64.ToBase64(InS));
        end;
    end;

    procedure MiniStatement(MemberNo: Text[100]) MiniStmt: Text
    var
        minimunCount: Integer;
        amount: Decimal;
        description: Text;
        Members: Record Customer;
        loanrepayment2: Option;
        shareCap: Option;
        depContribution: Option;
        runcount: Integer;
        MaxNumberOfRows: Integer;
        MemberLedgerEntry: Record "Cust. Ledger Entry";
    begin
        Members.Reset;
        Members.SetRange(Members."No.", MemberNo);
        if Members.Find('-') then begin
            shareCap := MemberLedgerEntry."transaction type"::"Shares Capital";
            depContribution := MemberLedgerEntry."transaction type"::"Deposit Contribution";
            loanrepayment2 := MemberLedgerEntry."transaction type"::Repayment;
            MaxNumberOfRows := 10;
            MemberLedgerEntry.Reset;
            MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
            MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '%1|%2|%3', shareCap, depContribution, loanrepayment2);
            MemberLedgerEntry.Ascending(false);
            if MemberLedgerEntry.Find('-') then begin
                MemberLedgerEntry.CalcFields(MemberLedgerEntry."Amount");
                repeat
                    MiniStmt := MiniStmt + Format(MemberLedgerEntry."Posting Date") + '|' + Format(MemberLedgerEntry."Transaction Type") + '|' + Format((Abs(MemberLedgerEntry.Amount))) + ';';
                    runcount := runcount + 1;
                    if runcount >= 10 then begin
                        exit(MiniStmt);
                    end;
                until MemberLedgerEntry.Next = 0;
            end else begin
                MiniStmt := 'No transactions were found';
                exit(MiniStmt);
            end
        end else begin
            MiniStmt := 'Member not found';
            exit(MiniStmt);
        end
    end;

    procedure fnLoanDetails(MemberNo: Text[100]) Statement: Text
    var
        Loans: record "Loans Register";
        LoanGuar: Record "Loans Guarantee Details";
        GuarantorsDetails: Text;
        Loanstatement: Text;
        LoanRepayment: Decimal;
    begin
        LoanRepayment := 0;
        Loans.Reset();
        Loans.SetRange(Loans."Client Code", MemberNo);
        Loans.SetAutoCalcFields(Loans."Outstanding Balance");
        Loans.SetRange(Posted, true);
        Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
        if Loans.FindSet() then begin
            repeat
                If Loans."Recommended Repayment" > 0 then begin
                    LoanRepayment := Loans."Recommended Repayment";
                end else begin
                    LoanRepayment := Loans.Repayment;
                end;
                Loanstatement := Loanstatement + Format(Loans."Loan  No.") + '|' + Format(Loans."Approved Amount") + '|' + Format(Loans."Loan Product Type")
                + '|' + Format(Loans."Outstanding Balance") + '|' + Format(Loans.Installments) + '|' + Format(Loans.Interest) + '|' + Format(LoanRepayment) + '|' + Format(Loans."Loans Category-SASRA") + ';';

                LoanGuar.Reset();
                LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                if LoanGuar.FindSet() then begin
                    repeat
                        GuarantorsDetails := GuarantorsDetails + Format(LoanGuar."Loan No") + '|' + Format(LoanGuar."Member No") + '|' + Format(LoanGuar.Name) + '|' + Format(LoanGuar."Amont Guaranteed") + '::'
                    until LoanGuar.Next = 0;
                end;
                Statement := Loanstatement + ':::::' + GuarantorsDetails;
            until Loans.Next = 0;

            exit(Statement)
        end;
    end;
}
