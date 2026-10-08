@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'WIP Operational report Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define root view entity ZPP_WIP_REPORT_PV2
  provider contract transactional_query
  as projection on ZPP_WIP_REPORT_VER2
{
  key ProductionOrder,
  key ProductionOrderItem,
  key ProductionOrderOperation,
      SalesOrder,
      YY1_PriorityPONos_SDH,
      YY1_Project_SDH,
      ProductName,
      Product,
      WorkCenter,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      PlannedTotalQty,
      BaseUnit,
      @Semantics.quantity.unitOfMeasure: 'YY1_WGT_PC_PRDU'
      YY1_WGT_PC_PRD,
      YY1_WGT_PC_PRDU,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      ConfYieldQtyInProductionUnit,
      ConfirmationUnit,
      ConfirmationEntryDate,
      Jobsht,
      Vrno,
      Sectmat,
      EnteredByUser,
      pdtext,
      Operation_weight,
      Prod_weight,
      Balance_qty,
      Balance_Wt
}
