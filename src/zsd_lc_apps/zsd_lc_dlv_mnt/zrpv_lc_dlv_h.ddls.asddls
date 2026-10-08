@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Delivery Creation - Header Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZRPV_LC_DLV_H
  provider contract transactional_query
  as projection on ZRCV_LC_DLV_H
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
      /* Associations */
      _Item : redirected to composition child ZIPV1_LC_DLV_I,
      _lcnum : redirected to composition child ZIPV2_LC_LN
}
