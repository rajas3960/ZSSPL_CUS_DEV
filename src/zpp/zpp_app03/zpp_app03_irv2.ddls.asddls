@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order App Child Entity Item 2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APP03_IRV2
  as select from zpp_app03_itb2
  association to parent ZPP_APP03_RV1 as _hdr on _hdr.Jobshtnum = $projection.Jobsheet and _hdr.Werks = $projection.Plant
{
  key jobsheet  as Jobsheet,
  key sno       as Sno,
  key orderno   as Orderno,
  orderitem    as Orderitem,
  resev        as Resev,
      matnr     as Matnr,
      maktx     as Maktx,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      plndqty   as Plndqty,
      uom       as Uom,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      reqty     as Reqty,
      vbeln     as Vbeln,
      soitem    as Soitem,
      @Semantics.user.createdBy: true
      createdby as Createdby,
      @Semantics.systemDateTime.createdAt: true
      createdon as Createdon,
      plant as Plant,
      _hdr
}
