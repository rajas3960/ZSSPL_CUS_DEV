@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order Header View entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_CHALLAN_POH as select from I_PurchaseOrderAPI01 
{
    key PurchaseOrder,
    PurchaseOrderType
    
} where PurchaseOrderType = 'ZSUB'
