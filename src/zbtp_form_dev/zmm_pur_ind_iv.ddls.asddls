@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Indent - Root View Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_PUR_IND_IV
  as select from ZMM_PUR_IND_RE
   association [0..*] to  ZMM_PUR_IND_RV as _Header on $projection.Purcreq = _Header.purreq_no
                                                     and $projection.purreqitno = _Header.purreq_itno
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
      _Header.CostCenter,
      _Header.COSTNAME,
      _Header
}
