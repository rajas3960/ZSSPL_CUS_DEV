@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Details Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPP_MAT_PV provider contract transactional_query as projection on ZPP_MAT_RV
{
    key Matnr,
    Plant,
    Bourningloss,
    createdon
}
