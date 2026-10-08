@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Optimization V4 Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZPP_APPS02_OP
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZPP_APPS02_OP' )
{
      @UI.hidden: true
  key domain_name,
      @UI.hidden: true
  key value_position,
      @Semantics.language: true
      @UI.hidden: true
  key language,
      @EndUserText.label: 'Optimization'
      @ObjectModel.text.element: [ 'text' ]
      value_low as name,
      @Semantics.text: true
      text 
}
