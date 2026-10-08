@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order Good Issue - APP'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APP09_IPV2 as projection on ZPP_APP09_IRV2
{
    key Jobshtnum,
    key Sno,
    Matnr,
    Werks,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Comqty,
    Uom,
    @Semantics.quantity.unitOfMeasure: 'Stcuom'
    Stocqty,
    Stcuom,
    Btach,
    Strgloc,
    /* Associations */
    _hdr : redirected to parent ZPP_APP09_PV
}
