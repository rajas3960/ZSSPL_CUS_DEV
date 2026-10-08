@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Delivery Creation - Child Entity1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZIV1_LC_DLV_I
  as select from ztb2_lc_dlv_i
{
  key recguid as Recguid,
  key sonum   as Sonum,
  key soitem  as Soitem,
      pstyv   as Pstyv,
      product as Product,
      prddesc as Prddesc,
      plant   as Plant,
      sloc    as Sloc,
      @Semantics.quantity.unitOfMeasure: 'Salunt'
      ordqty  as Ordqty,
      @Semantics.quantity.unitOfMeasure: 'Salunt'
      opnqty  as Opnqty,
      salunt  as Salunt,
      docurr  as Docurr,
      @Semantics.amount.currencyCode: 'Docurr'
      itmnet  as Itmnet,
      @Semantics.amount.currencyCode: 'Docurr'
      itmtax  as Itmtax,
      @Semantics.quantity.unitOfMeasure: 'Salunt'
      stkqty  as Stkqty,
      @Semantics.quantity.unitOfMeasure: 'Salunt'
      dlvqty  as Dlvqty,
      @Semantics.amount.currencyCode: 'Docurr'
      dlvnet  as Dlvnet,
      @Semantics.amount.currencyCode: 'Docurr'
      dlvtax  as Dlvtax,
      @Semantics.amount.currencyCode: 'Docurr'
      dlvtot  as Dlvtot
}
