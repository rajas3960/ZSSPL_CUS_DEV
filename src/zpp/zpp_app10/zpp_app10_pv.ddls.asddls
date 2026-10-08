@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order Good Recipts - APP'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_APP10_pv provider contract transactional_query as projection on ZPP_APP10_RV
{
    key werks,
    key jobshtnum,
    serialno,
    jobdesc,
    createdby,
    createdon,
    lastchangedby,
    lastchangedon,
    delmark,
    status,
    /* Associations */
    _item1,
    _item2
}
