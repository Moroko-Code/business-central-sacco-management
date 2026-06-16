# Dynamics 365 Business Central SACCO Management System

## Project Summary

This project is a custom **Dynamics 365 Business Central SACCO Management System** developed for SACCO, credit union, and microfinance operations.

The system supports **membership management, BOSA member accounts, loan management, guarantor management, loan approval workflow, interest calculation, repayment schedules, arrears and penalty tracking, member statements, receipts, SMS notifications, payment integration, Power BI reporting, member self-service, mobile field officer operations, API integration, and custom Role Center dashboards**.

This project demonstrates hands-on experience in **Business Central AL development, ERP customization, financial workflows, credit management, API integrations, reporting, and business process automation**.

## Screenshot
<img width="958" height="410" alt="image" src="https://github.com/user-attachments/assets/24fe9d47-87e2-43d8-a25a-e34c4b31ed25" />


## Business Problem Solved

Many SACCOs manage members, loans, repayments, deposits, approvals, statements, and communication manually using spreadsheets or disconnected systems.

This creates challenges such as:

- Difficult tracking of active, dormant, exited, or deceased members
- Manual loan application and approval processes
- Manual guarantor tracking
- Manual interest and repayment schedule calculations
- Payment reconciliation errors
- Poor visibility of arrears and penalties
- Delayed member statements
- Poor visibility of SACCO performance
- Delayed member communication
- Limited integration between operations and accounting
- Slow access to loan, member, and financial reports

This solution brings SACCO operations into **Microsoft Dynamics 365 Business Central**, allowing users to manage membership, loans, approvals, guarantors, receipts, payments, statements, communication, and reporting from one ERP system.

## What I Built

### 1. Custom SACCO Role Center

I created a custom **Business Central Role Center** for SACCO users.

The dashboard gives users quick access to:

- Members
- Credits
- Chart of Accounts
- Posted Receipts
- Financial Management
- Membership Management
- Credit Management
- Loan Approvals
- Member Statements
- Reports and Analytics

The Role Center includes cue tiles that show member statistics, gender analytics, loan summaries, arrears, pending approvals, and other operational indicators.

### 2. Membership Management

The system tracks SACCO members by different statuses.

Member categories include:

- All Members
- Active Members
- Dormant Members
- Deceased Members
- Awaiting Exit Members
- Exited Members

This helps SACCO staff monitor member activity and manage the full member lifecycle.

### 3. BOSA Member Accounts

The system supports **BOSA member account management** for SACCO back-office operations.

It helps connect member records with:

- Deposits
- Contributions
- Share capital
- Loan activity
- Receipts
- Member statements
- Financial reporting

### 4. Gender Analytics

The dashboard provides gender-based member statistics.

It tracks:

- Male members
- Female members

This supports management reporting and gives better visibility of member distribution.

### 5. Loan Management

The system includes loan dashboard cues for tracking SACCO loan activities by status and loan product.

Loan categories and statuses include:

- Applied Loans
- Active Loans
- Cleared Loans
- Pending Loans
- Log Book Loans
- Long Term Loans
- Sadika PAP Loans
- School Fees Loans
- Emergency Loans

This gives credit officers and management quick visibility of loan performance and pending credit activities.

### 6. Loan Approval Workflow

The system includes a loan approval process to control loan review and authorization.

The workflow supports:

- Loan application submission
- Loan review
- Approval or rejection
- Status tracking
- Separation of duties
- Management visibility of pending approvals

This improves control, accountability, and transparency in the loan process.

### 7. Guarantor Management

The system supports guarantor tracking for SACCO loans.

It helps users manage:

- Loan guarantor details
- Member-guarantor relationships
- Guarantor responsibility per loan
- Loan security validation
- Guarantor reporting

This supports SACCO credit risk control and loan compliance.

### 8. Automated Interest Calculation

The system includes interest calculation logic for SACCO loans.

It helps calculate loan interest based on the defined loan setup and product rules.

This reduces manual calculations and improves accuracy in loan processing.

### 9. Loan Repayment Schedule

The system supports loan repayment schedule generation.

The repayment schedule helps track:

- Installment amounts
- Due dates
- Principal amount
- Interest amount
- Outstanding balances
- Repayment progress

This improves loan monitoring and member repayment visibility.

### 10. Arrears and Penalty Tracking

The system supports arrears and penalty tracking for overdue loans.

It helps SACCO staff monitor:

- Overdue installments
- Loan arrears
- Penalty charges
- Outstanding balances
- Members with delayed repayments

This improves loan recovery and credit management.

---

### 11. Member Statement Report

The system includes member statement reporting.

The member statement can be used to show member financial activity such as:

- Deposits
- Contributions
- Loan disbursements
- Loan repayments
- Charges
- Balances
- Transaction history

This improves transparency and supports member service.

### 12. Receipts and Payment Processing

The system supports SACCO receipt and payment tracking.

Payment areas include:

- Member deposits
- Loan repayments
- Monthly contributions
- Share capital payments
- Entrance fees
- Posted receipts
- Payment reconciliation

