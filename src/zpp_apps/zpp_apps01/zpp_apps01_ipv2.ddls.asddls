@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Child Item Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS01_IPV2 as projection on ZPP_APPS01_IRV2
{
    key Uuid,
    key Orderno,
    key Sno,
    key Sno1,
    Matnr,
    Maktx,
    @Semantics.quantity.unitOfMeasure: 'Comuom'
    Comqty,
    Comuom,
       @Semantics.quantity.unitOfMeasure: 'Baseuom'
    Baseqty,
    Baseuom,
    /* Associations */
    _hdr : redirected to ZPP_APPS01_pv,
    _item : redirected to parent ZPP_APPS01_iPV1
}
