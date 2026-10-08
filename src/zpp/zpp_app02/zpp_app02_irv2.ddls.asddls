@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Manage Production Order App Child Item Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APP02_IRV2 as select from zpp_app02_itb2
association to parent ZPP_APP02_IRV as _Shdr on _Shdr.Uuid = $projection.Uuid and _Shdr.Item = $projection.Item
association[1..1] to ZPP_APP02_HRV as _Hdr on _Hdr.Uuid = $projection.Uuid
{
    key uuid as Uuid,
    key item as Item,
    key citem as Citem,
    orderno as Orderno,
    material as Material,
     materialdec as Materialdec,
    @Semantics.quantity.unitOfMeasure: 'Unit'
    qunt as Qunt,
    unit as Unit,
    _Shdr,
    _Hdr
}
