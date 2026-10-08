@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View Operational WIP Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_WIP_01_RV
  as select from ZPP_WIP_RV
{

  key ProductionOrderOperation,
  key ProductionOrder,
      Product,
      WorkCenter,
      SalesOrder,
      YY1_PriorityPONos_SDH,
      YY1_Project_SDH,
      ProductName,
      ConfirmationUnit,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      OpPlannedTotalQuantity,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      ConfYieldQtyInProductionUnit,
      ConfirmationEntryDate,
      YY1_LENGTH_MM_PRDU,
      @Semantics.quantity.unitOfMeasure: 'YY1_LENGTH_MM_PRDU'
      YY1_LENGTH_MM_PRD,
      @Semantics.quantity.unitOfMeasure: 'YY1_UNIT_WGT_PRDU'
      YY1_UNIT_WGT_PRD,
      YY1_UNIT_WGT_PRDU,
      @Semantics.quantity.unitOfMeasure: 'YY1_WGT_PC_PRDU'
      WIEGHTPERPC,
      YY1_WGT_PC_PRDU,
      Balance_qty,
      Jobsht,
      Vrno,
      EnteredByUser,
      pdtext,
      //    BillOfMaterialComponent,
      cast(
        ( cast( OpPlannedTotalQuantity as abap.dec(15,3) )
        * cast( WIEGHTPERPC as abap.dec(15,3) ) )
        as abap.dec(15,3)
      ) as Operation_weight,
      cast(
            ( cast( ConfYieldQtyInProductionUnit as abap.dec(15,3) )
            * cast( WIEGHTPERPC as abap.dec(15,3) ) )
            as abap.dec(15,3)
      ) as Prod_weight,
      cast(
            ( cast( Balance_qty as abap.dec(15,3) )
            * cast( WIEGHTPERPC as abap.dec(15,3) ) )
            as abap.dec(15,3)
      ) as Balance_wt
}
where
      YY1_PriorityPONos_SDH        is not initial
  and YY1_Project_SDH              is not initial
  and ConfYieldQtyInProductionUnit is not initial
