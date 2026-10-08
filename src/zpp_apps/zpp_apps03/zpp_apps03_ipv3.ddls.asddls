@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Planning And Production - Length And quantity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS03_IPV3 as projection on ZPP_APPS03_IRV3
{
    key Uuid,
    key Length,
    Quantity,
    _hdr : redirected to  parent ZPP_APPS03_PV
}
