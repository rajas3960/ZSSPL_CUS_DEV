@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Grouping Of Material'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_PURREQ_MATERIAL as select from ZMM_MAXGR  as mdi
 
{ 
    key mdi.Material,
    key mdi.MaterialDocument,
    key mdi.MaterialDocumentYear,
    key mdi.MaterialDocumentItem,
    mdi.PostingDate,
    mdi.PurchaseOrder,
    mdi.PurchaseOrderItem,
    mdi.Supplier,
    mdi.CostCenter
}

  
