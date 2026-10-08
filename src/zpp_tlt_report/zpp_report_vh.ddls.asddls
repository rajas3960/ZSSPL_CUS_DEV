@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help For report'
@Metadata.ignorePropagatedAnnotations: true
define view entity zpp_REPORT_VH as select from I_SalesDocument
{
    key SalesDocument,
    YY1_Project_SDH as project,
    YY1_PriorityPONos_SDH as Po
}where YY1_Project_SDH is not initial and YY1_PriorityPONos_SDH is not initial
