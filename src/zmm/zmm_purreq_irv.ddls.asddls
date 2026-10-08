//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Purchase Indent report Item child entity'
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
//define view entity ZMM_PURREQ_IRV as select from I_PurchaseRequisitionItemAPI01 as PREQI 
//left outer join zmm_purchase_reg as pru on pru.Material = PREQI.Material 
//left outer join ZMM_MATSTC as mat on mat.Material = PREQI.Material 
//left outer join I_Plant as pl on pl.Plant = PREQI.Plant and PREQI.Language = 'E'
//association to parent ZMM_PURREQ_HRV as _header on $projection.purreq_no = _header.indentno
//
//{
//  key PREQI.PurchaseRequisition as purreq_no,
// key ltrim(PREQI.PurchaseRequisitionItem,'0') as purreq_itno,
// PREQI.PurchaseRequisitionItemText as itemtext,
//concat(
//    concat(
//        concat(
//            concat(
//                concat(
//                    PREQI.PurchaseRequisitionItemText,
//                    concat(' :', ltrim(PREQI.Material,'0'))
//                ),
//                concat(' Remark : ', PREQI.YY1_Remarks_PRI)
//            ),
//            concat(
//                ' ReqDate : ',
//                concat(
//                    concat(
//                        substring(PREQI.DeliveryDate, 7, 2),
//                        concat('.', substring(PREQI.DeliveryDate, 5, 2))
//                    ),
//                    concat('.', substring(PREQI.DeliveryDate, 1, 4))
//                )
//            )
//        ),
//        ' ReqDays : '
//    ),
//    cast(
//        dats_days_between(PREQI.PurReqCreationDate, PREQI.DeliveryDate)
//        as abap.char(20)
//    )
//) as itemdecs
//,
//
//@Aggregation.default: #SUM @Aggregation.exception: #LAST
//sum(cast(PREQI.RequestedQuantity as abap.dec(23,3))) as REQ,
//// @Semantics.quantity.unitOfMeasure: 'BaseUnit' 
// mat.STcok  as stock,
// pl.PlantName as div,
// PREQI.BaseUnit,
// PREQI.PurReqnItemCurrency as curr,
// cast(PREQI.PurchaseRequisitionPrice as abap.dec(15,2)) as PERPRICE,
// @Aggregation.default: #SUM @Aggregation.exception: #LAST
//sum(cast(PREQI.ItemNetAmount as abap.dec(23,2))) as NET_AMT,
// PREQI.YY1_Remarks_PRI as remarks,
// PREQI.DeliveryDate as reqdate,
// PREQI.PurReqCreationDate as indetdate,
// pru.GRDocument,
// pru.VendorName,
//// PREQI.PurchasingDocument,
//// PREQI.PurchasingDocumentItem,
// PREQI.Plant,
// @Semantics.durationInDays: true
//cast( dats_days_between( PREQI.PurReqCreationDate , PREQI.DeliveryDate ) as abap.int4 )  as REQDays  ,
//
//concat(
//    concat(
//        concat(
//            concat(
//                coalesce(pru.GRDocument, ''),
//                concat('/', coalesce(pru.PurchaseOrder, ''))
//            ),
//            concat(
//                '/',
//                coalesce(replace(pru.VendorName, '&', 'and'), '')
//            )
//        ),
//        concat(
//            '/',
//            coalesce(cast(pru.NetAmount as abap.char(20)), '')
//        )
//    ),
//    ''
//) as lastgrnpov
//,
// 
///* association */
//_header
//
//}
//where PREQI.IsDeleted <> 'X'
//group by
//    PREQI.PurchaseRequisition,
//    PREQI.PurchaseRequisitionItem,
//    PREQI.PurchaseRequisitionItemText,
//    PREQI.Material,
//    PREQI.YY1_Remarks_PRI,
//    PREQI.DeliveryDate,
//    PREQI.PurReqCreationDate,
//    mat.STcok,
//    pl.PlantName,
//    PREQI.BaseUnit,
//    PREQI.PurReqnItemCurrency,
//    PREQI.PurchaseRequisitionPrice,
//    pru.GRDocument,
//    pru.VendorName,
//    PREQI.Plant,
//    pru.PurchaseOrder,
//    pru.NetAmount
//
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Indent report Item child entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_PURREQ_IRV 
  as select from I_PurchaseRequisitionItemAPI01 as PREQI

  /* Latest GR per material (unique) */
  left outer join ZMM_MAXGR as pru
       on pru.Material = PREQI.Material

  left outer join ZMM_MATSTC as mat 
       on mat.Material = PREQI.Material 

  left outer join I_Plant as pl 
       on pl.Plant = PREQI.Plant 
      and PREQI.Language = 'E'

  association to parent ZMM_PURREQ_HRV as _header 
       on $projection.purreq_no = _header.indentno

