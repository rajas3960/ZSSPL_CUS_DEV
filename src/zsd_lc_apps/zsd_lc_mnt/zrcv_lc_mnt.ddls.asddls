@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer LC Data Maintanence'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define root view entity ZRCV_LC_MNT
  as select from ZRV_LC_MNT
{
      @EndUserText.label: 'LC Number'
  key Lcnumber,
      Vfdate,
      Vtdate,
      Lcdate,
      Lcvdate,
      Bankname,
      Bnkbrch,
      @EndUserText.label: 'Customer'
      Soldto,
      Cusname,
      @Semantics.amount.currencyCode: 'lccuky'
      Lcamt,
      @Semantics.amount.currencyCode: 'lccuky'
      Lcutamt,
      @Semantics.amount.currencyCode: 'lccuky'
      Lcbcamt,
      Lccuky,
      Status
}
