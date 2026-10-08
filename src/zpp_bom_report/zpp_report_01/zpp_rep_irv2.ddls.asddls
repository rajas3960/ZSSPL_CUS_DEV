@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Wise Weight Summary Sub item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_REP_IRV2 as select from ZPP_RP01_RV as bom

    left outer join ZPP_RP01_RV as bom1
      on bom1.Material = bom.BillOfMaterialComponent

    left outer join ZPP_RP01_RV as bom2
      on bom2.Material = bom1.BillOfMaterialComponent
     and bom2.BillOfMaterialComponent like '%HT'

    left outer join ZPP_RP01_RV as bom3
      on bom3.Material = bom1.BillOfMaterialComponent
     and bom3.BillOfMaterialComponent like '%MS'

    left outer join ZPP_RP01_RV as bom4
      on bom4.Material = bom1.BillOfMaterialComponent
     and bom4.BillOfMaterialComponent like '%BN'

    left outer join ZPP_STRUCTURE_REP01 as HT
      on HT.Material = bom2.BillOfMaterialComponent

    left outer join ZPP_STRUCTURE_REP01 as MS
      on MS.Material = bom3.BillOfMaterialComponent

    left outer join ZPP_STRUCTURE_REP01 as BN
      on BN.Material = bom4.BillOfMaterialComponent

    left outer join ZPP_RP01_RV as mark
      on mark.Material = bom1.BillOfMaterialComponent
    
    left outer join ZPP_RP01_RV as mark1
      on mark1.Material = mark.BillOfMaterialComponent

    association [1..1] to ZPP_REPORT_HRV as _hdr
      on _hdr.Material = $projection.Material

    association to parent ZPP_REP_IRV as item
      on item.Material  = $projection.Material
     and item.Structure = $projection.Structure
    

{
    key bom.Material,
    key bom.BillOfMaterialComponent as Structure,

    key bom1.BillOfMaterialComponent as Tower_Type,

        bom2.BillOfMaterialComponent as BOM_HT,
        bom3.BillOfMaterialComponent as BOM_MS,
        bom4.BillOfMaterialComponent as BOM_BN,

        HT.Total_weight as HT_Weight,
        MS.Total_weight as MS_Weight,
        BN.Total_weight as BN_Weight,

        min( mark1.BillOfMaterialComponent ) as Mark_No,

        item,
        _hdr
}
group by
    bom.Material,
    bom.BillOfMaterialComponent,
    bom1.BillOfMaterialComponent,
    bom2.BillOfMaterialComponent,
    bom3.BillOfMaterialComponent,
    bom4.BillOfMaterialComponent,
    HT.Total_weight,
    MS.Total_weight,
    BN.Total_weight
