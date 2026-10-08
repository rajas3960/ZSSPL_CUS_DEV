@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order - Item View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS07_IRV
  as select from ZPP_APPS07_RRV01
  association to parent ZPP_APPS07_RV as _hdr on _hdr.Vrno = $projection.Vrno
{
  key  Vrno,
  key  Sno,
  key  Pardtm,
       Uuid,
       Orderno,
       Plant,
       Matnr,
       Maktx,
       Plnqty,
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

       _hdr
}
