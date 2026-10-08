@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order App Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_APP04_PV provider contract transactional_query as projection on ZPP_APP04_RV
{
    key Jobsheet,
    Plant,
    Matnr,
    Vblen,
        @Semantics.user.createdBy: true
    Createdby,
        @Semantics.systemDateTime.createdAt: true
    Createdon,
    /* Associations */
    _Item : redirected to composition child ZPP_APP04_IPV
}
