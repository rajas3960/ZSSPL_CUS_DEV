@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Billing Document Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_MATERIAL_BILL as select from I_BillingDocument as bdh
inner join I_BillingDocumentItem as bdi on bdi.BillingDocument = bdh.BillingDocument
{
    key bdi.BillingDocument,
    key bdi.BillingDocumentItem,
    bdi.ReferenceSDDocument ,
    substring(bdi.ReferenceSDDocumentItem,3,4) as ReferenceSDDocumentItem,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    bdi.NetAmount,
    bdi.TransactionCurrency,
    @Semantics.quantity.unitOfMeasure:'BillingQuantityUnit'
    bdi.BillingQuantity,
    bdi.BillingQuantityUnit,
    bdi.MaterialGroup
    
    
} where bdh.BillingDocumentType = 'JSN'
