//@Abapocatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help for Material'

define view entity ZPP_MAT_VH as select from I_ProductionOrderComponent as poc
left outer join I_ProductionOrder as pord on pord.ProductionOrder = poc.ProductionOrder
left outer join I_ProductionOrderOperation_2 as po on po.ProductionOrder = poc.ProductionOrder 
                                                   and po.BillOfOperationsGroup = pord.BillOfOperationsGroup
                                                   and po.BillOfOperationsVariant = pord.BillOfOperationsVariant     
association[1..1] to I_WorkCenter as wc              on wc.WorkCenterInternalID =     po.WorkCenterInternalID                                               
//left outer join I_ProductionOrderItem  as poi on poi.ProductionOrder = poc.ProductionOrder
//                                            and poi.PlanningPlant = '1040'
//                                            
                                            
{

key poc.Material,
poc.ProductionOrder,
 po.ProductionOrderOperationText,
 po.BillOfOperationsGroup,
 po.BillOfOperationsVariant,
 wc.WorkCenter
}where poc.Plant = '1040' 
and poc.MaterialGroup = 'WIRE ROD' or poc.MaterialGroup = 'SPR BLACK' or poc.MaterialGroup = 'PCK BLACK'
//and poi.OrderIsReleased <> 'X'
//and poi.IsMarkedForDeletion <> 'X'
//and poi.IsCompletelyDelivered <> 'X'
and poc.Batch is not initial
group by 
//poi.Product,
poc.Material,
poc.ProductionOrder,
po.ProductionOrderOperationText,
wc.WorkCenter,
 po.BillOfOperationsGroup,
 po.BillOfOperationsVariant