This improves financial control and reduces manual posting errors.

## Integrations

### 1. SMS Integration

I designed SMS integration logic to support automatic member communication from Business Central.

Example SMS notifications include:

- Member registration confirmation
- Loan application received
- Loan approval notification
- Payment receipt confirmation
- Loan repayment reminder
- Overdue loan reminder
- Account status update
- Statement notification

#### SMS Integration Flow

Business Central Event
        |
        v
AL Codeunit / Integration Logic
        |
        v
SMS Provider API
        |
        v
Member Receives SMS


This demonstrates experience with Business Central events, AL codeunits, and external API integration.

---

### 2. Payment Integration

The system integrates with external payment channels such as mobile money, bank payment gateways, or SACCO payment platforms.

#### Payment Integration Flow


Member Makes Payment
        |
        v
Mobile Money / Bank / Payment Gateway
        |
        v
Middleware or API Endpoint
        |
        v
Business Central Validates Payment
        |
        v
Receipt / Journal / Ledger Entry Created
        |
        v
Payment Posted or Sent for Approval
        |
        v
SMS Confirmation Sent to Member

This helps automate payment processing, reduce reconciliation errors, and improve member communication.

### 3. M-Pesa / Mobile Money Integration

The system supports mobile money payment integration for SACCO transactions.

Supported use cases include:

- Loan repayment through mobile money
- Member deposit through mobile money
- Monthly contribution payment
- Share capital payment
- Payment confirmation
- Receipt creation
- SMS confirmation to members

This improves convenience for members and reduces manual payment entry.

---

### 4. API Integration with External Systems

The system supports API-based integration with external platforms.

Integration use cases include:

- Payment systems
- SMS providers
- Member self-service portal
- Mobile Power App
- Reporting tools
- External SACCO platforms

This demonstrates Business Central integration design using APIs, web services, and AL integration logic.

---

## Reporting and Analytics

### Power BI Reporting Dashboard

The project includes Power BI reporting support for management visibility.

Reports and dashboards can show:

- Member statistics
- Loan portfolio performance
- Loan arrears
- Repayment performance
- Payment trends
- Gender distribution
- Active and dormant members
- Financial summaries

This helps management make better data-driven decisions.

---

## Member and Field Officer Access

### Member Self-Service Portal

The solution includes member self-service capability where members can access key information and services.

Member self-service features include:

- Viewing member details
- Viewing loan information
- Viewing statements
- Checking balances
- Viewing repayment schedules
- Receiving payment confirmations

---

### Mobile Power App for Field Officers

The project includes mobile support using Power Apps for field officers.

Field officers can use the mobile app to:

- View member information
- Capture member updates
- Support loan follow-up
- Review repayment information
- Access member status
- Support field operations

This improves field productivity and reduces paperwork.

---

## Technical Skills Demonstrated

This project demonstrates experience with:

- Microsoft Dynamics 365 Business Central
- AL Programming Language
- Visual Studio Code
- Tables
- Pages
- Page Extensions
- Codeunits
- Reports
- Role Center customization
- Cue tables and cue pages
- Business Central financial management
- Membership management workflows
- Credit and loan management workflows
- Loan approval workflow
- Guarantor management
- Interest calculation logic
- Repayment schedule logic
- Arrears and penalty tracking
- Member statement reporting
- API and web service concepts
- HttpClient integration design
- SMS API integration
- Payment gateway integration
- M-Pesa / mobile money integration
- Power BI reporting
- Power Apps integration
- ERP business process automation
- Dashboard and navigation design

---

## My Role and Contribution

I worked on the design and development of this SACCO solution in Microsoft Dynamics 365 Business Central.

My contribution included:

- Designing the SACCO Role Center
- Creating member dashboard cues
- Creating loan dashboard cues
- Building SACCO navigation menus
- Supporting member management workflows
- Supporting loan and credit management workflows
- Designing loan approval workflow
- Building guarantor management functionality
- Supporting automated interest calculation
- Supporting loan repayment schedule logic
- Supporting arrears and penalty tracking
- Designing member statement reporting
- Designing receipt and payment tracking flow
- Designing SMS notification flow
- Designing payment integration flow
- Supporting M-Pesa / mobile money integration
- Supporting Power BI reporting dashboard
- Supporting member self-service capability
- Supporting mobile Power App use for field officers
- Testing the system in Business Central
- Improving usability for SACCO staff

## Target Users

This solution is suitable for:

- SACCOs
- Credit unions
- Cooperative societies
- Microfinance institutions
- Member-based financial organizations
- Savings and loan organizations

## Portfolio Summary

This project shows how Microsoft Dynamics 365 Business Central can be customized for SACCO and microfinance operations.

It combines:

- ERP customization
- Membership management
- Loan management
- Financial tracking
- SMS communication
- Payment integration
- Role Center dashboards
- Reporting and analytics
- Mobile field operations
- Member self-service
- Business process automation

## Author
**Mathew Moroko**  
Dynamics 365 Business Central Developer | AL Developer | ERP Integration Enthusiast
