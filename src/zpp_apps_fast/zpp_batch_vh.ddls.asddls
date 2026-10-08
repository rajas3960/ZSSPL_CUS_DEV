@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help for Batch'
@Metadata.ignorePropagatedAnnotations: true
define view entity zpp_batch_vh as select from I_Product as Pod
left outer join I_MaterialDocumentItem_2 as matdocitem on matdocitem.Material = Pod.Product
                                                       and matdocitem.Plant = '1040'
                                                       and matdocitem.GoodsMovementType = '105'
                                                       and matdocitem.MaterialDocument is not initial
                                                       and matdocitem.Batch is not initial
{
    key Pod.Product as matnr,
    key matdocitem.MaterialDocument as mat,
    key matdocitem.Batch,
//    key matdocitem.MaterialDocumentItem,
    @Semantics.quantity.unitOfMeasure: 'uom'
    matdocitem.QuantityInBaseUnit as Totqt,
    matdocitem.MaterialBaseUnit as uom
//    matdocitem.YY1_Length_No_MMI as length
    
}where Pod.ProductGroup = 'WIRE ROD' or Pod.ProductGroup = 'SPR BLACK' or Pod.ProductGroup = 'PCK BLACK'

group by
Pod.Product,
matdocitem.MaterialDocument,
matdocitem.Batch,
matdocitem.QuantityInBaseUnit,
matdocitem.MaterialBaseUnit,
matdocitem.MaterialDocumentItem
//matdocitem.YY1_Length_No_MMI
