@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Maintain User Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPP_APPS08_RV as select from zpp_apps08_htb
{
    key uuid as Uuid,
    userid as Userid,
    name as Name,
    catorg as Catorg,
    compny as Compny,
    plant as Plant,
     @Semantics.user.createdBy: true
    createdby as Createdby,
       @Semantics.systemDateTime.createdAt: true
    createdon as Createdon
}
