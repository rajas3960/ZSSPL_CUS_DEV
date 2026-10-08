@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Release Document Sub Item PV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zpp_app03_ipv02 as projection on zpp_app03_ire2
{
    key Uuid,
    key Srno,
    Proj,
    Towertype,
    Ttdesc,
    Ttsub,
    Ttsdesc,
    str,
    strdesc,
    Combi,
    mark,
    Bom,
    mk,
    /* Associations */
    _hdr: redirected to parent ZPP_APP03_Hpv
    
}
