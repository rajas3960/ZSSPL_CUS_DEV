@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ffffff'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ztesting2 as select from I_MaterialDocumentItem_2
{
key MaterialDocument,
key MaterialDocumentItem,
key MaterialDocumentYear,
 substring(InvtryMgmtRefDocumentItem,2,4) as InvtryMgmtRefDocumentItem,
 InvtryMgmtReferenceDocument,
 PurchaseOrder,
 PurchaseOrderItem
}

