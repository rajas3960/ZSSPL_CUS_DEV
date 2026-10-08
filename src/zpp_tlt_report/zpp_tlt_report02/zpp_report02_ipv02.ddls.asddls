@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Mis Report projection view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define root view entity ZPP_REPORT02_ipv02 provider contract transactional_query as projection on zpp_report02_irv
{
    key SalesDocument,
    key YY1_PriorityPONos_SDH,
    ProductName,
    YY1_Project_SDH,
    batch_wt,
    Plan_wt,
    Balance_Wt,
    Glava_in,
    Balglvin_wt,
    Glalva_wt,
    Balglv_wt,
    Despatch_wt,
    Balrdispatch_wt,
    TotSP_Wt
}
