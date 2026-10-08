@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order App Projection Item View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APP03_IPV1  as projection on ZPP_APP03_IRV1
{
  key Jobshtnum,
  key Orderno,
  Orderitem,
      Plant,
      Matnr,
      Maktx,
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
      @Semantics.user.createdBy: true
      Createdby,
      @Semantics.systemDateTime.createdAt: true
      Createdon,
      _hdr : redirected to parent ZPP_APP03_PV1     
}
