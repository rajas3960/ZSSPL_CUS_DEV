@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Planning refernce View N'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS_PRV as select from ZPP_APPS_PLNVH
{
   key PurchaseOrder,
   key PurchaseOrderItem,
   key mod,
   YY1_PriorityPONO_PDH,
   SupplyingPlant,
   Plant,
   YY1_Length_PDI,
   YY1_Width_PDI,
   YY1_Pieces_PDI,
   @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
   OrderQuantity,
   PurchaseOrderQuantityUnit,
   Material,
   PurchaseOrderItemText,
   SchedLineStscDeliveryDate,
   Mark,
   Plannedorder,
   Mark2,
    @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
   plqty,
   Plndorder
}
