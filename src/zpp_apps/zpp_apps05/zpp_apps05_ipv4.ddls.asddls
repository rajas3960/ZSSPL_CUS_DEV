@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Projection Item View Stock'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_IPV4
  as projection on ZPP_APPS05_IRV4
{
  key Uuid,
  key Sno,
      Vrno,
      Length,
      Quantity,
      Quanwt,
      Irno,
      Matnr,
      Batch,
      Plant,
      Storagelocation,
       Matnoitno,
      /* Associations */
      _Hdr : redirected to parent ZPP_APPS05_PV
}
