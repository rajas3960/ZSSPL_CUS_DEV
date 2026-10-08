@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Item View For Stocks'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS02_IRV4 as select from ZPP_APPS02_ITB4
association to parent ZPP_APPS02_RV as _hdr on _hdr.Uuid = $projection.Uuid
{
    key uuid as Uuid,
    key sno as Sno,
    length as Length,
    quantity as Quantity,
    _hdr
}
