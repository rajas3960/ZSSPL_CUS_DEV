@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Report Header PV - BOM Summary'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZSD_REP_PV provider contract transactional_query as projection on ZSD_REP_RV
{
    key SalesDocument,
    SalesDocumentType,
    SalesDocumentDate,
    PurchaseOrderByCustomer,
    CustomerPurchaseOrderDate,
    YY1_PriorityPONos_SDH,
    SoldToParty,
    CustomerName,
    BPAddrStreetName,
    PostalCode,
    CityName,
    YY1_Gstno_sd_SDH,
    YY1_Statename_Sd_SDH,
    ShipToCustomer,
    Customer_Name,
    StreetName,
    Postal_Code,
    City_Name,    
     @Semantics.largeObject:{
      mimeType: 'mimetype',
      fileName: 'filename',
      contentDispositionPreference: #INLINE
      }
    Attachment,
    Mimetype,
    Filename,
    /* Associations */
    Item : redirected to composition child ZSD_REP_IPV
    
}
