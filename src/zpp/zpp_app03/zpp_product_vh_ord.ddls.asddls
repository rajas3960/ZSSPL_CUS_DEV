@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Value Order Open Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_PRODUCT_VH_ORD as select from ZPP_APP03_ORD
{
key    Material,
    ProductType,
    ProductName,
    ProductionPlant
    
}
group by 
Material,
ProductType,
ProductName,
ProductionPlant
