@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Delivery Creation - Root Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZRV_LC_DLV_H
  as select from ztb1_lc_dlv_h
{
  key recguid  as Recguid,
  key sonum    as Sonum,
      sotype   as Sotype,
      ernam    as Ernam,
      erdat    as Erdat,
      audat    as Audat,
      vkorg    as Vkorg,
      vtweg    as Vtweg,
      spart    as Spart,
      soldto   as Soldto,
      shipto   as Shipto,
      staddr   as Staddr,
      shaddr   as Shaddr,
      cusref   as Cusref,
      crefdt   as Crefdt,
      prcdat   as Prcdat,
      prcprcd  as Prcprcd,
      docurr   as Docurr,
      @Semantics.amount.currencyCode: 'Docurr'
      netval   as Netval,
      @Semantics.amount.currencyCode: 'Docurr'
      taxval   as Taxval,
      @Semantics.amount.currencyCode: 'Docurr'
      grdtot   as Grdtot,
      totlcno  as Totlcno,
      @Semantics.amount.currencyCode: 'Docurr'
      totlcval as Totlcval,
      @Semantics.amount.currencyCode: 'Docurr'
      totdlval as Totdlval
}
