@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I_PRODUCTIONORDERCOMPONENT VIEW'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS_COMPRC as select distinct  from I_ProductionOrderComponent as pro 
inner join I_Product as prt on prt.Product = pro.Material
{   
    key prt.Product,
    key pro.ProductionOrder
 
    

} where prt.ProductType = 'ROH' and (pro.Plant ='1020' or pro.Plant = '1010' )
