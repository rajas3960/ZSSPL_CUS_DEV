@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Entity-Purchase Requestion'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZMM_PURCHASE_REQ_Root as select from ZMM_PURCHASE_REQ_RV
{

    key purreq_no,
    key purreq_itno,
    Hdesc,
    itemtext,
    @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    REQ,
    BaseUnit,
    curr,
     @Semantics.amount.currencyCode: 'curr'
    PERPRICE,
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
    REQDays
}
