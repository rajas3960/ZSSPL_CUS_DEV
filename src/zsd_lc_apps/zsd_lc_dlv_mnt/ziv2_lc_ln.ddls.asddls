@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Delivery Creation - Child Entity2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZIV2_LC_LN
  as select from ztb3_lc_ln
{
  key recguid  as Recguid,
  key sonum    as Sonum,
  key soldto   as Soldto,
  key lcnumber as Lcnumber,
      vfdate   as Vfdate,
      vtdate   as Vtdate,
      lcdate   as Lcdate,
      lcvdate  as Lcvdate,
      bankname as Bankname,
      bnkbrch  as Bnkbrch,
      @Semantics.amount.currencyCode: 'Lccuky'
      lcamt    as Lcamt,
      @Semantics.amount.currencyCode: 'Lccuky'
      lcutamt  as Lcutamt,
      @Semantics.amount.currencyCode: 'Lccuky'
      lcbcamt  as Lcbcamt,
      @Semantics.amount.currencyCode: 'Lccuky'
      lcselamt as Lcselamt,
      lccuky   as Lccuky,
      status   as Status,
      mark     as Mark
}
