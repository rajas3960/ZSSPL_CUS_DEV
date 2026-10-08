@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Planning Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPP_APPS_ROL01_PV provider contract transactional_query as projection on ZPP_APPS_ROL01_RV
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
Plannedorder,
@Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
  menge
//  meins
}
