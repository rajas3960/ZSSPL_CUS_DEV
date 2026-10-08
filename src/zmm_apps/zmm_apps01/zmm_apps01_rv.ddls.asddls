@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Requistion Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_APPS01_RV as select from zmm_apps01_htb
composition[0..*] of ZMM_APPS01_IRV as _item
{
    key uuid as Uuid,
    purreqnum as Purreqnum,
    purreqdesc as Purreqdesc,
    purreqtyp as Purreqtyp,
    prtypdesc as Prtypdesc,
    totitms as Totitms,
    @Semantics.amount.currencyCode: 'Currency'
    totnet as Totnet,
    currency as Currency,
    status as Status,
    mark as Mark,
      @Semantics.user.createdBy: true
      createdby          as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      createdat          as CreatedAt,
      @Semantics.user.lastChangedBy: true
      lastchangedby      as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat      as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchangedat as LocalLastChangedAt,
    _item
}
