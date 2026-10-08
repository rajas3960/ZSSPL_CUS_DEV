@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Create Invoice Report Projection View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZFI_INVOICE_PV provider contract transactional_query as projection on ZFI_INVOICE_RE
{
    key SAP_DOCNO,
    key ACCITEM,
    key FiscalYear,
    key CompanyCode,
    VENDORCODE,
    VENDORNAME,
    SUPPLIERINVOICEDATE,
    SUPPLIERINVOICENO,
    PostingDate,
    VENDOR_GSTINNO,
    VENDOR_PANNO,
    TEXT,
    ProfitCenter,
    GLAccount,
    GLAccountName,
    TaxCode,
    TransactionCurrency,
    CompanyCodeCurrency,
    AccountingDocumentType,
    @Aggregation.default: #SUM @Aggregation.exception: #LAST
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    TAXABLE_VALUE_C,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    TAXABLE_VALUE_T,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    CGST_T,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    CGST_C,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    SGST_C,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    SGST_T,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    IGST_C,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    IGST_T,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    TDS_C,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    TDS_T,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    @Aggregation.default: #SUM @Aggregation.exception: #LAST
    GROSS_AMOUNT_C,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    GROSS_AMOUNT_T,
    WITHHOLDINGTXT,
    IsReversal,
    IsReversed,
    ReverseDocument
}
