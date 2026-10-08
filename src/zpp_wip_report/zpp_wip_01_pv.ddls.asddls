@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Of WIP report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZPP_WIP_01_PV provider contract transactional_query as projection on ZPP_WIP_01_RV
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
    YY1_LENGTH_MM_PRDU,
    @Semantics.quantity.unitOfMeasure: 'YY1_LENGTH_MM_PRDU'
    YY1_LENGTH_MM_PRD,
    @Semantics.quantity.unitOfMeasure: 'YY1_UNIT_WGT_PRDU'
    YY1_UNIT_WGT_PRD,
    YY1_UNIT_WGT_PRDU,
    ConfirmationEntryDate,
    @Semantics.quantity.unitOfMeasure: 'YY1_WGT_PC_PRDU'
    WIEGHTPERPC,
    YY1_WGT_PC_PRDU,
    Balance_qty,
    Operation_weight,
    Prod_weight,
    Balance_wt,
    Jobsht,
    Vrno,
    EnteredByUser,
    pdtext
//    BillOfMaterialComponent
}
