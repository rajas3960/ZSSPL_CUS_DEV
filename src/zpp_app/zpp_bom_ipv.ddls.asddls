@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view of BOM Screen Item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_BOM_IPV as projection on ZPP_BOM_IRV
{
    key Uuid,
    key Itemno,
    Details,
    Itemcreate,
    Initials,
    @Semantics.user.createdBy: true
    Itemcreatedby,
    @Semantics.systemDateTime.createdAt: true
    Itemcreatedat,
    @Semantics.user.lastChangedBy: true
    Itemlastchangedby,
    /* Associations */
    _hdr : redirected to parent ZPP_BOM_HPV
}
