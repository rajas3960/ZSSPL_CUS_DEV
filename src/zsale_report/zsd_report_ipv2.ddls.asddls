@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sale Report For Mark Number'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZSD_REPORT_IPV2 as projection on ZSD_REPORT_IRV2 as item1
{
    key SalesDocument,
    key BillOfMaterial,
    key Material,
    key MainItemPricingRefProduct,
    @Semantics.quantity.unitOfMeasure: 'RequestedQuantityUnit'
    RequestedQuantity,
    RequestedQuantityUnit,
    Totalwt,
    @Semantics.quantity.unitOfMeasure: 'UOM'
    YY1_LENGTH_MM_PRD,
    @Semantics.quantity.unitOfMeasure: 'wuom'
    YY1_UNIT_WGT_PRD,
    @Semantics.quantity.unitOfMeasure: 'UOM'
    YY1_WIDTH_MM_PRD,
    @Semantics.quantity.unitOfMeasure: 'wuom'
    YY1_WGT_PC_PRD,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    NetPriceAmount,
    TransactionCurrency,
    wuom,
    UOM,
    ProductName,
    /* Associations */
    item :redirected to parent ZSD_REP_IPV,
     _hdr: redirected to ZSD_REP_PV   
}
