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
define view entity ZPP_APP09_IPV1 as select from ZPP_APP03_IRV2
{
key Jobsheet as Jobshtnum,
key Orderno,
Orderitem,
Resev,
Matnr,
Maktx,
 @Semantics.quantity.unitOfMeasure: 'Uom'
Plndqty,
Uom,
 @Semantics.quantity.unitOfMeasure: 'Uom'
sum(Reqty) as Reqty,
Createdby,
Createdon,
Plant,
Vbeln,
Soitem,
/* Associations */
_hdr

}
group by 
Jobsheet ,
 Orderno,
Orderitem,
Resev,
Matnr,
Maktx,

Plndqty,
Uom,
Createdby,
Createdon,
Plant,
Vbeln,
Soitem
