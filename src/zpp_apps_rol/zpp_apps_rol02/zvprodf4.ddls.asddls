@AbapCatalog.sqlViewName: 'ZVPRODORDF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order F4'
@Metadata.ignorePropagatedAnnotations: true
define view ZVPRODF4 as  select from I_ManufacturingOrderItem as a

    inner join   I_MfgOrderWithStatus     as b on b.ManufacturingOrder = a.ManufacturingOrder

{
  key a.ManufacturingOrder,
  key a.ManufacturingOrderItem,
      a.ManufacturingOrderType,
      a.Product,
      a.ProductionPlant,
      a.MRPController
}
where
       (a.ManufacturingOrderType      = 'ZMTO' or  a.ManufacturingOrderType = 'YBM1' or  a.ManufacturingOrderType = 'ZMTS' )
  and(
       a.ProductionPlant             = '1020'
    or a.ProductionPlant             = '1010'
  )
  and  a.OrderIsReleased             = 'X'

  and  b.OrderIsTechnicallyCompleted = ''

  and  a.IsMarkedForDeletion         = ''
