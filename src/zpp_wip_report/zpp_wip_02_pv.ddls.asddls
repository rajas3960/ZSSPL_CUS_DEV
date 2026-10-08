@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Operational WIP Details Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPP_WIP_02_PV provider contract transactional_query as projection on ZPP_WIP_02_RV
{
    key ProductionOrderOperation,
    key ProductionOrder,
    key OrderConfirmation,
    SalesOrder,
    YY1_PriorityPONos_SDH,
    YY1_Project_SDH,
    ProductName,
    Product,
    WorkCenter,
    ConfirmationUnit,
    @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
    @Aggregation.default: #SUM
    OpPlannedTotalQuantity,
    @Aggregation.default: #SUM
    @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
    ConfYieldQtyInProductionUnit,
    ConfirmationEntryDate,
    Jobsht,
    Vrno,
    EnteredByUser,
    pdtext,
    @Semantics.quantity.unitOfMeasure: 'YY1_WGT_PC_PRDU'
    WIEGHTPERPC,
    YY1_WGT_PC_PRDU,
    @Aggregation.default: #SUM
    OPQTY_KG,
    @Aggregation.default: #SUM
    PRODQQTY_KG
    
}
