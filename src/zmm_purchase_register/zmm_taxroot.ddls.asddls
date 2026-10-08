@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Tax Root Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_TAXROOT
  as select from     I_JournalEntry            as JEH
    inner join       I_JournalEntryItem        as JEI on  JEI.AccountingDocument =  JEH.AccountingDocument
                                                      and JEI.FiscalYear         =  JEH.FiscalYear
                                                      and JEI.Ledger             =  '2L'
                                                      and JEI.LedgerGLLineItem   =  '000001'
                                                      and JEI.TaxCode            <> ''
    right outer join I_OperationalAcctgDocItem as ACI on  ACI.AccountingDocument =  JEI.AccountingDocument
                                                      and ACI.FiscalYear         =  JEI.FiscalYear
                                                      and ACI.ProfitCenter       <> ''

{
  key ACI.AccountingDocument     as GLNumber,
  key ACI.AccountingDocumentItem as GLItem,
  key ACI.FiscalYear             as GRYear
}
