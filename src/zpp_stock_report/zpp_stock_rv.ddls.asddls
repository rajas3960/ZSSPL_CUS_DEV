@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Report Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_STOCK_RV as select from I_PurchaseOrderAPI01 as Poh
left outer join I_Supplier  as supnm on supnm.Supplier = Poh.Supplier 
left outer join I_Plant as PLT on PLT.Plant = Poh.SupplyingPlant
inner join I_PurchaseOrderItemAPI01 as Poi on Poi.PurchaseOrder = Poh.PurchaseOrder
left outer join I_MaterialDocumentItem_2 as Moi on Moi.PurchaseOrder = Poi.PurchaseOrder and Moi.PurchaseOrderItem = Poi.PurchaseOrderItem
left outer join I_StockQuantityCurrentValue_2( P_DisplayCurrency: 'INR' ) as Stq 
on Stq.Product = Moi.Material and Stq.Batch = Moi.Batch and Stq.StorageLocation = Moi.StorageLocation and Stq.Plant = Moi.Plant
and Stq.ValuationAreaType = '1'
left outer join I_Product as PRT on PRT.Product = Moi.Material
left outer join I_ProductText as Pdcs on Pdcs.Product = PRT.Product
left outer join zpp_stock_ht1 as stochd on stochd.materialdocumentyear = Moi.MaterialDocumentYear 
                                        and stochd.materialdocument = Moi.MaterialDocument
                                        and stochd.materialdocumentitem = Moi.MaterialDocumentItem
                                        and stochd.purchaseorder = Poh.PurchaseOrder
                                        and stochd.purchaseorderitem = Poi.PurchaseOrderItem
                                        and stochd.product = Moi.Material
                                        and stochd.plant = Stq.Plant
                                        and stochd.storagelocation = Stq.StorageLocation
                                        and stochd.batch = Stq.Batch
                                        and stochd.currency = Stq.Currency
                                        and stochd.inventorystocktype = Stq.InventoryStockType
                                        and stochd.inventoryspecialstocktype = Stq.InventorySpecialStockType

