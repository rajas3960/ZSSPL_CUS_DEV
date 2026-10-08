@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Projection Item View Length'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_IPV3 as projection on ZPP_APPS05_IRV3
{
    key Uuid,
    key Length,
    Quantity,
    /* Associations */
    _hdr : redirected to parent ZPP_APPS05_PV
}
