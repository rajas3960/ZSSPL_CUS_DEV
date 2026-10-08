@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Journal entry data debit and credit'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zfi_journalentry_data as select from ZSD_JOURNALENT_V as jeh 
inner join I_JournalEntryItem as jei on jei.AccountingDocument = jeh.AccountingDocument 
                                        and jei.Ledger = '0L' and jei.LedgerGLLineItem = '000001' and jei.TaxCode <> '' and jei.FiscalYear = jeh.FiscalYear
left outer join I_Customer                     as CUS    on CUS.Customer = jei.Customer
left outer join I_OperationalAcctgDocItem as aci on aci.AccountingDocument = jei.AccountingDocument
                                             and aci.FiscalYear = jei.FiscalYear and aci.ProfitCenter <>''
 left outer join I_OperationalAcctgDocItem as CGST on CGST.AccountingDocument = aci.AccountingDocument
                                               and CGST.FiscalYear = aci.FiscalYear and CGST.TaxItemGroup = aci.TaxItemGroup
                                               and CGST.AccountingDocumentItemType = 'T'
                                               and CGST.TransactionTypeDetermination = 'JOC'                                              
      left outer join I_OperationalAcctgDocItem as IGST on IGST.AccountingDocument = aci.AccountingDocument
                                               and IGST.FiscalYear = aci.FiscalYear and IGST.TaxItemGroup = aci.TaxItemGroup 
                                               and IGST.AccountingDocumentItemType = 'T'
                                               and IGST.TransactionTypeDetermination = 'JOI'
   left outer join I_Plant as PLT on PLT.Plant = jei.Plant
{
   
    key aci.CompanyCode,
    key aci.AccountingDocument,
    key aci.FiscalYear,
    key aci.TaxItemGroup,
    jeh.DocumentReferenceID,
    jeh.AccountingDocumentType,
    jeh.DocumentDate,
    jeh.PostingDate,
    CUS.CustomerName ,
    CUS.TaxNumber3,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum(aci.AmountInTransactionCurrency) as AmountInTransactionCurrency ,
    aci.TransactionCurrency,
    aci.TaxCode,
    CUS.Region,
    PLT.Plant,
    PLT.PlantName,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    CGST.AmountInTransactionCurrency as AmountInTransactionCurrencyC,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    IGST.AmountInTransactionCurrency as AmountInTransactionCurrencyI
    
    
    
}
group by
  aci.CompanyCode,
     aci.AccountingDocument,
     aci.FiscalYear,
     aci.TaxItemGroup,
    jeh.DocumentReferenceID,
    jeh.AccountingDocumentType,
    jeh.DocumentDate,
    jeh.PostingDate,
    CUS.CustomerName ,
    CUS.TaxNumber3,
    aci.TransactionCurrency,
    aci.TaxCode,
    CUS.Region,
    PLT.Plant,
    PLT.PlantName,
    CGST.AmountInTransactionCurrency ,
    IGST.AmountInTransactionCurrency
