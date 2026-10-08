@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Journal entry view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_JOURNALENT_V as select from I_JournalEntry
{
    key CompanyCode,
    key FiscalYear,
    key AccountingDocument,
    DocumentReferenceID,
    AccountingDocumentType,
    DocumentDate,
    PostingDate
   
    
    
} 
where AccountingDocumentType = 'DR' or AccountingDocumentType = 'DG' 
