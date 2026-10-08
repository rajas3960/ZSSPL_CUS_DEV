@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Dispatch Weight for Mis Report'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_DISPATCH_WT as select from ZPP_WIP_01_RV as dwt
{
     key dwt.SalesOrder,
    key dwt.YY1_PriorityPONos_SDH,
    key dwt.YY1_Project_SDH,
    cast(sum( dwt.Prod_weight) / 1000 as abap.dec( 15, 3 )) as Despatch_wt
        
}where dwt.WorkCenter = '30_DIN01'
group by 
dwt.SalesOrder,
dwt.YY1_PriorityPONos_SDH,
dwt.YY1_Project_SDH
