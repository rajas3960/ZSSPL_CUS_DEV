@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Indent -Root PEntity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_PUR_IND_IPV provider contract transactional_query
  as projection on ZMM_PUR_IND_IV
{
    key Purcreq,
    key purreqitno,
    PurchasingDocument,
    PurchasingDocumentItem,
    Itemtext,
    @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    Req,
    BaseUnit,
    Curr,
    @Semantics.amount.currencyCode: 'curr'
    Perprice,
    @Semantics.amount.currencyCode: 'curr'
    Netamt,
    Remarks,
    Reqdate,
    Indetdate,
    REQDays,
    CostCenter,
    COSTNAME,
    /* Associations */
    _Header
}
