@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View of the Bom report'
@Metadata.ignorePropagatedAnnotations: true

define root view entity zpp_report_rv 
  as select from I_Product as prod
left outer join  ZPP_RP01_RV as _bom
    on _bom.Material = prod.Product

left outer join ZPP_RP01_RV as _bom2
    on _bom2.Material = _bom.BillOfMaterialComponent

left outer join ZPP_RP01_RV as _bom3
    on _bom3.Material = _bom2.BillOfMaterialComponent

left outer join ZPP_RP01_RV as _bom4
    on _bom4.Material = _bom3.BillOfMaterialComponent
    
composition [0..* ] of ZPP_REPORT_IRV02 as _item

{
    key prod.Product                    as Project,
    key _bom.BillOfMaterialComponent    as Towertype,
    key _bom2.BillOfMaterialComponent   as Towersubtype,

    key _bom3.BillOfMaterialComponent   as Structure,

    case
        when max( _bom4.BillOfMaterialComponent ) <> ''
        then 'Mark Number Exist'
        else 'Mark Number Not Exist'
    end as Marknumber,
    _item
}where prod.ProductGroup = 'PROJ'

group by
    prod.Product,
    _bom.BillOfMaterialComponent,
    _bom2.BillOfMaterialComponent,
    _bom3.BillOfMaterialComponent
