@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Structure and HT AND MS Projection View Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPP_APPR_09_PV provider contract  transactional_query as projection on  ZPP_APPR_09_RV
{
    key Product,
    Price,
    Mark
}
