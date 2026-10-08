@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Item Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS01_IRV1 as select from zpp_apps01_itb1
association to parent ZPP_APPS01_RV as _hdr on _hdr.Uuid = $projection.Uuid
composition[0..*] of ZPP_APPS01_IRV2 as _citem

{
    key uuid as Uuid,
    key orderno as Orderno,
    key sno as Sno,
    orderitem as Orderitem,
    plant as Plant,
    matnr as Matnr,
    maktx as Maktx,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    plnqty as Plnqty,
    uom as Uom,
    vbeln as Vbeln,
    soitem as Soitem,
    rsnum as Rsnum,
     @Semantics.quantity.unitOfMeasure: 'Uom'
    reqty AS Reqty,
        @Semantics.quantity.unitOfMeasure: 'Matlentuom'
    matlent as Matlent,
    matlentuom as Matlentuom,
      @Semantics.quantity.unitOfMeasure: 'Matwidthuom'
    matwidth as Matwidth,
    matwidthuom as Matwidthuom,
      @Semantics.quantity.unitOfMeasure: 'Totwghuom'
    totwgh as Totwgh,
    totwghuom as Totwghuom,
      @Semantics.quantity.unitOfMeasure: 'Untwghuom'
    untwgh as Untwgh,
    untwghuom as Untwghuom,
      @Semantics.quantity.unitOfMeasure: 'Wgtpcuom'
    wgtpc as Wgtpc,
    wgtpcuom as Wgtpcuom,
    operation as Operation,
    _hdr,
    _citem
}
