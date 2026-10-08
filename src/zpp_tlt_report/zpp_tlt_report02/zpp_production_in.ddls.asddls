@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Glava In Production Wt for PWT Report'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_PRODUCTION_IN as select from ZPP_WIP_01_RV as PWT
{
    key PWT.SalesOrder,
    key PWT.YY1_PriorityPONos_SDH,
    key PWT.YY1_Project_SDH,
    cast(sum( PWT.Prod_weight) / 1000 as abap.dec( 15, 3 )) as Glava_in
        
}where PWT.WorkCenter = '30_GIN01'
group by 
PWT.SalesOrder,
PWT.YY1_PriorityPONos_SDH,
PWT.YY1_Project_SDH
