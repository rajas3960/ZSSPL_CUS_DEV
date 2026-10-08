@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Of the Bom Details'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zpp_report_PV provider contract transactional_query as projection on zpp_report_rv
{
    key Project,
    key Towertype,
    key Towersubtype,
    key Structure,
    Marknumber,
    _item: redirected to composition child ZPP_REPORT_IPV02
}
