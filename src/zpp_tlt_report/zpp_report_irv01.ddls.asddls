@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Balance to Plan mark no'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_REPORT_IRV01 as select from I_SalesDocument as s
left outer join I_SalesDocumentItem as si on si.SalesDocument = s.SalesDocument
                                          and si.SalesDocumentItemCategory = 'TAN'
left outer join I_Product as p on p.Product = si.Product           
left outer join ZPP_RP01_RV as cop on cop.Material  = si.Material                               
{
    key s.SalesDocument,
    key s.YY1_PriorityPONos_SDH, 
    key s.YY1_Project_SDH, 
    key cop.BillOfMaterialComponent,  
    key si.Product,
    cast(si.RequestedQuantity as abap.dec( 15, 3 )) * cast(p.YY1_WGT_PC_PRD as abap.dec( 15, 3 )) as Mark_wt
}where s.YY1_PriorityPONos_SDH is not initial and s.YY1_Project_SDH is not initial
