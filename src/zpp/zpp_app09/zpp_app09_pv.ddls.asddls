@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order Good Issue - APP'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_APP09_PV provider contract transactional_query as projection on  ZPP_APP09_RV
{
    key Werks,
    key Jobshtnum,
    Serialno,
    Jobdesc,
    Createdby,
    Createdon,
    Lastchangedby,
    Lastchangedon,
    Delmark,
    Status,
    /* Associations */
    item1,
    _item2 : redirected to composition child ZPP_APP09_IPV2
}
