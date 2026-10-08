@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I_Journallineitemdata'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_RP02_JV as select from I_JournalEntryItem
{
    key SourceLedger,
    key CompanyCode,
    key FiscalYear,
    key AccountingDocument,
    key LedgerGLLineItem,
    key Ledger,
    GLAccount,
    TaxCode,
    FiscalYearPeriod,
    Supplier,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    AmountInTransactionCurrency,
    TransactionCurrency
    
    
}
where Ledger = '0L' and LedgerGLLineItem = '000001'
