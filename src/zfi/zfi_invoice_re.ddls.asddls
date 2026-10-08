@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Create Invoce Report Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZFI_INVOICE_RE
  as select from    ZFI_journal_entry         as jeh
    inner join      I_JournalEntryItem        as jei  on  jei.AccountingDocument =  jeh.AccountingDocument
                                                      and jei.FiscalYear         =  jeh.FiscalYear
                                                      and jei.Ledger             =  '0L'
                                                      and jei.LedgerGLLineItem   =  '000001'
                                                      //and jei.TaxCode            <> ''
    left outer join I_Supplier                as SUP  on SUP.Supplier = jei.Supplier
    left outer join I_OperationalAcctgDocItem as ACI  on  ACI.AccountingDocument =  jei.AccountingDocument
                                                      and ACI.FiscalYear         =  jei.FiscalYear
                                                      and ACI.ProfitCenter       <> ''
    left outer join I_GLAccountText           as GLT  on  GLT.GLAccount = ACI.GLAccount
                                                      and GLT.Language  = 'E'
    left outer join I_OperationalAcctgDocItem as CGST on  CGST.AccountingDocument           = ACI.AccountingDocument
                                                      and CGST.FiscalYear                   = ACI.FiscalYear
                                                      and CGST.TaxItemGroup                 = ACI.TaxItemGroup
                                                      and CGST.AccountingDocumentItemType   = 'T'
                                                      and CGST.TransactionTypeDetermination = 'JIC' // CGST
    left outer join I_OperationalAcctgDocItem as SGST on  SGST.AccountingDocument           = ACI.AccountingDocument
                                                      and SGST.FiscalYear                   = ACI.FiscalYear
                                                      and SGST.TaxItemGroup                 = ACI.TaxItemGroup
                                                      and SGST.AccountingDocumentItemType   = 'T'
                                                      and SGST.TransactionTypeDetermination = 'JIS' // SGST
    left outer join I_OperationalAcctgDocItem as IGST on  IGST.AccountingDocument           = ACI.AccountingDocument
                                                      and IGST.FiscalYear                   = ACI.FiscalYear
                                                      and IGST.TaxItemGroup                 = ACI.TaxItemGroup
                                                      and IGST.AccountingDocumentItemType   = 'T'
                                                      and IGST.TransactionTypeDetermination = 'JII' //IGST
    left outer join I_OperationalAcctgDocItem as TDS on  TDS.AccountingDocument           = ACI.AccountingDocument
                                                      and TDS.FiscalYear                   = ACI.FiscalYear
                                                      and TDS.TransactionTypeDetermination = 'WIT' //TDS
    left outer join I_GLAccountText as TDS_NAME on TDS_NAME.GLAccount = TDS.GLAccount
   
{ 
 key jei.AccountingDocument as SAP_DOCNO,
 key jei.AccountingDocumentItem as ACCITEM,
 key jei.FiscalYear,
 key jei.CompanyCode,
 jei.Supplier as VENDORCODE,
 SUP.SupplierName as VENDORNAME,
 jeh.DocumentDate as SUPPLIERINVOICEDATE,
 jeh.DocumentReferenceID as SUPPLIERINVOICENO,
 jeh.PostingDate,
 SUP.TaxNumber3 as VENDOR_GSTINNO,
 substring(SUP.TaxNumber3, 3, 10) as VENDOR_PANNO,
 jei.DocumentItemText as TEXT,
 ACI.ProfitCenter,
 ACI.GLAccount ,
 GLT.GLAccountName,
 ACI.TaxCode,
 ACI.TransactionCurrency,
 ACI.CompanyCodeCurrency,
 jeh.AccountingDocumentType,
 @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
/////////////////////////////////////
 ACI.AmountInCompanyCodeCurrency as TAXABLE_VALUE_C,
////////////////////////////////////
 @Semantics.amount.currencyCode: 'TransactionCurrency'
ACI.AmountInTransactionCurrency as TAXABLE_VALUE_T,
 @Semantics.amount.currencyCode: 'TransactionCurrency'

 CGST.AmountInTransactionCurrency as CGST_T,
 @Semantics.amount.currencyCode: 'CompanyCodeCurrency'

 CGST.AmountInCompanyCodeCurrency  as CGST_C,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'

 SGST.AmountInCompanyCodeCurrency  as SGST_C,
 @Semantics.amount.currencyCode: 'TransactionCurrency'

 SGST.AmountInTransactionCurrency  as SGST_T,
 
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
 
 IGST.AmountInCompanyCodeCurrency  as IGST_C,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  
 IGST.AmountInTransactionCurrency as IGST_T,
 @Semantics.amount.currencyCode: 'CompanyCodeCurrency'

 TDS.AmountInCompanyCodeCurrency  as TDS_C,
 @Semantics.amount.currencyCode: 'TransactionCurrency'

 TDS.AmountInTransactionCurrency  as TDS_T,
// ROUND
// OTHERCHARGES
jeh.IsReversal,
jeh.IsReversed,
jeh.ReverseDocument,
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
cast(
    
        coalesce(cast(ACI.AmountInCompanyCodeCurrency as abap.dec(23,2)), 0) 
      + coalesce(cast(CGST.AmountInCompanyCodeCurrency as abap.dec(23,2)), 0) 
      + coalesce(cast(SGST.AmountInCompanyCodeCurrency as abap.dec(23,2)), 0) 
      + coalesce(cast(IGST.AmountInCompanyCodeCurrency as abap.dec(23,2)), 0) 
      + coalesce(cast(TDS.AmountInCompanyCodeCurrency as abap.dec(23,2)), 0)
     as abap.dec(23,2)
) as GROSS_AMOUNT_C,

@Semantics.amount.currencyCode: 'TransactionCurrency'
cast(
    
        coalesce(cast(ACI.AmountInTransactionCurrency as abap.dec(23,2)), 0) 
      + coalesce(cast(CGST.AmountInTransactionCurrency as abap.dec(23,2)), 0) 
      + coalesce(cast(SGST.AmountInTransactionCurrency as abap.dec(23,2)), 0) 
      + coalesce(cast(IGST.AmountInTransactionCurrency as abap.dec(23,2)), 0)  
      + coalesce(cast(TDS.AmountInTransactionCurrency as abap.dec(23,2)), 0)
     as abap.dec(23,2)
) as GROSS_AMOUNT_T,



 TDS_NAME.GLAccountName as WITHHOLDINGTXT
 
 

}
