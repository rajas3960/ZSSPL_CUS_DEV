@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Challan Wise Report Projection View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZMM_CHALLAN_PV provider contract transactional_query as projection on ZMM_CHALLAN_RV
{
    key PurchaseOrder,
    key PurchaseOrderItem,
     key PurchaseOrderScheduleLine,
  key ReservationItem,
//    key ReservationItem,
    key  MOMENT101,
//    key MaterialDocumentItem,
key imaterial,
  key MaterialDocumentYear,
//    key mdiitem,
     hmaterial,
     
    hqom,
    @Semantics.quantity.unitOfMeasure: 'hqom'
    hquantity,
    
    qom,
    @Semantics.quantity.unitOfMeasure: 'qom'
    iquantity,
    @Semantics.quantity.unitOfMeasure: 'qom'
    BILLQYT,
    UOMB,
    MaterialDocument,
     @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      BillingQuantity,
      BillingDocument,
//      BillingDocumentItem,
       @Semantics.amount.currencyCode: 'TransactionCurrency'
      NetAmount,
      BillingQuantityUnit,
      TransactionCurrency,
//      MOMENT101,
      @Semantics.quantity.unitOfMeasure: 'MOMENTU101'
 MOMENTB101,
       MOMENTU101,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      TotalGoodsMvtAmtInCCCrcy ,
     CompanyCodeCurrency,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      moment543,
      MaterialBaseUnit,
      blance1,
      blance2,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      MOMENT543O,
      MaterialGroup,
      totbalc,
      Supplier_Name,
      Supplier,
      Plant,
      Batch
//      process_loss
      
}
