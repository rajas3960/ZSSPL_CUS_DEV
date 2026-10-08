@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Release Document Sub Item Root view'
@Metadata.ignorePropagatedAnnotations: true
define view entity zpp_app03_ire2
  as select from zpp_app03_idb02
  association to parent ZPP_APP03_HRE as _hdr on  _hdr.Uuid  = $projection.Uuid
                                              and _hdr.Matnr = $projection.Proj
{
  key uuid      as Uuid,
  key srno      as Srno,
      proj      as Proj,
      towertype as Towertype,
      ttdesc    as Ttdesc,
      ttsub     as Ttsub,
      ttsdesc   as Ttsdesc,
      str       as str,
      strdesc   as strdesc,
      combi     as Combi,
      mark      as mark,
      bom       as Bom,
      mk as mk,
      _hdr
}
