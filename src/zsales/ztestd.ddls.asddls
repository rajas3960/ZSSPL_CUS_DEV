@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'api2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ztestd as select from I_JournalEntry
{
    key CompanyCode,
    key FiscalYear,
    key AccountingDocument,
    AccountingDocumentType,
    DocumentReferenceID
} where AccountingDocumentType = 'DR' or AccountingDocumentType = 'DG'
