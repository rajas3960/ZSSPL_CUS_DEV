@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product View help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@VDM.viewType: #COMPOSITE
@ObjectModel.dataCategory: #VALUE_HELP
@Search.searchable: true
@Consumption.ranked: true
define view entity ZPP_PRODUCT_VH4 as select from I_Product as ph
{
     @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.3
      @Search.ranking: #HIGH
//      @ObjectModel.text.association: '_Text'
  key Product,
  _Text,
  @UI.hidden: true
  _Text.ProductName as Productname


} where ProductType = 'FERT'
