@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Item Root View 3'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
  
define view entity ZPP_APPS01_IRV3 as select from zpp_apps01_itb3
association to parent ZPP_APPS01_RV as _hdr on _hdr.Uuid = $projection.Uuid
{
    key uuid as Uuid,
    key orderno as Orderno,
    orderitem as Orderitem,
    plant as Plant,
    matnr as Matnr,
    maktx as Maktx,
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
    soitem as Soitem,
    rsnum as Rsnum,
    operation as Operation,
    secon  as Secon,
    _hdr
}
