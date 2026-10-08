@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Release Document IPV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZPP_APP03_IPV as projection on ZPP_APP03_IRE
{
    key Uuid,
    key Srno,
    Proj,
    Towertype,
    Ttdesc,
    Ttsub,
    Ttsdesc,
    mark,    
    /* Associations */
    hdr : redirected to parent ZPP_APP03_Hpv
}
