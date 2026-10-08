@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MIS Report RV'
@Metadata.ignorePropagatedAnnotations: true
define view entity zpp_report02_rv as select from I_SalesDocument as sd
{
//    key sd.SalesDocument,
    key sd.YY1_PriorityPONos_SDH
}where YY1_PriorityPONos_SDH is not initial
group by
sd.YY1_PriorityPONos_SDH
