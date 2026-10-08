@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'material item conve'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_MATERIAL_CONV as select from I_MaterialDocumentItem_2 
{
    key MaterialDocumentYear,
    key max(MaterialDocument ) as MaterialDocument,
    key min(MaterialDocumentItem) as MaterialDocumentItem ,
    Material,
    Plant,
    StorageLocation,
    StorageType,
    StorageBin,
    Batch,
    IsAutomaticallyCreated,
    max(substring(MaterialDocumentParentLine,3,5)) as MaterialDocumentParentLine_Adj, 
    PurchaseOrder,
    PurchaseOrderItem,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum(QuantityInBaseUnit) as QuantityInBaseUnit,
    MaterialBaseUnit,
    InventorySpecialStockType,
    GoodsMovementType
    
} where GoodsMovementType = '541' and InventorySpecialStockType = 'O' and GoodsMovementIsCancelled is initial
group by 
 MaterialDocumentYear,
//     MaterialDocument,
//     MaterialDocumentItem,
    Material,
    Plant,
    StorageLocation,
    StorageType,
    StorageBin,
    Batch,
    IsAutomaticallyCreated,
//    MaterialDocumentParentLine,
    PurchaseOrder,
    PurchaseOrderItem,
//    QuantityInBaseUnit,
    MaterialBaseUnit,
    InventorySpecialStockType,
    GoodsMovementType

