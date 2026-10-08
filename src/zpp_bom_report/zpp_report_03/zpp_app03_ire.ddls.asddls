@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Release Document Item Root view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APP03_IRE as select from zpp_app03_idb as item
association to parent ZPP_APP03_HRE as hdr on hdr.Uuid = $projection.Uuid
                                           and hdr.Matnr = $projection.Proj
{
    key uuid as Uuid,
    key srno as Srno,
    proj as Proj,
    towertype as Towertype,
    ttdesc as Ttdesc,
    ttsub as Ttsub,
    ttsdesc as Ttsdesc,
    mark,
    hdr
}
