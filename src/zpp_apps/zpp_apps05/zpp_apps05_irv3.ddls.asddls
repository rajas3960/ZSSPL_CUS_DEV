@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Item View Entity 3 Length'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_IRV3 as select from zpp_apps05_itb3
association to parent ZPP_APPS05_RV as _hdr on _hdr.Uuid = $projection.Uuid
{
    key uuid as Uuid,
    key length as Length,
    quantity as Quantity,
    _hdr
}
