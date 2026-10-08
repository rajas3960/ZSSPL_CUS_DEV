@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header Material and Component'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zmm_challan_HC as select from zmm_challan_m101 as mdi 
left outer join zmm_material_cov as mds on mds.MaterialDocument = mdi.MaterialDocument
{
    key mdi.MaterialDocumentYear,
    key mdi.MaterialDocument,
    key mdi.MaterialDocumentItem,
    mds.Material,
    mds.Plant,
    mdi.StorageLocation,
    mdi.StorageType,
    mdi.StorageBin,
    mds.Batch,
    mdi.ShelfLifeExpirationDate,
    mdi.ManufactureDate,
    mdi.Supplier,
    mdi.SalesOrder,
    mdi.SalesOrderItem,
    mdi.SalesOrderScheduleLine,
    mdi.WBSElementInternalID,
    mdi.Customer,
    mdi.InventorySpecialStockType,
    mdi.InventoryStockType,
    mdi.StockOwner,
    mdi.GoodsMovementType,
    mdi.DebitCreditCode,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    mdi.QuantityInBaseUnit,
    mdi.MaterialBaseUnit,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    mdi.TotalGoodsMvtAmtInCCCrcy,
    mdi.CompanyCodeCurrency,
    mdi.PurchaseOrder,
    mdi.PurchaseOrderItem,

    
  
 @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    mds.QuantityInBaseUnit as qses
    
}
