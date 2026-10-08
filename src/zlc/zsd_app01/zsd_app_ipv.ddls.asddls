@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item Projection View Child Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZSD_APP_IPV as projection on ZSD_APP_IRV
{
    key Recguid,
    key Item,
    Product,
     @Semantics.quantity.unitOfMeasure: 'Requestqntunit'
    Requestqnt,
    Requestqntunit,
    Plnt,
    @Semantics.amount.currencyCode: 'Curr'
    Netamt,
    Curr,
    /* Associations */
    _SalesHeader : redirected to parent ZSD_APP_HPV
}
