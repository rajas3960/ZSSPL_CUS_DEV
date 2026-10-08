@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZNS_PKG_IV2 rOOT VIEW ITEM'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZNS_PKG_IV2 as select from ZNS_PKG_TB2
association to parent zns_pkg_rv1 as _hdr on _hdr.uuid = $projection.uuid
{
    key uuid as Uuid,
    key item as Item,
    sonumber as Sonumber,
    plant as Plant,
    soldtoparty as Soldtoparty,
    phoneno as Phoneno,
    email as Email,
    _hdr
}
