@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Report Projection View - Indent'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZMM_PUR_IND_P  provider contract transactional_query
  as projection on ZMM_PUR_IND_R
{
    key PURCREQ,
    key purreqitno,
    Hdesc,
    itemtext,
    @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    REQ,
    BaseUnit,
    curr,
    @Semantics.amount.currencyCode: 'Curr'
    PERPRICE,
    @Semantics.amount.currencyCode: 'Curr'
    NETAMT,
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
