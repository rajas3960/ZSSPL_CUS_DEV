@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Balance Plan Report'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zpp_report_rv03
  as select from    zpp_report_rv01 as main
    left outer join zpp_report_rv02 as mark on  mark.Vbeln = main.SalesDocument
                                            and mark.project = main.YY1_Project_SDH
                                            and mark.purno   = main.YY1_PriorityPONos_SDH
                                            and mark.sectmat = main.BillOfMaterialComponent
  composition [0..*] of ZPP_REP_IRV03 as item
{
  key main.BillOfMaterialComponent,
  key main.YY1_PriorityPONos_SDH as YY1_PriorityPONos_SDH,
  key main.YY1_Project_SDH,
  key main.SalesDocument,
      main.ProductName,
      main.Secwieght,
      mark.totoal_planwt,
      cast(cast(coalesce(main.Secwieght,0) as abap.dec( 10, 3 )) - cast( coalesce(mark.totoal_planwt,0) as abap.dec( 10, 3 ))
         as abap.dec(15,3)
      )                          as Blance_wt,
      item

}
where
      main.YY1_PriorityPONos_SDH is not initial
  and main.YY1_Project_SDH       is not initial
//  and cast(cast(coalesce(main.Secwieght,0) as abap.dec( 10, 3 )) - cast( coalesce(mark.totoal_planwt,0) as abap.dec( 10, 3 ))
//         as abap.dec(15,3)
//      )                          is not null

group by
  main.BillOfMaterialComponent,
  main.YY1_PriorityPONos_SDH,
  main.YY1_Project_SDH,
  main.SalesDocument,
  main.ProductName,
  main.Secwieght,
  mark.totoal_planwt
