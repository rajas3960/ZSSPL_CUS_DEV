@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Item Order Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZSD_APP2_IRV as select from I_SalesDocumentItem
{
    key SalesDocument,
    key SalesDocumentItem,
    Material,
    Product,
    Batch,
    @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    OrderQuantity,
    OrderQuantityUnit,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    NetPriceAmount,
    TransactionCurrency
}
