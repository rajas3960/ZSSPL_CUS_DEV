@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Dispatch Wt For Section'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZQM_DISPWT_SEC as select from  I_SalesDocument       as sd
    left outer join I_BillingDocumentItem as bdi on  bdi.SalesDocument             =  sd.SalesDocument
                                                 and bdi.ReturnItemProcessingType  <> 'X'
                                                 and bdi.OverallBillingStatus      =  'A'
                                                 and bdi.SalesDocumentItemCategory =  'TAN'
    left outer join ZPP_RP01_RV as b on b.Material = bdi.Product                                             
    left outer join I_Product             as Pd  on Pd.Product = bdi.Product
{
  key sd.SalesDocument,
  key sd.YY1_PriorityPONos_SDH,
  key sd.YY1_Project_SDH,
  b.BillOfMaterialComponent,
      cast(
      sum( cast(bdi.BillingQuantity as abap.dec( 10, 3 )) * cast( Pd.YY1_WGT_PC_PRD as abap.dec( 10, 3 )))
      as abap.dec(15,3)
      ) as TotSP_Wt

}
where
      sd.YY1_PriorityPONos_SDH is not initial
  and sd.YY1_Project_SDH       is not initial
group by
  sd.SalesDocument,
  sd.YY1_PriorityPONos_SDH,
  sd.YY1_Project_SDH,
  b.BillOfMaterialComponent
