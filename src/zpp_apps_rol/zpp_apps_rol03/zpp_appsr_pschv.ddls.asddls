@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order Schedule View'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPSR_PSCHV as select from I_PurOrdScheduleLineAPI01
{
key PurchaseOrder,
key PurchaseOrderItem,
key max( PurchaseOrderScheduleLine ) as PurchaseOrderScheduleLine ,
max(SchedLineStscDeliveryDate) as SchedLineStscDeliveryDate


}
group by
PurchaseOrder,
PurchaseOrderItem
