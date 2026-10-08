@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Plant Value Help'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS_PLANT as select from I_Plant
{
    key Plant as plant,
    PlantName as plantd
}
