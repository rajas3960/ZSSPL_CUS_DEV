@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View of the balance to plan'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_REPORT_RV2 as select from I_SalesOrder as s
left outer join I_PlannedOrder        as p on p.SalesOrder = s.SalesOrder
    left outer join I_SalesOrderItem      as si  on  si.SalesOrder     = s.SalesOrder
//                                                 and si.SalesOrderItem = p.SalesOrderItem
    left outer join I_ProductionOrderItem as pi  on // pi.PlannedOrder                 =  p.PlannedOrder
                                                 pi.SalesOrder                   =  si.SalesOrder
                                                 and pi.SalesOrderItem               =  si.SalesOrderItem
                                                 and pi.IsMarkedForDeletion          <> 'X'
                                                 and pi.OrderItemIsNotRelevantForMRP <> 'X'
    left outer join I_ProductText         as pt  on  pt.Product  = p.Product
                                                 and pt.Language = $session.system_language
    left outer join I_Product             as pod on pod.Product = p.Product
{
  key s.SalesOrder,
  key p.SalesOrderItem,
  key p.Product,
      pt.ProductName,
      pod.ProductGroup,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      p.PlannedTotalQtyInBaseUnit,
      case
      when pod.YY1_UNIT_WGT_PRD is null
           or pod.YY1_UNIT_WGT_PRD = 0
        then cast( 0 as abap.dec(15,3) )
      else
        cast(
          cast( p.PlannedTotalQtyInBaseUnit as abap.dec(15,3) )
          / cast( pod.YY1_UNIT_WGT_PRD as abap.dec(15,3) )
          as abap.dec(15,3)
        )
      end                                                             as bal_pcs,


      p.BaseUnit,
      @Semantics.quantity.unitOfMeasure: 'RequestedQuantityUnit'
      case
      when pod.ProductGroup = 'FGM'
      then si.RequestedQuantity
      else
      cast( 0 as abap.quan(13,3) )
      end                                                             as RequestedQuantity,
      si.RequestedQuantityUnit,
      sum( cast( pi.PlannedTotalQty as abap.dec( 15, 3 ) ))           as jcpc,
      sum( cast( pi.PlannedTotalQtyInBaseUnit as abap.dec( 15, 3 ) )) as jcqty,
      cast(
      cast( coalesce(p.PlannedTotalQtyInBaseUnit,0) as abap.dec(15,3) )
      + sum( cast( coalesce(pi.PlannedTotalQtyInBaseUnit,0) as abap.dec(15,3) ) )
      as abap.dec(15,3)
      )                                                               as Plan_TotalQty,
      cast(
      sum( cast( coalesce(pi.PlannedTotalQty,0) as abap.dec(15,3) ) )
      +
      case
      when cast( coalesce(pod.YY1_UNIT_WGT_PRD,0) as abap.dec(15,3) ) = 0
        then cast( 0 as abap.dec(15,3) )
      else
        cast(
          cast( coalesce(p.PlannedTotalQtyInBaseUnit,0) as abap.dec(15,3) )
          /
          cast( coalesce(pod.YY1_UNIT_WGT_PRD,0) as abap.dec(15,3) )
          as abap.dec(15,3)
        )
      end
      as abap.dec(15,3)
      )                                                               as TotalPC


}
where
      p.SalesOrder is not initial
  and p.MRPPlant   = '1040'
group by
  s.SalesOrder,
  p.SalesOrderItem,
  p.Product,
  pod.ProductGroup,
  pt.ProductName,
  pod.YY1_UNIT_WGT_PRD,
  p.PlannedTotalQtyInBaseUnit,
  p.BaseUnit,
  si.RequestedQuantity,
  si.RequestedQuantityUnit
