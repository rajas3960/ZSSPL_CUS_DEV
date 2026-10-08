@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Item Projection For Stocks'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS02_IPV4 as projection on ZPP_APPS02_IRV4
{
    key Uuid,
    key Sno,
    Length,
    Quantity,
    /* Associations */
    _hdr : redirected to parent ZPP_APPS02_PV
}
