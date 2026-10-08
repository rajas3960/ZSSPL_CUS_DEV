@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Item View Entity 4 Stock'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_IRV4 as select from zpp_apps05_itb4
association to parent ZPP_APPS05_RV as _Hdr on _Hdr.Uuid  = $projection.Uuid 
{
    key uuid as Uuid,
    key sno as Sno,
    vrno as Vrno,
    length as Length,
    quantity as Quantity,
     quanwt  as Quanwt,   
    irno as Irno,
           matnr      as Matnr,
  batch           as Batch,
  plant           as Plant,
  storagelocation as Storagelocation,
   matnoitno       as Matnoitno,
    _Hdr
}
