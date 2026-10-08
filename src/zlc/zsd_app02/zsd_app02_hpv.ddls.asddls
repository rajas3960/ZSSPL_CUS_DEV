@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order LC Utilization Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_APP02_HPV provider contract transactional_query as projection on ZSD_APP02_HRV
{
    key SalesDocument,
    SoldToParty,
    SalesDocumentDate,
    PurchaseOrderByCustomer,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    TotalNetAmount,
     @Semantics.amount.currencyCode: 'TransactionCurrency'
    TaxAmount1,
    TransactionCurrency,
    IncotermsClassification,
        CreatedByUser,
    CreationDate,
    LastChangedByUser,
    LastChangeDateTime,
    /* Associations */
    _litem :redirected to composition child ZSD_APP02_IPV
}
