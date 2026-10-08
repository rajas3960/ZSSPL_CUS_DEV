@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Item View Comp'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS02_IRV
  as select from zpp_apps02_itb1
  association to parent ZPP_APPS02_RV as _hdr on _hdr.Uuid = $projection.Uuid
{
  key uuid      as Uuid,
  key orderno   as Orderno,
      orderitem as Orderitem,
      plant     as Plant,
      matnr     as Matnr,
      maktx     as Maktx,
      length    as Length,
      width     as Width,
      smatnr    as Smatnr,
      netwt     as Netwt,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      plnqty    as Plnqty,
      uom       as Uom,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      reqty     as Reqty,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      totreqty  as Totreqty,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      totopnqty as Totopnqty,
      vbeln     as Vbeln,
      soitem    as Soitem,
      rsnum     as Rsnum,
      operation as Operation,
      _hdr
}
