@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Overall Status View help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity zsd_overall_statusvh as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name:'ZOVERALL_STUS' )
{
  @UI.hidden: true
  key domain_name,
  @UI.hidden: true
  key value_position,
  @UI.hidden: true
  @Semantics.language: true
  key language,
  @UI.textArrangement: #TEXT_ONLY
  @ObjectModel.text.element: [ 'text' ]
  value_low,
  @Semantics.text: true
  text  
}
