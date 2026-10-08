@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Manage Production Order App Item Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APP02_IPV as projection on ZPP_APP02_IRV
{
    key Uuid,
    key Item,
    Orderno,
    Material,
    Materialdec,
    @Semantics.quantity.unitOfMeasure: 'Unit'
    Quant,
    Unit,
    Plant,
    Sono,
    Soitm,
    Mark,
    Status,
    /* Associations */
    _Citem  : redirected to composition child ZPP_APP02_IPV2,
    _Hdr  : redirected to parent ZPP_APP02_HPV
}
