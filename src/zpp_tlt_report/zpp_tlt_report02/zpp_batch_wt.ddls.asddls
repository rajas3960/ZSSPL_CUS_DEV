@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Total Batch Weight'
@Metadata.ignorePropagatedAnnotations: true
define view entity zpp_batch_wt as select from I_SalesDocument as sd
left outer join I_SalesDocumentItem as sdi on sd.SalesDocument = sdi.SalesDocument
left outer join I_Product           as PD     on PD.Product = sdi.Material
left outer join I_ProductText as pdt on pdt.Product = sd.YY1_Project_SDH
{
    key sd.SalesDocument,
    key sd.YY1_PriorityPONos_SDH,
    pdt.ProductName,
    cast( sum ((cast(sdi.RequestedQuantity as abap.dec( 10, 3 ) ) * cast( PD.YY1_WGT_PC_PRD as abap.dec( 10, 3 )) / 1000)) as abap.dec( 15, 3 )) as batch_wt
}where sd.YY1_PriorityPONos_SDH is not initial
group by 
sd.SalesDocument,
pdt.ProductName,
sd.YY1_PriorityPONos_SDH
