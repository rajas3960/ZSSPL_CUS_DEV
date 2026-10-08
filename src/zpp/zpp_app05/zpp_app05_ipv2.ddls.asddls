 @AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order App Projection child Item View 2'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APP05_IPV2 as projection on  ZPP_APP05_IRV2
{
    key Jobsheet,
    key Sno,
    key Orderno,
    Matnr,
    Maktx,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Plndqty,
    Uom,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Reqty,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Componentqty,
    @Semantics.quantity.unitOfMeasure: 'Uom' 
    Stockqty,
    @Semantics.user.createdBy: true
    Createdby,
    @Semantics.systemDateTime.createdAt: true
    Createdon,
    Plant,
    /* Associations */
    _hdr : redirected to parent ZPP_APP05_PV1    
} 
