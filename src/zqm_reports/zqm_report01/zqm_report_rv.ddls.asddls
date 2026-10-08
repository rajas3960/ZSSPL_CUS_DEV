@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Wise Section Details'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZQM_REPORT_RV
  as select from    I_SalesDocument     as s
    left outer join I_SalesDocumentItem as si  on  si.SalesDocument             = s.SalesDocument
                                               and si.SalesDocumentItemCategory = 'TAP'
    left outer join I_ProductText       as pt  on  pt.Product  = s.YY1_Project_SDH
                                               and pt.Language = $session.system_language
    left outer join ZPP_RP01_RV         as b   on b.BillOfMaterialComponent = si.Material
    left outer join I_ProductText       as pd  on  pd.Product  = b.Material
                                               and pd.Language = $session.system_language
    left outer join ZQM_REPORT_SEC      as ms  on ms.SalesDocument = s.SalesDocument
    left outer join ZQM_PLANWT_SEC      as pw  on  pw.Vbeln   = ms.SalesDocument
                                               and pw.sectmat = ms.BillOfMaterialComponent
    left outer join ZQM_PRODWT_SEC      as pdw on  pdw.SalesOrder              = ms.SalesDocument
                                               and pdw.BillOfMaterialComponent = ms.BillOfMaterialComponent
    left outer join ZQM_GALWT_SEC       as gw  on  gw.SalesOrder              = ms.SalesDocument
                                               and gw.BillOfMaterialComponent = ms.BillOfMaterialComponent
    left outer join ZQM_DISINWT_SEC     as din on  din.SalesOrder              = ms.SalesDocument
                                               and din.BillOfMaterialComponent = ms.BillOfMaterialComponent
    left outer join ZQM_DISPWT_SEC      as d   on  d.SalesDocument           = ms.SalesDocument
                                               and d.BillOfMaterialComponent = ms.BillOfMaterialComponent
  composition [0..*] of ZQM_REPORT_IRV as item
{
  key s.SalesDocument,
  key s.YY1_Project_SDH       as Project,
  key s.YY1_PriorityPONos_SDH as po,
  key b.Material              as Subtype,
  key ms.BillOfMaterialComponent,
      s.PurchaseOrderByCustomer,
      s.CustomerPurchaseOrderDate,
      pt.ProductName,
      pd.ProductName          as Subtypedesc,
      ms.SalesDocumentItemText,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      si.RequestedQuantity    as RequestedQuantity,
      si.BaseUnit,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      ms.RequestedQuantity    as bat_wt,
      ms.sec_kg,
      pw.totoal_planwt,
      cast( cast( coalesce ( ms.sec_kg,0) as abap.dec( 15, 3 ))
       - cast( coalesce ( pw.totoal_planwt,0) as abap.dec( 15, 3 ))
        as abap.dec( 15, 3 )) as Bal_PlanWt,
      pdw.Glava_in            as prod_wt,
      cast( cast( coalesce ( pw.totoal_planwt,0) as abap.dec( 15, 3 ))
       - cast( coalesce ( pdw.Glava_in,0) as abap.dec( 15, 3 ))
        as abap.dec( 15, 3 )) as Bal_Prodwt,
      gw.Glava,
      cast( cast( coalesce ( pdw.Glava_in,0) as abap.dec( 15, 3 ))
       - cast( coalesce ( gw.Glava,0) as abap.dec( 15, 3 ))
        as abap.dec( 15, 3 )) as Bal_galwt,
      din.Dispin_wt,
      cast( cast( coalesce (  gw.Glava,0) as abap.dec( 15, 3 ))
       - cast( coalesce (din.Dispin_wt,0) as abap.dec( 15, 3 ))
        as abap.dec( 15, 3 )) as Bal_dinwt,
      d.TotSP_Wt              as dispwt,
      item


}
where
      s.YY1_Project_SDH       is not initial
  and s.YY1_PriorityPONos_SDH is not initial

group by
  s.SalesDocument,
  s.YY1_Project_SDH,
  s.YY1_PriorityPONos_SDH,
  s.PurchaseOrderByCustomer,
  s.CustomerPurchaseOrderDate,
  pt.ProductName,
  pd.ProductName,
  //  si.Material,
  b.Material,
  ms.BillOfMaterialComponent,
  ms.SalesDocumentItemText,
  si.BaseUnit,
  si.RequestedQuantity,
  ms.RequestedQuantity,
  ms.sec_kg,
  pw.totoal_planwt,
  pdw.Glava_in,
  gw.Glava,
  din.Dispin_wt,
  d.TotSP_Wt
