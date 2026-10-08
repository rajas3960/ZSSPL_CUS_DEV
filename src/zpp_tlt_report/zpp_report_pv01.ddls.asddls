@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Balance Plan Report'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zpp_report_pv01 provider contract transactional_query as projection on zpp_report_rv03
{
    key BillOfMaterialComponent,
    key YY1_PriorityPONos_SDH,
    key YY1_Project_SDH,
    key SalesDocument, 
    ProductName,
    Secwieght,
    totoal_planwt,
    Blance_wt,
    item : redirected to composition child ZPP_REP_IPV03
}
