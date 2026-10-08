@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PR First Line Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMM_PR_FIRST_ITEM as select from I_PurchaseRequisitionItemAPI01
{
    key PurchaseRequisition,
    key min(PurchaseRequisitionItem) as PurchaseRequisitionItem
    
}group by PurchaseRequisition
