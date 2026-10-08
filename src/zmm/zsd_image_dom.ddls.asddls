@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Image Domain logo'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_image_dom as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name:'ZMM_LOGO' )
{
@UI.hidden: true
    key domain_name,
@UI.hidden: true
    key value_position,
@Semantics.language: true
@UI.hidden: true
    key language,
@EndUserText.label: 'Value'
    value_low as FIXED_VAL,
    @Semantics.imageUrl: true
    text as IMAGES
      
}
