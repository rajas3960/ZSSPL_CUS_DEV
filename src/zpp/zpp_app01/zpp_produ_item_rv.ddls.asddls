@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Item Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_PRODU_ITEM_RV as select from I_ManufacturingOrderItem as _hdr
//inner join I_ManufacturingOrderComponent as _cop on _cop.ManufacturingOrder = _hdr.ManufacturingOrder

{
    key _hdr.ManufacturingOrder,
    key _hdr.ManufacturingOrderItem,
    _hdr.OrderIsReleased,
    _hdr.IsMarkedForDeletion,
    _hdr.Material,
    _hdr.ProductionPlant,

    _hdr.SalesOrder,
    _hdr.SalesOrderItem,
    @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
    _hdr.MfgOrderItemPlannedTotalQty,
    _hdr.ProductionUnit,
    _hdr._Product.ProductType as ProductType
    
    
    
} where _hdr.OrderIsReleased <> 'X' and _hdr._Product.ProductType = 'HALB'
