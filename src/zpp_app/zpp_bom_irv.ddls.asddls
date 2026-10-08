@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOM root view of Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_BOM_IRV as select from zpp_bom_idb
association to parent ZPP_BOM_HRV as _hdr on _hdr.Uuid = $projection.Uuid
{
    key uuid as Uuid,
    key itemno as Itemno,
    details as Details,
    itemcreate as Itemcreate,
    initials as Initials,
    itemcreatedby as Itemcreatedby,
    itemcreatedat as Itemcreatedat,
    itemlastchangedby as Itemlastchangedby,
    _hdr
}
