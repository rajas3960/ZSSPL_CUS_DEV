@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order App Item RV'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APP06_IRV1
  as select from zpp_app06_itb1 as itb1
    inner join   zpp_app03_tb1  as tb1 on  tb1.jobshtnum = itb1.jobshtnum
                                       and tb1.werks     = itb1.plant
  association to parent ZPP_APP06_RV1 as _hdr on  _hdr.Jobshtnum = $projection.jobshtnum
                                              and _hdr.Werks     = $projection.plant
{
  key itb1.jobshtnum     as jobshtnum,
  key itb1.matnr         as matnr,
      itb1.plant         as plant,
      itb1.maktx         as maktx,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      itb1.totreqty      as totreqty,
      itb1.uom           as uom,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      itb1.receiptqty    as receiptqty,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      itb1.totopnqty     as totopnqty,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      itb1.totreceiptqty as totreceiptqty,
      @Semantics.user.createdBy: true
      itb1.createdby     as createdby,
      @Semantics.systemDateTime.createdAt: true
      itb1.createdon     as createdon,
      _hdr

} where tb1.status = 'C' and tb1.delmark <> 'X'
