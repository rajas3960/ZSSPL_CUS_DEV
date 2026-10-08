@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Requistion Projection View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZMM_PURREQ_PV provider contract transactional_query as projection on  ZMM_PURREQ_RV
{
    key purreq_no,
    key purreq_itno,
    Hdesc,
    itemtext,
    @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    @Aggregation.default: #SUM @Aggregation.exception: #LAST
    REQ,
    
    BaseUnit,
    curr,
    @Semantics.amount.currencyCode: 'curr'
    PERPRICE,
    @Aggregation.default: #SUM @Aggregation.exception: #LAST
    @Semantics.amount.currencyCode: 'curr'
    NET_AMT,
    CostCenter,
    GLAccount,
    COSTNAME,
    remarks,
    reqdate,
    indetdate,
    dept,
//    GRDocument,
//    VendorName,
    PurchasingDocument,
    PurchasingDocumentItem,
    @Semantics.durationInDays: true
    REQDays,
    @Semantics.imageUrl: true
    imge
     
}
