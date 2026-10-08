@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Item View Entity 2 PendMar'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}


define view entity ZPP_APPS05_IRV2 as select from zpp_apps05_itb2
association to parent ZPP_APPS05_RV as _hdr  on _hdr.Uuid = $projection.Uuid
{
    key uuid as Uuid,
    key sno as Sno,
    orderno as Orderno,
    vrno as Vrno,
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
      jobsht  as   Jobsht,
  operation  as    Operation,
  resv      as Resv,
    _hdr
}
