@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Section Summary'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZQM_REPORT_SEC
  as select from I_SalesDocumentItem as s
    left outer join ZPP_RP01_RV as b
      on b.Material = s.Material
    left outer join I_Product as p
      on p.Product = s.Material
{
  key s.SalesDocument,
  key b.BillOfMaterialComponent,

  max( s.SalesDocumentItemText ) as SalesDocumentItemText,

  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  sum( s.RequestedQuantity ) as RequestedQuantity,

  cast(
    sum(
      s.RequestedQuantity *
      cast( p.YY1_WGT_PC_PRD as abap.dec(15,3) )
    )
    as abap.dec(15,3)
  ) as sec_kg,

  s.BaseUnit
}
where
  s.SalesDocumentItemCategory = 'TAN'
group by
  s.SalesDocument,
  b.BillOfMaterialComponent,
  s.BaseUnit
