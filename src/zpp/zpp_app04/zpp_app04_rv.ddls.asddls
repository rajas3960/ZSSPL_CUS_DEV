@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order App Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_APP04_RV as select from zpp_app04_tb1
composition[0..*]  of ZPP_APP04_IRV as _Item
{
    key jobsheet as Jobsheet,
    plant as Plant,
    matnr as Matnr,
    vblen as Vblen,
        @Semantics.user.createdBy: true
    createdby as Createdby,
        @Semantics.systemDateTime.createdAt: true
    createdon as Createdon,
    _Item
}
