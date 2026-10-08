@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Projection Item View pMa'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true 
define view entity ZPP_APPS05_IPV1 as projection on ZPP_APPS05_IRV1
{
    key Uuid,
 @Search.defaultSearchElement: true
   @Search.fuzzinessThreshold: 0.3
      @Search.ranking: #HIGH
    key Orderno,
    Orderitem,
    Plant,
     @Search.defaultSearchElement: true
        @Search.fuzzinessThreshold: 0.3
      @Search.ranking: #HIGH
    Matnr,
    Maktx,
    Length,
 Width,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Plnqty,
    Uom,
      @Semantics.quantity.unitOfMeasure: 'Uom'
    Reqty,
      @Semantics.quantity.unitOfMeasure: 'Uom'
    Totreqty,
      @Semantics.quantity.unitOfMeasure: 'Uom'
    Totopnqty,
     @Search.defaultSearchElement: true
       @Search.fuzzinessThreshold: 0.3
      @Search.ranking: #HIGH
    Vbeln,
    Soitem,
    Rsnum,
     @Search.defaultSearchElement: true
       @Search.fuzzinessThreshold: 0.3
      @Search.ranking: #HIGH
    Operation,
    Secon,
     Netwt,
    /* Associations */
    _hdr : redirected to parent ZPP_APPS05_PV
}
