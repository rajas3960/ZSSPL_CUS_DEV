@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Planning Root View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPP_APPS_ROL01_RV as select distinct from ZPP_APPS_PRV
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
Plannedorder as Plndord,
Mark2,
@Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
plqty as menge,
Plndorder as Plannedorder
}
