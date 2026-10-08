@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Status For Domain View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS06_DVE as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZPP_APPS06_DV' )
{

      @UI.hidden: true
  key domain_name,
      @UI.hidden: true
  key value_position,
      @Semantics.language: true
      @UI.hidden: true
  key language,
      @EndUserText.label: 'Status'
      @ObjectModel.text.element: [ 'text' ]
      value_low as name,
      @Semantics.text: true
      text 
}
