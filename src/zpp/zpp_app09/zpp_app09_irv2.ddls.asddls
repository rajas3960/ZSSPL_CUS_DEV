@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order Good Issue - APP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APP09_IRV2 as select from zpp_app09_itb2
association to parent zpp_app09_rv as _hdr  on _hdr.jobshtnum = $projection.Jobshtnum and _hdr.werks = $projection.Werks
{
    key jobshtnum as Jobshtnum,
    key sno as Sno,
    matnr as Matnr,
    werks as Werks,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    comqty as Comqty,
    uom as Uom,
    @Semantics.quantity.unitOfMeasure: 'Stcuom'
    stocqty as Stocqty,
    stcuom as Stcuom,
    btach as Btach,
    strgloc as Strgloc,
    _hdr
}
