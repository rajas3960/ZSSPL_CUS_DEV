@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'zstatus_f'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zstatus_f  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name : 'ZSTTUS')
{
    key domain_name,
    key value_position,
    key language,
    value_low,
    text
}
