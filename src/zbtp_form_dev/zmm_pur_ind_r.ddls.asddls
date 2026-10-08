@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Report Root Entity - Indent'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root  view entity ZMM_PUR_IND_R
  as select from    I_PurchaseRequisitionAPI01     as PREQH
    inner join      I_PurchaseRequisitionItemAPI01 as PREQI   on PREQI.PurchaseRequisition = PREQH.PurchaseRequisition
    left outer join I_PurReqnAcctAssgmtAPI01       as preqacc on  preqacc.PurchaseRequisition     = PREQI.PurchaseRequisition
                                                              and preqacc.PurchaseRequisitionItem = PREQI.PurchaseRequisitionItem
    left outer join I_CostCenterText               as CONA    on  CONA.CostCenter = preqacc.CostCenter
                                                              and CONA.Language   = 'E'
    left outer join I_PurchasingGroup              as Pgr     on Pgr.PurchasingGroup = PREQI.PurchasingGroup
    left outer join ZMM_PURC_REG_RE                as pru     on  pru.PurchaseOrder     = PREQI.PurchasingDocument
                                                              and pru.PurchaseOrderItem = PREQI.PurchasingDocumentItem
{
  key PREQH.PurchaseRequisition                                                               as PURCREQ ,
  key PREQI.PurchaseRequisitionItem                                                           as purreqitno,
      PREQH.PurReqnDescription                                                                as Hdesc,
      PREQI.PurchaseRequisitionItemText                                                       as itemtext,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      PREQI.RequestedQuantity                                                                 as REQ,
      PREQI.BaseUnit,
      PREQI.PurReqnItemCurrency                                                               as curr,
      @Semantics.amount.currencyCode: 'curr'
      PREQI.PurchaseRequisitionPrice                                                          as PERPRICE,
      @Semantics.amount.currencyCode: 'curr'
      PREQI.ItemNetAmount                                                                     as NETAMT,
      preqacc.CostCenter,
      preqacc.GLAccount,
      CONA.CostCenterDescription                                                              as COSTNAME,
      PREQI.YY1_Remarks_PRI                                                                   as remarks,
      PREQI.DeliveryDate                                                                      as reqdate,
      PREQI.PurReqCreationDate                                                                as indetdate,
      Pgr.PurchasingGroupName                                                                 as dept,
      pru.GRDocument,
      pru.VendorName,
      PREQI.PurchasingDocument,
      PREQI.PurchasingDocumentItem,
      @Semantics.durationInDays: true
      cast( dats_days_between( PREQI.PurReqCreationDate , PREQI.DeliveryDate ) as abap.int4 ) as REQDays
 
}
  
