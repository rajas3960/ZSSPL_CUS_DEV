@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Report - View Entity For Section Material'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define view entity ZPP_APPS05_STCV as select from ZPP_STOCK_RV
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
    SUPPLNAME
    
    
}
