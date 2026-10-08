@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Manage Production Order APP - PGI GRN REZ'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_APP01_HRV as select from zpp_app01_htb1
composition[0..*] of ZPP_APP01_IRV as _Mitem
{
    key uuid as Uuid,
    plant as Plant,
    mat as Mat,
    salesno as Salesno,
    @Semantics.user.createdBy: true
    createdby as Createdby,
    @Semantics.systemDateTime.createdAt: true
    createdon as Createdon,
    _Mitem
}
