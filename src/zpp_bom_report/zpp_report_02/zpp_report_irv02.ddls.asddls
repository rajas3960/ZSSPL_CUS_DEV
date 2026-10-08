@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bill Of Material Report Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_REPORT_IRV02 as select from zpp_report_rv as hdr
left outer join ZPP_RP01_RV as item on item.Material = hdr.Structure
left outer join ZPP_RP01_RV as item1 on item1.Material = item.BillOfMaterialComponent
association to parent zpp_report_rv as _hdr on _hdr.Structure = $projection.Structure
                                            and _hdr.Project = $projection.Project
                                            and _hdr.Towersubtype = $projection.Towersubtype
                                            and _hdr.Towertype = $projection.Towertype
{
    key hdr.Project,
    key hdr.Towertype,
    key hdr.Towersubtype,
    key hdr.Structure,
    key item.BillOfMaterialComponent as MarkNumber,
    item1.BillOfMaterialComponent as Componet,
    case
        when item1.BillOfMaterialComponent  <> ''
        then 'Componet Exist'
        else 'Componet Not Exist'
    end as Comp,
    _hdr
}
