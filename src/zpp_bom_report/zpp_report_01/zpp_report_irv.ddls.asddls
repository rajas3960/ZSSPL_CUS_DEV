@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Wise Weight Summary Item Details'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZPP_REPORT_IRV
  as select distinct from ZPP_RP01_RV as bom
left outer join ZPP_RP01_RV as bom1
on bom1.Material = bom.BillOfMaterialComponent
    left outer join I_ProductText as pt
      on pt.Product = bom.BillOfMaterialComponent
     and pt.Language = $session.system_language
     

    composition [0..*] of ZPP_REPORT_IRV2 as Item1

{
    key bom.Material,
    key bom.BillOfMaterialComponent as Structure,
    key bom1.BillOfMaterialComponent as Tower_type,
   
        pt.ProductName,
        Item1
}
