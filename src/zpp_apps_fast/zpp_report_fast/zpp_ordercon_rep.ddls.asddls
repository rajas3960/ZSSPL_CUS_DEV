@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Conformation'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_Ordercon_REP
  as select from    I_ProductionOrder             as po
    left outer join I_ProductionOrderItem         as poi on  poi.ProductionOrder     =  po.ProductionOrder
                                                         and poi.ProductionPlant     =  '1040'
                                                         and poi.IsMarkedForDeletion <> 'X'
                                                         and poi.OrderIsReleased     =  'X'
    left outer join I_ProductionOrderOperation_2  as pop on pop.ProductionOrder = poi.ProductionOrder
    left outer join I_ProductionOrderConfirmation as poc on  poc.ProductionOrder              = pop.ProductionOrder
                                                         and poc.ProductionOrderOperation     = pop.ProductionOrderOperation
//                                                         and poc.ConfirmationText             is initial
                                                         and poc.ConfirmationIsReversed       is initial
                                                         and poc.ConfirmationTotalQuantity    is not initial
                                                         and poc.ConfYieldQtyInProductionUnit is not initial
                                                         and poc.WorkCenter                   is not initial
                                                         and poc.ConfirmationIsReversed <> 'X'
                                                         and poc.CancelledOrderConfirmation = '00000000'
    left outer join I_ProductText                 as pdt on pdt.Product = poi.Product
    left outer join I_WorkCenter                  as wc  on wc.WorkCenterInternalID = pop.WorkCenterInternalID
    left outer join I_Product                     as pd  on pd.Product = poi.Product
{
  key po.ProductionOrder as ProductionOrder,
  key poi.ProductionOrderItem,
  key pop.ProductionOrderOperation,
      poi.SalesOrder,
      poi.SalesOrderItem,
      poi.Product,
      wc.WorkCenter,
      pop.ProductionOrderOperationText,
      @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
      @Aggregation.default: #SUM
      poi.PlannedTotalQty,
      poi.ProductionUnit,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      pd.YY1_UNIT_WGT_PRD,
      @Semantics.quantity.unitOfMeasure:'ConfirmationUnit'
      @Aggregation.default: #SUM
      sum( poc.ConfYieldQtyInProductionUnit ) as ConfYieldQtyInProductionUnit,
      poc.ConfirmationUnit,
      max( poc.ConfirmationEntryDate )        as ConfirmationEntryDate,
      max( poc.EnteredByUser )                as EnteredByUser,
      pdt.ProductName                         as pdtext,
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      poi.PlannedTotalQtyInBaseUnit,
      poi.BaseUnit,
      @Aggregation.default: #SUM
      cast(
      (
      sum( cast( poc.ConfYieldQtyInProductionUnit as abap.dec(15,3) ) )
      * cast( pd.YY1_UNIT_WGT_PRD as abap.dec( 15, 3 ))
      )
      as abap.dec(15,3)
      )                                       as Prod_weight,
      @Aggregation.default: #SUM
      cast(
      (
      cast( poi.PlannedTotalQty as abap.dec(15,3) )
      -
      coalesce(
      sum( cast( poc.ConfYieldQtyInProductionUnit as abap.dec(15,3) ) ),
      0
      )
      )
      as abap.dec(15,3)
      )                                       as Balance_qty,
      @Aggregation.default: #SUM
      cast(
      (
      cast( poi.PlannedTotalQty as abap.dec(15,3) )
      -
      coalesce(
      sum( cast( poc.ConfYieldQtyInProductionUnit as abap.dec(15,3) ) ),
      0
      )
      )
      *
      cast( pd.YY1_UNIT_WGT_PRD as abap.dec( 15, 3 ))
      as abap.dec(15,3)
      )                                       as Balance_Wt
      
}
where
  poi.SalesOrder is not initial
group by
  po.ProductionOrder,
  poi.ProductionOrderItem,
  pop.ProductionOrderOperation,
  poi.SalesOrder,
  poi.SalesOrderItem,
  poi.Product,
  pop.ProductionOrderOperationText,
  wc.WorkCenter,
  poi.PlannedTotalQty,
  poi.ProductionUnit,
  pdt.ProductName,
  poi.PlannedTotalQtyInBaseUnit,
  poi.BaseUnit,
  pd.YY1_UNIT_WGT_PRD,
  poc.ConfirmationUnit
