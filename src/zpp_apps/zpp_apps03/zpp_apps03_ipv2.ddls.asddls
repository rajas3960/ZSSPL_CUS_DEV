@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Planning And Optimizing App Projection View Item 2'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS03_IPV2 as projection on ZPP_APPS_IRV2
{
    key Uuid,
    key Sno,
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
    
    /* Associations */
    _hdr : redirected to parent ZPP_APPS03_PV
}
