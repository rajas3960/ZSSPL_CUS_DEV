@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Challan wise report Grouping'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_CHALLAN_GV
  as select distinct from I_POSubcontractingCompAPI01 as POS
  //ZMM_CHALLAN_POH             as POH
    inner join            I_PurchaseOrderItemAPI01    as POI on  POI.PurchaseOrder     = POS.PurchaseOrder
                                                             and POI.PurchaseOrderItem = POS.PurchaseOrderItem

  //    on  POS.PurchaseOrder     = POI.PurchaseOrder
  //                                                             and POS.PurchaseOrderItem = POI.PurchaseOrderItem
    left outer join       ZMM_MATERIAL_CONV           as PGR on  PGR.PurchaseOrder     = POS.PurchaseOrder
                                                             and PGR.PurchaseOrderItem = POS.PurchaseOrderItem
                                                             and PGR.Material          = POS.Material
                                                             and PGR.Plant             = POS.Plant
                                                             and PGR.Batch             = POS.Batch
    left outer join       ZMM_MATERIAL_BILL           as BDI on  BDI.ReferenceSDDocument     = PGR.MaterialDocument
                                                             and BDI.ReferenceSDDocumentItem = PGR.MaterialDocumentItem
    left outer join       zmm_challan_HC              as mdi on  mdi.PurchaseOrder     = POS.PurchaseOrder
                                                             and mdi.PurchaseOrderItem = POS.PurchaseOrderItem
                                                             and mdi.Material          = POS.Material
                                                             and mdi.Plant             = POS.Plant
                                                             and mdi.Batch             = POS.Batch
    left outer join       ZMM_MATERIAL_PROCES         as mat on  mat.PurchaseOrder     = POS.PurchaseOrder
                                                             and mat.PurchaseOrderItem = POS.PurchaseOrderItem
                                                             and mat.Material          = POS.Material
                                                             and mat.Plant             = POS.Plant
                                                             and mat.Batch             = POS.Batch

    left outer join       I_PurchaseOrderAPI01        as Po  on Po.PurchaseOrder = POI.PurchaseOrder
    left outer join       I_Supplier                  as SN  on SN.Supplier      = Po.Supplier
    left outer join       I_Plant                     as Plant on Plant.Plant = POI.Plant
{
  key POS.PurchaseOrder,
  key POS.PurchaseOrderItem,
  key POS.PurchaseOrderScheduleLine,
  key POS.ReservationItem,
  key mdi.MaterialDocument                                               as MOMENT101,
  key POS.Material                                                       as imaterial,
  key mdi.MaterialDocumentYear,

      POI.Material                                                       as hmaterial,
      POI.BaseUnit                                                       as hqom,
      @Semantics.quantity.unitOfMeasure: 'hqom'
      POI.OrderQuantity                                                  as hquantity,

      POS.BaseUnit                                                       as qom,
      @Semantics.quantity.unitOfMeasure: 'qom'
      POS.RequiredQuantity                                               as iquantity,

      @Semantics.quantity.unitOfMeasure: 'UOMB'
      PGR.QuantityInBaseUnit                                             as BILLQYT,
      PGR.MaterialBaseUnit                                               as UOMB,
      PGR.MaterialDocument,

      @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      BDI.BillingQuantity,
      BDI.BillingDocument,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      BDI.NetAmount,
      BDI.BillingQuantityUnit,
      BDI.TransactionCurrency,

      @Semantics.quantity.unitOfMeasure: 'MOMENTU101'
      mdi.QuantityInBaseUnit                                             as MOMENTB101,
      mdi.MaterialBaseUnit                                               as MOMENTU101,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      mdi.TotalGoodsMvtAmtInCCCrcy,
      mdi.CompanyCodeCurrency,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      mdi.qses                                                           as moment543,
      mdi.MaterialBaseUnit,

      BDI.MaterialGroup,
      cast(POI.OrderQuantity - mdi.QuantityInBaseUnit as abap.dec(15,3)) as blance1,
      cast(PGR.QuantityInBaseUnit - mdi.qses as abap.dec(15,3))          as blance2,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      mat.QuantityInBaseUnit                                             as MOMENT543O,
      Po.Supplier                                                        as Supplier,
      SN.SupplierName                                                    as Supplier_Name,
      Plant.PlantName                                                    as Plant,
      POS.Batch                                                          as Batch   
}
group by
  POS.PurchaseOrder,
  POS.PurchaseOrderItem,
  POS.PurchaseOrderScheduleLine,
  POS.ReservationItem,
  mdi.MaterialDocument,
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
  BDI.NetAmount,
  BDI.BillingQuantityUnit,
  BDI.TransactionCurrency,
  mdi.QuantityInBaseUnit,
  mdi.MaterialBaseUnit,
  mdi.TotalGoodsMvtAmtInCCCrcy,
  mdi.CompanyCodeCurrency,
  mdi.qses,
  BDI.MaterialGroup,
  mat.QuantityInBaseUnit,
  Po.Supplier, 
  SN.SupplierName,
  Plant.PlantName,
  POS.Batch 
