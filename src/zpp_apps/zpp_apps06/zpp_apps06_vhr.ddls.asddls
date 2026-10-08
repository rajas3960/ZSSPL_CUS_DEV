@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Help For Plan Numbers'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZPP_APPS06_VHR as select from zpp_apps05_htb
{
    
    @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.3
      @Search.ranking: #HIGH
    key  vrno 
}
