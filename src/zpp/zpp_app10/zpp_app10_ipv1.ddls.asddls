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
define view entity zpp_app10_ipv1 as select from ZPP_APP09_IPV1
{
    key Jobshtnum,
    key Orderno,
    Orderitem,
    Resev,
    Matnr,
    Maktx,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Plndqty,
    Uom,
     @Semantics.quantity.unitOfMeasure: 'Uom'
    Reqty,
    Createdby,
    Createdon,
    Plant,
    Vbeln,
Soitem,
    /* Associations */
    _hdr
}
