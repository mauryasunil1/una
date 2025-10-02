<?php
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 */

$aConfig = array(
    /**
     * Main Section.
     */
    'title' => 'Xero',
    'version_from' => '14.0.0',
    'version_to' => '15.0.0',
    'vendor' => 'UNA INC',

    'compatible_with' => array(
        '15.0.0-A1'
    ),

    /**
     * 'home_dir' and 'home_uri' - should be unique. Don't use spaces in 'home_uri' and the other special chars.
     */
    'home_dir' => 'boonex/xero/updates/update_14.0.0_15.0.0/',
    'home_uri' => 'xero_update_1400_1500',

    'module_dir' => 'boonex/xero/',
    'module_uri' => 'xero',

    'db_prefix' => 'bx_xero_',
    'class_prefix' => 'BxXero',

    /**
     * Installation/Uninstallation Section.
     */
    'install' => array(
        'execute_sql' => 0,
        'update_files' => 1,
        'update_languages' => 0,
        'clear_db_cache' => 0,
    ),

    /**
     * Category for language keys.
     */
    'language_category' => 'Xero',

    /**
     * Files Section
     */
    'delete_files' => array(
        'plugins/xeroapi/xero-php-oauth2/test/Api/AccountingApiTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Api/IdentityApiTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Api/',
        'plugins/xeroapi/xero-php-oauth2/test/Model/AccessTokenTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/AccountsPayableTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/AccountsReceivableTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/AccountsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/AccountTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/AccountTypeTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/AddressTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/AllocationsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/AllocationTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/AttachmentsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/AttachmentTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/BalancesTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/BankTransactionsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/BankTransactionTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/BankTransfersTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/BankTransferTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/BatchPaymentDetailsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/BatchPaymentsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/BatchPaymentTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/BillTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/BrandingThemesTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/BrandingThemeTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/CISOrgSettingTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/CISSettingsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/CISSettingTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ConnectionTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ContactGroupsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ContactGroupTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ContactPersonTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ContactsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ContactTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/CountryCodeTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/CreditNotesTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/CreditNoteTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/CurrenciesTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/CurrencyCodeTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/CurrencyTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ElementTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/EmployeesTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/EmployeeTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ErrorTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ExpenseClaimsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ExpenseClaimTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ExternalLinkTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/HistoryRecordsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/HistoryRecordTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/InvoiceRemindersTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/InvoiceReminderTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/InvoicesTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/InvoiceTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ItemsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ItemTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/JournalLineTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/JournalsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/JournalTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/LineAmountTypesTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/LineItemTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/LineItemTrackingTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/LinkedTransactionsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/LinkedTransactionTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ManualJournalLineTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ManualJournalsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ManualJournalTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/OnlineInvoicesTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/OnlineInvoiceTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/OrganisationsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/OrganisationTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/OverpaymentsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/OverpaymentTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/PaymentServicesTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/PaymentServiceTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/PaymentsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/PaymentTermTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/PaymentTermTypeTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/PaymentTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/PhoneTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/PrepaymentsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/PrepaymentTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/PurchaseOrdersTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/PurchaseOrderTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/PurchaseTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ReceiptsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ReceiptTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/RefreshTokenTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/RepeatingInvoicesTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/RepeatingInvoiceTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ReportAttributeTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ReportCellTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ReportFieldsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ReportRowsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ReportRowTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ReportsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ReportTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ReportWithRowsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ReportWithRowTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/RequestEmptyTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/RowTypeTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/SalesTrackingCategoryTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ScheduleTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/TaxComponentTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/TaxRatesTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/TaxRateTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/TaxTypeTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/TenNinteyNineContactTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/TimeZoneTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/TrackingCategoriesTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/TrackingCategoryTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/TrackingOptionsTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/TrackingOptionTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/UsersTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/UserTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/ValidationErrorTest.php',
        'plugins/xeroapi/xero-php-oauth2/test/Model/',
        'plugins/xeroapi/xero-php-oauth2/test/'
    ),
);
