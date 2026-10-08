@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Delivery Creation - Consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZRCV_LC_DLV_H
  as select from ZRV_LC_DLV_H
  composition [0..*] of ZICV1_LC_DLV_I as _Item
  composition [0..*] of ZICV2_LC_LN    as _lcnum
{
  key Recguid,
  key Sonum,
      Sotype,
      Ernam,
      Erdat,
      Audat,
      Vkorg,
      Vtweg,
      Spart,
      Soldto,
      Shipto,
      Staddr,
      Shaddr,
      Cusref,
      Crefdt,
      Prcdat,
      Prcprcd,
      Docurr,
      @Semantics.amount.currencyCode: 'Docurr'
      Netval,
      @Semantics.amount.currencyCode: 'Docurr'
      Taxval,
      @Semantics.amount.currencyCode: 'Docurr'
      Grdtot,
      Totlcno,
      @Semantics.amount.currencyCode: 'Docurr'
      Totlcval,
      @Semantics.amount.currencyCode: 'Docurr'
      Totdlval,
      _Item,
      _lcnum
}
