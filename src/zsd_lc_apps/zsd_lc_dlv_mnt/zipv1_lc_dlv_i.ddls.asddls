@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Delivery Creation - Item Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZIPV1_LC_DLV_I
  as projection on ZICV1_LC_DLV_I
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
      /* Associations */
      _hdr : redirected to parent ZRPV_LC_DLV_H
}
