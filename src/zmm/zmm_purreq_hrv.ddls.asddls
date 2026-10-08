@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Indent report Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity ZMM_PURREQ_HRV as select from I_PurchaseRequisitionAPI01 as Prh
inner join ZMM_PURCHASERQ_ITEM as puritm on puritm.PurchaseRequisition = Prh.PurchaseRequisition 
left outer join I_PurchasingGroup as purgrp on purgrp.PurchasingGroup = puritm.PurchasingGroup
left outer join I_PurReqnAcctAssgmtAPI01 as puracc on puracc.PurchaseRequisition = puritm.PurchaseRequisition and puracc.PurchaseRequisitionItem = puritm.PurchaseRequisitionItem
left outer join I_CostCenterText as CONA on CONA.CostCenter = puracc.CostCenter and CONA.Language = 'E'
left outer join zmm_app_attch as atc on atc.purreq = Prh.PurchaseRequisition
association[1..1] to zsd_image_dom as _image on 'X' = _image.FIXED_VAL
composition[0..*] of ZMM_PURREQ_IRV as _item
{
 key Prh.PurchaseRequisition as indentno,
 puritm.YY1_Purpose_PRI as Header_dec,
 puritm.YY1_Purpose_PRI as Req_type,
 Prh.LastChangeDateTime ,
 puritm.YY1_DepartmentR_PRI as dept,
 CONA.CostCenterDescription as Costname,
 puritm.PurchaseReqnCreationDate as indentdate,
 /* Associations */
 _image,
 @Semantics.imageUrl: true
 _image.IMAGES,
 cast('Purchase Indent No' as abap.char(20)) as Name,

case puritm.Plant
  when '1010' then cast(
    concat(
      'Works UNIT I : PLOT NO1 TO 4, Wanjra Layout,Kamptee Road,Nagpur 440026',
      'Email :- shilpa_ngp@shilparl.com'
    ) as abap.char(200)
  )

  when '1020' then cast(
    'Works UNIT II: PLOT NO B-209,MIDC,Butibori,Nagpur 441108 off: 07104-665200' as abap.char(200)
  )

  when '1030' then cast(
    'UNIT II: TLT Div.:- PLOT NO B-209,MIDC,Butibori,Nagpur 441108 off: 07104-665200' as abap.char(200)
  )

  when '1040' then cast(
    'UNIT II: Fasteners Div.:- PLOT NO B-209,MIDC,Butibori,Nagpur 441108 off: 07104-665200' as abap.char(200)
  )

  else cast('' as abap.char(200))
end as Plant,

puritm.Plant as Plantt,
atc.minetype,
atc.filename,
atc.attachment,
  
 _item
 
}
