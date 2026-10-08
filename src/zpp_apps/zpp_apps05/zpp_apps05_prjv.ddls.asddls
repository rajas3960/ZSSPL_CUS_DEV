@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_PRJV as select from I_ProductStdVH
{
     @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.3
      @Search.ranking: #HIGH
     @ObjectModel.text.association: '_Text'
    key Product,
    _Text
}
