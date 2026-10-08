@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Projection Parts View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_IPV7 as projection on ZPP_APPS05_IRV7
{
    key Uuid,
    key Srcid,
    key Parid,
    Vrno,
    Marno,
    Length,
    Process,
    Pcs,
    Balpcs,
    Orderno,
    Totqty,
    Atotqty,
    Lentqty,
    /* Associations */
    _hdr : redirected to ZPP_APPS05_PV ,
    _itemrsult : redirected to parent ZPP_APPS05_IPV6
}
