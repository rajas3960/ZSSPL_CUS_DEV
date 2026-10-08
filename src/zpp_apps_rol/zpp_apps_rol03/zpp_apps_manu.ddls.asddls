@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Mannufacture of Grouping'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS_MANU as select from I_ManufacturingOrder 
{
    key max(ManufacturingOrder) as ManufacturingOrder,
    PlannedOrder
    
} where IsMarkedForDeletion <> 'X'
group by
PlannedOrder
