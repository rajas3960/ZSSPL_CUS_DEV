@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection view of jobsheet child entity view2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zpp_app08_IPV2 as projection on zpp_app08_IREV2
{
    key Jobsheet,
    key Orderno,
    matnr,
    maktx,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Plnqty,
    Uom,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Reqty,
    Createdby,
    Createdon,
    Plant,
    /* Associations */
    _hdr: redirected to parent zpp_app08_PV1
}
