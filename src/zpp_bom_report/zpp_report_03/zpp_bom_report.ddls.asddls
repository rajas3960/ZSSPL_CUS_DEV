@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bill Of Material Report'
@Metadata.ignorePropagatedAnnotations: true
define view entity zpp_Bom_report
  as select from    zpp_app03_ire2 as hdr
    left outer join ZPP_RP01_RV   as bom3 on  bom3.Material                = hdr.Ttsub
                                          and bom3.BillOfMaterialComponent not like '%BN'
    left outer join ZPP_RP01_RV   as bom4 on bom4.Material = bom3.BillOfMaterialComponent
//    association to parent zpp_app03_ire2 as item1 on item1.Uuid = $projection.Uuid
//                                                  and item1.Srno = $projection.Srno
{
  key hdr.Uuid,
  key hdr.Srno,
      hdr.Proj,
      bom3.Material,
      bom3.BillOfMaterialComponent,
      bom4.BOM,
      min(bom4.BillOfMaterialComponent) as mark
}
group by
  hdr.Uuid,
  hdr.Srno,
  hdr.Proj,
   bom3.Material,
  bom3.BillOfMaterialComponent,
  bom4.BOM
