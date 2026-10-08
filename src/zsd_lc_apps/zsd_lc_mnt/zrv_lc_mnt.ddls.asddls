@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer LC Data Maintanence'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZRV_LC_MNT
  as select from ztb1_lc_mnt_h
{
  key lcnumber as Lcnumber,
      vfdate   as Vfdate,
      vtdate   as Vtdate,
      lcdate   as Lcdate,
      lcvdate  as Lcvdate,
      bankname as Bankname,
      bnkbrch  as Bnkbrch,
      soldto   as Soldto,
      cusname  as Cusname,
      @Semantics.amount.currencyCode: 'lccuky'
      lcamt    as Lcamt,
      @Semantics.amount.currencyCode: 'lccuky'
      lcutamt  as Lcutamt,
      @Semantics.amount.currencyCode: 'lccuky'
      lcbcamt  as Lcbcamt,
      lccuky   as Lccuky,
      status   as Status
}
