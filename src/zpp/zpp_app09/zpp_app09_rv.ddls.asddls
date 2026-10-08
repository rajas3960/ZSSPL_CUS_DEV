@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order Good Issue - APP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_APP09_RV as select from zpp_app03_tb1 as _hdr
association[1..*] to ZPP_APP09_IPV1 as item1 on item1.Jobshtnum = $projection.Jobshtnum
composition[0..*] of ZPP_APP09_IRV2 as _item2 
{
key _hdr.werks as Werks,
key _hdr.jobshtnum as Jobshtnum,
_hdr.serialno as Serialno,
_hdr.jobdesc as Jobdesc,
_hdr.createdby as Createdby,
_hdr.createdon as Createdon,
_hdr.lastchangedby as Lastchangedby,
_hdr.lastchangedon as Lastchangedon,
_hdr.delmark as Delmark,
_hdr.status as Status,
item1,
_item2
} where _hdr.status = 'C'
