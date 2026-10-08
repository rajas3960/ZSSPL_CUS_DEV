@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order App Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define  root view entity ZPP_APP05_RV1

 as select from zpp_app03_tb1
composition[0..*] of ZPP_APP05_IRV1 as _Item1
composition[0..*] of ZPP_APP05_IRV2 as _Item2
{
    key werks as Werks,
    key jobshtnum as Jobshtnum,
    serialno as Serialno,
    jobdesc as Jobdesc,
    delmark as Delmark,
    status as Status,
    @Semantics.user.createdBy: true
    createdby as Createdby,
    @Semantics.systemDateTime.createdAt: true
    createdon as Createdon,
    @Semantics.user.lastChangedBy: true
    lastchangedby as Lastchangedby,
    @Semantics.systemDateTime.lastChangedAt: true
    lastchangedon as Lastchangedon,
    _Item1,
    _Item2
    
}
