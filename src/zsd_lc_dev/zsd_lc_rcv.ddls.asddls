@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Root C View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_LC_RCV
  as select from    zsd_lc_rv       as TAB
 //  left outer join I_SalesDocument as SDB on SDB.YY1_LC_Number__SDH = TAB.Lcnum
    // composition [0..*] of zsd_item_pv as _Item
{
      @EndUserText.label: 'LC Number'
  key TAB.Lcnum,
      TAB.Valfrm,
      TAB.Valto
      
}
