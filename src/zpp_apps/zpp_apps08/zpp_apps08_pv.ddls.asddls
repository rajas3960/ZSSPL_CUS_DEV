@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Maintain User Projection View Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPP_APPS08_PV provider contract transactional_query as projection on ZPP_APPS08_RV
{
    key Uuid,
    Userid,
    Name,
    @UI.hidden: true
    Catorg,
    Compny,
    Plant,
    @Semantics.user.createdBy: true
    Createdby,
    @Semantics.systemDateTime.createdAt: true
    Createdon
}
