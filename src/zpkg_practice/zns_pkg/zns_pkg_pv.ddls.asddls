@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZNS_PKG_PV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZNS_PKG_PV  provider contract transactional_query as projection on ZNS_PKG_RV
{
    key Sono,
    Cust,
    Ot,
    Plant,
        @Semantics.user.createdBy: true
       Createdby,
         @Semantics.systemDateTime.createdAt: true
     Createdon
}
