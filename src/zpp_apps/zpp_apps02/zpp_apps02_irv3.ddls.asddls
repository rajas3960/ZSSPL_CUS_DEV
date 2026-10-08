@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Item View Length 3'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS02_IRV3 as select from zpp_apps02_itb3
association to parent ZPP_APPS02_RV as _hdr on _hdr.Uuid = $projection.Uuid
{
    key uuid as Uuid,
    key sno as Sno,
     length as Length,
    quantity as Quantity,
    _hdr
}
