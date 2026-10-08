@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Report Projection View Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root  view entity ZPP_STOCK_PV provider contract transactional_query as projection on ZPP_STOCK_RV
{
    key MaterialDocumentYear,
    key MaterialDocument,
    key MaterialDocumentItem,
    key PurchaseOrder,
    key PurchaseOrderItem,
    key Product,
    key Plant,
    key StorageLocation,
    key Batch,
    key Currency,
    key InventoryStockType,
key InventorySpecialStockType,
    PostingDate,
    YY1_Length_No_MMI,
    YY1_WidthNo_MMI,
    YY1_Pieces_No_MMI,
    YY1_PriorityPONO_PDH,
    @Semantics.quantity.unitOfMeasure: 'YY1_UNIT_WGT_PRDU'
     YY1_UNIT_WGT_PRD,
     YY1_UNIT_WGT_PRDU,
    IRNno,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    QuantityInBaseUnit,
     @Semantics.quantity.unitOfMeasure: 'EntryUnit'
    QuantityInEntryUnit,
    MaterialBaseUnit,
    EntryUnit,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
MatlWrhsStkQtyInMatlBaseUnit,
ProductName,
MaterialGroup,
DocumentDate,
totqty,
totlent,
balance,
length,
width,
pcs ,
DeliveryDocument,
   DeliveryDocumentItem   
}
