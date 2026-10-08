@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item View of Project Wise Mark Number'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZQM_REPORT_IRV
  as select from    I_SalesDocument     as s
    left outer join I_SalesDocumentItem as si  on  si.SalesDocument             = s.SalesDocument
                                               and si.SalesDocumentItemCategory = 'TAP'
    left outer join I_ProductText       as pt  on pt.Product = s.YY1_Project_SDH
    left outer join ZPP_RP01_RV         as b   on b.BillOfMaterialComponent = si.Material
    left outer join ZPP_REPORT_IRV01    as m   on  m.SalesDocument         = s.SalesDocument
                                               and m.YY1_PriorityPONos_SDH = s.YY1_PriorityPONos_SDH
                                               and m.YY1_Project_SDH       = s.YY1_Project_SDH
    left outer join ZPP_REP_IRV02       as i   on  i.Matnr   = m.Product
                                               and i.project = m.YY1_Project_SDH
                                               and i.purno   = m.YY1_PriorityPONos_SDH
    left outer join ZPP_WIP_REPORT_VER2 as gin on  gin.SalesOrder            = m.SalesDocument
                                               and gin.YY1_Project_SDH       = m.YY1_Project_SDH
                                               and gin.YY1_PriorityPONos_SDH = m.YY1_PriorityPONos_SDH
                                               and gin.Product               = m.Product
                                               and gin.WorkCenter            = '30_GIN01'
    left outer join ZPP_WIP_REPORT_VER2 as gal on  gal.SalesOrder            = m.SalesDocument
                                               and gal.YY1_Project_SDH       = m.YY1_Project_SDH
                                               and gal.YY1_PriorityPONos_SDH = m.YY1_PriorityPONos_SDH
                                               and gal.Product               = m.Product
                                               and gal.WorkCenter            = '30_GAL01'
    left outer join ZPP_WIP_REPORT_VER2 as din on  din.SalesOrder            = m.SalesDocument
                                               and din.YY1_Project_SDH       = m.YY1_Project_SDH
                                               and din.YY1_PriorityPONos_SDH = m.YY1_PriorityPONos_SDH
                                               and din.Product               = m.Product
                                               and din.WorkCenter            = '30_DIN01'
      association to parent ZQM_REPORT_RV as hdr on hdr.SalesDocument = $projection.SalesDocument
                                                 and hdr.Project = $projection.YY1_Project_SDH
                                                 and hdr.po = $projection.YY1_PriorityPONos_SDH
                                                 and hdr.BillOfMaterialComponent = $projection.BillOfMaterialComponent
                                                 and hdr.Subtype = $projection.Material
{
  key s.YY1_PriorityPONos_SDH              as YY1_PriorityPONos_SDH,
  key m.Product,
  key s.YY1_Project_SDH,
  key s.SalesDocument,
  key m.BillOfMaterialComponent,
  key b.Material,
      i.totoal_planwt,
      cast(m.Mark_wt as abap.dec( 15, 3 )) as Mark_wt,
      cast(cast(coalesce(m.Mark_wt,0) as abap.dec( 10, 3 )) - cast( coalesce(i.totoal_planwt,0) as abap.dec( 10, 3 ))
             as abap.dec(15,3)
          )                                as Blance_wt,

      gin.Prod_weight                      as gin_wt,
      gin.Balance_Wt                       as balgin_wt,
      gal.Prod_weight                      as gal_wt,
      gal.Balance_Wt                       as balgal_wt,
      din.Prod_weight                      as din_wt,
      din.Balance_Wt                       as baldin_wt,
      hdr

}
where
      m.YY1_PriorityPONos_SDH is not initial
  and m.YY1_Project_SDH       is not initial
group by
  s.YY1_PriorityPONos_SDH,
  m.Product,
  s.YY1_Project_SDH,
  s.SalesDocument,
  m.BillOfMaterialComponent,
  b.Material,
  i.totoal_planwt,
  m.Mark_wt,
  gin.Prod_weight,
  gin.Balance_Wt,
  gal.Prod_weight,
  gal.Balance_Wt,
  din.Prod_weight,
  din.Balance_Wt
