@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Operational WIP Details Report'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPP_WIP_02_RV
  as select from    I_ProductionOrder             as po
    left outer join I_ProductionOrderItem         as POI     on POI.ProductionOrder = po.ProductionOrder
  //  left outer join  I_ProductionOrderOperation_2 as pop on pop.ProductionOrder = POI.ProductionOrder
    left outer join I_ProductionOrderConfirmation as POC     on  POC.ProductionOrder           = POI.ProductionOrder
    //                                                         and POC.ProductionOrderOperation = POC.ProductionOrderOperation
                                                             and POC.ConfirmationText          is initial
                                                             and POC.ConfirmationIsReversed    is initial
                                                             and POC.ConfirmationTotalQuantity is not initial
    left outer join I_Product                     as Product on Product.Product = POI.Product
    left outer join I_SalesDocument               as sd      on sd.SalesDocument = POI.SalesOrder
    left outer join I_ProductText                 as pt      on  pt.Product  = sd.YY1_Project_SDH
                                                             and pt.Language = $session.system_language
    left outer join ZPP_APPS05_IRV2               as js      on  js.Orderno = POI.ProductionOrder
                                                             and js.Matnr   = POI.Product
    left outer join I_ProductText                 as pdt     on pdt.Product = POI.Product
  //    left outer join ZPP_RP01_RV as bom on bom.Material = POI.Product

{

  key POC.ProductionOrderOperation,
  key po.ProductionOrder,
  key POC.OrderConfirmation,
      POI.SalesOrder,
      sd.YY1_PriorityPONos_SDH,
      sd.YY1_Project_SDH,
      pt.ProductName,
      POI.Product,
      POC.WorkCenter,
      POC.ConfirmationUnit,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      POC.OpPlannedTotalQuantity,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      POC.ConfYieldQtyInProductionUnit as ConfYieldQtyInProductionUnit,      
      POC.ConfirmationEntryDate        as ConfirmationEntryDate,
      js.Jobsht,
      js.Vrno,
      POC.EnteredByUser                as EnteredByUser,
      pdt.ProductName                  as pdtext,
      @EndUserText.label: 'Weight/PC'
      @Semantics.quantity.unitOfMeasure: 'YY1_WGT_PC_PRDU'
      Product.YY1_WGT_PC_PRD           as WIEGHTPERPC,
      Product.YY1_WGT_PC_PRDU,
      cast( cast( POC.OpPlannedTotalQuantity as abap.dec( 10, 3 )) 
      * cast(Product.YY1_WGT_PC_PRD as abap.dec( 10, 3 ))
       as abap.dec( 15, 3 ) ) as OPQTY_KG,
       cast( cast( POC.ConfYieldQtyInProductionUnit as abap.dec( 10, 3 )) 
      * cast(Product.YY1_WGT_PC_PRD as abap.dec( 10, 3 ))
       as abap.dec( 15, 3 ) ) as PRODQQTY_KG
}
where
      POI.ProductionOrder is not initial
  and POC.WorkCenter      is not initial
  and POI.ProductionPlant = '1030'
  and sd.YY1_PriorityPONos_SDH        is not initial
  and sd.YY1_Project_SDH              is not initial
  and POC.ConfYieldQtyInProductionUnit is not initial
group by
  POC.ProductionOrderOperation,
  po.ProductionOrder,
  POC.OrderConfirmation,
  POI.SalesOrder,
  sd.YY1_PriorityPONos_SDH,
  sd.YY1_Project_SDH,
  pt.ProductName,
  POI.Product,
  js.Jobsht,
  js.Vrno,
  Product.YY1_WGT_PC_PRD,
  Product.YY1_WGT_PC_PRDU,
  pdt.ProductName,
  POC.WorkCenter,
  POC.ConfYieldQtyInProductionUnit,
  POC.EnteredByUser,
  POC.ConfirmationEntryDate,
  POC.OpPlannedTotalQuantity,
  Product.YY1_LENGTH_MM_PRDU,
  Product.YY1_LENGTH_MM_PRD,
  Product.YY1_UNIT_WGT_PRD,
  Product.YY1_UNIT_WGT_PRDU,
  POC.ConfirmationUnit
