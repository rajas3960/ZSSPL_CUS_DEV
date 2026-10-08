@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZNS_PKG_RV'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZNS_PKG_RV as select from zns_pkg_htb
{
    key sono as Sono,
    cust as Cust,
    ot as Ot,
    plant as Plant,
    @Semantics.user.createdBy: true
     createdby  as  Createdby,
     @Semantics.systemDateTime.createdAt: true
     createdon     as Createdon
}