{

key Moi.MaterialDocumentYear,
key Moi.MaterialDocument,
key Moi.MaterialDocumentItem,
key Poh.PurchaseOrder,
key Poi.PurchaseOrderItem,
key Moi.Material as Product,
key Stq.Plant,
key Stq.StorageLocation,
key Stq.Batch,
key Stq.Currency,
key Stq.InventoryStockType,
key Stq.InventorySpecialStockType,
Moi.YY1_Length_No_MMI,
Moi.YY1_WidthNo_MMI,
Moi.YY1_Pieces_No_MMI,
Poh.YY1_PriorityPONO_PDH,
@Semantics.quantity.unitOfMeasure: 'YY1_UNIT_WGT_PRDU'
PRT.YY1_UNIT_WGT_PRD,
PRT.YY1_UNIT_WGT_PRDU,
Moi.PostingDate,
concat(
  Moi.MaterialDocument,
  concat( '/', Poh.YY1_PriorityPONO_PDH )
) as IRNno,
@Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
Moi.QuantityInBaseUnit,
@Semantics.quantity.unitOfMeasure: 'EntryUnit'
Moi.QuantityInEntryUnit,
Moi.MaterialBaseUnit,
Moi.EntryUnit,
@Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
Stq.MatlWrhsStkQtyInMatlBaseUnit,
Pdcs.ProductName,
Poi.MaterialGroup,
Moi.DocumentDate,
//cast(cast(coalesce(Stq.MatlWrhsStkQtyInMatlBaseUnit * 1000,0) as abap.dec( 17,3  ) ) / cast( coalesce(Moi.YY1_Length_No_MMI * PRT.YY1_UNIT_WGT_PRD ,1 ) as abap.dec(15,3) )  as abap.dec(10,0) ) as balance
//case when Moi.YY1_WidthNo_MMI  is initial then
//   cast ( coalesce(Stq.MatlWrhsStkQtyInMatlBaseUnit * 1000,0) as abap.dec( 17,3  ) )
//   else
//   cast ( coalesce(Stq.MatlWrhsStkQtyInMatlBaseUnit * 1000000,0) as abap.dec( 17,3  ) )
//   end
 cast(0 as abap.dec( 17,3 ))    as totqty,
     
//case when Moi.YY1_WidthNo_MMI is initial  then
//   cast(coalesce(Moi.YY1_Length_No_MMI * PRT.YY1_UNIT_WGT_PRD,0) as abap.dec(15,3) )
//   else
//   cast(coalesce(Moi.YY1_Length_No_MMI   * PRT.YY1_UNIT_WGT_PRD,0) * Moi.YY1_WidthNo_MMI as abap.dec(15,3) )
//   
//   end
   
  cast(0 as abap.dec(15,3 ) )    as totlent,
//   case 
//   when ( Moi.YY1_Length_No_MMI = 0  )or  PRT.YY1_UNIT_WGT_PRD = 0   
//   then 
//   cast (  coalesce($projection.totqty ,0) as abap.dec( 17,3  ) ) 
//   else
//   cast(cast(coalesce($projection.totqty ,0)  as abap.dec( 17,3  ) ) / cast( coalesce($projection.totlent,0 ) as abap.dec(15,3) )  as abap.dec(10,0) )
//   end 
 cast(0 as abap.dec(17,3 ) ) as balance,
   case
   when
   Poh.SupplyingPlant is not initial
   then 
   'SHILPA STEEL AND POWER LTD'
   when Poh.Supplier is not initial
   then 
   supnm.SupplierName
   else null end as SUPPLNAME,
   stochd.length,
   stochd.width,
   stochd.pcs,
   Moi.DeliveryDocument,
   Moi.DeliveryDocumentItem
   
   
   
   
   
   
   

   
} where Moi.GoodsMovementType = '101' and Moi.Material <> '' and Moi.GoodsMovementIsCancelled is initial and Stq.MatlWrhsStkQtyInMatlBaseUnit <> 0 and Poh.YY1_PriorityPONO_PDH is not initial
union all
select from I_MaterialDocumentItem_2 as moi 
left outer join I_StockQuantityCurrentValue_2( P_DisplayCurrency: 'INR' ) as Stq 
on Stq.Product = moi.Material and Stq.Batch = moi.Batch and Stq.StorageLocation = moi.StorageLocation and Stq.Plant = moi.Plant
and Stq.ValuationAreaType = '1'
left outer join I_Product as PRT on PRT.Product = moi.Material
left outer join I_ProductText as Pdcs on Pdcs.Product = PRT.Product
{
key moi.MaterialDocumentYear,
key moi.MaterialDocument,
key moi.MaterialDocumentItem,
key substring(moi.YY1_PurchaseOrder_MMI,1,10) as PurchaseOrder,
key cast(substring(moi.YY1_PurchaseOrder_MMI,11,15) as abap.numc(5)) as PurchaseOrderItem,
key moi.Material as Product,
key Stq.Plant,
key Stq.StorageLocation,
key Stq.Batch,
key Stq.Currency,
key Stq.InventoryStockType,
key Stq.InventorySpecialStockType,
moi.YY1_Length_No_MMI,
moi.YY1_WidthNo_MMI,
moi.YY1_Pieces_No_MMI,
moi.YY1_ReferencePONo_MMI as YY1_PriorityPONO_PDH,
PRT.YY1_UNIT_WGT_PRD,
PRT.YY1_UNIT_WGT_PRDU,
moi.PostingDate, 
concat(
  moi.MaterialDocument,
  concat( '/', moi.YY1_ReferencePONo_MMI )
) as IRNno,
//@Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
moi.QuantityInBaseUnit,
//@Semantics.quantity.unitOfMeasure: 'EntryUnit'
moi.QuantityInEntryUnit,
moi.MaterialBaseUnit,
moi.EntryUnit,
//@Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
Stq.MatlWrhsStkQtyInMatlBaseUnit,
Pdcs.ProductName,
'' as MaterialGroup,
moi.DocumentDate,
cast(0 as abap.dec( 17,3 ))    as totqty,
  cast(0 as abap.dec(15,3 ) )    as totlent,
   cast(0 as abap.dec(17,3 ) ) as balance,
'SHILPA STEEL AND POWER LTD' as SUPPLNAME,
cast(0 as abap.dec(20) ) as length ,
cast(0 as abap.dec(20) ) as width,
cast(0 as abap.dec(20) ) as pcs,
moi.DeliveryDocument,
   moi.DeliveryDocumentItem





} where moi.GoodsMovementType = '309' and moi.YY1_ReferencePONo_MMI is not initial and moi.YY1_Length_No_MMI is not initial and moi.IsAutomaticallyCreated = 'X' and moi.StorageLocation = 'RY01' and moi.GoodsMovementIsCancelled is initial

