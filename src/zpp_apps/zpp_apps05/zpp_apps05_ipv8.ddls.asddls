@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Projection View Smv'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_IPV8 as projection on ZPP_APPS05_IRV8
{
    key Uuid,
    key Sno,
    Vrno,
    Length,
    width,
    Apcs,
    Used,
    Rqty,
    Uqty,
    Wasper,
    Rtrn,
    Netwst,
    Quanwt,
    Irno,
    Matnr,
 Batch,      
  Plant,
 Storagelocation,
  Matnoitno,
    /* Associations */
    _hdr : redirected to parent ZPP_APPS05_PV
}
