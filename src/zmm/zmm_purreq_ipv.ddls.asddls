@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View On Item level'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity zmm_purreq_ipv as projection on ZMM_PURREQ_IRV
{
    key purreq_no,
    key purreq_itno,
    itemtext,
    itemdecs,
    REQ,
//     @Semantics.quantity.unitOfMeasure: 'BaseUnit' 
    stock,
    div,
    BaseUnit,
    curr,
    PERPRICE,
    NET_AMT,
    remarks,
    reqdate,
    indetdate,
    GRDocument,
    VendorName,
//    PurchasingDocument,
//    PurchasingDocumentItem,
    Plant,
    REQDays,
    lastgrnpov,
    /* Associations */
    _header :  redirected to parent ZMM_PURREQ_HPV
  
}
