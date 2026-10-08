@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Items grouping'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_APP02_ITRV as select from I_SalesDocumentItem
{
    key SalesDocument,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum(TaxAmount) as TaxAmount,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum(NetAmount) as NetAmount,
    TransactionCurrency
   
}
group by 
SalesDocument,
TransactionCurrency
