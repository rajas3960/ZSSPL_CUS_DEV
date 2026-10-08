@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order Good Recipts - APP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_APP10_RV as select from zpp_app03_tb1 
association[0..*] to zpp_app10_ipv1 as _item1 on _item1.Jobshtnum = $projection.jobshtnum
association[0..*] to zpp_app10_irv2 as _item2 on _item2.Jobshtnum = $projection.jobshtnum

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
    
}where status = 'C'
