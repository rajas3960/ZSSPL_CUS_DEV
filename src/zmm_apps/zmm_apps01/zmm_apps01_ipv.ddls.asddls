@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Requistion Item Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APPS01_IPV as projection on ZMM_APPS01_IRV
{
    key Uuid,
    key Purreqitm,
    @EndUserText.label: 'Material'
    Material,
    Matdesc,
    Matgrp,
    Extmatgrp,
    @EndUserText.label: 'Plant'
    Plant,
    Plantdesc,
    Purgrp,
    Purgrpdesc,
    Delvdate,
    Purorg,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Reqqty,
    Uom,
    @Semantics.amount.currencyCode: 'Currency'
    Valprice,
     @Semantics.amount.currencyCode: 'Currency'
    Totvalue,
    Currency,
    Length,
    Width,
    Pices,
@Semantics.user.createdBy: true
      ItemCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      ItemCreatedAt,
      @Semantics.user.lastChangedBy: true
      ItemLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      ItemLastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      ItemLocalLastChangedAt,
    /* Associations */
    _hdr : redirected to parent ZMM_APPS01_PV
}
