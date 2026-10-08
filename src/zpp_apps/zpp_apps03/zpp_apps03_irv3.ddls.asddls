@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Planning And Production - Length And quantity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS03_IRV3 as select from zpp_apps3_itb3
association to parent ZPP_APPS03_RV as _hdr on _hdr.Uuid = $projection.Uuid
{
    key uuid as Uuid,
    key length as Length,
    quantity as Quantity,
    _hdr
}
