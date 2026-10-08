@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Projection Item View Mark'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZPP_APPS05_IPV2 as projection on ZPP_APPS05_IRV2
{
    key Uuid,
    key Sno,
    Orderno,
    Vrno,
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
Resv,
    /* Associations */
    _hdr : redirected to parent ZPP_APPS05_PV
}
