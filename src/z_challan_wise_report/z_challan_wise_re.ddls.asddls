
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CHALLAN_WISE_REPORT RE'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z_CHALLAN_WISE_RE 
as select from I_PurchaseOrderAPI01               as POH
inner join I_PurchaseOrderItemAPI01               as POI        on   POI.PurchaseOrder = POH.PurchaseOrder
//left outer join I_GoodsMovementCube               as GOOD       on   GOOD.PurchaseOrder = POI.PurchaseOrder
 //                                                               and  GOOD.PurchaseOrderItem = POI.PurchaseOrderItem
 //                                                               and  GOOD.MaterialDocumentItem ='0001'
//inner join I_BillingDocumentItem             as BILL            on   BILL.CreatedByUser = POH.CreatedByUser  
                                                               // and  BILL.BillingDocumentItem ='000002'
                                                               // and  BILL.BillingDocumentItem ='000004'
left outer join I_MaterialDocumentItem_2               as MDII       on   MDII.PurchaseOrder = POI.PurchaseOrder  
                                                                      and  MDII.PurchaseOrderItem = POI.PurchaseOrderItem
{
  key MDII.PurchaseOrder     as PONumber,
  key MDII.Material          as Item,
  @Semantics.quantity.unitOfMeasure:    'GRUnit'
   MDII.QuantityInBaseUnit as POQty,
  POI.BaseUnit                  as GRUnit,
  MDII.MaterialDocument      as DocNo
 // BILL.BillingDocument       as ChallanNo
}
