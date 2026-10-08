@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Balance to Plan mark no'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZPP_REP_IPV03 as projection on ZPP_REP_IRV03
{
    key YY1_PriorityPONos_SDH,
    key Product,
    key YY1_Project_SDH,
    key SalesDocument,
    key BillOfMaterialComponent,
    totoal_planwt,
    Mark_wt,
    Blance_wt,
    /* Associations */
    hdr : redirected to parent zpp_report_pv01
}
