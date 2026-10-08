@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Item View Entity 5 Stock'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_IRV5 as select from zpp_apps05_itb5
association to parent ZPP_APPS05_RV as _Hdr on _Hdr.Uuid = $projection.Uuid
{
    key uuid as Uuid,
    key materialdoc as Materialdoc,
    key matdocitm as Matdocitm,
    key purchaseorder as Purchaseorder,
    key purchaseorderitem as Purchaseorderitem,
    key product as Product,
    key plant as Plant,
    key storagelocation as Storagelocation,
    key batch as Batch,
    length as Length,
    width as Width,
    piecs as Piecs,
    apiecs as Apiecs,
      rpiecs     as Rpiecs,
  rquantity      as Rquantity,
    quantity as Quantity,
    aquatity as Aquatity,
    irno as       Irno,
    pripono as    Pripono,
    supp as       Supp,
     mark   as Mark,
    
    _Hdr
}
