@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD projection view entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity zsd_item_pv provider contract transactional_query
  as projection on  ZSD_ITEM_RV
{
    key SALENO,
    CreatedByUser,
    CreationDate,
    LastChangedByUser,
    LastChangeDate
    //_Header : redirected to parent ZSD_LV_RPV
}
