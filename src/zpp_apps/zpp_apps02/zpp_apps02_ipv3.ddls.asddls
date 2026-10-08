@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Item Projection View Len'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS02_IPV3 as projection on ZPP_APPS02_IRV3
{
    key Uuid,
    key sno,
     Length,
    Quantity,
    _hdr : redirected to parent ZPP_APPS02_PV
}
