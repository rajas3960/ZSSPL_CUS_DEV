@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production report for 1040'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_PRODUCTION_REP
  as select from    I_ProductionOrderComponent as pc
    left outer join I_ProductionOrderItem      as poi on  poi.ProductionOrder              =  pc.ProductionOrder
                                                      and poi.PlanningPlant                =  '1040'
//                                                      and poi.IsMarkedForDeletion          <> 'X'
//                                                      and poi.IsCompletelyDelivered        <> 'X'
//                                                      and poi.OrderItemIsNotRelevantForMRP <> 'X'
//                                                      and poi.OrderIsReleased <> 'X'
    left outer join I_Product                  as pd  on pd.Product = poi.Product
    left outer join I_ProductText              as pdt on  pdt.Product  = poi.Product
                                                      and pdt.Language = $session.system_language
    left outer join I_SalesDocument            as so  on so.SalesDocument = poi.SalesOrder
    left outer join I_Customer                 as cus on cus.Customer = so.SoldToParty

{
  key pc.Material,
  key pc.ProductionOrder,
      pc.ProductionOrderOperation,
      pc.Plant,
      poi.Product,
      pdt.ProductName,
      poi.SalesOrder,
      poi.SalesOrderItem,
      poi.PlannedOrderPlannedDeliveryDte,
      @Semantics.quantity.unitOfMeasure: 'uom'
      cast (poi.PlannedTotalQty as abap.dec( 10, 3 ))             as PlannedYieldQuantity,
      //    @Semantics.quantity.unitOfMeasure: 'um'
      //   cast(
      //    cast( poi.PlannedTotalQty as abap.dec(15,3) ) *
      //    cast( pd.YY1_UNIT_WGT_PRD as abap.dec(15,3) )
      //as abap.dec(15,3) ) as PlannedTotalQtyInBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'uom'
      poi.PlannedTotalQtyInBaseUnit,
      poi.ProductionUnit                                          as uom,
      poi.OrderIsReleased,
      pc.Batch,
      so.SoldToParty,
      so.PurchaseOrderByCustomer,
      concat( concat( pc.ProductionOrder, '/' ), poi.SalesOrder ) as OrderSalesOrder,
      @Semantics.quantity.unitOfMeasure: 'um'
      pd.YY1_UNIT_WGT_PRD,
      pc.BaseUnit                                                 as um,
      pd.ProductGroup,
      cus.CustomerName
}
where
      pc.Plant = '1040'
  and (
         pc.MaterialGroup = 'WIRE ROD'
      or pc.MaterialGroup = 'SPR BLACK'
      or pc.MaterialGroup = 'PCK BLACK'
      )
  and poi.OrderIsReleased <> 'X'
  and (
         pd.ProductGroup = 'BOLT'
      or pd.ProductGroup = 'NUT'
      or pd.ProductGroup = 'SPR'
      or pd.ProductGroup = 'PCK'
      )
  and poi.IsMarkedForDeletion <> 'X'
  and poi.IsCompletelyDelivered <> 'X'
  and poi.OrderItemIsNotRelevantForMRP <> 'X'
  and pc.Batch is not initial
  and poi.PlanningPlant = '1040'
