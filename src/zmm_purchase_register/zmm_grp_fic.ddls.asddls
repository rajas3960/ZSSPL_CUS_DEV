@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Lable view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_GRP_FIC as select from ZMM_GRP_SER_1
{
    key CompanyCode,
   key AccountingDocument, 

//    key AccountingDocumentItem,
    key FiscalYear,
    TaxItemGroup,
    DocumentReferenceID,
    PostingDate   as GRpostingDate,
    InvoiceDate,
//   DocumentDate,   
    FiscalYearPeriod, 
    PurchasingDocument,
    PurchasingDocumentItem,
    Product,
    GLAccount,
    TaxCode,
    IN_HSNOrSACCode,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    AmountInCompanyCodeCurrency,
    CompanyCodeCurrency,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    AmountInTransactionCurrency,
    TransactionCurrency,
    PostingDate,
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    CGST_C,
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    IGST_C,
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    IGST1_C,
        @Semantics.amount.currencyCode: 'TransactionCurrency'
    CGST_T,
    TransactionTypeDetermination,
        @Semantics.amount.currencyCode: 'TransactionCurrency'
    IGST_T,
        @Semantics.amount.currencyCode: 'TransactionCurrency'
    IGST1_T,
    TransactionTypeDeterminationI,
    TransactionTypeDeterminationI1,
    TaxNumber3,
    supplier,
    SupplierName,
    Region,
    Country,
    BusinessPartnerPanNumber,
    Reference3IDByBusinessPartner,
    OriginalReferenceDocument,
    @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    Quantity,
    BaseUnit,
    DebitCreditCode
//    Supplier
} group by 
  CompanyCode,
    AccountingDocument ,
//     AccountingDocumentItem,
     FiscalYear,
     TaxItemGroup,
    DocumentReferenceID,
    InvoiceDate,
//    DocumentDate,
    FiscalYearPeriod,
    PurchasingDocument,
    PurchasingDocumentItem,
    Product,
    GLAccount,
    TaxCode,
    IN_HSNOrSACCode,
    AmountInCompanyCodeCurrency,
    CompanyCodeCurrency,
    AmountInTransactionCurrency,
    TransactionCurrency,
    PostingDate,
    CGST_C,
    IGST_C,
    IGST1_C,
    CGST_T,
    TransactionTypeDetermination,
    IGST_T,
    IGST1_T,
    TransactionTypeDeterminationI,
    TransactionTypeDeterminationI1,
    TaxNumber3,
    supplier,
    SupplierName,
    Region,
    Country,
    BusinessPartnerPanNumber,
    Reference3IDByBusinessPartner,
    OriginalReferenceDocument,
    Quantity,
    BaseUnit,
    DebitCreditCode
//    Supplier
