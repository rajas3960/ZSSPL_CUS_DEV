@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order Item 2 RV'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APP06_IRV2
  as select from zpp_app03_itb2 as itb2
  inner join zpp_app03_tb1 as tb1 on tb1.jobshtnum = itb2.jobsheet and tb1.werks = itb2.plant
  association to parent ZPP_APP06_RV1 as _hdr on _hdr.Jobshtnum = $projection.Jobsheet and _hdr.Werks = $projection.Plant
{
  key itb2.jobsheet  as Jobsheet,
  key itb2.sno       as Sno,
  key itb2.orderno   as Orderno,
      itb2.matnr     as Matnr,
      itb2.maktx     as Maktx,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      itb2.plndqty   as Plndqty,
      itb2.uom       as Uom,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      itb2.reqty     as Reqty,
      @Semantics.user.createdBy: true
      itb2.createdby as Createdby,
      @Semantics.systemDateTime.createdAt: true
      itb2.createdon as Createdon,
      itb2.plant as Plant,
      _hdr
} where tb1.status = 'C' and tb1.delmark <> 'X'
