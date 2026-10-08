@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help For Operation'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZVH_OPERATION as select from I_ProductionOrderConfirmation
{
    key WorkCenter
}where Plant = '1030' and WorkCenter is not initial
group by
WorkCenter
