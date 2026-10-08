@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Group By section'
@Metadata.ignorePropagatedAnnotations: true
@UI.presentationVariant: [{ sortOrder: [{by: 'mat_type' , direction: #ASC}] }]
define root view entity ZPP_BOM_SECTION
  as select from    zpp_bom_itb as _hdr
    left outer join ZPP_RP01_RV as _item on _item.Material = _hdr.markno
    left outer join I_Product as pd   on pd.Product = _item.BillOfMaterialComponent
{
  key _hdr.bomnum,
      _hdr.uuid,
      _item.BillOfMaterialComponent,
      _hdr.markdesc,
      case
      when _hdr.markdesc like 'MS%' then 'MS'
      when _hdr.markdesc like 'HT%' then 'HT'
      else 'NA'
      end                                           as mat_type,
      @Semantics.quantity.unitOfMeasure: 'UOM'
      pd.YY1_UNIT_WGT_PRD,
      pd.YY1_UNIT_WGT_PRDU                       as UOM,
      sum( cast( _hdr.totalwt as abap.dec(15,3) ) ) as total_weight
}
group by
  _hdr.bomnum,
  _hdr.uuid,
  _item.BillOfMaterialComponent,
  _hdr.markdesc,
  pd.YY1_UNIT_WGT_PRD,
  pd.YY1_UNIT_WGT_PRDU
