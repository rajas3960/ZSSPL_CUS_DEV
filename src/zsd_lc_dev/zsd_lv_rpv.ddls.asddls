@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Projection Root View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_LV_RPV
  provider contract transactional_query
  as projection on ZSD_LC_RCV
{
      @EndUserText.label: 'LC Number'
  key Lcnum,
      Valfrm,
      Valto
     
}
