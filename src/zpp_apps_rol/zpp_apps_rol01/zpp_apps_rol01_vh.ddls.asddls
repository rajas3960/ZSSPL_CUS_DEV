@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production View help'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS_ROL01_VH as select from ZPP_APPS_ROL01_RV
{
   key Material,
    key SupplyingPlant,
    key PurchaseOrderItemText
}
group by 
Material,
SupplyingPlant,
PurchaseOrderItemText
