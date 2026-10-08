@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item Root View Child entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_APP_IRV as select from ZSD_APP_ITB
association to parent ZSD_APP_HRV as _SalesHeader on $projection.Recguid = _SalesHeader.Recguid
{
    key recguid as Recguid,
    key item as Item,
    product as Product,
    @semantics.quantity.unitOfMeasure: 'Requestqntunit'
    requestqnt as Requestqnt,
    requestqntunit as Requestqntunit,
    plnt as Plnt,
    @semantics.amount.currencyCode: 'Curr'
    netamt as Netamt,
    curr as Curr,
    /* Association */ 
    _SalesHeader
}
