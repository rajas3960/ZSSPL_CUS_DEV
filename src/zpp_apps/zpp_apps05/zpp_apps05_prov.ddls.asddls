@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order - view entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_PROV as select from ZPP_RP01_RV as _sec
left outer join ZPP_APPS05_ORV as _ord on _ord.Material = _sec.Material
left outer join I_SalesDocumentItem as soi on soi.SalesDocument = _ord.SalesOrder and soi.SalesDocumentItem = _ord.SalesOrderItem
{
key _ord.ManufacturingOrder,
key _ord.ManufacturingOrderItem,
key _sec.BillOfMaterialCategory,
key _sec.BillOfMaterialItemNodeNumber,
key _sec.BOMItemInternalChangeCount,
key _sec.BOM,
key _sec.BillOfMaterialVariant,
key _sec.Material,
key _sec.Plant,
key _sec.BillOfMaterialVariantUsage,
_ord.OrderIsReleased,
_ord.IsMarkedForDeletion,
//_ord.Material,
_ord.ProductionPlant,
_ord.SalesOrder,
_ord.SalesOrderItem,
@Semantics.quantity.unitOfMeasure: 'ProductionUnit'
_ord.MfgOrderItemPlannedTotalQty,
_ord.ProductionUnit,
_ord.ProductType,
_ord.CompanyCode,
_ord.ManufacturingOrderType,
_ord.ProductName,
_ord.Batch,
_ord.StorageLocation,
_ord.Reservation,
_sec.BillOfMaterialComponent,
_sec.BillOfMaterialItemCategory,
_sec.BillOfMaterialItemUnit,
@Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
_sec.BillOfMaterialItemQuantity,
_sec.IsSubItem,
_sec.BOMItemSorter,
@Semantics.quantity.unitOfMeasure: 'YY1_LENGTH_MM_PRDU'
_sec.YY1_LENGTH_MM_PRD,

_sec.YY1_LENGTH_MM_PRDU,
@Semantics.quantity.unitOfMeasure: 'YY1_UNIT_WGT_PRDU'
_sec.YY1_UNIT_WGT_PRD,
_sec.YY1_UNIT_WGT_PRDU,
@Semantics.quantity.unitOfMeasure: 'YY1_WGT_PC_PRDU'
_sec.YY1_WGT_PC_PRD,
_sec.YY1_WGT_PC_PRDU,
@Semantics.quantity.unitOfMeasure: 'YY1_WIDTH_MM_PRDU'
_sec.YY1_WIDTH_MM_PRD,
_sec.YY1_WIDTH_MM_PRDU,
soi.MainItemPricingRefProduct,
soi._SalesDocument.YY1_PriorityPONos_SDH




    
} where _ord.ManufacturingOrder is not initial and ( _sec.BillOfMaterialVariant = _ord.BillOfMaterialVariant )
