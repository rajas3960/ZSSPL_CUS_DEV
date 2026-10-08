@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'jobsheet production order root entity view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zpp_app08_REV1 as select from zpp_app08_tb1
composition[0..*] of zpp_app08_irev1 as _Item1
composition[0..*] of zpp_app08_irev2 as _Item2

{
    key werks as werks,
    key jobshtno,
    serialno as serialno,
    jobdesc as JobDesc,
    delmark as Delmark,
    status as Status,
    @Semantics.user.createdBy: true
    createdby as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    createdon as Createdon,
    @Semantics.user.lastChangedBy: true
    lastchangedby as Lastchangedby,
    @Semantics.systemDateTime.lastChangedAt: true
    lastchangedon as Lastchangedon,
    _Item1,
    _Item2
}
