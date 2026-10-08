@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Extra Length View Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity zmm_length_ve as select from zpp_apps05_itb6 as hdr
inner join zpp_apps05_itb7 as itm on itm.uuid = hdr.uuid and itm.srcid = hdr.srcid 
{
 key hdr.uuid as Uuid,
 key hdr.srcid as Srcid,
 hdr.vrno as Vrno,
 hdr.wast as Wast,
 hdr.srcpcs,
 sum(itm.lentqty ) as Lentqty   
}where itm.lentqty <> 0
group by 
hdr.uuid,
hdr.srcid,
hdr.vrno,
 hdr.srcpcs,
hdr.wast
