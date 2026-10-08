@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bill Of Material Report'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_BOM_REP
  as select from    I_Product     as pd
    left outer join ZPP_RP01_RV   as bom  on bom.Material = pd.Product
    left outer join I_ProductText as pdt  on  pdt.Product  = bom.BillOfMaterialComponent
                                          and pdt.Language = $session.system_language
    left outer join ZPP_RP01_RV   as bom2 on bom2.Material = bom.BillOfMaterialComponent
    left outer join I_ProductText as pdt2 on  pdt2.Product  = bom2.BillOfMaterialComponent
                                          and pdt2.Language = $session.system_language
    left outer join ZPP_RP01_RV   as bom3 on bom3.Material = bom2.BillOfMaterialComponent
    left outer join I_ProductText as pdt3 on  pdt3.Product  = bom3.BillOfMaterialComponent
                                          and pdt3.Language = $session.system_language
    left outer join ZPP_RP01_RV   as bom4 on bom4.Material = bom3.BillOfMaterialComponent
{
  key  pd.Product                        as Project,
  key  bom.BillOfMaterialComponent       as Towertype,
  key  bom2.BillOfMaterialComponent      as Towersubtype,
  key  bom3.BillOfMaterialComponent      as str,
  key  bom3.BOM                          as Bomno,
  key  min(bom4.BillOfMaterialComponent) as Mark,
       pdt.ProductName                   as Towertypedesc,
       pdt2.ProductName                  as towersubtypedesc,
       pdt3.ProductName                  as strdesc
}
where
      pd.ProductGroup              = 'PROJ'
  and bom4.BillOfMaterialComponent is not initial
group by
  pd.Product,
  bom.BillOfMaterialComponent,
  bom2.BillOfMaterialComponent,
  bom3.BillOfMaterialComponent,
  bom3.BOM,
  pdt.ProductName,
  pdt2.ProductName,
  pdt3.ProductName
