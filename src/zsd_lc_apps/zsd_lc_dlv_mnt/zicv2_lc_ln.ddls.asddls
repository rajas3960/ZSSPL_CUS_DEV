@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Delivery Creation - LC Data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZICV2_LC_LN
  as select from ZIV2_LC_LN
  association to parent ZRCV_LC_DLV_H as _hdr on  $projection.Recguid = _hdr.Recguid
                                              and $projection.Sonum   = _hdr.Sonum
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
      _hdr
}
