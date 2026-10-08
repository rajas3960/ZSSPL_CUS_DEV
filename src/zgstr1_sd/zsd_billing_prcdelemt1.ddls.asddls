@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I_Billingdocumentprcingelement'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_BILLING_PRCDELEMT1 as select from I_BillingDocumentItemPrcgElmnt
{
  key BillingDocument,
  key BillingDocumentItem,
  key PricingProcedureStep,
  ConditionType,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  max(ConditionAmount) as ConditionAmount ,
  TransactionCurrency,
  ConditionInactiveReason,
  ConditionRateRatio,
  ConditionCurrency,
  ConditionRateRatioUnit,
  TaxCode,
  max(ConditionRateValue) as ConditionRateValue,
    ConditionQuantityUnit,
  @Semantics.quantity.unitOfMeasure: 'ConditionQuantityUnit'
  max( ConditionBaseQuantity ) as ConditionBaseQuantity
  

  
} where ConditionInactiveReason <> 'X'
group by 
  BillingDocument,
   BillingDocumentItem,
  PricingProcedureStep,
  ConditionType,
  TransactionCurrency,
  ConditionInactiveReason,
  ConditionRateRatio,
  ConditionCurrency,
  ConditionRateRatioUnit,
    TaxCode,
    ConditionQuantityUnit
