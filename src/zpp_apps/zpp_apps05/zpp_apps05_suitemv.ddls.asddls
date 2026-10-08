@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Subitem View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_SUITEMV as select from zpp_apps05_itb2p
association to parent ZPP_APPS05_ITMS as _hdr on _hdr.Vrno = $projection.Vrno and _hdr.Jobsht = $projection.Jobsht
composition[1..*] of ZPP_APPS05_OPITMC as _item
{
key  vrno as Vrno,
    key jobsht as Jobsht,
  key sno as Sno,
   uuid as Uuid,
  orderno as Orderno,
  plant as Plant,
  matnr as Matnr,
  maktx as Maktx,
  @Semantics.quantity.unitOfMeasure: 'Uom'
  plnqty as Plnqty,
  @Semantics.quantity.unitOfMeasure: 'Uom'
  reqty as Reqty,
  uom as Uom,
  vbeln as Vbeln,
  length as Length,
  width as Width,
  wetpc as Wetpc,
  netwt as Netwt,
  operation as Operation,
  _hdr,
  _item
}
