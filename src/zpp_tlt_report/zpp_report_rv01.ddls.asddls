@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Balance Plan Report'
@Metadata.ignorePropagatedAnnotations: true
define view entity zpp_report_rv01 as select from I_SalesDocument as so
left outer join I_SalesDocumentItem as soi on soi.SalesDocument = so.SalesDocument
left outer join ZPP_RP01_RV as cop on cop.Material  = soi.Material
left outer join I_Product as pd on pd.Product = cop.BillOfMaterialComponent
left outer join I_ProductText as pdesc on pdesc.Product = cop.BillOfMaterialComponent
{
    key cop.BillOfMaterialComponent,
    key so.SalesDocument,
    key so.YY1_PriorityPONos_SDH, 
    key so.YY1_Project_SDH,   
    pdesc.ProductName,
    cast(
    sum(
        cast( soi.RequestedQuantity as abap.dec(15,3) ) *
        cast( soi.YY1_Weight_Pc_SDI as abap.dec(15,3) )
    )
    as abap.dec(15,3)
    ) as Secwieght
}where soi.SalesDocumentItemCategory = 'TAN' and so.YY1_PriorityPONos_SDH is not initial and so.YY1_PriorityPONos_SDH is not initial
group by cop.BillOfMaterialComponent,
pdesc.ProductName,
so.SalesDocument,
so.YY1_Project_SDH,  
so.YY1_PriorityPONos_SDH
