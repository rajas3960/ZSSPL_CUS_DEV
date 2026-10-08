@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZNS_PKG_IPV2'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZNS_PKG_IPV2 as projection on ZNS_PKG_IV2
{
    key Uuid,
    key Item,
    Sonumber,
    Plant,
    Soldtoparty,
    Phoneno,
    Email,
    /* Associations */
    _hdr : redirected to parent ZNS_PKG_PV1
}
