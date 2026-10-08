@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Requistion Root Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_APPS01_PV provider contract transactional_query as projection on ZMM_APPS01_RV
{
    key Uuid,
    Purreqnum,
    Purreqdesc,
    Purreqtyp,
    Prtypdesc,
    Totitms,
    @Semantics.amount.currencyCode: 'Currency'
    Totnet,
    Currency,
    Status,
    Mark,
@Semantics.user.createdBy: true
      CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      CreatedAt,
      @Semantics.user.lastChangedBy: true
      LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
    /* Associations */
    _item : redirected to composition child zmm_apps01_ipv
}
