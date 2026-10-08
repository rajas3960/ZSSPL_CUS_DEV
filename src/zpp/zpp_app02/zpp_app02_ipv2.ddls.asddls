@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Manage Production Order App Child Item Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APP02_IPV2 as projection on ZPP_APP02_IRV2
{
    key Uuid,
    key Item,
    key Citem,
    Orderno,
    Material,
    Materialdec,
    @Semantics.quantity.unitOfMeasure: 'Unit'
    Qunt,
    Unit,
    /* Associations */
    _Hdr   : redirected to ZPP_APP02_HPV,
    _Shdr :  redirected to parent ZPP_APP02_IPV
}
