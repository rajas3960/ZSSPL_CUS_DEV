@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RAW MATERIAL REPORT PROJECTION VIEW'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPP_RM_REP_CV
  provider contract transactional_query
  as projection on ZPP_RM_REP_RV
{
  key uuid,
  key sectmat,  
  key vrno,
  key project,
  key irno,
      ProductName,
      length,
      used,
      uqty
}
