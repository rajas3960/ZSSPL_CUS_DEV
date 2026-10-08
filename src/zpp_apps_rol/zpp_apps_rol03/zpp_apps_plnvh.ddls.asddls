@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Planning refernce View'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS_PLNVH as select from ZPP_APPS_ROL01_RV1 as _std
left outer join ZPP_APPSR_IRV2T as _cus on _cus.Purchaseorder = _std.PurchaseOrder and _cus.Purchaseitm = _std.PurchaseOrderItem  
left outer join I_PlannedOrder as _pln on _pln.PlannedOrder = _cus.Plannedorder
left outer join I_ManufacturingOrder as moi on moi.PlannedOrder = _cus.Plannedorder  and moi.IsMarkedForDeletion <> 'X'


{

    key _std.PurchaseOrder,
    key _std.PurchaseOrderItem,
    key moi.ManufacturingOrder as mod,
    _std.YY1_PriorityPONO_PDH,
    _std.SupplyingPlant,
    _std.Plant,
    _std.YY1_Length_PDI,
    _std.YY1_Width_PDI,
    _std.YY1_Pieces_PDI,
    @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
    _std.OrderQuantity,
    _std.PurchaseOrderQuantityUnit,
    _std.Material,
    _std.PurchaseOrderItemText,
    _std.SchedLineStscDeliveryDate,
    _cus.Mark as Mark,
    _cus.Plannedorder as Plannedorder,
    case 
     when _pln.PlannedOrder is not initial
     then 'P'
     when moi.PlannedOrder is not initial
     then 'P'
     else 
     ' ' end as Mark2,
     @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
     case 
     when $projection.Mark2 = 'P'
     then 
     _std.OrderQuantity
     else 
      null end as plqty,
      
      case 
     when $projection.Mark2 = 'P'
     then 
     _cus.Plannedorder
     else null end as Plndorder,
           case 
     when $projection.Mark2 = 'P'
     then 
     moi.ManufacturingOrder
     else null end as manufat
     
     
     
} 
