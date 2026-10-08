@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I_PRODUCTIONORDERCOMPONENT VIEW'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS_prodtc as select distinct  from ZPP_APPS_COMPRC
{
key Product
}
