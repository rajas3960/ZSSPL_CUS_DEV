@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order View Without release'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_ORV as select from I_ManufacturingOrderItem as _hdr
inner join I_ManufacturingOrder as _hd on _hd.ManufacturingOrder = _hdr.ManufacturingOrder
 

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
    _hdr.StorageLocation,
    _hdr.Reservation,
    _hd.BillOfMaterialVariant
} where  _hdr.OrderIsReleased = ' ' and _hd.IsMarkedForDeletion = ' ' and _hdr.IsCompletelyDelivered = ' ' //_hdr._Product.ProductType = 'HALB' and
