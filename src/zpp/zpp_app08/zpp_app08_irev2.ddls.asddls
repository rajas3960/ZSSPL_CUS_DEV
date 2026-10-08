@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'jobsheet production order child entity item2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define  view entity zpp_app08_IREV2 as select from zpp_app08_itb2
association to parent zpp_app08_REV1 as _hdr on _hdr.jobshtno = $projection.Jobsheet
and _hdr.werks = $projection.Plant

{
    key jobsheet as Jobsheet,
    key orderno as Orderno,
    matnr as matnr,
    maktx as maktx,
    @Semantics.quantity.unitOfMeasure: 'uom'
    plnqty as Plnqty,
    uom as Uom,
    @Semantics.quantity.unitOfMeasure: 'uom'
    reqty as Reqty,
    @Semantics.user.createdBy: true
    createdby as Createdby,
    @Semantics.systemDateTime.createdAt: true
    createdon as Createdon,
    plant as Plant,
    _hdr
}
