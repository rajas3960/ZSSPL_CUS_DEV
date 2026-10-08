@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Release Document'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPP_APP03_IRV3 as select from ZPP_RP01_RV as ts
left outer join ZPP_RP01_RV as str on str.Material = ts.BillOfMaterialComponent
                                       and str.BillOfMaterialComponent is not initial 
                                      
{
    key str.Material,
    key str.BillOfMaterialComponent
}
