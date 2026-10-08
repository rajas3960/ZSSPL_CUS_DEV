@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TESTING'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_GRP_SUP2 as select from I_JournalEntry as jhi
inner join I_JournalEntryItem as JEI on JEI.AccountingDocument = jhi.AccountingDocument and JEI.FiscalYear = jhi.FiscalYear
                                                              and JEI.Ledger='0L'  and JEI.LedgerGLLineItem ='000002' 
{
   
 key jhi.CompanyCode,
// key jhi.FiscalYear,
// key jhi.AccountingDocument,
 key JEI.SourceLedger,
// key JEI.CompanyCode,
 key JEI.FiscalYear,
 key JEI.AccountingDocument,
 key JEI.LedgerGLLineItem,
 key JEI.Ledger,
 JEI.AccountingDocumentType,
 JEI.DocumentDate,
 JEI.PostingDate,
 jhi.DocumentReferenceID,
 JEI.PurchasingDocument,
 JEI.PurchasingDocumentItem,
 JEI.ReferenceDocument,
 JEI.ReferenceDocumentItem
 
    
}
