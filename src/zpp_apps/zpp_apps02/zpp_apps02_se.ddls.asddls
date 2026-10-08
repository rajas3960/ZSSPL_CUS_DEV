@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Section and Sales order connection'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS02_SE as select from ZPP_RP01_RV as _hdr
left outer join I_SalesOrderItem as _sdi on _sdi.Material = _hdr.Material
left outer join I_ProductDescription as pd on pd.Product = _hdr.Material
left outer join I_PlannedOrder as _PLD on _PLD.SalesOrder = _sdi.SalesOrder and _PLD.SalesOrderItem = _sdi.SalesOrderItem

{
    key _sdi.SalesOrder,
    key _sdi.SalesOrderItem,
    key _hdr.BillOfMaterialCategory,
    key _hdr.BillOfMaterialItemNodeNumber,
    key _hdr.BOMItemInternalChangeCount,
    key _hdr.BOM,
    key _hdr.BillOfMaterialVariant,
    key _hdr.Material,
    key _hdr.Plant,
    key _hdr.BillOfMaterialVariantUsage,
    _hdr.BillOfMaterialComponent,
      @Semantics.quantity.unitOfMeasure: 'YY1_LENGTH_MM_PRDU'
    _sdi._Product.YY1_LENGTH_MM_PRD,
     _sdi._Product.YY1_LENGTH_MM_PRDU,
    @Semantics.quantity.unitOfMeasure: 'YY1_WIDTH_MM_PRDU'
    _sdi._Product.YY1_WIDTH_MM_PRD,
    _sdi._Product.YY1_WIDTH_MM_PRDU,
     @Semantics.quantity.unitOfMeasure: 'YY1_UNIT_WGT_PRDU'
    _sdi._Product.YY1_WGT_PC_PRD,
    _sdi._Product.YY1_UNIT_WGT_PRDU,
    @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    _sdi.OrderQuantity,
    _PLD.PlannedOrder,
    _sdi.OrderQuantityUnit,
    pd.ProductDescription
    
    
 
}
