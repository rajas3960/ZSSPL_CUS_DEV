@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'API'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZTEST as select from  I_JournalEntry
{
  
    key CompanyCode,
    key FiscalYear,
    key AccountingDocument,
    DocumentReferenceID
    
} where AccountingDocumentType = 'DR' and AccountingDocumentType = 'DZ'
    
