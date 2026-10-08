@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection view of jobsheet child entity view1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define  view entity zpp_app08_IPV1 as projection on zpp_app08_IREV1
{
    key Jobsheetno,
    key Orderno,
    plant,
    matnr,
    maktx,
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
    Rsnum,
    Createdby,
    Createdon,
    /* Associations */
    _hdr: redirected to parent zpp_app08_pv1
}
