@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Item Projection View3'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS02_IPV2
  as projection on ZPP_APPS02_IRV2
{
  key Uuid,
  key Orderno,
  key Sno,
      Orderitem,
      Plant,
      Matnr,
      Maktx,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      Plnqty,
      Uom,
      Vbeln,
      Soitem,
      Rsnum,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      Reqty,
      @Semantics.quantity.unitOfMeasure: 'Matlentuom'
      Matlent,
      Matlentuom,
      @Semantics.quantity.unitOfMeasure: 'Matwidthuom'
      Matwidth,
      Matwidthuom,
      @Semantics.quantity.unitOfMeasure: 'Totwghuom'
      Totwgh,
      Totwghuom,
      @Semantics.quantity.unitOfMeasure: 'Untwghuom'
      Untwgh,
      Untwghuom,
      @Semantics.quantity.unitOfMeasure: 'Wgtpcuom'
      Wgtpc,
      Wgtpcuom,
      Operation,
      /* Associations */
      _hdr : redirected to parent ZPP_APPS02_PV
}
