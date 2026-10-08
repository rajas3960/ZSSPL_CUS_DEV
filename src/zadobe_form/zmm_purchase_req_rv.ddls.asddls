//@AbapCatalog.sqlViewName: 'ZMM_PUR_REQ'
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Requsition Root View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZMM_PURCHASE_REQ_RV
  as select from    I_PurchaseRequisitionAPI01     as PREQH
    inner join      I_PurchaseRequisitionItemAPI01 as PREQI   on PREQI.PurchaseRequisition = PREQH.PurchaseRequisition
    left outer join I_PurReqnAcctAssgmtAPI01       as preqacc on  preqacc.PurchaseRequisition     = PREQI.PurchaseRequisition
                                                              and preqacc.PurchaseRequisitionItem = PREQI.PurchaseRequisitionItem
    left outer join I_CostCenterText               as CONA    on  CONA.CostCenter = preqacc.CostCenter
                                                              and CONA.Language   = 'E'
    left outer join I_PurchasingGroup              as Pgr     on Pgr.PurchasingGroup = PREQI.PurchasingGroup
//    left outer join ZMM_PURC_REG_RE                as pru     on  pru.PurchaseOrder     = PREQI.PurchasingDocument
//                                                              and pru.purchaseorderitem = PREQI.PurchasingDocumentItem
{
  key PREQH.PurchaseRequisition                                                               as purreq_no,
  key PREQI.PurchaseRequisitionItem                                                           as purreq_itno,
      PREQH.PurReqnDescription                                                                as Hdesc,
      PREQI.PurchaseRequisitionItemText                                                       as itemtext,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      PREQI.RequestedQuantity                                                                 as REQ,
      PREQI.BaseUnit,
      PREQI.PurReqnItemCurrency                                                               as curr,
      @Semantics.amount.currencyCode: 'curr'
      PREQI.PurchaseRequisitionPrice                                                          as PERPRICE,
      @Semantics.amount.currencyCode: 'curr'
      PREQI.ItemNetAmount                                                                     as NET_AMT,
      preqacc.CostCenter,
      preqacc.GLAccount,
      CONA.CostCenterDescription                                                              as COSTNAME,
      PREQI.YY1_Remarks_PRI                                                                   as remarks,
      PREQI.DeliveryDate                                                                      as reqdate,
      PREQI.PurReqCreationDate                                                                as indetdate,
      Pgr.PurchasingGroupName                                                                 as dept,
//      pru.GRDocument,
//      pru.VendorName,
      PREQI.PurchasingDocument,
      PREQI.PurchasingDocumentItem,
      @Semantics.durationInDays: true
      cast( dats_days_between( PREQI.PurReqCreationDate , PREQI.DeliveryDate ) as abap.int4 ) as REQDays


}
