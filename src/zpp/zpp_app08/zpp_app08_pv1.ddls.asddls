@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection view of  root entity view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zpp_app08_PV1 provider contract transactional_query as projection on zpp_app08_REV1
{
    key werks,
    key jobshtno,
    serialno,
    JobDesc,
    Delmark,
    Status,
    CreatedBy,
    Createdon,
    Lastchangedby,
    Lastchangedon,
    /* Associations */
    _Item1: redirected to composition child zpp_app08_IPV1,
    _Item2: redirected to composition child zpp_app08_IPV2
}
