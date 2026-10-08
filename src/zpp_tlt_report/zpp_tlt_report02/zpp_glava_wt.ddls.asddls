@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Glava Production Wt for MIS Report'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_GLAVA_WT as select from ZPP_WIP_01_RV as gwt
{
     key gwt.SalesOrder,
    key gwt.YY1_PriorityPONos_SDH,
    key gwt.YY1_Project_SDH,
    cast(sum( gwt.Prod_weight) / 1000 as abap.dec( 15, 3 )) as Glalva_wt
        
}where gwt.WorkCenter = '30_GAL01'
group by 
gwt.SalesOrder,
gwt.YY1_PriorityPONos_SDH,
gwt.YY1_Project_SDH
