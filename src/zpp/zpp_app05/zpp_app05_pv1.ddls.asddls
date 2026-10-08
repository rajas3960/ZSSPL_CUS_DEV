@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order App Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_APP05_PV1 provider contract transactional_query as projection on ZPP_APP05_RV1
{
    key Werks,
    key Jobshtnum,
    Serialno,
    Jobdesc,
    Delmark,
    Status,
    @Semantics.user.createdBy: true
    Createdby,
    @Semantics.systemDateTime.createdAt: true
    Createdon,
    @Semantics.user.lastChangedBy: true
    Lastchangedby,
    @Semantics.systemDateTime.lastChangedAt: true
    Lastchangedon,
    _Item1: redirected to composition child ZPP_APP05_IPV1,
    _Item2 : redirected to composition child ZPP_APP05_IPV2
    
}
