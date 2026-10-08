@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MIS Details Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPP_REP_CV 
provider contract transactional_query
as projection on ZPP_REP_RV

{
    key Salesorder,
    key SaleslineItem,
    key Plant,
    PricingReferenceMaterial,
    SoldToParty,
    SoldToPartyName,
    ShipToParty,
    ShipToPartyName,
    ProductNumber,
    ItemDescription,
    @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    OrderQuantity,
    OrderQuantityUnit,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    Ratekg,
    TransactionCurrency,
    @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
    ProductionQuantityDIN,
    ConfirmationUnit,
    @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
    DispatchedQty,
    BillingQuantityUnit,
    @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
    BalanceQuantity,
    BalanceAmount
}
