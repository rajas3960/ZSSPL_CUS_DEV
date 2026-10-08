@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Child Item Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS01_IRV2 as select from zpp_apps01_itb2
association to parent ZPP_APPS01_IRV1 as _item on _item.Uuid = $projection.Uuid and _item.Orderno = $projection.Orderno and
_item.Sno =  $projection.Sno 
association[1..1] to ZPP_APPS01_RV as _hdr on _hdr.Uuid = $projection.Uuid
{
    key uuid as Uuid,
    key orderno as Orderno,
    key sno as Sno,
    key sno1 as Sno1,
    matnr as Matnr,
    maktx as Maktx,
    @Semantics.quantity.unitOfMeasure: 'Comuom'
    comqty as Comqty,
    comuom as Comuom,
    @Semantics.quantity.unitOfMeasure: 'Baseuom'
    baseqty as Baseqty,
    baseuom as Baseuom,
    _item,
    _hdr
}
