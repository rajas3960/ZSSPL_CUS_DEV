@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Balance Plan Report'
@Metadata.ignorePropagatedAnnotations: true
define view entity zpp_report_rv02 as select from zpp_apps05_htb as _hdr  
left outer join ZPP_APPS05_IRV2 as _item    on _item.Uuid = _hdr.uuid                                      
{
    key _hdr.sectmat,
    key _hdr.purno,
    key _hdr.project,
    key _item.Vbeln,    
    cast(sum(_item.Netwt) as abap.dec( 15, 3 )  ) as totoal_planwt  
    
}
group by
_hdr.sectmat,
_hdr.purno,
_hdr.project,
_item.Vbeln
