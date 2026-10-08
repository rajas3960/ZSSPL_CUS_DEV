@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Challan Wise Report Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: {
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_CHALLAN_RV
  as select from ZMM_CHALLAN_GV
  {
  key PurchaseOrder,
  key PurchaseOrderItem,
  key PurchaseOrderScheduleLine,
  key ReservationItem,
  key MOMENT101,
  key imaterial,
  key MaterialDocumentYear,
  hmaterial,
  hqom,
  @Semantics.quantity.unitOfMeasure: 'qom'
  hquantity,
  qom,
  @Semantics.quantity.unitOfMeasure: 'qom'
  iquantity,
  @Semantics.quantity.unitOfMeasure: 'UOMB'
  BILLQYT,
  UOMB,
  MaterialDocument,
    @Semantics.quantity.unitOfMeasure: 'UOMB'
  BillingQuantity,
  BillingDocument,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  NetAmount,
  BillingQuantityUnit,
  TransactionCurrency,
   @Semantics.quantity.unitOfMeasure: 'MOMENTU101'
  MOMENTB101,
  MOMENTU101,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  TotalGoodsMvtAmtInCCCrcy,
  CompanyCodeCurrency,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  moment543,
  MaterialBaseUnit,
  MaterialGroup,
  blance1,
  blance2,
   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  MOMENT543O,
  cast(blance2 - cast(MOMENT543O as abap.dec(15,3)) as abap.dec(15,3) )   as totbalc,
  Supplier,
  Supplier_Name,
  Plant,
  Batch
  }
