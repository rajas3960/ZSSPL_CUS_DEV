@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ref for IOPERADTI'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZIOPADI as select distinct from I_OperationalAcctgDocItem
{
    key CompanyCode,
    key AccountingDocument,
    key FiscalYear,
    max(AccountingDocumentItem) as AccountingDocumentItem,
    ChartOfAccounts,
    PurchasingDocumentItem,
    AccountingDocumentItemType,
    ClearingDate,
    ClearingCreationDate,
    ClearingJournalEntryFiscalYear,
    ClearingDocFiscalYear,
    ClearingJournalEntry,
    ClearingAccountingDocument,
    PostingKey,
    FinancialAccountType,
    SpecialGLCode,
    SpecialGLTransactionType,
    DebitCreditCode,
    BusinessArea,
    PartnerBusinessArea,
    TaxCode,
    TaxCountry,
    TaxRateValidityStartDate,
    WithholdingTaxCode,
    TaxItemGroup,
    TaxType,
   substring(OriginalReferenceDocument,1,10) as reference,
   PurchasingDocument,
   PostingDate,
   OriginalReferenceDocument as OriginalReferenceDocument, 
   @Semantics.quantity.unitOfMeasure:    'baseunit'
    Quantity,
    BaseUnit,
    TransactionCurrency,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    AmountInTransactionCurrency
       
}
where AccountingDocumentType = 'RE'
group by 
CompanyCode,
     AccountingDocument,
     FiscalYear,
//  AccountingDocumentItem,
    ChartOfAccounts,
    PurchasingDocumentItem,
    AccountingDocumentItemType,
    ClearingDate,
    ClearingCreationDate,
    ClearingJournalEntryFiscalYear,
    ClearingDocFiscalYear,
    ClearingJournalEntry,
    ClearingAccountingDocument,
    PostingKey,
    FinancialAccountType,
    SpecialGLCode,
    SpecialGLTransactionType,
    DebitCreditCode,
    BusinessArea,
    PartnerBusinessArea,
    TaxCode,
    TaxCountry,
    TaxRateValidityStartDate,
    WithholdingTaxCode,
    TaxItemGroup,
    TaxType,
    OriginalReferenceDocument,
     PurchasingDocument,
   PostingDate,
   OriginalReferenceDocument,
   Quantity,
    BaseUnit,
    TransactionCurrency,
    AmountInTransactionCurrency

