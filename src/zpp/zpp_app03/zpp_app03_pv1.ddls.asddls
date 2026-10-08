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
define root view entity ZPP_APP03_PV1 provider contract transactional_query as projection on ZPP_APP03_RV1
{
    key Werks,
    key Jobshtnum,
    Serialno,
    @EndUserText.label: 'Jobsheet Desc:'
    Jobdesc,
    Delmark,
    Status,
    @Semantics.user.createdBy: true
    Createdby,
    @Semantics.systemDateTime.createdAt: true
    Createdon,
    @Semantics.user.localInstanceLastChangedBy: true
    Lastchangedby,
   @Semantics.systemDateTime.localInstanceLastChangedAt: true
    Lastchangedon,
    _Item1: redirected to composition child ZPP_APP03_IPV1,
    _Item2 : redirected to composition child ZPP_APP03_IPV2
    
}
