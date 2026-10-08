@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Dispatch in Wt For Section'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZQM_DISINWT_SEC as select from ZPP_WIP_01_RV as PWT
left outer join ZPP_RP01_RV as b on b.Material = PWT.Product
{
    key PWT.SalesOrder,
    key PWT.YY1_PriorityPONos_SDH,
    key PWT.YY1_Project_SDH,
    b.BillOfMaterialComponent,
    cast(sum( PWT.Prod_weight) as abap.dec( 15, 3 )) as Dispin_wt
        
}where PWT.WorkCenter = '30_DIN01'
group by 
PWT.SalesOrder,
PWT.YY1_PriorityPONos_SDH,
PWT.YY1_Project_SDH,
b.BillOfMaterialComponent
