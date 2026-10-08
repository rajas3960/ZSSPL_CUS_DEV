@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item Projection View of the Mark number'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZQM_REPORT_IPV as projection on ZQM_REPORT_IRV
{
    key YY1_PriorityPONos_SDH,
    key Product,
    key YY1_Project_SDH,
    key SalesDocument,
    key BillOfMaterialComponent,
    key Material,
    totoal_planwt,
    Mark_wt,
    Blance_wt,
    gin_wt,
    balgin_wt,
    gal_wt,
    balgal_wt,
    din_wt,
    baldin_wt,
    hdr :redirected to parent ZQM_REPORT_PV
}
