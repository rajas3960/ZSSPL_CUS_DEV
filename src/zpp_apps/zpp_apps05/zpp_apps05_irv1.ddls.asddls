@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Projection Item View pMark'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_IRV1
  as select from zpp_apps05_itb
  association to parent ZPP_APPS05_RV as _hdr on _hdr.Uuid = $projection.Uuid
{
  key uuid      as Uuid,
  key orderno   as Orderno,
      orderitem as Orderitem,
      plant     as Plant,
      matnr     as Matnr,
      maktx     as Maktx,
      length    as Length,
      width     as Width,
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
      secon     as Secon,
      netwt     as Netwt,
      _hdr
} 
