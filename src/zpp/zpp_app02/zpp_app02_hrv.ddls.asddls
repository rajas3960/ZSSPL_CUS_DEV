@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Manage Production Order App Header Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_APP02_HRV as select from zpp_app02_htb
composition[1..*] of ZPP_APP02_IRV as _Item
{
    key uuid as Uuid,
    mat as Mat,
    plant as Plant,
    salesno as Salesno,
    createdby as Createdby,
    createdon as Createdon,
    _Item
}
