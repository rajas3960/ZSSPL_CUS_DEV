@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Challan wise Report - Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APP_RV as select from I_PurchaseOrderAPI01 as POH
inner join I_PurchaseOrderItemAPI01 as POI on POI.PurchaseOrder =  POH.PurchaseOrder
{
    key POI.PurchaseOrder,
    key POI.PurchaseOrderItem,
    POI.Material                                                       as hmaterial,
      POI.BaseUnit                                                       as hqom,
      @Semantics.quantity.unitOfMeasure: 'hqom'
      POI.OrderQuantity  
}
