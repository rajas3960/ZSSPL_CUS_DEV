@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Register Debit and Credit'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_GRP_SER_1 as select from  I_JournalEntry as jeh
inner join I_JournalEntryItem as JEI on JEI.AccountingDocument = jeh.AccountingDocument and JEI.FiscalYear = jeh.FiscalYear
                                                              and JEI.Ledger='0L' and JEI.LedgerGLLineItem ='000002' 
                                                              // and JEI.TransactionTypeDetermination <> 'WRX'
                                                              
      left outer join I_SuplrInvcItemPurOrdRefAPI01 as SDC on SDC.ReferenceDocument = JEI.AccountingDocument
                                                          and SDC.SupplierInvoice = JEI.ReferenceDocument
                                                         and SDC.IsSubsequentDebitCredit is not initial                                                             
//and JEI.AccountingDocumentType = 'RE'
      left outer join I_Supplier as SUP on SUP.Supplier = JEI.Supplier
      left outer join I_OperationalAcctgDocItem as ACI on ACI.AccountingDocument = JEI.AccountingDocument //CHANGE
                                               and ACI.FiscalYear = JEI.FiscalYear 
                                               and (ACI.ProfitCenter <> '')                                                                                
                                                and JEI.TransactionTypeDetermination <> 'WRX'
      left outer join I_OperationalAcctgDocItem as CGST on CGST.AccountingDocument = ACI.AccountingDocument
                                               and CGST.FiscalYear = ACI.FiscalYear 
                                               and CGST.AccountingDocumentItemType = 'T'
                                               and CGST.TransactionTypeDetermination = 'JIC'                                              
      left outer join I_OperationalAcctgDocItem as IGST on IGST.AccountingDocument = ACI.AccountingDocument
                                               and IGST.FiscalYear = ACI.FiscalYear
                                               and IGST.AccountingDocumentItemType = 'T'
                                               and IGST.TransactionTypeDetermination = 'JII' 
       left outer join I_OperationalAcctgDocItem as IGST1 on IGST1.AccountingDocument = ACI.AccountingDocument
                                               and IGST1.FiscalYear = ACI.FiscalYear 
                                               and IGST1.AccountingDocumentItemType = 'T'
                                               and IGST1.TransactionTypeDetermination = 'JIM'
{
 key ACI.CompanyCode,
 key ACI.AccountingDocument,
// key ACI.AccountingDocumentItem,
 key ACI.FiscalYear,
 key ACI.TaxItemGroup,
 jeh.DocumentReferenceID ,
 jeh.DocumentDate  as InvoiceDate,
 jeh.PostingDate   as GRpostingDate,
 JEI.FiscalYearPeriod,
 ACI.PurchasingDocument,
ACI.PurchasingDocumentItem,
ACI.Product,
//@EndUserText.label: 'OMKAR'
@EndUserText.label: 'TEJA'
min(ACI.GLAccount) as GLAccount,
ACI.TaxCode,
ACI.IN_HSNOrSACCode,
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
sum(ACI.AmountInCompanyCodeCurrency ) as AmountInCompanyCodeCurrency,
ACI.CompanyCodeCurrency,
@Semantics.amount.currencyCode: 'TransactionCurrency'
sum(ACI.AmountInTransactionCurrency) as AmountInTransactionCurrency,
ACI.TransactionCurrency,
@Semantics.amount.currencyCode: 'TransactionCurrency'
 JEI.AmountInTransactionCurrency as AmtTransactionCurrency,
ACI.PostingDate,
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
CGST.AmountInCompanyCodeCurrency as CGST_C,
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
IGST.AmountInCompanyCodeCurrency as IGST_C,
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
IGST1.AmountInCompanyCodeCurrency as IGST1_C,
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
CGST.AmountInTransactionCurrency as CGST_T,
CGST.TransactionTypeDetermination as TransactionTypeDetermination,
@Semantics.amount.currencyCode: 'TransactionCurrency'
IGST.AmountInTransactionCurrency as IGST_T,
@Semantics.amount.currencyCode: 'TransactionCurrency'
IGST1.AmountInTransactionCurrency as IGST1_T,
IGST.TransactionTypeDetermination as TransactionTypeDeterminationI,
IGST1.TransactionTypeDetermination as TransactionTypeDeterminationI1,
SUP.TaxNumber3,
SUP.Supplier, 
SUP.SupplierName,
SUP.Region,
SUP.Country,
SUP.BusinessPartnerPanNumber,
substring(ACI.Reference3IDByBusinessPartner,5,10)as Reference3IDByBusinessPartner,
substring(ACI.OriginalReferenceDocument,1,10) as OriginalReferenceDocument,
substring(ACI.Reference3IDByBusinessPartner,15,4) as Reference3IDByBusinessItem,
@Semantics.quantity.unitOfMeasure: 'BaseUnit'
ACI.Quantity,
ACI.BaseUnit,
ACI.DebitCreditCode
//ACI.Supplier
}
group by 

ACI.CompanyCode,
  ACI.AccountingDocument,
//  ACI.AccountingDocumentItem,
  ACI.FiscalYear,
  ACI.TaxItemGroup,
 jeh.DocumentReferenceID,
  jeh.DocumentDate,
//  jeh.InvoiceDate,
  jeh.PostingDate,
   JEI.GLAccount, 
   JEI.DebitAmountInTransCrcy,
  JEI.CreditAmountInTransCrcy ,
 JEI.AmountInTransactionCurrency,
   JEI.FiscalYearPeriod,
   ACI.PurchasingDocument,
   ACI.PurchasingDocumentItem,
ACI.Product,
ACI.TaxCode,
ACI.IN_HSNOrSACCode,
ACI.CompanyCodeCurrency,
ACI.TransactionCurrency,
ACI.PostingDate,
CGST.AmountInCompanyCodeCurrency,
IGST.AmountInCompanyCodeCurrency,
IGST1.AmountInCompanyCodeCurrency ,
CGST.AmountInTransactionCurrency ,
CGST.TransactionTypeDetermination,
IGST.AmountInTransactionCurrency,
IGST1.AmountInTransactionCurrency,
IGST.TransactionTypeDetermination,
IGST1.TransactionTypeDetermination,
SUP.TaxNumber3,
SUP.Supplier,
SUP.SupplierName,
SUP.Region,
SUP.Country,
SUP.BusinessPartnerPanNumber,
ACI.Reference3IDByBusinessPartner,
ACI.OriginalReferenceDocument,
ACI.Quantity,
ACI.BaseUnit,
ACI.DebitCreditCode

