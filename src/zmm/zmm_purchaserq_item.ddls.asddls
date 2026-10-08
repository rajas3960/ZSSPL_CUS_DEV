@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase req. item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMM_PURCHASERQ_ITEM as select from ZMM_PR_FIRST_ITEM as poi

inner join I_PurchaseRequisitionItemAPI01 as poii on poii.PurchaseRequisition = poi.PurchaseRequisition and poii.PurchaseRequisitionItem = poi.PurchaseRequisitionItem
{
    key poi.PurchaseRequisition,
    key poi.PurchaseRequisitionItem as PurchaseRequisitionItem,
  
    poii.YY1_Purpose_PRI as YY1_Purpose_PRI,
     poii.YY1_DepartmentR_PRI as YY1_DepartmentR_PRI,
    poii.Plant as Plant ,
  
    poii.PurchaseReqnCreationDate as PurchaseReqnCreationDate,
    poii.PurchasingGroup as PurchasingGroup
  
}
