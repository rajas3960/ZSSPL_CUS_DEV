@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order - Projection View GI & GR'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZPP_APPS07_IPV as projection on ZPP_APPS07_IRV
{
    key Vrno,
    key Sno,
     key Pardtm,
    Uuid,
    Orderno,
    Plant,
    Matnr,
    Maktx,
//        @Semantics.quantity.unitOfMeasure: 'uom'
    Plnqty,
//        @Semantics.quantity.unitOfMeasure: 'uom'
    Reqty,
    Uom,
    Vbeln,
    Length,
    Width,
    Wetpc,
    Netwt,
    Jobsht,
    Operation,
     Resv,
    ReservationItem,
    SalesOrderItem,
    srclent,
    /* Associations */
    _hdr : redirected to parent ZPP_APPS07_PV
}
