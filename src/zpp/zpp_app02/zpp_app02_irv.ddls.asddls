@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Manage Production Order App Item Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APP02_IRV as select from zpp_app02_itb1
association to parent ZPP_APP02_HRV as _Hdr on  _Hdr.Uuid = $projection.Uuid
composition[1..*] of ZPP_APP02_IRV2 as _Citem
{
    key uuid as Uuid,
    key item as Item,
    orderno as Orderno,
    material as Material,
      materialdec as Materialdec,
    @Semantics.quantity.unitOfMeasure: 'Unit'
    quant as Quant,
    unit as Unit,
    plant as Plant,
    sono as Sono,
    soitm as Soitm,
    mark as Mark,
    status as Status,
    _Hdr,
    _Citem
}
