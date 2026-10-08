@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Summary S L View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_IRV8 as select from zpp_apps05_itb8
association to parent ZPP_APPS05_RV as _hdr on _hdr.Uuid = $projection.Uuid
{
    key uuid as Uuid,
    key sno as Sno,
    vrno as Vrno,
    length as Length,
    width as width,
    apcs as Apcs,
    used as Used,
    rqty as Rqty,
    uqty as Uqty,
    wasper as Wasper,
    rtrn as Rtrn,
    netwst as Netwst,
    quanwt as Quanwt,
    irno as Irno,
     matnr  as Matnr,
  batch     as Batch,      
  plant     as Plant,
  storagelocation as Storagelocation,
  matnoitno       as Matnoitno,
    _hdr
}
