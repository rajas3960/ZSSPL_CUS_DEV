@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Total Plan Weight'
@Metadata.ignorePropagatedAnnotations: true
define view entity zpp_plan_wt
  as select from zpp_report_rv02
{
  key Vbeln,
//  key Purno,
      cast( sum( totoal_planwt ) / 1000 as abap.dec( 15, 3 ) ) as Plan_wt
}
group by
  Vbeln
//  purno
