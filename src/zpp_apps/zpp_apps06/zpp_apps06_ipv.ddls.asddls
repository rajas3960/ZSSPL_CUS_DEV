@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Orders - Item Projection View Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS06_IPV as projection on ZPP_APPS06_IRV
{
    key Vrno,
    key Sno,
    Uuid,
    Orderno,
    Plant,
    Matnr,
    Maktx,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Plnqty,
     @Semantics.quantity.unitOfMeasure: 'Uom'
    Reqty,
    Uom,
    Vbeln,
    Length,
    Width,
    Wetpc,
    Netwt,
    Jobsht,
    Operation,
    OrderIsReleased,
    OrderIsReleasedc,
    /* Associations */
    _hdr : redirected to parent ZPP_APPS06_PV
}
