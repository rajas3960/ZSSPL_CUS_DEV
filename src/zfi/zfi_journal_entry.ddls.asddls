@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Journal Entry type and reversal'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_journal_entry as select from I_JournalEntry as jeh
{
    key CompanyCode,
    key FiscalYear,
    key AccountingDocument,
    AccountingDocumentType,
    DocumentDate,
    PostingDate,
    DocumentReferenceID,
    IsReversal,
    IsReversed,
    ReversalReferenceDocument,
    ReverseDocument
    
   
} where jeh.AccountingDocumentType = 'KR' or jeh.AccountingDocumentType = 'KG'
