@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Manufacturing Order Item View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_Orderitem_Rv as select from I_ManufacturingOrderItem as _hdr

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
    _hdr._Product.ProductType as ProductType,
    _hdr.CompanyCode,
    _hdr.ManufacturingOrderType,
    _hdr._Product._Text.ProductName,
    _hdr._Batch.Batch,
    _hdr.StorageLocation
    
    
    
    
} where _hdr.OrderIsReleased <> 'X' and _hdr._Product.ProductType = 'HALB'
