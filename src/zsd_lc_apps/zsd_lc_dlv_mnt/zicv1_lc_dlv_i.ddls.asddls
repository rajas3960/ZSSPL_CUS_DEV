@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Delivery Creation - Item Data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZICV1_LC_DLV_I
  as select from ZIV1_LC_DLV_I
  association to parent ZRCV_LC_DLV_H as _hdr on  $projection.Recguid = _hdr.Recguid
                                              and $projection.Sonum   = _hdr.Sonum
{
  key Recguid,
  key Sonum,
  key Soitem,
      Pstyv,
      Product,
      Prddesc,
      Plant,
      Sloc,
      @Semantics.quantity.unitOfMeasure: 'Salunt'
      Ordqty,
      @Semantics.quantity.unitOfMeasure: 'Salunt'
      Opnqty,
      Salunt,
      Docurr,
      @Semantics.amount.currencyCode: 'Docurr'
      Itmnet,
      @Semantics.amount.currencyCode: 'Docurr'
      Itmtax,
      @Semantics.quantity.unitOfMeasure: 'Salunt'
      Stkqty,
      @Semantics.quantity.unitOfMeasure: 'Salunt'
      Dlvqty,
      @Semantics.amount.currencyCode: 'Docurr'
      Dlvnet,
      @Semantics.amount.currencyCode: 'Docurr'
      Dlvtax,
      @Semantics.amount.currencyCode: 'Docurr'
      Dlvtot,
      _hdr
}
