@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Wise Weight Summary Item Details'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_REP_IRV as select from ZPP_RP01_RV as bom

    left outer join I_ProductText as pt
      on pt.Product = bom.BillOfMaterialComponent
     and pt.Language = $session.system_language
     
    association to parent ZPP_REPORT_HRV as _hdr
      on _hdr.Material = $projection.Material

    composition [0..*] of ZPP_REP_IRV2 as Item1

{
    key bom.Material,
    key bom.BillOfMaterialComponent as Structure,
   
        pt.ProductName,

        _hdr,
        Item1
}
