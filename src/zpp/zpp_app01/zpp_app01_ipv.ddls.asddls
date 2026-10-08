@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Manage Production Order Application Item Projection View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZPP_APP01_IPV as projection on ZPP_APP01_IRV
{
    key Uuid,
    key Sno,
    Ccode,
    Plant,
    Fgproduct,
    Bomid,
    Component,
    Bomvar,
    Bomitmnode,
    Bomintchgcnt,
    Bomver,
    Bomcat,
    Componentdescription,
    @Semantics.quantity.unitOfMeasure: 'Componentuom'
    Componentquantity,
    Componentuom,
    Manuford,
    /* Associations */
    _Mhdr : redirected to parent ZPP_APP01_HPV
}
