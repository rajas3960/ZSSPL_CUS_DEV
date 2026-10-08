@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Moment type 101'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zmm_challan_m101 as select from I_MaterialDocumentItem_2 

{
    key MaterialDocumentYear,
    key max(MaterialDocument) as MaterialDocument,
    key max(MaterialDocumentItem) as MaterialDocumentItem,
    Material,
    Plant,
    StorageLocation,
    StorageType,
    StorageBin,
    Batch,
    ShelfLifeExpirationDate,
    ManufactureDate,
    Supplier,
    SalesOrder,
    SalesOrderItem,
    SalesOrderScheduleLine,
    WBSElementInternalID,
    Customer,
    InventorySpecialStockType,
    InventoryStockType,
    StockOwner,
    GoodsMovementType,
    DebitCreditCode,
     @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(QuantityInBaseUnit) as QuantityInBaseUnit,
     MaterialBaseUnit ,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(TotalGoodsMvtAmtInCCCrcy) as TotalGoodsMvtAmtInCCCrcy  ,
     CompanyCodeCurrency,
     PurchaseOrder,
     PurchaseOrderItem
    
} where GoodsMovementType = '101'
group by 
MaterialDocumentYear,
MaterialDocumentItem,
Material,
    Plant,
    StorageLocation,
    StorageType,
    StorageBin,
    Batch,
    ShelfLifeExpirationDate,
    ManufactureDate,
    Supplier,
    SalesOrder,
    SalesOrderItem,
    SalesOrderScheduleLine,
    WBSElementInternalID,
    Customer,
    InventorySpecialStockType,
    InventoryStockType,
    StockOwner,
    GoodsMovementType,
    DebitCreditCode,
    MaterialBaseUnit ,
//     TotalGoodsMvtAmtInCCCrcy ,
     CompanyCodeCurrency,
     PurchaseOrder,
     PurchaseOrderItem

