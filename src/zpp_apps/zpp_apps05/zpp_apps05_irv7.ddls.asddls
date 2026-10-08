@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Parts View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_IRV7 as select from zpp_apps05_itb7
association to parent ZPP_APPS05_IRV6 as _itemrsult on _itemrsult.Uuid = $projection.Uuid 
and _itemrsult.Srcid = $projection.Srcid
association[1..1] to ZPP_APPS05_RV as _hdr on _hdr.Uuid = $projection.Uuid
{
    key uuid as Uuid,
    key srcid as Srcid,
    key parid as Parid,
    vrno as Vrno,
    marno as Marno,
    length as Length,
    process as Process,
    pcs as Pcs,
    balpcs as Balpcs,
      orderno  as Orderno,
  totqty     as Totqty,
  atotqty    as Atotqty,
  lentqty    as Lentqty,
    _itemrsult,
    _hdr
}
