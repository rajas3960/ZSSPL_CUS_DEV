@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MIS Report IRV'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zpp_report02_irv
  as select from    I_SalesDocument     as sd
    left outer join I_SalesDocumentItem as sdi     on sdi.SalesDocument = sd.SalesDocument
    left outer join zpp_batch_wt        as batch   on batch.SalesDocument = sd.SalesDocument
    left outer join zpp_plan_wt         as planwt  on planwt.Vbeln = sd.SalesDocument
    left outer join ZPP_PRODUCTION_IN   as galvain on galvain.SalesOrder = sd.SalesDocument
    left outer join ZPP_GLAVA_WT        as galva   on galva.SalesOrder = sd.SalesDocument
    left outer join ZPP_DISPATCH_WT     as rdisp   on rdisp.SalesOrder = sd.SalesDocument
    left outer join ZPP_BDISPATCH_WT as    bdisp   on bdisp.SalesDocument = sd.SalesDocument

{
  key sd.SalesDocument,
  key sd.YY1_PriorityPONos_SDH,
      sd.YY1_Project_SDH,
      batch.ProductName,
      batch.batch_wt,
      planwt.Plan_wt,
      cast(
         cast( coalesce(batch.batch_wt,0)  as abap.dec( 15, 3 ) )
       - cast( coalesce(planwt.Plan_wt,0) as abap.dec( 15, 3 ) )
         as abap.dec( 15, 3 )
      ) as Balance_Wt,
      galvain.Glava_in,
      cast(
         cast( coalesce(planwt.Plan_wt,0)  as abap.dec( 15, 3 ) )
       - cast( coalesce(galvain.Glava_in,0) as abap.dec( 15, 3 ) )
         as abap.dec( 15, 3 )
      ) as Balglvin_wt,
      galva.Glalva_wt,
      cast(
         cast( coalesce(galvain.Glava_in,0)  as abap.dec( 15, 3 ) )
       - cast( coalesce(galva.Glalva_wt,0) as abap.dec( 15, 3 ) )
         as abap.dec( 15, 3 )
      ) as Balglv_wt,
      rdisp.Despatch_wt,
      cast(
         cast( coalesce(galva.Glalva_wt,0)  as abap.dec( 15, 3 ) )
       - cast( coalesce(rdisp.Despatch_wt,0) as abap.dec( 15, 3 ) )
         as abap.dec( 15, 3 )
      ) as Balrdispatch_wt,
      bdisp.TotSP_Wt      
      
}where sd.YY1_Project_SDH is not initial and sd.YY1_PriorityPONos_SDH is not initial
group by
  sd.SalesDocument,
  sd.YY1_PriorityPONos_SDH,
  batch.batch_wt,
  sd.YY1_Project_SDH,
  planwt.Plan_wt,
  batch.ProductName,
  galvain.Glava_in,
  galva.Glalva_wt,
  rdisp.Despatch_wt,
  bdisp.TotSP_Wt
