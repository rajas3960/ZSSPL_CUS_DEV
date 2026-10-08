@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order LC Utilization Amount Application Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_APP02_HRV as select from I_SalesDocument as _SDH
association[1..1] to ZSD_APP02_ITRV as _ITM on _ITM.SalesDocument = $projection.SalesDocument
composition[0..*] of ZSD_APP02_IRV as _litem
{
key _SDH.SalesDocument,
      _SDH.SoldToParty,
      _SDH.SalesDocumentDate,
      _SDH.PurchaseOrderByCustomer,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
     cast(_SDH.TotalNetAmount +  _ITM.TaxAmount as abap.curr(15,2)) as TotalNetAmount,
       @Semantics.amount.currencyCode: 'TransactionCurrency'
     _ITM.TaxAmount as TaxAmount1,
     _SDH.TransactionCurrency,
     _SDH.IncotermsClassification,
     _SDH.CreatedByUser,
    _SDH.CreationDate,
    _SDH.LastChangedByUser,
    _SDH.LastChangeDateTime,
     _litem,
     _ITM
}
