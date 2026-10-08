@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'WIP Operational report'
@Metadata.ignorePropagatedAnnotations: true
@Analytics.dataCategory: #CUBE
define view entity ZPP_WIP_REPORT_V2
  as select from    I_ProductionOrder             as PO
    left outer join I_ProductionOrderItem         as poi on  poi.ProductionOrder     =  PO.ProductionOrder
                                                         and poi.ProductionPlant     =  '1030'
                                                         and poi.IsMarkedForDeletion <> 'X'
                                                         and poi.OrderIsReleased = 'X'
    left outer join I_ProductionOrderOperation_2  as pop on pop.ProductionOrder = poi.ProductionOrder
    left outer join I_Product                     as pd  on pd.Product = poi.Product
    left outer join I_ProductionOrderConfirmation as poc on  poc.ProductionOrder              = pop.ProductionOrder
                                                         and poc.ProductionOrderOperation     = pop.ProductionOrderOperation
                                                         and poc.ConfirmationText             is initial
                                                         and poc.ConfirmationIsReversed       is initial
                                                         and poc.ConfirmationTotalQuantity    is not initial
                                                         and poc.ConfYieldQtyInProductionUnit is not initial
                                                         and poc.WorkCenter                   is not initial
    left outer join I_SalesDocument               as sd  on  sd.SalesDocument         = poi.SalesOrder
                                                         and sd.YY1_PriorityPONos_SDH is not initial
                                                         and sd.YY1_Project_SDH       is not initial
    left outer join I_ProductText                 as pt  on  pt.Product  = sd.YY1_Project_SDH
                                                         and pt.Language = $session.system_language
    left outer join ZPP_APPS05_IRV2               as js  on  js.Orderno = poi.ProductionOrder
                                                         and js.Matnr   = poi.Product
  //                                                         and js.Vrno is not null
    left outer join zpp_apps05_htb                 as hjs on hjs.vrno = js.Vrno
    left outer join I_ProductText                 as pdt on pdt.Product = poi.Product
    left outer join I_WorkCenter                  as wc  on wc.WorkCenterInternalID = pop.WorkCenterInternalID
{
  key PO.ProductionOrder,
  key poi.ProductionOrderItem,
  key pop.ProductionOrderOperation,
      poi.SalesOrder,
      sd.YY1_PriorityPONos_SDH,
      sd.YY1_Project_SDH,
      pt.ProductName,
      poi.Product,
      wc.WorkCenter,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      @Aggregation.default: #SUM
      poi.PlannedTotalQty,
      poi.BaseUnit,
      @Semantics.quantity.unitOfMeasure: 'YY1_WGT_PC_PRDU'
      pd.YY1_WGT_PC_PRD,
      pd.YY1_WGT_PC_PRDU,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      @Aggregation.default: #SUM
      sum( poc.ConfYieldQtyInProductionUnit ) as ConfYieldQtyInProductionUnit,
      poc.ConfirmationUnit,
      max( poc.ConfirmationEntryDate )        as ConfirmationEntryDate,
      js.Jobsht,
      js.Vrno,
      hjs.sectmat,
      max( poc.EnteredByUser )                as EnteredByUser,
      pdt.ProductName                         as pdtext,
      @Aggregation.default: #SUM
      cast(
      ( cast( poi.PlannedTotalQty as abap.dec(15,3) )
      * cast( pd.YY1_WGT_PC_PRD as abap.dec(15,3) ) )
      as abap.dec(15,3)
      )                                       as Operation_weight,
      @Aggregation.default: #SUM
      cast(
      (
      sum( cast( poc.ConfYieldQtyInProductionUnit as abap.dec(15,3) ) )
      * cast( pd.YY1_WGT_PC_PRD as abap.dec(15,3) )
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
      cast( pd.YY1_WGT_PC_PRD as abap.dec(15,3) )
      as abap.dec(15,3)
      )                                       as Balance_Wt
}
group by
  PO.ProductionOrder,
  poi.ProductionOrderItem,
  pop.ProductionOrderOperation,
  poi.SalesOrder,
  poi.Product,
  wc.WorkCenter,
  poi.PlannedTotalQty,
  poi.BaseUnit,
  pd.YY1_WGT_PC_PRD,
  pd.YY1_WGT_PC_PRDU,
  pdt.ProductName,
  sd.YY1_PriorityPONos_SDH,
  sd.YY1_Project_SDH,
  hjs.sectmat,
  pt.ProductName,
  poc.ConfirmationUnit,
  js.Jobsht,
  js.Vrno,
  hjs.sectmat
