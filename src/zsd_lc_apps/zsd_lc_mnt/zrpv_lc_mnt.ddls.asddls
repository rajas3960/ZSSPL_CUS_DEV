@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer LC Data Maintanence'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZRPV_LC_MNT
  provider contract transactional_query
  as projection on ZRCV_LC_MNT
{
  key Lcnumber,
      Vfdate,
      Vtdate,
      Lcdate,
      Lcvdate,
      Bankname,
      Bnkbrch,
      Soldto,
      Cusname,
      @Semantics.amount.currencyCode: 'Lccuky'
      Lcamt,
      @Semantics.amount.currencyCode: 'lccuky'
      Lcutamt,
      @Semantics.amount.currencyCode: 'lccuky'
      Lcbcamt,
      Lccuky,
      Status
}
