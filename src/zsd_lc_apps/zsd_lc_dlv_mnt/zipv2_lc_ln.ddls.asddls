@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Delivery Creation - LC Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZIPV2_LC_LN
  as projection on ZICV2_LC_LN
{
  key Recguid,
  key Sonum,
  key Soldto,
  key Lcnumber,
      Vfdate,
      Vtdate,
      Lcdate,
      Lcvdate,
      Bankname,
      Bnkbrch,
      @Semantics.amount.currencyCode: 'Lccuky'
      Lcamt,
      @Semantics.amount.currencyCode: 'Lccuky'
      Lcutamt,
      @Semantics.amount.currencyCode: 'Lccuky'
      Lcbcamt,
      @Semantics.amount.currencyCode: 'Lccuky'
      Lcselamt,
      Lccuky,
      Status,
      Mark,
      /* Associations */
      _hdr : redirected to parent ZRPV_LC_DLV_H
}