{
  /* KEYS */
  key PREQI.PurchaseRequisition              as purreq_no,
  key PREQI.PurchaseRequisitionItem as purreq_itno,

  PREQI.PurchaseRequisitionItemText          as itemtext,

  /* ITEM LONG TEXT */
  concat(
      concat(
          concat(
              concat(
                  concat(
                      PREQI.PurchaseRequisitionItemText,
                      concat(' :', ltrim(PREQI.Material,'0'))
                  ),
                  concat(' Remark : ', PREQI.YY1_Remarks_PRI)
              ),
              concat(
                  ' ReqDate : ',
                  concat(
                      concat(
                          substring(PREQI.DeliveryDate, 7, 2),
                          concat('.', substring(PREQI.DeliveryDate, 5, 2))
                      ),
                      concat('.', substring(PREQI.DeliveryDate, 1, 4))
                  )
              )
          ),
          ' ReqDays : '
      ),
      cast(
          dats_days_between(PREQI.PurReqCreationDate, PREQI.DeliveryDate)
          as abap.char(20)
      )
  ) as itemdecs,

  /* REQUESTED QTY */
  @Aggregation.default: #SUM 
  @Aggregation.exception: #LAST
  sum(cast(PREQI.RequestedQuantity as abap.dec(23,3))) as REQ,

  mat.STcok                    as stock,
  pl.PlantName                 as div,
  PREQI.BaseUnit,
  PREQI.PurReqnItemCurrency as curr,
  cast(PREQI.PurchaseRequisitionPrice as abap.dec(15,2)) as PERPRICE,

  @Aggregation.default: #SUM 
  @Aggregation.exception: #LAST
  sum(cast(PREQI.ItemNetAmount as abap.dec(23,2)))      as NET_AMT,

  PREQI.YY1_Remarks_PRI        as remarks,
  PREQI.DeliveryDate           as reqdate,
  PREQI.PurReqCreationDate     as indetdate,

  /* ===== GR FIELDS WITH MAX (NO DUPLICATES) ===== */

  @Aggregation.default: #MAX
  max( pru.MaterialDocument )        as GRDocument,

  @Aggregation.default: #MAX
  max( pru.MaterialDocumentItem )    as GRItem,

  @Aggregation.default: #MAX
  max( pru.Supplier )                as VendorName,

  @Aggregation.default: #MAX
  max( pru.PurchaseOrder )           as PurchaseOrder,

  @Aggregation.default: #MAX
  max( pru.PurchaseOrderItem )       as PurchaseOrderItem,

  /* LAST GR SUMMARY TEXT */
  concat(
      concat(
          concat(
              concat(
                  coalesce(max(pru.MaterialDocument), ''),
                  concat('/', coalesce(max(pru.PurchaseOrder), ''))
              ),
              concat('/', coalesce(max(pru.Supplier), ''))
          ),
          concat('/', coalesce(cast(max(pru.MaterialDocumentItem) as abap.char(20)), ''))
      ),
      ''
  ) as lastgrnpov,

  PREQI.Plant,

  /* DAYS DIFF */
  @Semantics.durationInDays: true
  cast(
      dats_days_between(PREQI.PurReqCreationDate , PREQI.DeliveryDate ) 
      as abap.int4 
  ) as REQDays,

  _header

}
where PREQI.IsDeleted <> 'X'
group by
    PREQI.PurchaseRequisition,
    PREQI.PurchaseRequisitionItem,
    PREQI.PurchaseRequisitionItemText,
    PREQI.Material,
    PREQI.YY1_Remarks_PRI,
    PREQI.DeliveryDate,
    PREQI.PurReqCreationDate,
    mat.STcok,
    pl.PlantName,
    PREQI.BaseUnit,
    PREQI.PurReqnItemCurrency,
    PREQI.PurchaseRequisitionPrice,
    PREQI.Plant;
