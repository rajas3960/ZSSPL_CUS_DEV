@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APPS01_PRODV as select from I_Product as Pr
left outer join I_ProductDescription_2 as Prd on Prd.Product = Pr.Product and Prd.Language = 'E'
left outer join I_ProductPlantBasic as Ppb on Ppb.Product = Pr.Product 
left outer join I_ProductValuationBasic as Pvb on Pvb.Product = Ppb.Product and Pvb.ValuationArea = Ppb.Plant
left outer join I_Plant as PT on PT.Plant = Ppb.Plant
{
    key Pr.Product,
    key Prd.Language,
    key Ppb.Plant,
    key Pvb.ValuationType,
    PT.PlantName,
    PT.DefaultPurchasingOrganization,
    Pr.ProductGroup,
    Pr.BaseUnit,
    Pr.ExternalProductGroup,
    Prd.ProductDescription,
    Ppb.PurchasingGroup,
    Pvb.ValuationArea,
      Pvb.Currency,
@Semantics.amount.currencyCode: 'Currency'
      Pvb.StandardPrice,
      Pvb.PriceUnitQty,
      Pvb.InventoryValuationProcedure ,
@Semantics.amount.currencyCode: 'Currency'
     Pvb.MovingAveragePrice,
@Semantics.amount.currencyCode: 'Currency'
  case Pvb.InventoryValuationProcedure
  when  'V'
  then 
  Pvb.MovingAveragePrice
  when 'S'
  then
  Pvb.StandardPrice
  else
  null
  end as valuprice,
  @Semantics.quantity.unitOfMeasure: 'YY1_UNIT_WGT_PRDU'
  Pr.YY1_UNIT_WGT_PRD,
  Pr.YY1_UNIT_WGT_PRDU
  
  
     
    
    
   
}
