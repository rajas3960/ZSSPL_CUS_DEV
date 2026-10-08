@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item Data Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@UI.presentationVariant: [{ sortOrder: [{by: 'MainItemPricingRefProduct' , direction: #ASC}] }]
@ObjectModel.supportedCapabilities: [ #OUTPUT_FORM_DATA_PROVIDER ]
define view entity ZSD_REP_IPV as projection on ZSD_REPORT
{
 key SalesDocument,
 key BillOfMaterial,
 key MainItemPricingRefProduct,
 SalesDocumentItemText,
 ConsumptionTaxCtrlCode,
 TransactionCurrency,
 RequestedQuantityUnit,
 @Semantics.quantity.unitOfMeasure: 'RequestedQuantityUnit'
 RequestedQuantity,
 CGSTRate,
 CGSTValue,
 SGSTRate,
 SGSTValue,
 IGSTRate,
 IGSTValue,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
 zpr1rate,
 TotalWeight,
 TotalPrice,

    /* Associations */
    
    _hdr :  redirected to parent ZSD_REP_PV,
    Item1 : redirected to composition child ZSD_REPORT_IPV2
}
