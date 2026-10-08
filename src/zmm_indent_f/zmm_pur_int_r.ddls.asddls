@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Indent -Root Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_PUR_INT_R as select from I_PurchaseRequisitionAPI01     as PR
   
    inner join      I_PurchaseRequisitionItemAPI01 as PI    on PI.PurchaseRequisition = PR.PurchaseRequisition    
 
{
  key PI.PurchaseRequisition                                                               as Purcreq,
  key PI.PurchaseRequisitionItem                                                           as purreqitno,
      PI.PurchasingDocument,
      PI.PurchasingDocumentItem,
      PI.PurchaseRequisitionItemText                                                       as Itemtext,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      PI.RequestedQuantity                                                                 as Req,
      PI.BaseUnit,
      PI.PurReqnItemCurrency                                                               as Curr,
      @Semantics.amount.currencyCode: 'curr'
      PI.PurchaseRequisitionPrice                                                          as Perprice,
      @Semantics.amount.currencyCode: 'curr'
      PI.ItemNetAmount                                                                     as Netamt,
      PI.YY1_Remarks_PRI                                                                   as Remarks,
      PI.DeliveryDate                                                                      as Reqdate,
      PI.PurReqCreationDate                                                                as Indetdate,
      @Semantics.durationInDays: true
      cast( dats_days_between( PI.PurReqCreationDate , PI.DeliveryDate ) as abap.int4 ) as REQDays
    
}
