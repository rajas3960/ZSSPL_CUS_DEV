@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Requistion Report Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_PURREQ_RV as select from I_PurchaseRequisitionAPI01 as PREQH
inner join I_PurchaseRequisitionItemAPI01 as PREQI on PREQI.PurchaseRequisition = PREQH.PurchaseRequisition
left outer join I_PurReqnAcctAssgmtAPI01 as preqacc on preqacc.PurchaseRequisition = PREQI.PurchaseRequisition and preqacc.PurchaseRequisitionItem = PREQI.PurchaseRequisitionItem
left outer join I_CostCenterText as CONA on CONA.CostCenter = preqacc.CostCenter and CONA.Language = 'E'
left outer join I_PurchasingGroup as Pgr on Pgr.PurchasingGroup = PREQI.PurchasingGroup 
left outer join ZMM_PURC_REG_RE as pru on pru.PurchaseOrder = PREQI.PurchasingDocument and pru.PurchaseOrderItem = PREQI.PurchasingDocumentItem 
left outer join zsd_image_dom as img on 'X' = img.FIXED_VAL
{
 key PREQH.PurchaseRequisition as purreq_no,
 key PREQI.PurchaseRequisitionItem as purreq_itno,
 PREQH.PurReqnDescription as Hdesc,
 PREQI.PurchaseRequisitionItemText as itemtext,
 @Semantics.quantity.unitOfMeasure: 'BaseUnit'
 PREQI.RequestedQuantity as REQ,
 PREQI.BaseUnit,
 PREQI.PurReqnItemCurrency as curr,

 cast(PREQI.PurchaseRequisitionPrice as abap.dec(11,2)) as PERPRICE,
 
 cast(PREQI.ItemNetAmount as abap.dec(11,2))as NET_AMT,
 preqacc.CostCenter,
 preqacc.GLAccount,
 CONA.CostCenterDescription as COSTNAME,
 PREQI.YY1_Remarks_PRI as remarks,
 PREQI.DeliveryDate as reqdate,
 PREQI.PurReqCreationDate as indetdate,
 Pgr.PurchasingGroupName as dept,
// pru.GRDocument,
// pru.VendorName,
 PREQI.PurchasingDocument,
 PREQI.PurchasingDocumentItem,
 @Semantics.durationInDays: true
cast( dats_days_between( PREQI.PurReqCreationDate , PREQI.DeliveryDate ) as abap.int4 )  as REQDays,
 @Semantics.imageUrl: true
 img.IMAGES as imge
 
 
 
   }
