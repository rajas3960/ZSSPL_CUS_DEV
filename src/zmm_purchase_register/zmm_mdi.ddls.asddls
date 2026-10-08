@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    }
define root view entity ZMM_MDI
  as select from I_MaterialDocumentItem_2   as MDI
    inner join   I_MaterialDocumentHeader_2 as MDH on  MDH.MaterialDocument     = MDI.MaterialDocument
                                                   and MDH.MaterialDocumentYear = MDI.MaterialDocumentYear
{
  key MDI.MaterialDocumentYear,
  key MDI.MaterialDocument,
  key MDI.MaterialDocumentItem,
      MDI.PostingDate,
      MDI.DebitCreditCode,
      MDI.GoodsMovementType,
      MDI.DocumentDate,
      @Semantics.quantity.unitOfMeasure:    'EntryUnit'
      MDI.QuantityInEntryUnit,
      MDI.EntryUnit,
      @Semantics.amount.currencyCode:       'CompanyCodeCurrency'
      MDI.TotalGoodsMvtAmtInCCCrcy,
      MDI.CompanyCodeCurrency,
      MDI.CompanyCode as CompanyCode,
      MDI.PurchaseOrder,
      MDI.PurchaseOrderItem,
      MDI.OrderID,
      MDI.OrderItem,
      MDI.Supplier,
      MDH.ReferenceDocument
}
where
      MDI.GoodsMovementType <> '321'
  and MDI.GoodsMovementType <> '643'
  //  and MDI.GoodsMovementType <> '541'
  or  MDI.GoodsMovementType =  '101'
  or  MDI.GoodsMovementType =  '102'
  or  MDI.GoodsMovementType =  '122'
  or  MDI.GoodsMovementType =  '161'
