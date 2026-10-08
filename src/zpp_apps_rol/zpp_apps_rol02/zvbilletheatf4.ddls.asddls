@AbapCatalog.sqlViewName: 'ZVHEATNO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'f4 For Billet Heat Number'
@Metadata.ignorePropagatedAnnotations: true
define view ZVBILLETHEATF4

  as select distinct from   ZPP_APPS_COMPRC as prc        
  
 inner join I_MaterialStock_2 as a on a.Material = prc.Product
  

    left outer join       I_ProductText     as b on  b.Product  = a.Material
                                                 and b.Language = $session.system_language

    left outer join       I_Product         as c on c.Product = a.Material

{
  key prc.ProductionOrder,
  key a.Material,
  key a.Plant,
  key a.StorageLocation,
  key a.Batch                             as HeatNumber,

      c.ProductType,
      b.ProductName,
      a.MaterialBaseUnit,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(a.MatlStkIncrQtyInMatlBaseUnit) as IncreaseQty,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(a.MatlStkDecrQtyInMatlBaseUnit) as DecreaseQty
}

where
      c.ProductType        = 'ROH'
      
  and a.InventoryStockType = '01'
  

group by
  prc.ProductionOrder,
  a.Material,
  a.Plant,
  a.StorageLocation,
  a.Batch,
  b.ProductName,
  a.MaterialBaseUnit,
  c.ProductType
