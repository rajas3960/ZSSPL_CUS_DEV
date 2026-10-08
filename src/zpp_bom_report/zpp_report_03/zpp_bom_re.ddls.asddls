@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOM REPORT'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_BOM_RE as select from I_Product     as pd
    left outer join ZPP_RP01_RV   as bom  on bom.Material = pd.Product
    left outer join I_ProductText as pdt  on  pdt.Product  = bom.BillOfMaterialComponent
                                          and pdt.Language = $session.system_language
    left outer join ZPP_RP01_RV   as bom2 on bom2.Material = bom.BillOfMaterialComponent
    left outer join I_ProductText as pdt2 on  pdt2.Product  = bom2.BillOfMaterialComponent
                                          and pdt2.Language = $session.system_language
//    left outer join ZPP_RP01_RV as bom4  on bom4.Material = bom3.BillOfMaterialComponent                                      
{
  key pd.Product                   as Project,
  key bom.BillOfMaterialComponent  as Towertype,
  key bom2.BillOfMaterialComponent as Towersubtype,
      pdt.ProductName              as Towertypedesc,
      pdt2.ProductName             as towersubtypedesc
}
where
  pd.ProductGroup = 'PROJ'
