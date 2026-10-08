@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order App Item Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APP03_IRV1
  as select from zpp_app03_itb1
  association to parent ZPP_APP03_RV1 as _hdr on _hdr.Jobshtnum = $projection.Jobshtnum and _hdr.Werks = $projection.Plant
{
  key jobshtnum as Jobshtnum,
  key orderno   as Orderno,
    orderitem    as Orderitem,
      plant     as Plant,
      matnr     as Matnr,
      maktx     as Maktx,
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
  soitem        as Soitem,
       rsnum as  Rsnum,
      @Semantics.user.createdBy: true
      createdby as Createdby,
      @Semantics.systemDateTime.createdAt: true
      createdon as Createdon,
      _hdr
}
