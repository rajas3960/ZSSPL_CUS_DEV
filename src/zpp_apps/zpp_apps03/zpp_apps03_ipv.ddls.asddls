@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Planning And Optimizing App Projection View Item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS03_IPV as projection on ZPP_APPS03_IRV
{
    key Uuid,
    key Orderno,
    Length,
    Width,
    Plant,
    Matnr,
    Maktx,
    Smatnr,
    Netwt,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Plnqty,
    Uom,
      @Semantics.quantity.unitOfMeasure: 'Uom'
    Reqty,
      @Semantics.quantity.unitOfMeasure: 'Uom'
    Totreqty,
      @Semantics.quantity.unitOfMeasure: 'Uom'
    Totopnqty,
    Vbeln,
    Soitem,
    Rsnum,
    Operation,
    /* Associations */
    _hdr : redirected to parent ZPP_APPS03_PV
}
