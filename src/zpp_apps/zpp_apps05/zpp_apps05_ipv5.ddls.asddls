@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Projection Item View 5 Stok'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity ZPP_APPS05_IPV5
  as projection on ZPP_APPS05_IRV5
{
  key Uuid,
      @Search.defaultSearchElement: true
  key Materialdoc,
  key Matdocitm,
      @Search.defaultSearchElement: true
  key Purchaseorder,
  key Purchaseorderitem,
      @Search.defaultSearchElement: true
  key Product,
  key Plant,
  key Storagelocation,
  key Batch,
      Length,
      Width,
      Piecs,
      Apiecs,
  
   @EndUserText.label: 'Request Pieces'
   Rpiecs,

      @EndUserText.label: 'Request Quantity'
 Rquantity,
      Quantity,
      Aquatity,
      Irno,
       @Search.defaultSearchElement: true
//       @Search.defaultSearchElement: true
 @Search.fuzzinessThreshold: 0.5
      @Search.ranking: #HIGH
      Pripono,
      Supp,
      Mark,
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_HIDE_VIRT'
    virtual ishide : abap_boolean,
      /* Associations */
      _Hdr : redirected to parent ZPP_APPS05_PV
}
