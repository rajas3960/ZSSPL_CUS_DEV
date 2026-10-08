@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'jobsheet production order child entity view1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zpp_app08_IREV1 as select from zpp_app08_itb1
association to parent zpp_app08_REV1 as _hdr on _hdr.jobshtno = $projection.Jobsheetno 
and _hdr.werks = $projection.plant

{
   key jobsheetno as Jobsheetno,
   key orderno as Orderno,
   plant as plant,
   matnr as matnr,
   maktx as maktx,
   @Semantics.quantity.unitOfMeasure: 'Uom'
   plnqty as Plnqty,
   uom as Uom,
   @Semantics.quantity.unitOfMeasure: 'Uom'
   reqty as Reqty,
   @Semantics.quantity.unitOfMeasure: 'Uom'
   totreqty as Totreqty,
   @Semantics.quantity.unitOfMeasure: 'Uom'
   totopnqty as Totopnqty,
   vbeln as Vbeln,
   rsnum as Rsnum,
   @Semantics.user.createdBy: true
   createdby as Createdby,
   @Semantics.systemDateTime.createdAt: true
   createdon as Createdon,
   _hdr
   
    
}
