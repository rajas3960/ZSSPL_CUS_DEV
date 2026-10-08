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

define view entity ZPP_APPS01_IPV3 as projection on  ZPP_APPS01_IRV3
{
    key Uuid,
    key Orderno,
    Orderitem,
    Plant,
@Search.defaultSearchElement: true 
@Search.ranking: #HIGH
@Search.mode: #IDENTIFIER 
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
     Operation,
     Secon,
    /* Associations */
    _hdr : redirected to parent ZPP_APPS01_pv
}
