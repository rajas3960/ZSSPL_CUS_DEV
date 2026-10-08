@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Item cov'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zmm_material_cov as select from  I_MaterialDocumentItem_2 as mdi 
inner join I_MaterialDocumentHeader_2 as MDH on MDH.MaterialDocument = mdi.MaterialDocument
 
{

  key mdi.MaterialDocumentYear,
  key max(mdi.MaterialDocument ) as MaterialDocument,
  key max(mdi.MaterialDocumentItem) as MaterialDocumentItem  ,
  mdi.Material,
  mdi.Plant,
  mdi.StorageLocation,
  mdi.StorageType,
  mdi.StorageBin,
  mdi.Batch,
  mdi.GoodsMovementType,
  mdi.PurchaseOrder,
  mdi.PurchaseOrderItem,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  sum(mdi.QuantityInBaseUnit) as QuantityInBaseUnit,
  mdi.MaterialBaseUnit
  
  
} where mdi.GoodsMovementType = '543' and MDH.InventoryTransactionType = 'WE'
group by 
mdi.MaterialDocumentYear,
mdi.MaterialDocumentItem,
 mdi.Material,
  mdi.Plant,
  mdi.StorageLocation,
  mdi.StorageType,
  mdi.StorageBin,
  mdi.Batch,
  mdi.GoodsMovementType,
  mdi.PurchaseOrder,
  mdi.PurchaseOrderItem,
mdi.MaterialBaseUnit
