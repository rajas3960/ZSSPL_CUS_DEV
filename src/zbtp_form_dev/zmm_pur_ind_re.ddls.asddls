@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_PUR_IND_RE
  as select from   I_PurchaseRequisitionAPI01     as PREQH
   
    inner join      I_PurchaseRequisitionItemAPI01 as PREQI    on PREQI.PurchaseRequisition = PREQH.PurchaseRequisition    
 
{
  key PREQI.PurchaseRequisition                                                               as Purcreq,
  key PREQI.PurchaseRequisitionItem                                                           as purreqitno,
      PREQI.PurchasingDocument,
      PREQI.PurchasingDocumentItem,
      PREQI.PurchaseRequisitionItemText                                                       as Itemtext,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      PREQI.RequestedQuantity                                                                 as Req,
      PREQI.BaseUnit,
      PREQI.PurReqnItemCurrency                                                               as Curr,
      @Semantics.amount.currencyCode: 'curr'
      PREQI.PurchaseRequisitionPrice                                                          as Perprice,
      @Semantics.amount.currencyCode: 'curr'
      PREQI.ItemNetAmount                                                                     as Netamt,
      PREQI.YY1_Remarks_PRI                                                                   as Remarks,
      PREQI.DeliveryDate                                                                      as Reqdate,
      PREQI.PurReqCreationDate                                                                as Indetdate,
      @Semantics.durationInDays: true
      cast( dats_days_between( PREQI.PurReqCreationDate , PREQI.DeliveryDate ) as abap.int4 ) as REQDays
}
