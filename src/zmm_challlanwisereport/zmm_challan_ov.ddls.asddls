@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Overall Challan Wise View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zmm_challan_ov as select from ZMM_CHALLAN_POH             as POH
    inner join      I_PurchaseOrderItemAPI01    as POI on POI.PurchaseOrder = POH.PurchaseOrder
    left outer join I_POSubcontractingCompAPI01 as POS on  POS.PurchaseOrder     = POI.PurchaseOrder
                                                       and POS.PurchaseOrderItem = POI.PurchaseOrderItem
    left outer join ZMM_MATERIAL_CONV    as PGR on  PGR.PurchaseOrder          = POS.PurchaseOrder
                                                       and PGR.PurchaseOrderItem      = POS.PurchaseOrderItem
                                                       and  PGR.MaterialDocumentParentLine_Adj  = POS.ReservationItem
    left outer join ZMM_MATERIAL_BILL as BDI on BDI.ReferenceSDDocument = PGR.MaterialDocument and BDI.ReferenceSDDocumentItem = PGR.MaterialDocumentItem
    left outer join  zmm_challan_HC as mdi on mdi.PurchaseOrder = POI.PurchaseOrder and mdi.PurchaseOrderItem = POI.PurchaseOrderItem
{
  key POI.PurchaseOrder,
  key POI.PurchaseOrderItem,
  key POS.ReservationItem,
  key mdi.MaterialDocument as MOMENT101,
  key mdi.MaterialDocumentItem,
  key mdi.MaterialDocumentYear,
     POI.Material           as hmaterial,
     POS.Material           as imaterial,
     POI.BaseUnit           as hqom,
     @Semantics.quantity.unitOfMeasure: 'hqom'
     POI.OrderQuantity      as hquantity,
     POS.BaseUnit           as qom,
     @Semantics.quantity.unitOfMeasure: 'qom'
     POS.RequiredQuantity   as iquantity,
     @Semantics.quantity.unitOfMeasure: 'UOMB'
     PGR.QuantityInBaseUnit as BILLQYT,
     PGR.MaterialBaseUnit   as UOMB,
     PGR.MaterialDocument,
     @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
     BDI.BillingQuantity,
     BDI.BillingDocument,
     BDI.BillingDocumentItem,
       @Semantics.amount.currencyCode: 'TransactionCurrency'
     BDI.NetAmount,
     BDI.BillingQuantityUnit,
     BDI.TransactionCurrency,
     @Semantics.quantity.unitOfMeasure: 'MOMENTU101'
     mdi.QuantityInBaseUnit as MOMENTB101,
     mdi.MaterialBaseUnit   as MOMENTU101,
           @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
     mdi.TotalGoodsMvtAmtInCCCrcy,
     mdi.CompanyCodeCurrency,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
     mdi.qses as moment543,
     mdi.MaterialBaseUnit,
     BDI.MaterialGroup
}
group by
  POI.PurchaseOrder,
  POI.PurchaseOrderItem,
  POS.ReservationItem,
  mdi.MaterialDocument,
  mdi.MaterialDocumentItem,
  mdi.MaterialDocumentYear,
  POI.Material,
  POS.Material,
  POI.BaseUnit,
  POI.OrderQuantity,
  POS.BaseUnit,
  POS.RequiredQuantity,
  PGR.QuantityInBaseUnit,
  PGR.MaterialBaseUnit,
  PGR.MaterialDocument,
  BDI.BillingQuantity,
  BDI.BillingDocument,
  BDI.BillingDocumentItem,
  BDI.NetAmount,
  BDI.BillingQuantityUnit,
  BDI.TransactionCurrency,
  mdi.QuantityInBaseUnit,
  mdi.MaterialBaseUnit,
  mdi.TotalGoodsMvtAmtInCCCrcy,
  mdi.CompanyCodeCurrency,
  mdi.qses,
  BDI.MaterialGroup
