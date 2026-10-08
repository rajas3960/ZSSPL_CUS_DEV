@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Details'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZPP_MAT_RV as select from zpp_mat_tb
{
    key matnr as Matnr,
    plant as Plant,
    bourningloss as Bourningloss,
    createdon
}
