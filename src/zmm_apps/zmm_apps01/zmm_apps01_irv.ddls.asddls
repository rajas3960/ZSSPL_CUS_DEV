@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Requistion Item View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APPS01_IRV as select from zmm_apps01_itb
association to parent ZMM_APPS01_RV as _hdr on _hdr.Uuid = $projection.Uuid
{
    key uuid as Uuid,
    key purreqitm as Purreqitm,
    material as Material,
    matdesc as Matdesc,
    matgrp as Matgrp,
    extmatgrp as Extmatgrp,
    plant as Plant,
    plantdesc as Plantdesc,
    purgrp as Purgrp,
    purgrpdesc as Purgrpdesc,
    delvdate as Delvdate,
    purorg as Purorg,
    @Semantics.quantity.unitOfMeasure : 'Uom'
    reqqty as Reqqty,
    uom as Uom,
    @Semantics.amount.currencyCode: 'Currency'
    valprice as Valprice,
    @Semantics.amount.currencyCode: 'Currency'
    totvalue as Totvalue,
    currency as Currency,
    length as Length,
    width as Width,
    pices as Pices,
         @Semantics.user.createdBy: true
      itemcreatedby          as ItemCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      itemcreatedat          as ItemCreatedAt,
      @Semantics.user.lastChangedBy: true
      itemlastchangedby      as ItemLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      itemlastchangedat      as ItemLastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      itemlocallastchangedat as ItemLocalLastChangedAt,
    _hdr
}
