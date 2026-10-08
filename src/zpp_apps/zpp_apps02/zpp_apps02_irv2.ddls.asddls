@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Item View 3'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS02_IRV2
  as select from zpp_apps02_itb2
association to parent ZPP_APPS02_RV as _hdr on _hdr.Uuid = $projection.Uuid
  
{
  key uuid        as Uuid,
  key orderno     as Orderno,
  key sno         as Sno,
      orderitem   as Orderitem,
      plant       as Plant,
      matnr       as Matnr,
      maktx       as Maktx,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      plnqty      as Plnqty,
      uom         as Uom,
      vbeln       as Vbeln,
      soitem      as Soitem,
      rsnum       as Rsnum,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      reqty       as Reqty,
      @Semantics.quantity.unitOfMeasure: 'Matlentuom'
      matlent     as Matlent,
      matlentuom  as Matlentuom,
      @Semantics.quantity.unitOfMeasure: 'Matwidthuom'
      matwidth    as Matwidth,
      matwidthuom as Matwidthuom,
      @Semantics.quantity.unitOfMeasure: 'Totwghuom'
      totwgh      as Totwgh,
      totwghuom   as Totwghuom,
      @Semantics.quantity.unitOfMeasure: 'Untwghuom'
      untwgh      as Untwgh,
      untwghuom   as Untwghuom,
      @Semantics.quantity.unitOfMeasure: 'Wgtpcuom'
      wgtpc       as Wgtpc,
      wgtpcuom    as Wgtpcuom,
      operation   as Operation,
      _hdr
}
