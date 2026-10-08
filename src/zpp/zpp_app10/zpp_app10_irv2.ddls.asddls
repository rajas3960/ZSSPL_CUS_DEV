@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order Good Recipts - APP'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zpp_app10_irv2 as select from ZPP_APP09_IRV2
{
    key Jobshtnum,
    key Sno,
    Matnr,
    Werks,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Comqty,
    Uom,
     @Semantics.quantity.unitOfMeasure: 'Uom'
    Stocqty,
    Stcuom,
    Btach,
    Strgloc,
    /* Associations */
    _hdr
}
