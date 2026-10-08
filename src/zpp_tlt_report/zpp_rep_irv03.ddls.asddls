@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Balance to Plan i no'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_REP_IRV03
  as select from    ZPP_REPORT_IRV01 as m
    left outer join ZPP_REP_IRV02    as i on  i.Matnr   = m.Product
                                          and i.project = m.YY1_Project_SDH
                                          and i.purno   = m.YY1_PriorityPONos_SDH
                                          and i.Vbeln   = m.SalesDocument
  association to parent zpp_report_rv03 as hdr on  hdr.SalesDocument           = $projection.SalesDocument
                                               and hdr.YY1_PriorityPONos_SDH   = $projection.YY1_PriorityPONos_SDH
                                               and hdr.YY1_Project_SDH         = $projection.YY1_Project_SDH
                                               and hdr.BillOfMaterialComponent = $projection.BillOfMaterialComponent
{
  key m.YY1_PriorityPONos_SDH              as YY1_PriorityPONos_SDH,
  key m.Product,
  key m.YY1_Project_SDH,
  key m.SalesDocument,
  key m.BillOfMaterialComponent,
      i.totoal_planwt,
      cast(m.Mark_wt as abap.dec( 15, 3 )) as Mark_wt,
      cast(cast(coalesce(m.Mark_wt,0) as abap.dec( 10, 3 )) - cast( coalesce(i.totoal_planwt,0) as abap.dec( 10, 3 ))
             as abap.dec(15,3)
          )                                as Blance_wt,
      hdr

}
where
      m.YY1_PriorityPONos_SDH is not initial
  and m.YY1_Project_SDH       is not initial
group by
  m.YY1_PriorityPONos_SDH,
  m.Product,
  m.YY1_Project_SDH,
  m.SalesDocument,
  m.BillOfMaterialComponent,
  i.totoal_planwt,
  m.Mark_wt
