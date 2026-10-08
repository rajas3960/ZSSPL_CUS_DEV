@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Direct Asset And GL Codes View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_RP01_INGA as select from ZMM_RP01_INV
{
   key CompanyCode,
   key AccountingDocument,
   key FiscalYear,
   key TaxItemGroup,
   DocumentReferenceID,
   InvoiceDate,
   GRpostingDate,
   FiscalYearPeriod,
   PurchasingDocument,
   PurchasingDocumentItem,
   Product,
   AccountingDocumentType,
   GLAccount,
   TaxCode,
   IN_HSNOrSACCode,
   @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
   AmountInCompanyCodeCurrency,
   CompanyCodeCurrency,
   @Semantics.amount.currencyCode: 'TransactionCurrency'
   AmountInTransactionCurrency,
   TransactionCurrency,
   @Semantics.amount.currencyCode: 'TransactionCurrency'
   AmtTransactionCurrency,
   PostingDate,
   @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
   CGST_C,
   @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
   IGST_C,
   @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
   IGST1_C,
   @Semantics.amount.currencyCode: 'TransactionCurrency'
   CGST_T,
   TransactionTypeDetermination,
   @Semantics.amount.currencyCode: 'TransactionCurrency'
   IGST_T,
   @Semantics.amount.currencyCode: 'TransactionCurrency'
   IGST1_T,
   TransactionTypeDeterminationI,
   TransactionTypeDeterminationI1,
   TaxNumber3,
   Supplier,
   SupplierName,
   Region,
   Country,
   BusinessPartnerPanNumber,
   Reference3IDByBusinessPartner,
   OriginalReferenceDocument,
   @Semantics.quantity.unitOfMeasure: 'BaseUnit'
   Quantity,
     @Semantics.quantity.unitOfMeasure: 'BaseUnit'
   QuantityInEntryUnit,
   BaseUnit,
   DebitCreditCode,
   Reference3IDByBusinessItem,
   MasterFixedAsset,
   FixedAsset 
} where (MasterFixedAsset is not initial or Reference3IDByBusinessPartner = ' ') and AccountingDocumentType = 'RE' and PurchasingDocument = '' ;
