@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Item Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS02_IPV
  as projection on ZPP_APPS02_IRV
{
  key Uuid,
  key Orderno,
      Orderitem,
      Plant,
      Matnr,
      Maktx,
      Length,
      Width,
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
      _hdr : redirected to parent ZPP_APPS02_PV
}
