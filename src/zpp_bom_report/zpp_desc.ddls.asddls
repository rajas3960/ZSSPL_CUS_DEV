@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bom Description'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_DESC as select from ZPP_RP01_RV as main
left outer join I_BillOfMaterialHeaderDEX_2 as desc on desc.BillOfMaterial = main.BOM
{
 
 key main.Material,
 key  main.BOM,
 desc.BOMAlternativeText,
 desc.BOMHeaderText   
}
group by main.Material,
main.BOM,
desc.BOMAlternativeText,
desc.BOMHeaderText;
